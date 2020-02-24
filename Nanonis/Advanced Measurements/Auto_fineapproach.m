function Auto_fineapproach(session, basename, channel)

fgh1 = figure
hold on
title('Fine approach');
xlabel('Distance to full approach');
ylabel('Period');



% Load vis 
viBiasSpectroscopy = evalin('base', 'BiasSpectroscopy');
viZGet = evalin('base', 'ZPositionGet');
viZRamp = evalin('base', 'ZRamp');
viGS = evalin('base', 'Genericsweep');

% Perform initial period check
% Bias spectroscopy parameters configured in Nanonis Bias Spectroscopy
% Module!! (Except basename)
if strcmp(channel, "Bias (V)")==1
    viBiasSpectroscopy.SetControlValue('Basename', basename);
    viBiasSpectroscopy.Run;
else if strcmp(channel, "Output 3(V)")==1
        Genericsweep('Output 3 (V)', 0, 2, basename);
     else error('Wrong channel name');
     end
end


data = dir([session,'\',basename,'*.dat']);

path = [data(end).folder,'\',data(end).name];
[xdata(1,:) ,ydata(1,:), zdata(1,:)] = importbiasspectr(path);  
   
s = findbestfit(xdata(1, 3:end).', ydata(1, 3:end).',60);
period(1) = s(2);

% Get initial distance from full approached position
d = 4.25E-6 + viZGet.GetControlValue('Z current position');
k = 0.05;

yyaxis left;
scatter(d, period(end))
drawnow;

yyaxis right;
ylabel('k');
ylim([0, 0.1]);
scatter(d, k, 'filled');
drawnow;

% Fine approach loop
% Approach by k * current distance each steps and reduce k by half when a
% single approach reduce period by 5 %
while(period(end)>0.05 && d > 0.001E-6)
    viZRamp.SetControlValue('Target', - 4.25E-6 + d - k*d);
    viZRamp.Run;
    d = d - k*d;
    
    if strcmp(channel, "Bias (V)")==1
        viBiasSpectroscopy.Run;
        else if strcmp(channel, "Output 3(V)")==1
                Genericsweep('Output 3 (V)', 0, 2, basename);
             end
    end
    data = dir([session,'\',basename,'*.dat']);
    path = [data(end).folder,'\',data(end).name];
    [xdata(length(data),:) ,ydata(length(data),:), zdata(length(data),:)] = importbiasspectr(path);  
    
    s = findbestfit(xdata(length(data), 3:end).', ydata(length(data), 3:end).',60,period(end));
    period(end+1) = s(2);
    
    
    if period(end)/period(end-1) < 0.9
        k = k/2;
    end
    
    yyaxis left;
    scatter(d, period(end))
    drawnow;
    
    yyaxis right;
    scatter(d, k, 'filled');
    drawnow;
end
    
end
    