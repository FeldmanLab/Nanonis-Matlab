classdef Nanonis < handle
    
    properties
        Server, % ActiveX server for Labview
        vipath, % Path for VIs
        session, % Current Nanonis session folder
        vilist, % Labview VI functions in 'vipath' folder
    end 
        
    properties (Access = private)

        
    end
    
    
    methods
        %% Basic functions
        function obj = Nanonis(varargin)  % Class constructor
            obj.Server = actxserver('LabVIEW.Application');  % Initializing server
            obj.vipath = 'C:\Users\STM\Documents\LabVIEW Data\Nanonis PI';  %  Setup VIs directory
            obj.vilist = obj.Load_vi;
            obj.session = obj.Get_session;

          
%             msgbox ('Please make sure Nanonis is running');
        end
        
        function vis = Load_vi(obj)  % Creating all vi interface objects
            % Extract vi paths from directory
            vidir = dir([obj.vipath, '\*.vi']);
            
            % Store vi name and interface obj in cell array vis{i}
            for i = 1:length(vidir)
                vis(i).viname = vidir(i).name;
                vis(i).viobj = invoke(obj.Server, 'GetVIReference', [vidir(i).folder, '\' ,vidir(i).name]);
                assignin('base', erase(matlab.lang.makeValidName(vis(i).viname,'ReplacementStyle','delete'),"vi"), vis(i).viobj);
            end
           
            obj.vilist = vis;
            
        end
       
        
        function index = findvi(obj, vi)  % Find the vi index in vilist
                str=[];
                for i = 1:length(obj.vilist)
                    str{end+1} = obj.vilist(i).viname;
                end
                index = find(strcmp(vi, str)==1);
    
        end
        
         function path = Get_session(obj)
            index = obj.findvi('Get session path.vi');
            vi = obj.vilist(index).viobj;
            vi.Run;
            path = vi.GetControlValue('Session path');
            obj.session = path;
        end
                
    end 
        
    methods (Static)
        %% Generic static methods
        function set(vi,varargin)  % Perform multiple SetControlValue operations
            for i=1:(nargin-1)/2
                vi.SetControlValue(varargin{2*i-1},varargin{2*i});
            end
            
        end
        
        
        function vis = Load_vi_static()  % Creating all vi interface objects
            % Extract vi paths from directory
            vidir = dir(['C:\Users\STM\Documents\LabVIEW Data\Nanonis PI', '\*.vi']);
            
            % Store vi name and interface obj in cell array vis{i}
            % Store all vi objects in the base workspace. 
            for i = 1:length(vidir)
                vis(i).viname = vidir(i).name;
                vis(i).viobj = invoke(actxserver('LabVIEW.Application'), 'GetVIReference', [vidir(i).folder, '\' ,vidir(i).name]);
                assignin('base', erase(matlab.lang.makeValidName(vis(i).viname,'ReplacementStyle','delete'),"vi"), vis(i).viobj);
            end
        end
        
            
            
    end
       

    
end