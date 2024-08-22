BJT Common emitter (Coupling output capacitor)

.include './lib/npn.lib'

vin in gnd ac 1 sin(0 1 120)
Vbb x in DC 2
Rb x bb 20k
Q1 cc bb gnd Q2N2222A
Rc cc vc 400
Vcc vc gnd DC 10
Co cc out 470u
Rl out gnd 1k

.probe i(Rl)
.probe i(Q1,2)
.probe i(Q1,1)

.model QMOD NPN

.control
shell mkdir -p results plots

set wr_singlescale
compose vcc_values values 10 5
compose vbb_values values 2 1

ac dec 100 1e-2 500
set units = degrees
wrdata 'results/voltages_ac.txt' db(out) cph(out)


foreach vcc_value $&vcc_values
foreach vbb_value $&vbb_values
    alter vbb $vbb_value
    alter vcc $vcc_value
    tran 0.1m 75m
    run
end
end
setplot tran1
wrdata 'results/voltages.txt' v(in) v(out) tran3.v(out) tran2.v(out)
wrdata 'results/currents.txt' q1:b#branch q1:c#branch Rl#branch
wrdata 'results/transistor.txt' q1:b#branch v(cc) 
+                               tran3.q1:b#branch tran3.v(cc)
+                               tran2.q1:b#branch tran2.v(cc)

echo $plots
shell gnuplot amplifier2.gpi
.endc
