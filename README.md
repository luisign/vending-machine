# Controlador digital de _vending machine_ em SystemVerilog

Projeto da trilha RTL Design do programa CI Expert (Residência Tecnológica em Microeletrônica — MCTI/Softex/IRede), criando um controlador digital de uma máquina de venda automática com 4 itens de exemplo (café, água, suco e _snack_), utilizando uma máquina de estados finitos do tipo Moore, com memória de dados e _datapath_ combinacional.

## Estrutura do repositório

```
rtl/
├── vending_pkg.sv
├── credit_reg.sv
├── memory.sv
├── comparator.sv
├── subtractor.sv
├── control_unit.sv
└── vending_top.sv
sim/
└── tb_vending.sv
synth/
├── synth.tcl
├── vending.sdc
└── reports/
relatorio.pdf
```

## O código-fonte
### Pasta **rtl/**:
- **vending_pkg.sv**: define os estados da máquina de estados, larguras de sinais e outros parâmetros compartilhados entre os módulos;
- **credit_reg.sv**: um registrador síncrono de 8 bits que acumula o valor das moedas inseridas pelo usuário;
- **memory.sv**: memória que armazena o preço e estoque de cada um dos 4 itens (café, água, suco e _snack_), com leitura e escrita síncronas;
- **comparator.sv**: inclui a lógica combinacional que verifica se há crédito suficiente e estoque disponível para a compra;
- **subtractor.sv**: inclui a lógica combinacional que calcula o troco a ser devolvido;
- **control_unit.sv**: máquina de estados do tipo Moore com 6 estados (IDLE, COLLECT, CHECK, DISPENSE, CHANGE, ERROR) que coordena o fluxo da compra;
- **vending_top.sv**: módulo de topo, instancia e interliga os módulos acima.
### Pasta **sim/**:
- **tb_vending.sv**: arquivo de teste que verifica 4 cenários diferentes de uso.
### Pasta **synth/**
- **synth.tcl**: script de síntese lógica;
- **vending.sdc**: _constraints_ de _timing_;
- **Pasta reports/**: relatórios gerados pela síntese lógica;

## Fluxo simplificado de funcionamento

1. Usuário insere moedas (estado COLLECT), acumulando crédito.
2. Ao confirmar, o sistema verifica preço e estoque do item (estado CHECK).
3. Se confirmado o preço e o estoque, a máquina libera o item e decrementa o estoque (DISPENSE).
4. Depois, calcula e devolve o troco, zerando o crédito (CHANGE).
5. Se não houver crédito ou estoque suficiente, vai para ERROR.
6. No final do fluxo dos processos, a máquina retorna a IDLE.
