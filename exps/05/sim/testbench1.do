onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Entradas
add wave -noupdate -height 35 /circuito_jogo_base_tb1/clk_in
add wave -noupdate -color Cyan -height 35 /circuito_jogo_base_tb1/rst_in
add wave -noupdate -color Cyan -height 35 /circuito_jogo_base_tb1/iniciar_in
add wave -noupdate -color Cyan -height 35 /circuito_jogo_base_tb1/botoes_in
add wave -noupdate -divider Saidas
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/leds_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/pronto_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/ganhou_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/perdeu_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/clock_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/tem_jogada_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/jogada_correta_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/enderecoIgualRodada_out
add wave -noupdate -color Yellow -height 35 /circuito_jogo_base_tb1/timeout_out
add wave -noupdate -divider {Fluxo de Dados}
add wave -noupdate -height 45 /circuito_jogo_base_tb1/dut/s_db_contagem
add wave -noupdate -height 35 /circuito_jogo_base_tb1/dut/s_db_memoria
add wave -noupdate -height 35 /circuito_jogo_base_tb1/dut/s_db_jogada_feita
add wave -noupdate -height 35 /circuito_jogo_base_tb1/dut/s_db_rodada
add wave -noupdate -divider {Unidade de Controle}
add wave -noupdate -color Magenta -height 35 /circuito_jogo_base_tb1/dut/UC/Eatual
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1617 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 346
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
WaveRestoreZoom {0 ns} {1813 ns}
