function [dudn, un] = compress_analysis(filepath)

figure;
hold on;
box on;
sgtitle(filepath);
set(gcf, 'Position',  [100, 100, 1200, 800]);
[CurrentA, BiasV, Output3V, Input2V, Input3V, LIDemod1XA, LIDemod1YA, VbgV] = importcompressibility(filepath);
[Setpt, V2dmin, V2dmax, Ampl, Per, x, y] = importcompinfo(filepath);


subplot(2,3,1)
dudn = Input2V./LIDemod1XA*(3/(5E3*9.14E15*1E9));
plot(VbgV, smooth(dudn,3));  % Compressibility smoothed with span of 3
title('Compressibility');
% ylim([-4E-17, 2E-16]);

subplot(2,3,2)
plot(VbgV, LIDemod1XA*1E9);
title('I2dAC');

subplot(2,3,3)
plot(VbgV, Input2V);
title('IbgAC');

subplot(2,3,5)
plot(VbgV, -Output3V); hold on;
title('V2dDC');
delta_V2d = num2str(-Output3V(end)+Output3V(2));
% if Setpt ~= -1
%     yline(-V2dmax, 'r');
%     yline(-V2dmin, 'm');
%     hold off;
% end



subplot(2,3,4)
plot(VbgV, CurrentA); hold on;
title('DC Current');

if Setpt ~= -1
    yline(Setpt);
    yline(Setpt+Ampl,'y');
    yline(Setpt-Ampl,'g');
    hold off;
end

subplot(2,3,6)
for i = 1:size(VbgV)-1
    un(i) = trapz(dudn(1:i))*9.14E15*abs(VbgV(end)-VbgV(end-1));
end
plot(VbgV(2:end),un);
ylabel('\mu/meV')
title('\mu(n)');


end



