#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
#
#****************************************************************************
#
# Sample SDC for S10 GHRD. Targeting MGE component.
#
#****************************************************************************

#False path for PIO
set_false_path -from {*|alt_mge_phy_inst|mge_pcs|GMII_PCS.gmii_pcs|*} -to {*|altera_avalon_pio_inst|d1_data_in[*]}
set_false_path -from {*|alt_mge_phy_inst|mge_pcs|GMII_PCS.gmii_pcs|*} -to {*|altera_avalon_pio_inst|readdata[*]}
set_false_path -from {*|altera_xcvr_reset_control_s10_inst|*} -to {*|altera_avalon_pio_inst|d1_data_in[*]}
set_false_path -from {*|altera_xcvr_reset_control_s10_inst|*} -to {*|altera_avalon_pio_inst|readdata[*]}
set_false_path -from {*|mge_rcfg_inst|mge_rcfg_fsm_i|status[*]} -to {*|altera_avalon_pio_inst|d1_data_in[*]}
set_false_path -from {*|mge_rcfg_inst|mge_rcfg_fsm_i|status[*]} -to {*|altera_avalon_pio_inst|readdata[*]}

##Remove clock related to MGE 2.5Gbps mode
#remove_clock [get_clocks {*|alt_mge_phy_inst|profile1|*}]

# EMAC 0 Tx - Set exclusive clock groups for 2.5MHz, 25MHz and 125MHz clocks
if {[get_collection_size [get_pins -nowarn {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac0|phy_txclk_i}]] > 0} {
    create_generated_clock -name emac0_phy_txclk_i_from_i125 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[0]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac0|phy_txclk_i}] -add
    create_generated_clock -name emac0_phy_txclk_i_from_i25  -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[1]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac0|phy_txclk_i}] -add
    create_generated_clock -name emac0_phy_txclk_i_from_i2_5 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[2]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac0|phy_txclk_i}] -add
    set_clock_groups -logically_exclusive -group emac0_phy_txclk_i_from_i125 -group emac0_phy_txclk_i_from_i25 -group emac0_phy_txclk_i_from_i2_5
    # EMAC 0 Tx - hps_emac1_gtx_clk is asynchronous to the emac1_phy_txclk_i
    set_clock_groups -asynchronous \
        -group {emac0_phy_txclk_i_from_i125 emac0_phy_txclk_i_from_i25 emac0_phy_txclk_i_from_i2_5} \
        -group {hps_emac0_gtx_clk}
}

# EMAC 1 Tx - Set exclusive clock groups for 2.5MHz, 25MHz and 125MHz clocks
if {[get_collection_size [get_pins -nowarn {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac1|phy_txclk_i}]] > 0} {
    create_generated_clock -name emac1_phy_txclk_i_from_i125 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[0]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac1|phy_txclk_i}] -add
    create_generated_clock -name emac1_phy_txclk_i_from_i25  -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[1]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac1|phy_txclk_i}] -add
    create_generated_clock -name emac1_phy_txclk_i_from_i2_5 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[2]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac1|phy_txclk_i}] -add
    set_clock_groups -exclusive -group emac1_phy_txclk_i_from_i125 -group emac1_phy_txclk_i_from_i25 -group emac1_phy_txclk_i_from_i2_5
    # EMAC 1 Tx - hps_emac1_gtx_clk is asynchronous to the emac1_phy_txclk_i
    set_clock_groups -asynchronous \
        -group {emac1_phy_txclk_i_from_i125 emac1_phy_txclk_i_from_i25 emac1_phy_txclk_i_from_i2_5} \
        -group {hps_emac1_gtx_clk}
}

# EMAC 2 Tx - Set exclusive clock groups for 2.5MHz, 25MHz and 125MHz clocks
if {[get_collection_size [get_pins -nowarn {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac2|phy_txclk_i}]] > 0} {
    create_generated_clock -name emac2_phy_txclk_i_from_i125 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[0]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac2|phy_txclk_i}] -add
    create_generated_clock -name emac2_phy_txclk_i_from_i25  -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[1]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac2|phy_txclk_i}] -add
    create_generated_clock -name emac2_phy_txclk_i_from_i2_5 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[2]}] [get_pins {soc_inst|s10_hps|altera_stratix10_hps_inst|fpga_interfaces|peripheral_emac2|phy_txclk_i}] -add
    set_clock_groups -exclusive -group emac2_phy_txclk_i_from_i125 -group emac2_phy_txclk_i_from_i25 -group emac2_phy_txclk_i_from_i2_5
    # EMAC 2 Tx - hps_emac2_gtx_clk is asynchronous to the emac2_phy_txclk_i
    set_clock_groups -asynchronous \
        -group {emac2_phy_txclk_i_from_i125 emac2_phy_txclk_i_from_i25 emac2_phy_txclk_i_from_i2_5} \
        -group {hps_emac2_gtx_clk}
}

# EMAC 1 Rx - Set exclusive clock groups for 2.5MHz, 25MHz and 125MHz clocks
create_generated_clock -name emac1_rx_clk_mux_from_i125 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[0]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_1|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
create_generated_clock -name emac1_rx_clk_mux_from_i25  -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[1]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_1|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
create_generated_clock -name emac1_rx_clk_mux_from_i2_5 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[2]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_1|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
set_clock_groups -exclusive -group emac1_rx_clk_mux_from_i125 -group emac1_rx_clk_mux_from_i25 -group emac1_rx_clk_mux_from_i2_5

# EMAC 2 Rx - Set exclusive clock groups for 2.5MHz, 25MHz and 125MHz clocks
create_generated_clock -name emac2_rx_clk_mux_from_i125 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[0]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_2|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
create_generated_clock -name emac2_rx_clk_mux_from_i25  -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[1]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_2|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
create_generated_clock -name emac2_rx_clk_mux_from_i2_5 -source [get_pins {soc_inst|hps_mge|enet_iopll_0|altera_iopll_inst|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk[2]}] [get_nets {soc_inst|hps_mge|hps_to_mge_gmii_adapter_2|hps_to_mge_gmii_adapter_inst|u_hps_to_mge_gmii_adapter_core|u_clk_rx_mux|clk_out}] -add
set_clock_groups -exclusive -group emac2_rx_clk_mux_from_i125 -group emac2_rx_clk_mux_from_i25 -group emac2_rx_clk_mux_from_i2_5


#False path as tx_d, tx_en, tx_err is clocked with posedge of hps_emac*_gtx_clk for HPS EMAC Hard IP
set_false_path -fall_from [get_clocks {hps_emac*_gtx_clk}] -to {*|u_hps_to_mge_gmii_adapter_core|mac_tx*_d*}
