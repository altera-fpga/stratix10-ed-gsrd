#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
#
#****************************************************************************
#
# This script construct JTAG AVMM MAster sub system for higher level integration
# The GHRD create_ghrd_qsys.tcl will call each of those subsystem construct script
# automatically based on the corresponding parameter argument defined
#
#****************************************************************************

source ./arguments_solver.tcl
source ./utils.tcl
set sub_qsys_jtag subsys_jtg_mst

package require -exact qsys 18.1

create_system $sub_qsys_jtag

set_project_property DEVICE_FAMILY $device_family
set_project_property DEVICE $device
set_validation_property AUTOMATIC_VALIDATION false
    
add_component_param "altera_clock_bridge jtag_clk 
                    IP_FILE_PATH ip/$sub_qsys_jtag/jtag_clk.ip  
                    EXPLICIT_CLOCK_RATE 100000000 
                    NUM_CLOCK_OUTPUTS 1
                    "

add_component_param "altera_reset_bridge jtag_rst_in 
                    IP_FILE_PATH ip/$sub_qsys_jtag/jtag_rst_in.ip 
                    ACTIVE_LOW_RESET 1
                    SYNCHRONOUS_EDGES both
                    NUM_RESET_OUTPUTS 1
                    USE_RESET_REQUEST 0
                    "
    
if {$niosii_en == 0} {  
if {$h2f_f2h_loopback_en != 1 && $lwh2f_f2h_loopback_en != 1} { 
add_component_param "altera_jtag_avalon_master hps_m 
                    IP_FILE_PATH ip/$sub_qsys_jtag/hps_m.ip 
                    "
}

if {$h2f_f2sdram0_loopback_en == 0 || $h2f_f2sdram1_loopback_en == 0 || $h2f_f2sdram2_loopback_en == 0} {
set h2f_f2sdram_loopback_list "$h2f_f2sdram0_loopback_en $h2f_f2sdram1_loopback_en $h2f_f2sdram2_loopback_en"
for {set x 0} {$x<$f2sdram_count} {incr x} {
set count 0
foreach h2f_f2sdram_loopback $h2f_f2sdram_loopback_list {
if {$count == $x && $h2f_f2sdram_loopback == 0} {
add_component_param "altera_jtag_avalon_master f2sdram_m_${x} 
                    IP_FILE_PATH ip/$sub_qsys_jtag/f2sdram_m_${x}.ip "
}
incr count
}
}
}
}


add_component_param "altera_jtag_avalon_master fpga_m 
                    IP_FILE_PATH ip/$sub_qsys_jtag/fpga_m.ip 
                    "

# connections and connection parameters
connect "   jtag_clk.out_clk fpga_m.clk
            jtag_clk.out_clk jtag_rst_in.clk
            jtag_rst_in.out_reset fpga_m.clk_reset
"

if {$niosii_en == 0} {
if {$h2f_f2h_loopback_en != 1 && $lwh2f_f2h_loopback_en != 1} {
connect "   jtag_clk.out_clk hps_m.clk
            jtag_rst_in.out_reset hps_m.clk_reset
"
}

if {$h2f_f2sdram0_loopback_en == 0 || $h2f_f2sdram1_loopback_en == 0 || $h2f_f2sdram2_loopback_en == 0} {
set h2f_f2sdram_loopback_list "$h2f_f2sdram0_loopback_en $h2f_f2sdram1_loopback_en $h2f_f2sdram2_loopback_en"
for {set x 0} {$x<$f2sdram_count} {incr x} {
set count 0
foreach h2f_f2sdram_loopback $h2f_f2sdram_loopback_list {
if {$count == $x && $h2f_f2sdram_loopback == 0} {
connect "   jtag_clk.out_clk f2sdram_m_$x.clk
            jtag_rst_in.out_reset f2sdram_m_$x.clk_reset
"
}
incr count
}
}
}
}

# exported interfaces
export jtag_rst_in in_reset reset
export jtag_clk in_clk clk
export fpga_m master fpga_m_master
if {$niosii_en == 0} {
if {$h2f_f2h_loopback_en != 1 && $lwh2f_f2h_loopback_en != 1} {
export hps_m master hps_m_master
}
if {$h2f_f2sdram0_loopback_en == 0 || $h2f_f2sdram1_loopback_en == 0 || $h2f_f2sdram2_loopback_en == 0} {
set h2f_f2sdram_loopback_list "$h2f_f2sdram0_loopback_en $h2f_f2sdram1_loopback_en $h2f_f2sdram2_loopback_en"
for {set x 0} {$x<$f2sdram_count} {incr x} {
set count 0
foreach h2f_f2sdram_loopback $h2f_f2sdram_loopback_list {
if {$count == $x && $h2f_f2sdram_loopback == 0} {
export f2sdram_m_${x} master f2sdram_m_${x}_master
}
incr count
}
}
}
}

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {AUTO}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    
sync_sysinfo_parameters 
    
save_system ${sub_qsys_jtag}.qsys
