simplest emitter

.include './lib/npn.lib'

vin in gnd sin(0 1 120)
Vbb x in DC 2
Rb x bb 20k
Q1 cc bb gnd Q2N2222A
Rc cc vc 400
Vcc vc gnd DC 10
Rl cc gnd 1k

.probe i(Rl)
.probe i(Q1,2)
.probe i(Q1,1)

.model QMOD NPN

.control
shell mkdir -p results plots

compose vcc_values values 10 5
compose vbb_values values 2 1

foreach vcc_value $&vcc_values
foreach vbb_value $&vbb_values
    alter vbb $vbb_value
    alter vcc $vcc_value
    tran 0.1m 75m
end
end

setplot tran1
set wr_singlescale
wrdata 'results/voltages.txt' v(in) v(cc) tran3.v(cc) tran2.v(cc) 
wrdata 'results/currents.txt' q1:b#branch Rl#branch q1:c#branch
wrdata 'results/transistor.txt' q1:b#branch v(cc) 
+                               tran3.q1:b#branch tran3.v(cc)
+                               tran2.q1:b#branch tran2.v(cc)
shell gnuplot amplifier1.gpi
.endc
