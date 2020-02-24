%% Test silicon back gate sample script

k2410 = Keithley2400_RS232;
Ivi = evalin('base', 'CurrentAvgGet');

k2410.setvolt(0);
k2410.output_on;
figure;
VG = [];
I = [];

for vbg = -50:0.05:60
    k2410.rampvolt(vbg);
    Ivi.Run;
    VG(end+1) = vbg;
    I(end+1) = Ivi.GetControlValue('Current');
%     scatter(vbg,0.002/I(end));
%     hold on;
end

k2410.rampvolt(0);
k2410.output_off;
figure;
title('Si Bg Sweep');
yyaxis left;

plot(VG,(0.000002./I));
ylabel('Resistance/kOhm');

yyaxis right;
plot(VG, I);
ylabel('Current/A');