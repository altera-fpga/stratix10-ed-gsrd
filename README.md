# Stratix 10 Golden Hardware Reference Design (GHRD)

The GHRD is part of the Golden System Reference Design (GSRD), which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

Refer to the [Stratix 10 SoC GSRD](https://altera-fpga.github.io/latest/embedded-designs/stratix-10/sx/soc/gsrd/ug-gsrd-s10sx-soc/) for information about GSRD.

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
## Advanced feature
  - PCIe Rootport IP
  - SGMII with HPS EMAC and 1G/2.5G/5G/10G Multi-Rate Ethernet PHY Intel FPGA IP

## Dependency
* Altera Quartus Prime 25.3
* Supported Board
  - Intel Stratix 10 SX SoC Development Kit

## Tested Platform for the GHRD Make flow
* SUSE Linux Enterprise Server 15 SP4

## Supported Designs
### Baseline
This design boots from SD/MMC.
```bash
make s10-htile-soc-devkit-baseline-all
```
### HPS Serial Gigabit Media Independent Interface (SGMII)
This design boots from SD/MMC and enabled SGMII with HPS EMAC and 1G/2.5G/5G/10G Multi-Rate Ethernet PHY Intel FPGA IP
```bash
make s10-htile-soc-devkit-sgmii-all
```
### NAND
This design boots from nand.
```bash
make s10-htile-soc-devkit-nand-all
```
### PCIe Gen3x8
This design boots from SD/MMC and has PCIe RootPort IP.
```bash
make s10-htile-soc-devkit-pcie-gen3x8-all
```

## Install location
After build, the design files (zip, sof and rbf) can be found in install/designs folder.