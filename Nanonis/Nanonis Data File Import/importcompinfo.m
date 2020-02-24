function [Setpt, V2dmin, V2dmax, Ampl, Per, x, y] = importcompinfo(filepath)
% This function read the relevant parameters of a Bias Compressibility scan
% data, in addition to the numerical data from function
% 'importcompressibility.m'. Used in 'compress_analysis.m' etc. for
% plotting & visualizting & data analysis.

% Datafiles generated before 2/15/2020 do not contain SET info

    fid = fopen(filepath);
    
    % SET parameters are at the very beginning of the data file
    % Check if the datafile format contains SET parameters
    s = fgetl(fid);
    A = sscanf(s, '%s %f');
    if A(1)==83 && A(2)==101
        frewind(fid);
        s = fgetl(fid);
        Setpt = sscanf(s, 'Setpt %f');
        s = fgetl(fid);
        V2dmin = sscanf(s, 'V2dmin %f');
        s = fgetl(fid);
        V2dmax = sscanf(s, 'V2dmax %f');
        s = fgetl(fid);
        Ampl = sscanf(s, 'Amplitude %f');
        s = fgetl(fid);
        Per = sscanf(s, 'Period %f');
    else
        Setpt = -1; % Return -1 if data file does not contain compress info
        V2dmin = [];
        V2dmax = [];
        Ampl = [];
        Per = [];
    end
    
    
    % Move cursor to the last two lines of the attributes
    % The line before x coordinate is Z controller switch off delay info
    [line, n] = sscanf(fgetl(fid), 'Z-Controller>Switch off delay (s)	%f');
    while(n ~= 1)
        s = fgetl(fid);
        [line, n] = sscanf(s, 'Z-Controller>Switch off delay (s)	%f');
    end
    
    s = fgetl(fid);
    x = sscanf(s, '%f');
    s = fgetl(fid);
    y = sscanf(s, '%f');
    
    