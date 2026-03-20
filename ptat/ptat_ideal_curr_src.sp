*Difference of ctat ckt is PTAT ckt

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

