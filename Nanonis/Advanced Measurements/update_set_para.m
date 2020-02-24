function [position, period] = update_set_para(session, channel)
    % This function automatically perform a V2d sweep and updates the
    % working parameters of the tip
    % Find newest .dat file
    Genericsweep(channel, -2, 2, 400, 'SET parameter update');
    pause(5);
    
    % Find the newest datafile with basename 'SET parameter update'
    list = dir([session,'\','SET parameter update','*.dat']);
    index = sscanf(list(end).name, ['SET parameter update', '%d', '.dat']);
    if index < 1
               error('No datafile with basename found');
               else if index < 10
               counter = strcat("0000", num2str(index));
               else if 10 <= index <100
               counter = strcat("000", num2str(index));
               else if 100 <= index < 999
               counter = strcat("00", num2str(index));
               end
               end
               end
    end
    
    % Update parameters in SET Global.vi (from sinefit())
    
    path = strcat(session, '\', 'SET parameter update', string(counter), '.dat');
    [V2dV, ISET] = importbiasspectr(path);
    [position, period] = findbestfit_np(V2dV, ISET, 40);
    
end