function tilt_compensation(basename, Start, End, Points)

%% Load VIs

MTTvi = evalin('base', 'MoveTipTo');
ZCBOvi = evalin('base', 'ZCboSpectroscopy');

%% Perform Z CBO Spectroscopy At Each Point
    % Move tip to UPPER LEFT
    MTTvi.SetControlValue('X', -17.2E-6);
    MTTvi.SetControlValue('Y', 17.2E-6);
    MTTvi.Run;
    
    ZCBOvi.SetControlValue('Save basename (empty= no change)', [basename, 'UPPER LEFT']);
    ZCBOvi.SetControlValue('Z Start', Start);
    ZCBOvi.SetControlValue('Z End', End);
    ZCBOvi.SetControlValue('Number of Points Z', Points);
    ZCBOvi.Run;
    
    % Move tip to UPPER RIGHT
    MTTvi.SetControlValue('X', 17.2E-6);
    MTTvi.SetControlValue('Y', 17.2E-6);
    MTTvi.Run;
    
    ZCBOvi.SetControlValue('Save basename (empty= no change)', [basename, 'UPPER RIGHT']);
    ZCBOvi.Run;
    
    % Move tip to LOWER LEFT
    MTTvi.SetControlValue('X', 17.2E-6);
    MTTvi.SetControlValue('Y', -17.2E-6);
    MTTvi.Run;
    
    ZCBOvi.SetControlValue('Save basename (empty= no change)', [basename, 'LOWER LEFT']);
    ZCBOvi.Run;
    
    % Move tip to LOWER RIGHT
    MTTvi.SetControlValue('X', -17.2E-6);
    MTTvi.SetControlValue('Y', -17.2E-6);
    MTTvi.Run;
    
    ZCBOvi.SetControlValue('Save basename (empty= no change)', [basename, 'LOWER RIGHT']);
    ZCBOvi.Run;
    
    % Move tip to CENTER
    MTTvi.SetControlValue('X', 0);
    MTTvi.SetControlValue('Y', 0);
    MTTvi.Run;
    
    ZCBOvi.SetControlValue('Save basename (empty= no change)', [basename, 'CENTER']);
    ZCBOvi.Run;
    
    

