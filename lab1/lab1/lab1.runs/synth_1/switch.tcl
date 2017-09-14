# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/gjaa.connect/ECEN449/lab1/lab1/lab1.cache/wt [current_project]
set_property parent.project_path /home/gjaa.connect/ECEN449/lab1/lab1/lab1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib /home/gjaa.connect/ECEN449/lab1/lab1/lab1.srcs/sources_1/new/switch.v
read_xdc /home/gjaa.connect/ECEN449/lab1/lab1/lab1.srcs/constrs_1/new/switch.xdc
set_property used_in_implementation false [get_files /home/gjaa.connect/ECEN449/lab1/lab1/lab1.srcs/constrs_1/new/switch.xdc]

synth_design -top switch -part xc7z010clg400-1
write_checkpoint -noxdef switch.dcp
catch { report_utilization -file switch_utilization_synth.rpt -pb switch_utilization_synth.pb }
