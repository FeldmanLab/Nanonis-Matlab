function z_pos = coarse_appr(obj)  % Manual switching version
            
    s_vi = invoke(obj.Server, 'GetVIReference', [obj.vipath, '\Generic sweeper.vi'])
    z_vi = invoke(obj.Server, 'GetVIReference', [obj.vipath, '\Coarse_z.vi']);
            
    ans = questdlg('SET UNGROUNDED?', 'Operation', 'Yes');
    if strcmp(ans,'Yes')
    else
       error('Go home and sleep');
    end
            
    i = 1;
                
    s_vi.Run(true);
    quest = inputdlg('Type in period in unit of V');   % User read period from generic sweeper and input
    Per(i) = str2num(quest{1});
    z_pos(i) = 0;                % Z coarse position counter            
            
    importgenericsweeper
            
           
            
            
end
