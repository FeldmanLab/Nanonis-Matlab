function AppBSliveplot(Start, End, Ax1, Ax2, session, basename)
        % Bias spectroscopy type datafile live plot function for SPMUI apps

        data = dir([session,'\',basename,'*.dat']);

        for i = 1:length(data)
       
            path = [data(i).folder,'\',data(i).name];
        
            [xdata(i,:) ,ydata(i,:), zdata(i,:)] = importbiasspectr(path);  

        end

        %% Plot

        surf(Ax1, xdata(1,:),linspace(Start, End, i), ydata(1:i,:), 'edgecolor', 'none'); view(2);
        title([basename, ' - DC']);

        surf(Ax2, xdata(1,:),linspace(Start, End, i), zdata(1:i,:), 'edgecolor', 'none'); view(2); 
        title([basename, ' - AC']);

        end