# Stratix 10 Baseline Hardware Reference Designs

This repository contains Baseline Hardware Reference Designs for Altera Stratix 10 System On Chip (SoC) FPGA.
This repository is part of the Baseline System Example Design, which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

Refer to the [HPS Baseline System Example Design User Guide: Stratix 10 SoC Development Kit](https://altera-fpga.github.io/latest/embedded-designs/stratix-10/sx/soc/gsrd/ug-gsrd-s10sx-soc/) for more information.

This reference design demonstrating the following system integration between Hard Processor System (HPS) and FPGA IPs:
## Baseline feature
This is applicable to all designs.
- Hard Processor System enablement and configuration
  - HPS Peripheral and I/O (eg, NAND, SD/MMC, EMAC, USB, SPI, I2C, UART, and GPIO)
  - HPS Clock and Reset
  - HPS FPGA Bridge and Interrupt
- HPS EMIF configuration
- System integration with FPGA IPs
  - SYSID
  - Programmable I/O (PIO) IP for controlling DIPSW, PushButton, and LEDs)
  - FPGA On-Chip Memory

## Dependency
* Altera Quartus Prime 26.3
* Supported Board
  - Stratix 10 SX SoC Development Kit

## Tested platform for the hardware build flow
* SUSE Linux Enterprise Server 15 SP4

## Supported Designs
### Baseline
This design boots from SD/MMC.
```bash
make s10-htile-soc-devkit-oobe-baseline-all
```
### NAND
This design boots from NAND.
```bash
make s10-htile-soc-devkit-nand-baseline-all
```
### EMMC
This design boots from EMMC.
```bash
make s10-htile-soc-devkit-emmc-baseline-all
```

## Install location
After build, the design files (zip, sof and rbf) can be found in install/designs folder.
