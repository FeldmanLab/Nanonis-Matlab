function Coarse_xyz(Freq,Dir,Steps)
    
    e = actxserver('LabVIEW.Application');
    vipath = 'C:\Users\STM\Documents\LabVIEW Data\Nanonis PI\Coarse_z.vi'
    vi = invoke(e, 'GetVIReference',vipath);
    switch Dir
        case 'X+' 
            index = 0;
        case 'X-' 
            index = 1;
        case 'Y+' 
            index = 2;
        case 'Y-' 
            index = 3;
        case 'Z+' 
            index = 4;
        case 'Z-' 
            index = 5;
    end
    vi.SetControlValue('Frequency',Freq);
    vi.SetControlValue('Number of steps',Steps);
    vi.SetControlValue('Direction',index);
    vi.Run(true);
end