BJT Common emitter (Biased input)

.include './lib/npn.lib'

vin in gnd ac 1 sin(0 0.5 500)
Cin in bb 10u
R1 bb vc 90.5k
R2 bb gnd 5k
Q1 cc bb ee Q2N2222A
Re ee gnd 500
*r3 ee ex 100
*ce ex gnd 1.6m
Rc cc vc 10k
Vcc vc gnd DC 42
Co cc out 10u
Rl out gnd 10k

.probe i(Rl)
.probe i(Q1,2)
.probe i(Q1,1)

.model QMOD NPN

.control
shell mkdir -p results plots

set units = degrees
set wr_singlescale

ac dec 100 1e-2 100k
wrdata 'results/voltages_ac.txt' db(v(out)) cph(out)

tran 10u 5m
setplot tran1
wrdata 'results/voltages.txt' v(in) v(out) v(cc) v(cc,ee)
wrdata 'results/currents.txt' q1:b#branch q1:c#branch Rl#branch
wrdata 'results/transistor.txt' v(cc,ee) q1:b#branch q1:c#branch 
echo $plots
shell gnuplot amplifier3.gpi
.endc
