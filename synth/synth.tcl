# 1. Configurar target library e link library
set target_library "/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm/saed32rvt_tt1p05v25c.db"
set link_library "* $target_library"

# 2. Ler e analisar todos os arquivos RTL
set RTL_DIR "../rtl"
analyze -format sverilog [list \
    $RTL_DIR/vending_pkg.sv \
    $RTL_DIR/comparator.sv \
    $RTL_DIR/credit_reg.sv \
    $RTL_DIR/memory.sv \
    $RTL_DIR/subtractor.sv \
    $RTL_DIR/control_unit.sv \
    $RTL_DIR/vending_top.sv \
]

# 3. Elaborar o design com vending_top como top module e executar link
elaborate vending_top
link

# 4. Ler o arquivo de constraints
read_sdc vending.sdc

# 5. Executar check_design e salvar relatório
# Verifica se há loops combinacionais, latches inferidos ou pinos flutuantes
check_design > reports/check_design.rpt

# 6. Executar a síntese mantendo a hierarquia
compile_ultra -no_autoungroup

# 7. Gerar e salvar os relatórios de área, timing, potência e violações
report_area > reports/report_area.rpt
report_timing > reports/report_timing.rpt
report_power > reports/report_power.rpt
report_constraint -all_violators > reports/report_constraint.rpt

# 8. Exportar a netlist sintetizada em Verilog
write -format verilog -hierarchy -output vending_top_syn.v

# Sair do Design Compiler
exit
