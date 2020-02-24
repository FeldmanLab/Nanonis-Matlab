function I = Current_avg_get()
    vi = evalin('base','CurrentAvgGet');
    vi.Run(true);
    I = vi.GetControlValue('Current');
end