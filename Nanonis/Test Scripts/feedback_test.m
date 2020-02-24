function V2dnew = feedback_test(V2d, Iset)
    vi = evalin('base', 'SETFeedback1');
    vi.SetControlValue('Dummy current', Iset);
    vi.SetControlValue('V2d', V2d);
    vi.Run;
    V2dnew = vi.GetControlValue('V2dnew');
end