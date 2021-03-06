# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.cache/wt} [current_project]
set_property parent.project_path {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/GenerateBlock.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/TranslateToDisplay.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/RowChecker.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/Randomizer.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/PosCalc.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/GameClock.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/GameLogic.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/SevenSegmentDisplay.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/ScoreCalculator.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/RGBControl.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/ButtonSync.sv}
  {C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/sources_1/new/GameControl.sv}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/constrs_1/new/const.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/asus/Desktop/Bilkent 201/Cs 223/Project/TetrisFinal/TetrisFinal.srcs/constrs_1/new/const.xdc}}]


synth_design -top GameControl -part xc7a35tcpg236-1


write_checkpoint -force -noxdef GameControl.dcp

catch { report_utilization -file GameControl_utilization_synth.rpt -pb GameControl_utilization_synth.pb }
