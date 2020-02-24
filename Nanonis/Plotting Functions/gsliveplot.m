function f = gsliveplot(session, basename, varargin)



%% Get file names in the measurement session folder

data = dir([session,'\',basename,'*.dat']);

for i = 1:length(data)
       
    path = [data(i).folder,'\',data(i).name];
    
    [xdata(i,:) ,ydata(i,:)] = importgenericsweep(path);  
   
   
end

if nargin == -3
    figure(varargin{1});
    hold on;
else
    figure;
end
    f = surf(xdata(1,:),1:i,ydata(1:i,:), 'edgecolor', 'none');

end