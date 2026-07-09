# Arquivo de restricoes (SDC) - Vending Machine
# Periodo de clock: 20ns (50MHz)

# 1. Definicao do clock
create_clock -name clk -period 20.0 [get_ports clk]

# 2. Uncertainty (jitter/skew)
set_clock_uncertainty 0.5 [get_clocks clk]

# 3. Input delay (excluindo a porta de clock para evitar loops)
set_input_delay -clock clk 3.0 [all_inputs]

# 4. Output delay
set_output_delay -clock clk 3.0 [all_outputs]

# 5. Load (em picofarads) e driving cell
# Nota: Ajuste o valor de set_load conforme a capacidade de carga esperada (0.1pF = 100fF)
set_load 0.1 [all_outputs]

# ATENÇÃO: Substituir 'BUFX2' pelo nome de uma célula de buffer/inversor 
# que realmente exista na biblioteca de tecnologia (.db)
# set_driving_cell -lib_cell BUFX2 [all_inputs]
