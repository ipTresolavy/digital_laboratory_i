onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Entradas
add wave -noupdate -color White -height 35 /braille_teacher_tb1/DUT/clock
add wave -noupdate -color White -height 35 /braille_teacher_tb1/DUT/reset
add wave -noupdate -color White -height 35 /braille_teacher_tb1/DUT/iniciar
add wave -noupdate -color White -height 35 /braille_teacher_tb1/DUT/botoes
add wave -noupdate -color White -height 35 /braille_teacher_tb1/DUT/dado_escrita
add wave -noupdate -divider Saidas
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/erros
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/tempoMedio
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/fimDeJogo
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_clock
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_tem_jogada
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_enderecoIgualRodada
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_contagem
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_memoria
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_jogada_feita
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_rodada
add wave -noupdate -color Yellow -height 35 /braille_teacher_tb1/DUT/db_estado
add wave -noupdate -color Magenta -height 35 /braille_teacher_tb1/DUT/UC/Eatual
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
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
WaveRestoreZoom {0 ns} {7978516 ns}
