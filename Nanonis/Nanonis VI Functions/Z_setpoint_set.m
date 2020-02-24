function z = Z_setpoint_set(vi, val)
    
%% Set current setpoint
    vi.SetControlValue('Z setpoint', val);
    vi.Run;
    z = vi.GetControlValue('Z setpoint');
    
end