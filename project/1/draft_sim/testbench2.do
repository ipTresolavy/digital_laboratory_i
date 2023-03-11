onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Entradas
add wave -noupdate -height 35 /jogo_desafio_memoria_tb2/clk_in
add wave -noupdate -color Cyan -height 35 /jogo_desafio_memoria_tb2/rst_in
add wave -noupdate -color Cyan -height 35 /jogo_desafio_memoria_tb2/iniciar_in
add wave -noupdate -color Cyan -height 35 /jogo_desafio_memoria_tb2/botoes_in
add wave -noupdate -divider Saidas
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/leds_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/pronto_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/ganhou_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/perdeu_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/clock_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/tem_jogada_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/jogada_correta_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/enderecoIgualRodada_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/timeout_out
add wave -noupdate -color Yellow -height 35 /jogo_desafio_memoria_tb2/memoria_escreve_out
add wave -noupdate -divider {Fluxo de Dados}
add wave -noupdate -height 45 /jogo_desafio_memoria_tb2/dut/s_db_contagem
add wave -noupdate -height 35 /jogo_desafio_memoria_tb2/dut/s_db_memoria
add wave -noupdate -height 35 /jogo_desafio_memoria_tb2/dut/s_db_jogada_feita
add wave -noupdate -height 35 /jogo_desafio_memoria_tb2/dut/s_db_rodada
add wave -noupdate -divider {Unidade de Controle}
add wave -noupdate -color Magenta -height 35 /jogo_desafio_memoria_tb2/dut/UC/Eatual
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
WaveRestoreZoom {0 ns} {86114700 us}
