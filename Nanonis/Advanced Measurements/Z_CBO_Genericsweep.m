% This function performs the same experiment as vi 'Z CBO Spectroscopy',
% namely taking CBOs at different z positions
% However it sweeps an AO signal rather than BIAS, so that BIAS
% SPECTROSCOPY module is not used and all parameters are configured as
% inputs of this function. It uses function 'Genericsweep.m', which is a
% function built based on vi 'Generic sweep'

function Z_CBO_Genericsweep(Channel, Start, End, Steps, ZStart, ZEnd, ZSteps, Basename)


    % Load Z Ramp vi

    ZRampVi = evalin('base', 'ZRamp');
    
    
    z = linspace(ZStart, ZEnd, ZSteps);
    
    for i = 1:ZSteps
        ZRampVi.SetControlValue('Target', z(i));
        ZRampVi.Run;
        Genericsweep(Channel, Start, End, Steps, Basename);  % Run Generic sweeper at each height saved as 'basenamexxxxx.dat'
    end
    
    % Home tip when done, be sure home position is safe/Check Z limit
    BSliveplot(Nanonis.Get_session, Basename); % Plot when done
    ZRampVi.SetControlValue('Target', 0);
    ZRampVi.Run;