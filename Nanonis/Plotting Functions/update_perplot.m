function [z, per] = update_perplot(x, y, z, per, steps)
 
 fit = sinefit(x, y, per(end));
 newper = fit(2);
 z = [z, z(end)+steps]; 
 per = [per, newper]; 
 figure
 plot(z, per)
 (per(end)-per(end-1))/per(end-1)
 
end