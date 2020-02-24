function [z, period, position]=Z_analysis(session, basename, Start, End, Window)

period = [];
position = [];

%% Get file names in the measurement session folder

data = dir([session,'\',basename,'*.dat']);

for i = 1:length(data)
       
    path = [data(i).folder,'\',data(i).name];
    
    [xdata(i,:) ,ydata(i,:), zdata(i,:)] = importbiasspectr(path);  
    
    [s(1), s(2)] = findbestfit_np(xdata(i,2:end).',ydata(i,2:end).',Window);  % Window length defined here
   
    period(i) = s(2);
    position(i) = s(1); % The period position used to obtain sine fit
end

z = linspace(Start,End,length(data))

figure;
plot(z,period(1:end));
title('Period vs Z');
period = period(1:end)
position = position(1:end)