function Z_settings(vi, Home, Slew, Lift, Delay)

    vi.SetControlValue('Home position', Home); % In unit of m
    vi.SetControlValue('Withdraw slew rate', Slew); % In unit of m/s
    vi.SetControlValue('Tip lift', Lift); % Relative, in unit of m
    vi.SetControlValue('Switch off delay', Delay);  % In unit of s
    vi.Run;
    
end