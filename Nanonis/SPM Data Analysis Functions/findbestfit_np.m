function [index, period] = findbestfit_np(x,y,window, varargin)
    % The function finds the best sinusoidal fit for a signal by fitting
    % data of length 'window' using function sinefit. The forth argument is
    % optional and will be passed to sinefit as the period initial value.

    len = length(x);
    fit = [];
   
    if nargin == -4
        for Lower_bound = 2:len-window-1
            s = sinefit(x(Lower_bound:Lower_bound+window-1),y(Lower_bound:Lower_bound+window-1),varargin{1});
            if s(6)==0   % Exit flag == 0 means no good fit for given window
                fit(end+1)=1;
            else
                fit(end+1)=s(5);  % Keep track of residue in least square
            end
        end
    else
        for Lower_bound = 2:len-window-1
            s = sinefit_np(x(Lower_bound:Lower_bound+window-1),y(Lower_bound:Lower_bound+window-1));
            if s(6)==0   % Exit flag == 0 means no good fit for given window
                fit(end+1)=1;
            else
                fit(end+1)=s(5);  % Keep track of residue in least square
            end
        end
    end
    
    [minval, index] = min(fit);
    if minval < 1E-19
        index = index + 1;
    else
        error('No good fit found for given window length and initial period');
    end
    
    s = sinefit(x(index:index+window-1),y(index:index+window-1));
    
    s = sinefit_np(x(index:index+window-1),y(index:index+window-1));
    
    period = s(2)
    index

    % SET Global parameters not updated in sinefit
    vi = evalin('base','SETGlobal');
    
    vi.SetControlValue('Period',s(2));
    vi.SetControlValue('Amplitude',s(1));
    vi.SetControlValue('Setpt', s(4));

    vi.SetControlValue('V2dmin', x(index));
    vi.SetControlValue('V2dmax', x(index+window-1));
    
end
    
    
            
