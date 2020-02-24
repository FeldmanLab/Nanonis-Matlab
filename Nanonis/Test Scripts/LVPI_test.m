% Try calling LV VIs using ActiveX

e = actxserver('LabVIEW.Application');
vipath = 'C:\Users\STM\Documents\LabVIEW Data\Nanonis PI\Generic sweeper test.vi';
vi = invoke(e, 'GetVIReference',vipath);
vi.SetControlValue('Slew Rate',0.5);
vi.Run;


% Set parameters to vis
% Data read and plot?