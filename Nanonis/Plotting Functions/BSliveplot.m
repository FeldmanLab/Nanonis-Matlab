function varargout = BSliveplot(session, basename, varargin)

%% Get file names in the measurement session folder
%% Figure number could be optionally specified by varargin
%% Plotting to specified figure not realized yet. Use AppBSliveplot instead


data = dir([session,'\',basename,'*.dat']);

for i = 1:length(data)
       
    path = [data(i).folder,'\',data(i).name];
    
    [xdata(i,:) ,ydata(i,:), zdata(i,:)] = importbiasspectr(path);  
   
   
end

%% Plot
 if nargin == -3 %% If fig num specified, plot to this figure only
    figure(varargin{1});
    hold on;
 else
    figure;
 end
 
 f = surf(xdata(1,:),1:i,ydata(1:i,:), 'edgecolor', 'none'); view(2);
 title([basename, ' - DC']);
if nargin == -3
    figure(varargin{1}+1);
    hold on;
else
    figure;
end
h = surf(xdata(1,:),1:i,zdata(1:i,:), 'edgecolor', 'none'); view(2);
title([basename, ' - AC']);

end