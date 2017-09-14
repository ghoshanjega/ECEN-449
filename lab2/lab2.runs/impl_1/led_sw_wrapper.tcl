proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/gjaa.connect/ECEN449/lab2/lab2.cache/wt [current_project]
  set_property parent.project_path /home/gjaa.connect/ECEN449/lab2/lab2.xpr [current_project]
  set_property ip_repo_paths /home/gjaa.connect/ECEN449/lab2/lab2.cache/ip [current_project]
  set_property ip_output_repo /home/gjaa.connect/ECEN449/lab2/lab2.cache/ip [current_project]
  add_files -quiet /home/gjaa.connect/ECEN449/lab2/lab2.runs/synth_1/led_sw_wrapper.dcp
  add_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/led_sw.bmm
  set_property SCOPED_TO_REF led_sw [get_files -all /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/led_sw.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/led_sw.bmm]
  add_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf
  set_property SCOPED_TO_REF led_sw [get_files -all /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf]
  read_xdc -ref led_sw_microblaze_0_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_microblaze_0_0/led_sw_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_microblaze_0_0/led_sw_microblaze_0_0.xdc]
  read_xdc -ref led_sw_dlmb_v10_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_dlmb_v10_0/led_sw_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_dlmb_v10_0/led_sw_dlmb_v10_0.xdc]
  read_xdc -ref led_sw_ilmb_v10_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_ilmb_v10_0/led_sw_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_ilmb_v10_0/led_sw_ilmb_v10_0.xdc]
  read_xdc -ref led_sw_mdm_1_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_mdm_1_0/led_sw_mdm_1_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_mdm_1_0/led_sw_mdm_1_0.xdc]
  read_xdc -prop_thru_buffers -ref led_sw_clk_wiz_1_0 -cells inst /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_clk_wiz_1_0/led_sw_clk_wiz_1_0_board.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_clk_wiz_1_0/led_sw_clk_wiz_1_0_board.xdc]
  read_xdc -ref led_sw_clk_wiz_1_0 -cells inst /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_clk_wiz_1_0/led_sw_clk_wiz_1_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_clk_wiz_1_0/led_sw_clk_wiz_1_0.xdc]
  read_xdc -prop_thru_buffers -ref led_sw_rst_clk_wiz_1_100M_0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_rst_clk_wiz_1_100M_0/led_sw_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_rst_clk_wiz_1_100M_0/led_sw_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref led_sw_rst_clk_wiz_1_100M_0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_rst_clk_wiz_1_100M_0/led_sw_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_rst_clk_wiz_1_100M_0/led_sw_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref led_sw_axi_gpio_0_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_axi_gpio_0_0/led_sw_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_axi_gpio_0_0/led_sw_axi_gpio_0_0_board.xdc]
  read_xdc -ref led_sw_axi_gpio_0_0 -cells U0 /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_axi_gpio_0_0/led_sw_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files /home/gjaa.connect/ECEN449/lab2/lab2.srcs/sources_1/bd/led_sw/ip/led_sw_axi_gpio_0_0/led_sw_axi_gpio_0_0.xdc]
  read_xdc /home/gjaa.connect/ECEN449/lab2/lab2.srcs/constrs_1/new/led.xdc
  link_design -top led_sw_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force led_sw_wrapper_opt.dcp
  catch {report_drc -file led_sw_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file led_sw_wrapper.hwdef}
  place_design 
  write_checkpoint -force led_sw_wrapper_placed.dcp
  catch { report_io -file led_sw_wrapper_io_placed.rpt }
  catch { report_utilization -file led_sw_wrapper_utilization_placed.rpt -pb led_sw_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file led_sw_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force led_sw_wrapper_routed.dcp
  catch { report_drc -file led_sw_wrapper_drc_routed.rpt -pb led_sw_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file led_sw_wrapper_timing_summary_routed.rpt -rpx led_sw_wrapper_timing_summary_routed.rpx }
  catch { report_power -file led_sw_wrapper_power_routed.rpt -pb led_sw_wrapper_power_summary_routed.pb }
  catch { report_route_status -file led_sw_wrapper_route_status.rpt -pb led_sw_wrapper_route_status.pb }
  catch { report_clock_utilization -file led_sw_wrapper_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force led_sw_wrapper.mmi }
  catch { write_bmm -force led_sw_wrapper_bd.bmm }
  write_bitstream -force led_sw_wrapper.bit 
  catch { write_sysdef -hwdef led_sw_wrapper.hwdef -bitfile led_sw_wrapper.bit -meminfo led_sw_wrapper.mmi -ltxfile debug_nets.ltx -file led_sw_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

