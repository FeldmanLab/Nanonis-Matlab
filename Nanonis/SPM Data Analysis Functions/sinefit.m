function  result = sinefit(x,y,varargin)

% Generate proper initial values for sinusoidal fit. The third argument
% passes a initial period. If it is not given, the function automatically
% generate a initial period value by finding the median of crossings with
% respect to y center line.
if nargin == -3
    per = varargin{1};
else
    y=smooth(y);
    yu = max(y);
    yl = min(y);
    yr = (yu-yl);                               % Range of ‘y’
    yz(1:length(y)-1) = 0;
    % Find zero crossings
    [x0, y0] = intersections(x(1:end-1),diff(y),x(1:end-1),yz);
    per = 2*median(diff(x0));
end


ym = mean(y);                               % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);    % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                          % Least-Squares cost function
options = optimset('MaxFunEvals',100000000000000000, 'TolFun', 1E-5, 'TolX', 1E-5);
[s, fval,exitflag] = fminsearch(fcn, [yr/2;  per;  0.5;  ym], options);                      % Minimise Least-Squares
result = [transpose(s), fval, exitflag];

if fval > 1E-19                     % Using fval to check if the fitting is correct
    exitflag = 0;
    
end

xp = linspace(min(x),max(x),1000);

figure(1)
plot(x,y,'b',  xp, fit(s,xp), 'r')
grid

% 
% vi = evalin('base','SETGlobal');
% 
% vi.SetControlValue('Period',s(2));
% vi.SetControlValue('Amplitude',s(1));
% vi.SetControlValue('Setpt', s(4));



end