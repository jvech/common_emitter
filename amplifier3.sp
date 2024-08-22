BJT Common emitter (Biased input)

.include './lib/npn.lib'

vin in gnd ac 1 sin(0 1 120)
Cin in bb 10u
R1 bb vc 40k
R2 bb gnd 10k
Q1 cc bb ee Q2N2222A
Re ee gnd 1k
*r3 ee ex 74
*ce ex gnd 16u
Rc cc vc 3.5k
Vcc vc gnd DC 10
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

tran 0.1m 75m
setplot tran1
wrdata 'results/voltages.txt' v(in) v(out) v(cc) v(cc,ee)
wrdata 'results/currents.txt' q1:b#branch q1:c#branch Rl#branch
wrdata 'results/transistor.txt' v(cc,ee) q1:b#branch q1:c#branch 
echo $plots
shell gnuplot amplifier3.gpi
.endc
