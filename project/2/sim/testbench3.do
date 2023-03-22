onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Entradas
add wave -noupdate -color white /braille_teacher_tb3/DUT/clock
add wave -noupdate -color white /braille_teacher_tb3/DUT/reset
add wave -noupdate -color white /braille_teacher_tb3/DUT/iniciar
add wave -noupdate -color white /braille_teacher_tb3/DUT/botoes
add wave -noupdate -color white /braille_teacher_tb3/DUT/dado_escrita
add wave -noupdate -divider Saidas
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/erros
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/fimDeJogo
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_clock
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_tem_jogada
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_enderecoIgualRodada
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_contagem
add wave -noupdate -color yellow -radix hexadecimal /braille_teacher_tb3/DUT/db_memoria
add wave -noupdate -color yellow -radix hexadecimal /braille_teacher_tb3/DUT/db_jogada_feita
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_rodada
add wave -noupdate -color yellow /braille_teacher_tb3/DUT/db_estado
add wave -noupdate -divider {Fluxo de Dados}
add wave -noupdate /braille_teacher_tb3/DUT/FD/s_dado
add wave -noupdate -radix decimal /braille_teacher_tb3/caso
add wave -noupdate /braille_teacher_tb3/DUT/FD/erros
add wave -noupdate /braille_teacher_tb3/DUT/FD/s_dado
add wave -noupdate /braille_teacher_tb3/DUT/FD/s_jogada
add wave -noupdate /braille_teacher_tb3/DUT/FD/tem_escrita
add wave -noupdate /braille_teacher_tb3/DUT/FD/dado_escrita
add wave -noupdate -divider {Unidade de Controle}
add wave -noupdate -color Magenta /braille_teacher_tb3/DUT/UC/Eatual
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {46604926068 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 338
configure wave -valuecolwidth 134
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
WaveRestoreZoom {0 ns} {52514700 us}
