**************** BGR STARTUP CIRCUIT (VERIFIED) ****************

.title Startup Circuit with Proper Feedback

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

**************** Supply ****************
VDD vdd gnd 1.8

**************** Emulated BGR Core ****************
* This mimics PTAT node rising with time
IBIAS net1 gnd DC 5uA
C1 net1 gnd 10p

**************** Startup Circuit ****************
* net1 = BGR bias node
* net6 = startup node

* MP4: weak pull-up
XMP4 net6 net1 vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.15

* MP5: inject startup current
XMP5 net1 net6 vdd vdd sky130_fd_pr__pfet_01v8 w=5 l=0.15

* MN3: turn OFF path
XMN3 net6 net1 gnd gnd sky130_fd_pr__nfet_01v8 w=2 l=0.15

**************** Simulation ****************
.tran 1n 10u

.control
run

plot v(net1) v(net6)

.endc

.end
