# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /vagrant/Lab2/lab2_fpga/lab2_fpga.cache/wt [current_project]
set_property parent.project_path /vagrant/Lab2/lab2_fpga/lab2_fpga.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
read_verilog -library xil_defaultlib {
  /vagrant/Lab2/lab2_fpga/lab2_fpga.srcs/sources_1/imports/Lab2/shiftregister.v
  /vagrant/Lab2/lab2_fpga/lab2_fpga.srcs/sources_1/imports/Lab2/inputconditioner.v
  /vagrant/Lab2/lab2_fpga/lab2_fpga.srcs/sources_1/imports/Lab2/midpoint.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /vagrant/Lab2/lab2_fpga/lab2_fpga.srcs/constrs_1/imports/vagrant/ZYBO_Master.xdc
set_property used_in_implementation false [get_files /vagrant/Lab2/lab2_fpga/lab2_fpga.srcs/constrs_1/imports/vagrant/ZYBO_Master.xdc]


synth_design -top midpoint -part xc7z010clg400-1


write_checkpoint -force -noxdef midpoint.dcp

catch { report_utilization -file midpoint_utilization_synth.rpt -pb midpoint_utilization_synth.pb }
