# BGR-_Bandgap-Reference-Circuit
This github repository is for the design of a Band Gap Reference Circuit (BGR) using Google-skywater130 PDK.

## Introduction to BGR

The Bandgap Reference (BGR) is a circuit which provides a stable voltage output which is independent of factors like temperature, supply voltage.

  
  <img width="560" height="218" alt="image" src="https://github.com/user-attachments/assets/fdad6fd0-6e50-40b8-b697-cef2c2500d20" />



### Why BGR

- A battery is unsuitable for use as a reference voltage source.
  - voltage drops over time

- A typical power supply is also not suitable.
  - noisy output and/or residual ripple.

- A voltage reference IC used buried Zener diode.
  - Discrete design required additional components and high frequency filtering circuits due to higher thermal noise.
  - Low voltage Zener diode is not available


### Solution


- A Bangap reference which can be integrated in bulk CMOS, Bi-CMOS or Bipolar technologies without the use of external components.



## Features Of BGR
- Temp. independent voltage reference circuit widely used in Integrated Circuits
- Produces constant voltage regardless of power supply variation, temp. Changes and circuit loading.
- Output voltage of 1.2v (close to the band gap energy of silicon at 0 deg kelvin).
- All applications starting from analog, digital, mixed mode, RF and system-on-chip (SoC).


## Applications Of BGR

- DC-to-DC buck converters.
- Analog-to-Digital Converter (ADC).
- Digital-to-Analog Converter (DAC).
- Low dropout regulators (LDO).



 # 1.Tools and PDK Setup

 ## 1.1 Tools Required

 For the simulation of circuits we will need the following tools.
 - Spice netlist simulation -[Ngspice](https://ngspice.sourceforge.io/).
 - Schematic Editor - [Xschem](https://xschem.sourceforge.io/stefan/index.html)

### Ngspice ###


<img width="200" height="80" alt="image" src="https://github.com/user-attachments/assets/8f2c2a5f-52c2-417e-883c-3446eb12e916" />


[Ngspice](https://ngspice.sourceforge.io/devel.html) is the open source spice simulator for electric and electronic circuits. Ngspice is an open project, there is no closed group of developers.

[Ngspice User Manual](https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml).Complete reference manual in HTML format.

### Xschem ###

<img width="200" height="80" alt="image" src="https://github.com/user-attachments/assets/831fb715-0a88-4c82-811f-ce6a320eb3e9" />

[Xschem](https://xschem.sourceforge.io/stefan/)is an open-source schematic capture tool for VLSI and electronics. It is designed to be lightweight, fast, and capable of handling large hierarchical circuits while remaining user-friendly.

[Xschem Reference Manual](https://xschem.sourceforge.io/stefan/xschem_man/xschem_man.html).Complete reference manual.


## 1.2 PDK Required ##

A process design kit (PDK) is a set of files used within the semiconductor industry to model a fabrication process for the design tools used to design an integrated circuit. The PDK is created by the foundry defining a certain technology variation for their processes. It is then passed to their customers to use in the design process.

The PDK is [Google Skywater 130 nm PDK](https://skywater-pdk.readthedocs.io/en/main/).


<img width="455" height="190" alt="image" src="https://github.com/user-attachments/assets/2afe1e47-67b5-48d4-a2b8-02763c6b650a" />

[All Details](https://skywater-pdk.readthedocs.io/en/main/rules/device-details.html).All basic details of PDK.


## 1.3 Install and Setup EDA Tools ##

### Windows Subsystem for Linux (WSL) for Open Source EDA tools ###

Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment on your Windows machine, without the need for a separate virtual machine or dual booting. With native X11 (graphics) support on WSL2, the latest WSL, in Winodws 10 version 2004+ (Build 19041+) or Windows 11, you can now run GUI apps including all the open-source EDA tools.

Now we will share instructions for installing WSL2 on Winodws 10/11 and install the EDA tools on a Ubuntu 24.04 distribution.


----------------------------------------------------------------------------------------------------------------------------------------------

# 2. BGR Introduction

### 2.1 BGR Principle

The operation principle of BGR circuits is to sum a voltage with negative temprature coefficient with another one exhibiting opposite temperature dependancies. Generally semiconductor diode behave as CTAT i.e. Complement to absolute temp. which means with increase in temp. the voltage across the diode will decrease. So we need to find a PTAT circuit which can cancel out the CTAT nature.


<img width="749" height="455" alt="image" src="https://github.com/user-attachments/assets/87b9d8bf-0960-454c-87f5-d9e5b5ffe0fe" />

### 2.1.1 CTAT Circuit Voltage Simulation 

Usually semiconductor diodes shows CTAT behaviour. If we consider constant current is flowing through a forwrard biased diode, then with increase in temp. we can observe that the voltage across the diode is decreaseing. Generally, it is found that the slope of the V~Temp is -2mV/deg Centigarde.

<img width="950" height="586" alt="image" src="https://github.com/user-attachments/assets/e75e53a8-988a-4e77-addf-d7c1b473e285" />



***The slope value will be decrease in the rate of-2mV/deg Centigrade.***


<img width="668" height="249" alt="image" src="https://github.com/user-attachments/assets/8e4def12-19a7-4814-9a65-d4af6ec7d714" />

### CTAT Voltage Generation With Single BJT.

```
*CTAT Voltage generation with single BJT
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss
vdd     d        0          1.8
I0      d        ctat_op    10u
xpq1    0        0          ctat_op   sky130_fd_pr__pnp_05v5_W3p40L3p40   m=1
.dc     temp    -40         125       5

.control
run
plot v(ctat_op)
plot deriv(v(ctat_op))
.endc

.end
```

<img width="596" height="436" alt="image" src="https://github.com/user-attachments/assets/82aee313-6838-4074-8713-18fec8455a92" />




***Deriv Value CTAT***

<img width="596" height="436" alt="image" src="https://github.com/user-attachments/assets/cb17530c-0796-4ddb-94f1-55a3fe7c7816" />

### CTAT Voltage Generation With Multiple BJT.

```
*CTAT_ckt Voltage generation with Multiple BJT
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss
vdd     d        0          1.8
I0      d        ctat_op    10u
xpq1    0        0          ctat_op   sky130_fd_pr__pnp_05v5_W3p40L3p40   m=8
.dc     temp    -40         125       5

.control
run
plot v(ctat_op)
plot deriv(v(ctat_op))
.endc

.end
```
<img width="592" height="436" alt="image" src="https://github.com/user-attachments/assets/9c6256c3-2e4f-4426-ad9f-ce9fcbc51aa0" />

<img width="592" height="436" alt="image" src="https://github.com/user-attachments/assets/eddba05d-69a9-4935-a458-67ab52c90a14" />


### CTAT Voltage generation with different current source values.

```
*CTAT_ckt Voltage generation with different current source values
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss
vdd     d        0          1.8
I0      d        ctat_op    10u
xpq1    0        0          ctat_op   sky130_fd_pr__pnp_05v5_W3p40L3p40   m=8
.dc     temp    -40         125       5      I0    1u    10u      1u

.control
run
plot v(ctat_op)
.endc

.end
```

<img width="703" height="533" alt="image" src="https://github.com/user-attachments/assets/18638d0f-9771-4cf1-bcfc-2e22c002af64" />

### PTAT Circuit Simulation 









