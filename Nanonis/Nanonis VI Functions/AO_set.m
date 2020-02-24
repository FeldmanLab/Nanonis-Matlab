function AO_set(vi, Channel, Value)
   
    vi.SetControlValue('Channel', Channel);
    vi.SetControlValue('Value', Value);
    vi.Run;

end