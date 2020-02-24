function zfit(x, y)


fit = @(b,x)  b(1)+b(2)*(x+b(3)).^(-1);%+b(4).*x*log(1./(x-b(3)));    Approximate analytical form found in literature for two disks when d >> r
fcn = @(b) sum((fit(b,x) - y).^2);                             
options = optimset('MaxFunEvals',10000000);
s = fminsearch(fcn, [0.4;  -2E-4; 1E-6])
figure
title('Period vs Z');
xp = linspace(-1.5E-6,max(x),1000);
plot(x,y,'b',  xp,fit(s,xp), 'r')
title('Fitting Period vs Z (um)');
grid;

end