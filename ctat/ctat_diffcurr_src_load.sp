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

