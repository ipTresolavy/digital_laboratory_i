onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 35 /circuito_exp4_tb1/clk_in
add wave -noupdate -divider Entradas
add wave -noupdate -color Cyan -height 35 /circuito_exp4_tb1/rst_in
add wave -noupdate -color Cyan -height 35 /circuito_exp4_tb1/iniciar_in
add wave -noupdate -color Cyan -height 35 /circuito_exp4_tb1/chaves_in
add wave -noupdate -divider {Deteccao de Jogada}
add wave -noupdate -color White -height 35 /circuito_exp4_tb1/tem_jogada_out
add wave -noupdate -color White -height 35 /circuito_exp4_tb1/jogadafeita_out
add wave -noupdate -height 35 /circuito_exp4_tb1/dut/s_jogada
add wave -noupdate -divider Depuracao
add wave -noupdate -color White -height 35 /circuito_exp4_tb1/igual_out
add wave -noupdate -divider Resultado
add wave -noupdate -color Yellow -height 35 /circuito_exp4_tb1/acertou_out
add wave -noupdate -color Yellow -height 35 /circuito_exp4_tb1/errou_out
add wave -noupdate -color Yellow -height 35 /circuito_exp4_tb1/pronto_out
add wave -noupdate -divider Saidas
add wave -noupdate -color Yellow -height 35 /circuito_exp4_tb1/leds_out
add wave -noupdate -color Yellow -height 35 /circuito_exp4_tb1/clock_out
add wave -noupdate -divider FD
add wave -noupdate -color Orange -height 35 /circuito_exp4_tb1/dut/FD/s_endereco
add wave -noupdate -color Orange -height 35 /circuito_exp4_tb1/dut/FD/s_dado
add wave -noupdate -color Orange -height 35 /circuito_exp4_tb1/dut/FD/s_chaves
add wave -noupdate -divider UC
add wave -noupdate -color Magenta -height 35 /circuito_exp4_tb1/dut/UC/Eatual
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 278
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
WaveRestoreZoom {0 ns} {5250 ns}
