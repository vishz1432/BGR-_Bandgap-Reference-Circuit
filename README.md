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

## 2.1.1 CTAT Circuit Voltage Simulation 

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

## 2.1.2 PTAT Circuit Simulation 

***CTAT BJT Equations***

The collector current of a BJT diode-connected device is:

$$
I_D = I_S e^{\frac{V_D}{V_t}}
$$

Rearranging for the diode voltage:

$$
V_D = V_t \ln\left(\frac{I_0}{I_S}\right)
$$

The thermal voltage is defined as:

$$
V_t = \frac{kT}{q}
$$

The saturation current of the BJT is:

$$
I_S = A \mu k T n_i^2
$$

Carrier mobility temperature dependence:

$$
\mu \propto \mu_0 T^m
$$

where

$$
m = -\frac{3}{2}
$$

The intrinsic carrier concentration:

$$
n_i^2 \propto T^3 e^{\left(\frac{-E_g}{kT}\right)}
$$

Substituting the above relationships into the saturation current expression:

$$
I_S = A T^{(4+m)} e^{\left(\frac{-E_g}{kT}\right)}
$$


 
 From Diode current equation we can find that it has two parts, i.e.
  - Vt (Thermal Voltage) which is directly proportional to the temp. (order ~ 1)
  - Is (Reverse saturation current) which is directly proportional to the temp. (order ~ 2.5), as this Is term is in denominator so with increase in temp. the ln(Io/Is) decreases which is responsible for CTAT nature of the diode.


So to get a PTAT Voltage generation circuit we have to find some way such that we can get the Vt separated from Is.

To get Vt separated from Is we can approach in the following way

<img width="364" height="331" alt="image" src="https://github.com/user-attachments/assets/25ab5c9f-b7e3-4ecb-a218-5558ad07f12c" />

### PTAT Voltage Generation

PTAT (Proportional To Absolute Temperature) voltage is widely used in **bandgap reference circuits**.  
It is generated using two BJTs operating at the same current but having different emitter areas.

---

### BJT Collector Current Equation

The collector current of a BJT is given by:

$$
I_C = I_S e^{\frac{V_{BE}}{V_T}}
$$

where:

- $I_C$ = Collector current  
- $I_S$ = Saturation current  
- $V_{BE}$ = Base-emitter voltage  
- $V_T$ = Thermal voltage  

---

### Thermal Voltage

The thermal voltage is defined as:

$$
V_T = \frac{kT}{q}
$$

where:

- $k$ = Boltzmann constant  
- $T$ = Absolute temperature  
- $q$ = Electron charge  

At **300 K**,  

$$
V_T \approx 26 \, mV
$$

---

### Base-Emitter Voltage

Rearranging the BJT current equation:

$$
V_{BE} = V_T \ln\left(\frac{I_C}{I_S}\right)
$$

---

### Two-Transistor Configuration

For two BJTs operating at the **same current** but with **different emitter areas**:

Emitter area ratio:

$$
1 : N
$$

Since saturation current is proportional to emitter area:

$$
I_{S2} = N \cdot I_{S1}
$$

---

### Base-Emitter Voltages

For transistor $Q_1$:

$$
V_{BE1} = V_T \ln\left(\frac{I}{I_{S1}}\right)
$$

For transistor $Q_2$:

$$
V_{BE2} = V_T \ln\left(\frac{I}{I_{S2}}\right)
$$

Substituting $I_{S2} = N I_{S1}$:

$$
V_{BE2} = V_T \ln\left(\frac{I}{N I_{S1}}\right)
$$

---

### PTAT Voltage (ΔVBE)

Taking the difference between the two base-emitter voltages:

$$
\Delta V_{BE} = V_{BE1} - V_{BE2}
$$

$$
\Delta V_{BE} = V_T \ln(N)
$$

Substituting $V_T$:

$$
\Delta V_{BE} = \frac{kT}{q} \ln(N)
$$

Since temperature $T$ appears in the numerator, this voltage is **Proportional To Absolute Temperature (PTAT)**.

---

### PTAT Current

If a resistor $R$ is connected across $\Delta V_{BE}$:

$$
I_{PTAT} = \frac{\Delta V_{BE}}{R}
$$

Substituting $\Delta V_{BE}$:

$$
I_{PTAT} = \frac{V_T \ln(N)}{R}
$$

or

$$
I_{PTAT} = \frac{kT}{qR} \ln(N)
$$

Thus the generated current is **PTAT current**.

---

### Summary

The PTAT voltage generated is:

$$
\Delta V_{BE} = \frac{kT}{q} \ln(N)
$$

The PTAT current generated is:

$$
I_{PTAT} = \frac{kT}{qR} \ln(N)
$$

These PTAT quantities are combined with **CTAT voltage ($V_{BE}$)** in bandgap reference circuits to generate a **temperature-independent reference voltage**.

$$
V_{REF} = V_{BE} + k \cdot \Delta V_{BE}
$$


***In the above circuit same amount of current I is flowing in both the branches. So the node voltage A and B are going to be same V. Now in the B branch if we substract V1 from V, we get Vt independent of Is.***



### PTAT Voltage Derivation

The base-emitter voltage of a BJT is given by:

$$
V = V_t \ln\left(\frac{I}{I_S}\right)
$$

For a second transistor with emitter area ratio \(1:N\):

$$
V_1 = V_t \ln\left(\frac{I/N}{I_S}\right)
$$

---

### Difference of Base-Emitter Voltages

Subtracting the two voltages:

$$
V - V_1 = V_t \ln(N)
$$

This voltage difference is commonly denoted as:

$$
\Delta V_{BE} = V_t \ln(N)
$$

---

### PTAT Relationship

Since

$$
V_t = \frac{kT}{q}
$$

we get:

$$
\Delta V_{BE} = \frac{kT}{q} \ln(N)
$$

Here:

- \(V_t\) is **Proportional To Absolute Temperature (PTAT)**
- \(\ln(N)\) is a **constant**

Therefore:

$$
\Delta V_{BE} \propto T
$$

---

### Thermal Voltage

The thermal voltage is defined as:

$$
V_t = \frac{kT}{q}
$$

where:

- \(k\) = Boltzmann constant  
- \(T\) = absolute temperature  
- \(q\) = electron charge  

---

### Temperature Coefficient

The temperature derivative of the thermal voltage is:

$$
\frac{dV_t}{dT} = \frac{k}{q}
$$

Numerically,

$$
\frac{k}{q} \approx 85 \, \mu V / ^\circ C
$$

---

### Final PTAT Expression

$$
\Delta V_{BE} = V_t \ln(N)
$$

This voltage is **Proportional To Absolute Temperature (PTAT)** and is widely used in **bandgap reference circuits**.

### NOW

```
V= Combined Voltage across R1 and Q2 (CTAT in nature but less sloppy)
V1= Voltage across Q2 (CTAT in nature but more sloppy)
V-V1= Voltage across R1 (PTAT in nature)
```



From above we can see that the voltage V-V1 is PTAT in nature, but it's slope is very less as compared to the CTAT, so we have to increase the slope. In order to increase the slope we can use multiple BJTs as diode, so that current per individual diode will be less and it the slope of V-V1 will increase.



<img width="604" height="505" alt="image" src="https://github.com/user-attachments/assets/9bf8aade-4736-4e28-b157-7cf44ce969b5" />

### PTAT Voltage generation with ideal current source



<img width="851" height="586" alt="image" src="https://github.com/user-attachments/assets/23a0ca2f-7290-40e4-9c93-c114110fda2c" />


```
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss
vdd     d        0           1.8
I0      d        ctat_op     10u
I1      d        ctat_op1    10u
xpq1    0        0           ctat_op    sky130_fd_pr__pnp_05v5_W3p40L3p40   m=1
xpq2    0        0           ctat_op1   sky130_fd_pr__pnp_05v5_W3p40L3p40   m=8
.dc     temp    -40          125              5

.control
run
plot v(ctat_op) v(ctat_op1)
let ptat_op = v(ctat_op)-v(ctat_op1)
plot ptat_op
.endc

.end
```


<img width="697" height="537" alt="image" src="https://github.com/user-attachments/assets/00433c20-cb0d-4ad5-8d32-363bbc36dfbc" />



<img width="702" height="538" alt="image" src="https://github.com/user-attachments/assets/1f9d5f0f-71cb-49c1-8dbe-735a75e44376" />


### PTAT voltage generation across resistor


<img width="849" height="588" alt="image" src="https://github.com/user-attachments/assets/5dd06bf9-aee9-42b3-9245-e926e40f118a" />

```
*Difference in resistor voltage is PTAT
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss
vdd     d        0           1.8
I0      d        ra1         10u
xra1    ra1      na1         d       sky130_fd_pr__res_high_po_1p41      w=1.41  l=7.8
xra2    na1      na2         d       sky130_fd_pr__res_high_po_1p41      w=1.41  l=7.8
xra3    na2      na3         d       sky130_fd_pr__res_high_po_1p41      w=1.41  l=7.8
xra4    na2      na3         d       sky130_fd_pr__res_high_po_1p41      w=1.41  l=7.8
xpq1    0        0           na3     sky130_fd_pr__pnp_05v5_W3p40L3p40   m=8
.dc     temp    -40          125              5

.control
run
let  ptat_op = v(ra1)-v(na3)
plot v(na3) v(ra1)
plot ptat_op
.endc

.end
```

<img width="702" height="532" alt="image" src="https://github.com/user-attachments/assets/daf38e19-4154-4d05-bf46-b79973e334a8" />



<img width="693" height="536" alt="image" src="https://github.com/user-attachments/assets/df4cc3c3-b832-40a7-a5f3-53f72a1031e9" />


## 2.1.3 Resistance Tempco 


We know that resistor also behaves as PTAT, i.e the voltage across the resistor also increases with increase in the temp. In our BGR the PTAT voltage we are getting is not only by the virtue of Vt(Thermal voltgae) but with the additional PTAT voltage of the resistance.


### Resistor Temperature Coefficient (Tempco) Equations

 ***Ohm’s Law***

The resistance of a resistor is calculated using Ohm’s Law:

$$
R = \frac{V}{I}
$$

where

- \(R\) = Resistance  
- \(V\) = Voltage across the resistor  
- \(I\) = Current through the resistor  

---

### Resistance as a Function of Temperature

The resistance of a material varies with temperature according to:

$$
R(T) = R_0 \left(1 + \alpha (T - T_0)\right)
$$

where

- \(R(T)\) = Resistance at temperature \(T\)  
- \(R_0\) = Resistance at reference temperature \(T_0\)  
- \(\alpha\) = Temperature coefficient of resistance  

---

### Temperature Coefficient of Resistance

The temperature coefficient (Tempco) is defined as:

$$
\alpha = \frac{1}{R}\frac{dR}{dT}
$$

where

- \(dR/dT\) = Rate of change of resistance with temperature  
- \(R\) = Resistance at reference temperature  

---

### Approximate Tempco Calculation

Using two temperature points from simulation:

$$
\alpha \approx \frac{R_2 - R_1}{R_1 (T_2 - T_1)}
$$

where

- \(R_1\) = Resistance at temperature \(T_1\)  
- \(R_2\) = Resistance at temperature \(T_2\)

---

### Resistance Extraction in Simulation

In NGSPICE, resistance is calculated as:

$$
R = \frac{V(ra1)}{I_{vid}}
$$

where

- \(V(ra1)\) = Voltage at node **ra1**  
- \(I_{vid}\) = Current through voltage source **vid**

---

### Temperature Sweep

The temperature is swept during simulation using:

$$
T = -40^\circ C \rightarrow 125^\circ C
$$

to observe how the resistance changes with temperature.

---

### Summary Equation

The overall temperature dependence of resistance is given by:

$$
R(T) = R_0 \left(1 + \alpha (T - T_0)\right)
$$

This equation describes the **temperature coefficient behavior of resistors**, which is critical in precision analog circuits such as **bandgap references and temperature sensors**.

```
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global vdd gnd
.temp 27

*** resistor definition
xra1    ra1     na1     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra2    na1     na2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra3    na2     qp2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra4    na2     qp2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8

*** supply current
vsup    vdd     gnd     dc      2
vid     qp2     gnd     dc      0
isup    gnd     ra1     dc      10u

.dc     temp    -40     125     1

*** control statement
.control
run
plot v(ra1)
plot v(ra1)/vid#branch
.endc

.end
```




<img width="701" height="537" alt="image" src="https://github.com/user-attachments/assets/b5e59e0c-217c-4f53-8f47-2b00722a186e" />



From the above curve we can find that the Voltage across the resistnace is increasing with increase in temp., i.e. the PTAT nature.


Now to find the temco. we have to find the change in resistance w.r.t temp. The tempco. can be found from the slope of the following curve.


<img width="702" height="532" alt="image" src="https://github.com/user-attachments/assets/7772ab07-6282-47d2-bc42-28060a66c04e" />



Also we can find the PTAT voltages across the resistance for different current values from the following curve.

```
**** RES tempco circuit *****

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global vdd gnd
.temp 27

*** resistor definition
xra1    ra1     na1     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra2    na1     na2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra3    na2     qp2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8
xra4    na2     qp2     vdd     sky130_fd_pr__res_high_po_1p41     w=1.41  l=7.8

*** supply current
vsup    vdd     gnd     dc      2
vid     qp2     gnd     dc      0
isup    gnd     ra1     dc      10u

.dc     temp    -40     125     1     isup    1.25u    10u    1.25u

*** control statement
.control
run
plot v(ra1)
plot v(ra1)/vid#branch
.endc

.end
```



<img width="700" height="542" alt="image" src="https://github.com/user-attachments/assets/91d3214c-011e-433d-b189-bc3b770fae35" />












# 2.2 Types Of BGR Circuit


Architecture wise BGR can be designed in two ways.
- By Using Self-biased current mirror.
- By Using Operational-amplifier.


Application wise BGR can be categorized as
- High-PSRR and low-noise BGR.
- Low-power BGR.
- Low-voltage BGR.
- Curvature compensated BGR.


**We are going to design our BGR circuit using Self-biased current mirror architecture.**

## 2.2.1 Self-biased current mirror based BGR.
----------------------------------------------

The Self-biased current mirror based constitute of the following components.

- CTAT voltage generation circuit.
- PTAT voltage generation circuit.
- Self-biased current mirror circuit.
- Reference branch circuit.
- Start-up circuit.

***Now We are Using all the basic details for the components for the design .***

### CTAT Voltage generation circuit.

The CTAT Voltage generation circuit consist of a BJT connected as a diode, which shows CTAT nature as explained above.

<img width="183" height="243" alt="image" src="https://github.com/user-attachments/assets/6e913281-f6e0-457f-a325-4793438a4d8f" />


###  PTAT Voltage generation circuit

The PTAT Voltgae generation circuit consist of N BJTs connected with a series resistance. The operation principle is explained above.

<img width="393" height="399" alt="image" src="https://github.com/user-attachments/assets/9d240b72-50da-42f3-99ea-026db982cc43" />

### Self-Biased Current Mirror Circuit

The Self-biased current mirror is a type of current mirror which requires no external biasing. This current mirrors biases it self to the desired current value without any external current source reference.


<img width="358" height="301" alt="image" src="https://github.com/user-attachments/assets/b738c91d-abb6-4710-b395-3057ef4da178" />


### Reference Branch Circuit


The reference circuit branch performs the addition of CTAT and PTAT volages and gives the final reference voltage. We are using a mirror transitor and a BJT as diode in the reference branch. By virtue of the mirror transistor in the reference branch the same amount of current flows through it as of the current mirror branches. Now from the PTAT circuit branch we are getting PTAT voltage and PTAT current. The same PTAT current is flowing in the reference branch. But the slope of PTAT voltage is much more smaller than that of slope of CTAT voltgae. In order to make increase the voltage slope we have to increase the resistance (current constant, so V increases with increase in R). Now across the high resistance we will get our constant reference voltage which is the result of CTAT Voltage + PTAT Voltage.



<img width="137" height="386" alt="image" src="https://github.com/user-attachments/assets/19ccb3a5-54fc-4f5b-aa4f-916cae4e2019" />


### Start-up circuit

The start-up circuit is required to move out the self biased current mirror from degenerative bias point (zero current). The start-up circuit forecefully flows a slow amount of current through the self-biased current mirror when the current is 0 in the current mirror branches, as the current mirror is self biased this small current creats a disturbance and the current mirror auto biased to the desired current value.



  <img width="521" height="434" alt="image" src="https://github.com/user-attachments/assets/c6ff982a-23a4-477c-90bb-254963ffbc64" />


----------------------
  ***Now Finally the BGR  Circuit***


  ## Complete BGR Circuit


Now by connecting all above components we can get the complete BGR circuit.

  <img width="751" height="490" alt="image" src="https://github.com/user-attachments/assets/26885a62-a125-4ed0-8284-d58444dc5494" />


-----------------------------

  Advantages of SBCM BGR:
  - Easy to design.
  - Always stable.
  - Simplest topology.


Limitations of SBCM BGR:
- Voltage head-room issue.
- Cacode design needed to reduce PSRR.
- Low power supply rejection ratio (PSRR).
- Need start-up circuit


































