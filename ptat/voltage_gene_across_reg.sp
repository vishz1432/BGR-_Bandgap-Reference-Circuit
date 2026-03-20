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

