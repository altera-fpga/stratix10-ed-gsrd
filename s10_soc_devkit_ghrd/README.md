# Stratix 10 Golden Hardware Reference Design (GHRD)

The GHRD is part of the Golden System Reference Design (GSRD), which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

## Build Steps
1) Customize the GHRD settings in Makefile. Only necessary when the defaults are not suitable.
2) Generate the Quartus Project and source files.
   - Use target from [Supported Designs](#supported-designs)
3) Compile Quartus Project and generate the configuration file
   - $ `make sof` or $ `make all`

## Supported Designs
### Baseline
This design boots from SD/MMC.
```bash
make generate-s10-htile-soc-devkit-oobe-baseline
```
### HPS Serial Gigabit Media Independent Interface (SGMII)
This design boots from SD/MMC and enabled SGMII with HPS EMAC and 1G/2.5G/5G/10G Multi-Rate Ethernet PHY Intel FPGA IP
```bash
make generate-s10-htile-soc-devkit-oobe-sgmii
```
### NAND
This design boots from nand.
```bash
make generate-s10-htile-soc-devkit-nand-baseline
```
### PCIe Gen3x8
This design boots from SD/MMC and has PCIe RootPort IP.
Refer: [L-Tile and H-Tile Avalon Memory-mapped Intel FPGA IP for PCI Express* User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683667/23-4/introduction.html) and [Stratix 10 PCIe Root Port with MSI](https://www.rocketboards.org/foswiki/Projects/Stratix10PCIeRootPortWithMSI) for more information.
```bash
make generate-s10-htile-soc-devkit-oobe-pcie-gen3x8
```

## GHRD Overview

### Hard Processor System (HPS)
The GHRD HPS configuration matches the board schematic. Refer to [Stratix 10 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/683222/current) and [Intel Stratix 10 Hard Processor System Component Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/683516/current) for more information on HPS configuration.

### HPS External Memory Interfaces (EMIF)
The GHRD HPS EMIF configuration matches the board schematic. Refer to
[External Memory Interfaces Stratix 10 FPGA IP User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683741/current) for more information on HPS EMIF configuration.

### HPS-to-FPGA Address Map for all designs
The MPU region provide windows of 4 GB into the FPGA slave address space. The lower 1.5 GB of this space is mapped to two separate addresses - firstly from 0x8000_0000 to 0xDFFF_FFFF and secondly from 0x20_0000_0000 to 0x20_5FFF_FFFF. The following table lists the offset of each peripheral from the HPS-to-FPGA bridge in the FPGA portion of the SoC.

Refer to [Intel Stratix 10 Hard Processor System Address Map and Register Definitions](https://www.intel.com/content/www/us/en/programmable/hps/stratix-10/hps.html) for details.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| ocm | 0x0 | 256K | On-chip RAM as scratch pad |

### System peripherals
The the memory map of system peripherals in the FPGA portion of the SoC as viewed by the MPU (Cortex-A53), which starts at the lightweight HPS-to-FPGA base address of 0xF900_0000, is listed in the following table.

Note: All interrupt sources are also connected to an interrupt latency counter (ILC) module in the system, which enables System Console to be aware of the interrupt status of each peripheral in the FPGA portion of the SoC.

#### Lightweight HPS-to-FPGA Address Map for all designs
| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| sysid | 0x0000_0000 | 8 | Unique system ID   | None |
| led_pio | 0x0000_1080 | 16 | 4 x LED outputs   | None |
| button_pio | 0x0000_1060 | 16 | 4 x Push button inputs | 1 |
| dipsw_pio | 0x0000_1070	 | 16 | 4 x DIP switch inputs | 0 |
| ILC | 0x0000_1100 | 256 | Interrupt latency counter | None |

Note:
-  Only the lower three bits of LED outputs are available for software to control. The most significant bit of the LED is used in GHRD top module as heartbeat led. This LED blinks when the fpga design is loaded. Users will not be able to control this LED with HPS software, for example U-Boot or Linux.

#### Lightweight HPS-to-FPGA Address Map for SGMII design
| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| hps_mge | 0x0000_3000 | 256 | CSR ethernet subsystem | None |
| mge_led_pio | 0x0000_0100 | 16 | 13 x Inputs Collections for status of ethernet | None |
| mge_rcfg_pio | 0x0000_0110 | 16 | 4 x Input Collections for ethernet reconfiguration status | None |

Note: hps_mge is ethernet subsystem.
This is view within hps_mge. When accessing in HPS, offset of 0xF900_0000 + 0x0000_3000 is required.
The CSR is used to controll the following IPs:
| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| hps_to_mge_gmii_adapter_1 | 0x0000_0040 | 8 | HPS EMAC to Multirate PHY GMII Adapter 1 | None |
| alt_mge_phy_1 | 0x0000_0000 | 64 | 1G/2.5G/5G/10G Multirate Ethernet PHY 1 | None |
| hps_to_mge_gmii_adapter_2 | 0x0000_00C0 | 8 | HPS EMAC to Multirate PHY GMII Adapter 2 | None |
| alt_mge_phy_2 | 0x0000_0080 | 64 | 1G/2.5G/5G/10G Multirate Ethernet PHY 2 | None |

### JTAG master interfaces
The GHRD JTAG master interfaces allows you to access peripherals in the FPGA with System Console, through the JTAG master module. This access does not rely on HPS software drivers.

Refer to this [Guide](https://www.intel.com/content/www/us/en/docs/programmable/683819/current/analyzing-and-debugging-designs-with-84752.html) for information about system console.

### Address Map Specific for PCIE design
The Address Map for this design is consolidated in this section.

#### HPS-to-FPGA Address Map for PCIe design
The MPU region provide windows of 4 GB into the FPGA slave address space. The lower 1.5 GB of this space is mapped to two separate addresses - firstly from 0x8000_0000 to 0xDFFF_FFFF and secondly from 0x20_0000_0000 to 0x20_5FFF_FFFF. The following table lists the offset of each peripheral from the HPS-to-FPGA bridge in the FPGA portion of the SoC.

Refer to [Intel Stratix 10 Hard Processor System Address Map and Register Definitions](https://www.intel.com/content/www/us/en/programmable/hps/stratix-10/hps.html) for details.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| pcie_0.hptxs | 0x1000_0000 | 256M | Avalon MM Slave of PCIe HIP HPTXS port |
| pcie_0.hip_reconfig | 0x2000_0000 | 2M | Avalon MM Slave of PCIe HIP Reconfig port |

#### Lightweight HPS-to-FPGA Address Map for PCIe design
The the memory map of system peripherals in the FPGA portion of the SoC as viewed by the MPU (Cortex-A53), which starts at the lightweight HPS-to-FPGA base address of 0xF900_0000, is listed in the following table.

| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| pcie_link_stat_pio | 0x0000_0200 | 16 | 14 x pcie link status input collection | None |
| pcie_0.pb_lwh2f_pcie | 0x0001_0000 | 2M | PCIEe subsystem CSR  | None |
| axi_bridge_for_acp_0 | 0x0000_0210 | 8 | Simple ACE-LITE bridge to condition DOMAIN, BAR, SNOOP, CACHE, and PROT ports for ACP operation | None |

Note: pcie_0.pb_lwh2f_pcie is PCIe subsystem.
This is view within pcie_0. When accessing in HPS, offset of 0xF900_0000 + 0x0000_3000 is required.
| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| pcie_s10.cra | 0x0000_0000 | 32K | CSR for PCIe Control Register Access (CRA) interface | 3 |
| msi_irq.vector_slave | 0x0000_8000 | 128 | agent interface for MSI | None |
| msi_irq.csr | 0x0000_8080 | 16 | CSR for Message Signaled Interrupts (MSI) | 2 |
| perf_cnt_0 | 0x0000_80a0 | 32 | CSR for performance counter (for hardware benchmarking) | None |

Note: MSI and CRA IRQs are not connected to ILC.

### Interrupt Num
The Interrupt Num in this readme are FPGA IRQ. They have offset of 17 when mapped to Generic Interrupt Controller (GIC) in device tree structure(dts). Refer to F2H FPGA Interrupt[0] in [GIC Interrupt Map for the SoC HPS](https://www.intel.com/content/www/us/en/docs/programmable/683222/current/gic-interrupt-map-for-the-soc-hps-stratix.html).
Number 49 is shown for F2H FPGA Interrupt[0] as the first 32 IRQ is reserved. (49 - 32 = 17).

## Binaries location
After build, the design files (sof and rbf) can be found in output_files folder.
