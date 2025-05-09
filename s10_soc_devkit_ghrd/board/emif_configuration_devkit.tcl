#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
#
#****************************************************************************
#
# This file define the EMIF IP Platform Designer configuration script for devkit
#
#****************************************************************************

# ------ Component configuration --------------------- #

# note: you may apply preset then modify or directly set intended value of whole component's parameters
# sample of instantiation could be something like following
   if {$hps_emif_en == 1} {

      add_component_param     "altera_emif_s10_hps emif_hps 
							   IP_FILE_PATH ip/$qsys_name/emif_hps.ip"
							   

      if {$hps_emif_type == "ddr4"} {
         load_component emif_hps
         #apply_component_preset  "DDR4-2400U CL18 Component 1CS 4Gb (256Mb x16)"
	 #4GB 72 bit HILO DDR4
	 #D9TNZ  (MT40A512M16JY-075E:B)
         apply_component_preset  "DDR4-2666U CL18 Component 1CS 8Gb (512Mb x16)"
         save_component
    
         set_component_param     "emif_hps 
                                  PROTOCOL_ENUM PROTOCOL_DDR4
                                  PHY_DDR4_RATE_ENUM RATE_HALF
                                  MEM_DDR4_FORMAT_ENUM MEM_FORMAT_UDIMM
                                  MEM_DDR4_DQ_WIDTH $total_hps_emif_width
                                  MEM_DDR4_TCL 18
                                  MEM_DDR4_WTCL 14
                                  MEM_DDR4_ALERT_N_PLACEMENT_ENUM DDR4_ALERT_N_PLACEMENT_DATA_LANES
                                  MEM_DDR4_ALERT_N_DQS_GROUP 0
                                  MEM_DDR4_NUM_OF_DIMMS 1
                                  MEM_DDR4_RANKS_PER_DIMM 1
                                  MEM_DDR4_CK_WIDTH 1
                                  MEM_DDR4_RTT_WR_ENUM DDR4_RTT_WR_ODT_DISABLED
                                  MEM_DDR4_DRV_STR_ENUM DDR4_DRV_STR_RZQ_7
                                  MEM_DDR4_RTT_NOM_ENUM DDR4_RTT_NOM_RZQ_4
                                  MEM_DDR4_DM_EN true
                                  MEM_DDR4_READ_DBI true
                                  MEM_DDR4_WRITE_DBI false
                                  PHY_DDR4_CONFIG_ENUM CONFIG_PHY_AND_HARD_CTRL
                                  PHY_DDR4_USER_PING_PONG_EN false
                                  PHY_DDR4_DEFAULT_REF_CLK_FREQ false
                                  PHY_DDR4_USER_REF_CLK_FREQ_MHZ 133.333
                                  CTRL_DDR4_ECC_EN $hps_emif_ecc_en
                                  CTRL_DDR4_ECC_AUTO_CORRECTION_EN $hps_emif_ecc_en
                                  PHY_DDR4_DEFAULT_IO false
                                  PHY_DDR4_USER_AC_IO_STD_ENUM IO_STD_SSTL_12
                                  PHY_DDR4_USER_CK_IO_STD_ENUM IO_STD_SSTL_12
                                  PHY_DDR4_USER_DATA_IO_STD_ENUM IO_STD_POD_12
                                  PHY_DDR4_USER_AC_MODE_ENUM OUT_OCT_40_CAL
                                  PHY_DDR4_USER_CK_MODE_ENUM OUT_OCT_40_CAL
                                  PHY_DDR4_USER_DATA_OUT_MODE_ENUM OUT_OCT_40_CAL
                                  PHY_DDR4_USER_DATA_IN_MODE_ENUM IN_OCT_60_CAL
                                  PHY_DDR4_USER_PLL_REF_CLK_IO_STD_ENUM IO_STD_LVDS
                                  PHY_DDR4_USER_RZQ_IO_STD_ENUM IO_STD_CMOS_12
                                  PHY_DDR4_MEM_CLK_FREQ_MHZ 1066.667
                                  DIAG_EXTRA_CONFIGS SEQ_DBG_SKIP_STEPS_ADD=245760"
                                  
      } elseif {$hps_emif_type == "ddr3"} {
         load_component emif_hps
         apply_component_preset  "DDR3-2133N CL14 Component 1CS 4Gb (256Mb x16)"
         save_component

         set_component_param     "emif_hps  
                                  PROTOCOL_ENUM PROTOCOL_DDR3
                                  PHY_DDR3_RATE_ENUM RATE_HALF
                                  MEM_DDR3_FORMAT_ENUM MEM_FORMAT_UDIMM
                                  MEM_DDR3_DQ_WIDTH $total_hps_emif_width
                                  MEM_DDR3_TCL 14
                                  MEM_DDR3_WTCL 10
                                  MEM_DDR3_NUM_OF_DIMMS 1
                                  MEM_DDR3_RANKS_PER_DIMM 1
                                  MEM_DDR3_CK_WIDTH 1
                                  MEM_DDR3_RTT_WR_ENUM DDR3_RTT_WR_RZQ_4
                                  MEM_DDR3_DRV_STR_ENUM DDR3_DRV_STR_RZQ_7
                                  MEM_DDR3_RTT_NOM_ENUM DDR3_RTT_NOM_ODT_DISABLED
                                  MEM_DDR3_DM_EN true
                                  PHY_DDR3_CONFIG_ENUM CONFIG_PHY_AND_HARD_CTRL
                                  PHY_DDR3_USER_PING_PONG_EN false
                                  PHY_DDR3_USER_REF_CLK_FREQ_MHZ 133.333
                                  PHY_DDR3_DEFAULT_REF_CLK_FREQ false
                                  CTRL_DDR3_ECC_EN $hps_emif_ecc_en
                                  CTRL_DDR3_ECC_AUTO_CORRECTION_EN $hps_emif_ecc_en
                                  PHY_DDR3_IO_VOLTAGE 1.5
                                  PHY_DDR3_DEFAULT_IO false
                                  PHY_DDR3_USER_AC_IO_STD_ENUM IO_STD_SSTL_15_C1
                                  PHY_DDR3_USER_CK_IO_STD_ENUM IO_STD_SSTL_15_C1
                                  PHY_DDR3_USER_DATA_IO_STD_ENUM IO_STD_SSTL_15
                                  PHY_DDR3_USER_AC_MODE_ENUM CURRENT_ST_8
                                  PHY_DDR3_USER_CK_MODE_ENUM CURRENT_ST_8
                                  PHY_DDR3_USER_DATA_OUT_MODE_ENUM OUT_OCT_34_CAL
                                  PHY_DDR3_USER_DATA_IN_MODE_ENUM IN_OCT_120_CAL
                                  PHY_DDR3_USER_PLL_REF_CLK_IO_STD_ENUM IO_STD_LVDS
                                  PHY_DDR3_USER_RZQ_IO_STD_ENUM IO_STD_CMOS_15
                                  PHY_DDR3_MEM_CLK_FREQ_MHZ 1066.667"
      }


      # ------ Connections --------------------------------- #
      connect "emif_hps.hps_emif ${cpu_instance}.hps_emif"

      # ------ Ports export -------------------------------- #
      export emif_hps mem         emif_hps_mem 
      export emif_hps oct         emif_hps_oct 
      export emif_hps pll_ref_clk emif_hps_pll_ref_clk 
   }

   if {$fpga_emif_en == 1} {
      add_component_param     "altera_emif_s10 fpga_emif
							   IP_FILE_PATH ip/$qsys_name/fpga_emif.ip"

      load_component emif_hps
      apply_component_preset  fpga_emif "DDR4-2400U CL18 Component 1CS 4Gb (256Mb x16)"
      save_component
  
      set_component_param     "fpga_emif 
                               PROTOCOL_ENUM PROTOCOL_DDR4
                               PHY_DDR4_RATE_ENUM RATE_HALF
                               MEM_DDR4_FORMAT_ENUM MEM_FORMAT_UDIMM
                               MEM_DDR4_DQ_WIDTH $total_fpga_emif_width
                               MEM_DDR4_TCL 18
                               MEM_DDR4_WTCL 16
                               MEM_DDR4_ALERT_N_PLACEMENT_ENUM DDR4_ALERT_N_PLACEMENT_DATA_LANES
                               MEM_DDR4_ALERT_N_DQS_GROUP 0
                               MEM_DDR4_NUM_OF_DIMMS 1
                               MEM_DDR4_RANKS_PER_DIMM 1
                               MEM_DDR4_CK_WIDTH 1
                               MEM_DDR4_RTT_WR_ENUM DDR4_RTT_WR_ODT_DISABLED
                               MEM_DDR4_DRV_STR_ENUM DDR4_DRV_STR_RZQ_7
                               MEM_DDR4_RTT_NOM_ENUM DDR4_RTT_NOM_RZQ_4
                               MEM_DDR4_DM_EN true
                               MEM_DDR4_READ_DBI true
                               MEM_DDR4_WRITE_DBI false
                               PHY_DDR4_CONFIG_ENUM CONFIG_PHY_AND_HARD_CTRL
                               PHY_DDR4_USER_PING_PONG_EN false
                               PHY_DDR4_DEFAULT_REF_CLK_FREQ false
                               PHY_DDR4_USER_REF_CLK_FREQ_MHZ 133.333
                               CTRL_DDR4_ECC_EN $fpga_emif_ecc_en
                               CTRL_DDR4_ECC_AUTO_CORRECTION_EN $fpga_emif_ecc_en
                               PHY_DDR4_DEFAULT_IO false
                               PHY_DDR4_USER_AC_IO_STD_ENUM IO_STD_SSTL_12
                               PHY_DDR4_USER_CK_IO_STD_ENUM IO_STD_SSTL_12
                               PHY_DDR4_USER_DATA_IO_STD_ENUM IO_STD_POD_12
                               PHY_DDR4_USER_AC_MODE_ENUM OUT_OCT_40_CAL
                               PHY_DDR4_USER_CK_MODE_ENUM OUT_OCT_40_CAL
                               PHY_DDR4_USER_DATA_OUT_MODE_ENUM OUT_OCT_40_CAL
                               PHY_DDR4_USER_DATA_IN_MODE_ENUM IN_OCT_60_CAL
                               PHY_DDR4_USER_PLL_REF_CLK_IO_STD_ENUM IO_STD_LVDS
                               PHY_DDR4_USER_RZQ_IO_STD_ENUM IO_STD_CMOS_12
                               PHY_DDR4_MEM_CLK_FREQ_MHZ 1066.667
                               DIAG_EXTRA_CONFIGS SEQ_DBG_SKIP_STEPS_ADD=245760,DIAG_DISABLE_USERMODE_OCT_WORKAROUND=true"
     
      # ------ Connections --------------------------------- #
      connect "rst_in.out_reset fpga_emif.global_reset_reset_sink"
## This is for the SODIMM interface      load_component fpga_emif
## This is for the SODIMM interface      apply_component_preset"DDR4-2400U CL18 Component 1CS 8Gb (1Gb x8)"
## This is for the SODIMM interface      save_component
## This is for the SODIMM interface      set_component_param   "fpga_emif PROTOCOL_ENUM PROTOCOL_DDR4"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_RATE_ENUM RATE_QUARTER"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_FORMAT_ENUM MEM_FORMAT_UDIMM"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_DQ_WIDTH 8"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_TCL 17"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_WTCL 16"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_ALERT_N_PLACEMENT_ENUM DDR4_ALERT_N_PLACEMENT_AC_LANES"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_ALERT_N_AC_LANE 3"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_ALERT_N_AC_PIN 7"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_NUM_OF_DIMMS 1"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_RANKS_PER_DIMM 2"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_CK_WIDTH 2"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_RTT_WR_ENUM DDR4_RTT_WR_RZQ_3"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_DRV_STR_ENUM DDR4_DRV_STR_RZQ_7"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_RTT_NOM_ENUM DDR4_RTT_NOM_ODT_DISABLED"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_RTT_PARK DDR4_RTT_PARK_ODT_DISABLED"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_USE_DEFAULT_ODT 'false'"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_R_ODT0_1X1 off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_W_ODT0_1X1 off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_R_ODT0_2X2 off,off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_R_ODT1_2X2 off,off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_W_ODT0_2X2 off,off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_W_ODT1_2X2 off,off"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_DM_EN true"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_READ_DBI true"
## This is for the SODIMM interface      set_component_param   "fpga_emif MEM_DDR4_WRITE_DBI false"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_CONFIG_ENUM CONFIG_PHY_AND_HARD_CTRL"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_REF_CLK_FREQ_MHZ 133.333"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_DEFAULT_REF_CLK_FREQ false"
## This is for the SODIMM interface      set_component_param   "fpga_emif CTRL_DDR4_ECC_EN false"
## This is for the SODIMM interface      set_component_param   "fpga_emif CTRL_DDR4_ECC_AUTO_CORRECTION_EN false"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_DEFAULT_IO false"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_AC_IO_STD_ENUM IO_STD_SSTL_12"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_CK_IO_STD_ENUM IO_STD_SSTL_12"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_DATA_IO_STD_ENUM IO_STD_POD_12"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_AC_MODE_ENUM OUT_OCT_40_CAL"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_CK_MODE_ENUM OUT_OCT_40_CAL"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_DATA_OUT_MODE_ENUM OUT_OCT_34_CAL"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_DATA_IN_MODE_ENUM IN_OCT_60_CAL"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_PLL_REF_CLK_IO_STD_ENUM IO_STD_LVDS"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_USER_RZQ_IO_STD_ENUM IO_STD_CMOS_12"
## This is for the SODIMM interface      set_component_param   "fpga_emif DIAG_DDR4_EXPORT_SEQ_AVALON_SLAVE CAL_DEBUG_EXPORT_MODE_JTAG"
## This is for the SODIMM interface      set_component_param   "fpga_emif PHY_DDR4_MEM_CLK_FREQ_MHZ 1066.667"
## This is for the SODIMM interface      set_component_param   "fpga_emif DIAG_DDR4_SKIP_CA_DESKEW true"

      # ------ Ports export -------------------------------- #
      export fpga_emif local_reset_req       fpga_emif_local_reset_req 
      export fpga_emif local_reset_status    fpga_emif_local_reset_status 
      if {$fpga_emif_ecc_en == 1} {
      export fpga_emif ctrl_ecc_user_interrupt_0   fpga_emif_ctrl_ecc_user_interrupt 
      }
      export fpga_emif status                fpga_emif_status 
      export fpga_emif mem                   fpga_emif_mem 
      export fpga_emif oct                   fpga_emif_oct 
      export fpga_emif pll_ref_clk           fpga_emif_pll_ref_clk 
   }