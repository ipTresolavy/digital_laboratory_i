onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 35 /circuito_exp3_tb/caso
add wave -noupdate -height 35 /circuito_exp3_tb/clock_in
add wave -noupdate -divider Inputs
add wave -noupdate -color Cyan -height 35 /circuito_exp3_tb/reset_in
add wave -noupdate -color Cyan -height 35 /circuito_exp3_tb/iniciar_in
add wave -noupdate -color Cyan -height 35 /circuito_exp3_tb/chaves_in
add wave -noupdate -divider Outputs
add wave -noupdate -color Yellow -height 35 /circuito_exp3_tb/pronto_out
add wave -noupdate -divider Debugging
add wave -noupdate -color White -height 35 /circuito_exp3_tb/db_igual_out
add wave -noupdate -divider {Control Unit}
add wave -noupdate -color Magenta -label /circuito_exp3_tb/dut/UC/db_estado /circuito_exp3_tb/dut/UC/Eatual
add wave -noupdate -color Magenta -height 35 /circuito_exp3_tb/dut/s_zeraC
add wave -noupdate -color Magenta -height 35 /circuito_exp3_tb/dut/s_contaC
add wave -noupdate -color Magenta -height 35 /circuito_exp3_tb/dut/s_zeraR
add wave -noupdate -color Magenta -height 35 /circuito_exp3_tb/dut/s_registraR
add wave -noupdate -divider {Data Flow}
add wave -noupdate -color Orange -height 35 -label /circuito_exp3_tb/dut/FD/chaves /circuito_exp3_tb/dut/FD/registrador/D
add wave -noupdate -color Orange -height 35 -label /circuito_exp3_tb/dut/FD/db_chaves /circuito_exp3_tb/dut/FD/s_chaves
add wave -noupdate -color Orange -height 35 -label /circuito_exp3_tb/dut/FD/db_contagem /circuito_exp3_tb/dut/FD/s_endereco
add wave -noupdate -color Orange -height 35 -label /circuito_exp3_tb/dut/FD/db_memoria /circuito_exp3_tb/dut/FD/s_dado
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1150 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1260 ns}
