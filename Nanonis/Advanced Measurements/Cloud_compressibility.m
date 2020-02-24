function Cloud_compressibility(session, basename, start, endp, points, period, v2d)
    
    %% Load vis into function
    SCGvi = evalin('base', 'ScanCloudGet');
    
    BCvi = evalin('base', 'BiasCompressibility');
    
    MTTvi = evalin('base', 'MoveTipTo');
   
    ZRTvi = evalin('base', 'ZRamp');
    
    AOvi = evalin('base', 'AOSafeRamp');
    
    %% Get Cloud Points Coordinates
    SCGvi.Run;
    X = SCGvi.GetControlValue('X');
    Y = SCGvi.GetControlValue('Y');
    
    %% Perform Bias Compressibility Spectroscopy At Each Point
    for i = 1:length(X)
        % Move tip to position
        MTTvi.SetControlValue('X', single(X(i)));
        MTTvi.SetControlValue('Y', single(Y(i)));
        MTTvi.Run;
        
        % Check period and update tip working parameters (V2d = Output 3 (V))
        update_set_para(session, 'Output 3 (V)');
        
        % Set initial V2d to the ideal point specified by v2d
        AOvi.SetControlValue('Target', v2d);
        AOvi.SetControlValue('Channel name', 'Output 3 (V)');
        AOvi.Run;
        
        % Perform measurement
        BCvi.SetControlValue('Start (V)', start);
        BCvi.SetControlValue('End (V)', endp);
        BCvi.SetControlValue('N points', points);
        BCvi.SetControlValue('Average period (s)', period);
        BCvi.SetControlValue('Basename', basename);
        BCvi.Run(true);  % Run asynchronously
        
    end
end
        
        
        