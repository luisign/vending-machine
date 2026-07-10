`timescale 1ns / 1ps

module vending_tb;

    // Encoding dos estados da FSM:
    localparam ST_IDLE = 3'b000;
    localparam ST_COLLECT = 3'b001;
    localparam ST_CHECK = 3'b010;
    localparam ST_DISPENSE = 3'b011;
    localparam ST_CHANGE = 3'b100;
    localparam ST_ERROR = 3'b101;

    logic clk;
    logic reset;
    logic [1:0] coin_in;
    logic [1:0] sel_item;
    logic confirm;
    logic cancel;

    logic dispense;
    logic error_out;
    logic [7:0] change_out;
    logic [7:0] display;
    logic [2:0] state_out;

    vending_top dut (
        .clk(clk),
        .rst(reset),
        .coin_in(coin_in),
        .sel_item(sel_item),
        .confirm(confirm),
        .cancel(cancel),
        .dispense(dispense),
        .error_out(error_out),
        .change_out(change_out),
        .display(display),
        .state_out(state_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        #10000;
        $display("[FAIL] A simulacao excedeu 10.000ns, possivel FSM travada");
        $finish;
    end

    task apply_coin(input [1:0] value);
        begin
            @(posedge clk);
            coin_in = value;
            @(posedge clk);
            coin_in = 2'b00;
            @(posedge clk);
        end
    endtask

    task buy_item(input [1:0] item, input [1:0] coins []);
        begin
            sel_item = item;
            foreach (coins[i]) begin
                apply_coin(coins[i]);
            end
            confirm = 1;
            @(posedge clk);
            @(posedge clk);
            confirm = 0;
            @(posedge clk);
        end
    endtask

    task check(input [7:0] expected, input [7:0] actual, input string label);
        begin
            if (expected === actual)
                $display("[PASS] %s", label);
            else
                $display("[FAIL] %s | Esperado: %0d, obtido: %0d", label, expected, actual);
        end
    endtask

    task wait_until_state(input [2:0] target_state);
        begin
            while (state_out !== target_state) begin
                @(posedge clk);
            end
        end
    endtask

    task wait_until_idle();
        begin
            wait_until_state(ST_IDLE);
        end
    endtask

    task recover_from_error();
        begin
            @(posedge clk);
            cancel = 1;
            @(posedge clk);
            @(posedge clk);
            cancel = 0;
            
            wait_until_idle();
        end
    endtask

    initial begin
	$dumpfile("../sim/vending_tb.vcd");
        $dumpvars(0, vending_tb);
        $fsdbDumpfile("../sim/vending_tb.fsdb");
        $fsdbDumpvars(0, vending_tb);

        coin_in = 2'b00;
        sel_item = 2'b00;
        confirm = 0;
        cancel = 0;

        reset = 1;
        repeat (2) @(posedge clk);
        reset = 0;
        wait_until_idle();

        // Cenário 1: compra bem-sucedida com troco:
        buy_item(2'b00, '{2'b11});
        wait_until_state(ST_DISPENSE);
        check(1, dispense, "Cenario 1: dispense = 1");
        wait_until_state(ST_CHANGE);
        check(75, change_out, "Cenario 1: troco = 75");
        wait_until_idle();
        check(0, display, "Cenario 1: credito = 0 ao final");

        // Cenário 2: crédito insuficiente:
        buy_item(2'b11, '{2'b01});
        wait_until_state(ST_ERROR);
        check(1, error_out, "Cenario 2: ERROR = 1");
        check(ST_ERROR, state_out, "Cenario 2: FSM em ERROR");
        recover_from_error();

        // Cenário 3: cancelamento:
        apply_coin(2'b11);
        apply_coin(2'b11);
        @(posedge clk);
        cancel = 1;
        @(posedge clk);
        @(posedge clk);
        cancel = 0;

        wait_until_idle();
        check(200, change_out, "Cenario 3: cancel troco = 200");
        check(0, display, "Cenario 3: credito = 0 apos cancelamento");
        check(ST_IDLE, state_out, "Cenario 3: FSM retorna a IDLE");

        // Cenário 4: estoque zerado:
        for (int i = 1; i <= 4; i++) begin
            buy_item(2'b00, '{2'b11});
            wait_until_idle();
        end
        buy_item(2'b00, '{2'b11});
        wait_until_state(ST_ERROR);
        check(1, error_out, "Cenario 4: ERROR estoque vazio = 1");
        check(ST_ERROR, state_out, "Cenario 4: FSM em ERROR (sem estoque)");
        recover_from_error();

        $display("Todos os cenarios foram validados!");
        $finish;
    end

endmodule
