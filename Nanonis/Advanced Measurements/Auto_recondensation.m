%% Establish connection to LS350
t = tcpip('192.168.236.12',7777);  
fopen(t);


%% Recondensation protocol
fprintf(t, 'RANGE 1,4');  % Heat sorb at range 4 for 1 hour
pause(3600);
fprintf(t, 'RANGE 1,5');  % Heat sorb at range 5 for 1 hour
pause(14400);
fprintf(t, 'RANGE 1,0');  % Turn off sorb after four hours of recondensation
