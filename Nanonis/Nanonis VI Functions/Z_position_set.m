function z = Z_position_set(vi, val)
    
    vi.SetControlValue('Z position', val);
    vi.Run;
    z = vi.GetControlValue('Z position');
    
end