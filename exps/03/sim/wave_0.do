onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 40 /fluxo_dados_tb/caso
add wave -noupdate -height 40 /fluxo_dados_tb/clock_in
add wave -noupdate -divider Inputs
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/zerac_in
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/contac_in
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/escrevem_in
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/zerar_in
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/registrar_in
add wave -noupdate -color Cyan -height 40 /fluxo_dados_tb/chaves_in
add wave -noupdate -divider Outputs
add wave -noupdate -color Yellow -height 40 /fluxo_dados_tb/igual_out
add wave -noupdate -color Yellow -height 40 /fluxo_dados_tb/fimc_out
add wave -noupdate -divider Debugging
add wave -noupdate -color White -height 40 /fluxo_dados_tb/db_contagem_out
add wave -noupdate -color White -height 40 /fluxo_dados_tb/db_memoria_out
add wave -noupdate -color White -height 40 /fluxo_dados_tb/db_chaves_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {696 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
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
WaveRestoreZoom {0 ns} {756 ns}
