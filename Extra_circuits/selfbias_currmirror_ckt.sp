**************** CMOS Current Mirror (WORKING) ****************

.title CMOS Current Mirror Correct Bias

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

**************** Supply ****************
VDD vdd gnd dc 1.8

**************** Reference Branch ****************
* Use resistor to create VGS
RREF vdd ref 100k

* Diode-connected NMOS
XMN1 ref ref gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=1 m=1

**************** Output Branch ****************
XMN2 out ref gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=1 m=4

**************** Output Sweep ****************
VOUT out gnd dc 0

.dc VOUT 0 1.8 0.01

.control
run

* Output current
plot -i(VOUT)

* Check gate voltage
plot v(ref)

.endc

.end

