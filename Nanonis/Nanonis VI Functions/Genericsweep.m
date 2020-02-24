function Genericsweep(Channel, Start, End, Steps, Basename)
    
% Channel does not include bias

    GSvi = evalin('base', 'Genericsweep');
    
    
    GSvi.SetControlValue('Sweep signal', Channel);
    GSvi.SetControlValue('Lower limit', Start);
    GSvi.SetControlValue('Upper limit', End);
    GSvi.SetControlValue('Save basename (empty= no change)', Basename);
    GSvi.SetControlValue('Number of steps', Steps);
    
    GSvi.Run;

end

