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
  set_property webtalk.parent_dir /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.cache/wt [current_project]
  set_property parent.project_path /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.xpr [current_project]
  set_property ip_repo_paths /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.cache/ip [current_project]
  set_property ip_output_repo /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.cache/ip [current_project]
  add_files -quiet /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.runs/synth_1/jackpot.dcp
  read_xdc /home/gjaa.connect/ECEN449/lab1/jackpot/jackpot.srcs/constrs_1/new/jackpot.xdc
  link_design -top jackpot -part xc7z010clg400-1
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
  write_checkpoint -force jackpot_opt.dcp
  catch {report_drc -file jackpot_drc_opted.rpt}
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
  catch {write_hwdef -file jackpot.hwdef}
  place_design 
  write_checkpoint -force jackpot_placed.dcp
  catch { report_io -file jackpot_io_placed.rpt }
  catch { report_utilization -file jackpot_utilization_placed.rpt -pb jackpot_utilization_placed.pb }
  catch { report_control_sets -verbose -file jackpot_control_sets_placed.rpt }
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
  write_checkpoint -force jackpot_routed.dcp
  catch { report_drc -file jackpot_drc_routed.rpt -pb jackpot_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file jackpot_timing_summary_routed.rpt -rpx jackpot_timing_summary_routed.rpx }
  catch { report_power -file jackpot_power_routed.rpt -pb jackpot_power_summary_routed.pb }
  catch { report_route_status -file jackpot_route_status.rpt -pb jackpot_route_status.pb }
  catch { report_clock_utilization -file jackpot_clock_utilization_routed.rpt }
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
  write_bitstream -force jackpot.bit 
  catch { write_sysdef -hwdef jackpot.hwdef -bitfile jackpot.bit -meminfo jackpot.mmi -ltxfile debug_nets.ltx -file jackpot.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

