% This code is written to fit the core-shell spherical DEP polarization
% model to experimental data collected with the 3DEP analyzer (LabTech,
% East Sussex, UK). Cell electrical properties and transient slope are and
% computed. Written by Drs. Tayloria N.G. Adams and Tunglin "Anthony" Tsai.

% clear;clc;close all;                           % GUI Clean up

% Load CSV file containing experimental data
[file, path] = uigetfile('*.csv');             % Only allow *.csv files
[num, txt] = xlsread(strcat(path,file));       % Use xlsread to extract values into number and text array
fprintf('Loading %s\n',strcat(path,file))      % Print out the loaded file

% Defining input variables
x1 = num(5:end,1);                             % Locate the frequencies 
y1 = num(5:end,2);                             % Locate the response


Rmembrane     = num(1,1)/1e6;                  % Radius of the cell membrane (m)
Smedium1      = num(2,1)/10000;                % Conductivity of the medium, (S/m), (current 100uS/cm = 0.01S/m)

Evacuum       = 8.85e-12;                      % Permittivity of the vaccumm (unitless)
Emedium       = 78 * Evacuum;                  % Permittivity of the medium, unitless 
Membranethick = 10e-9;                         % Thickness of the cell membrane (m)

fprintf(['=> Defined Paramters:\n',                                                            ...
    '  --------------------------------------------------------------------------------\n',    ...
    '   Permittivity of Vacuum [F/m], [unitless]        =  [%0.3e], [%3.2f]\n',               ...
    '   Permittivity of Medium [F/m], [unitless]        =  [%0.3e], [%3.2f]\n',               ...
    '   Medium Conductivity [S/m], [uS/cm]                   =  [%0.3e], [%3.2f]\n',               ...
    '   Cell Radius [m], [um]                                =  [%0.3e], [%3.2f]\n',               ...
    '   Membrane Thickness [m], [nm]                         =  [%0.3e], [%3.2f]\n',               ...
    '  --------------------------------------------------------------------------------\n\n'], ...
    Evacuum, 1, Emedium, Emedium/Evacuum, Smedium1, Smedium1*10000, Rmembrane, Rmembrane*1e6, Membranethick, Membranethick*1e9);


% Initial Guesses
x0    = [50*Evacuum,    15*Evacuum,     0.3,    1e-5,     max(y1)/1];
x_min = [10*Evacuum,    10*Evacuum,     0.01,   1e-14,      0.5];
x_max = [78*Evacuum,    200*Evacuum,    1.0,    1e-2,       2];

fprintf(['=> Fitting Parameters                                      Lower Bound (x_min)     Initial Guess (x0)     Upper Bound (x_max)\n', ...
    '  ---------------------------------------------------     -------------------     ------------------     -------------------\n',      ...
    '   Permittivity of the Cytoplasm [F/m], [unitless]     =  [%0.3e], [%3.2f]    [%0.3e], [%3.2f]    [%0.3e], [%3.2f]\n',                    ...
	'   Permittivity of the Membrane [F/m], [unitless]      =  [%0.3e], [%3.2f]    [%0.3e], [%3.2f]    [%0.3e], [%3.2f]\n',                    ...    
	'   Conductivity of the Cytoplasm [S/m]                 =  [%0.4f]                [%0.4f]                [%0.3f]\n'                       ...
    '   Conductivity of the Membrane [S/m]                  =  [%0.3e]             [%0.3e]             [%0.3e]\n'                             ...    
	'   Linear Scalar (unitless)                            =  [%0.2f]                  [%0.2f]                  [%0.2f]\n',                  ...
    '  --------------------------------------------------------------------------------------------------------------------------\n\n'],   ...
	x_min(1), x_min(1)/Evacuum, x0(1), x0(1)/Evacuum, x_max(1), x_max(1)/Evacuum,   ...
	x_min(2), x_min(2)/Evacuum, x0(2), x0(2)/Evacuum, x_max(2), x_max(2)/Evacuum,   ...
	x_min(3), x0(3), x_max(3),                                                      ...
	x_min(4), x0(4), x_max(4),                                                      ...
	x_min(5), x0(5), x_max(5));

% Fminsearch section
options = optimset('PlotFcns',@optimplotfval);
fun     = @(x)residual(x1,y1,Evacuum,Emedium,Smedium1,Rmembrane,Membranethick,x); % x = [Ecyto,Emembrane1,Scyto,Smembrane]
xfinal  = fminsearchbnd(fun, x0, x_min, x_max, options);

% Fitting Results ==> xf = [Ecyto,Emembrane1,Scyto,Smembrane]
Ecyto         = xfinal(1);             % Permittivity of the cytoplasm, unitless
Emembrane1    = xfinal(2);             % Permittivity of the cell membrane, unitless
Scyto         = xfinal(3);             % Conductivity of the cytoplasm, (S/m)
Smembrane     = xfinal(4);             % Conductivity of the cell membrane, (S/m)
y1            = y1./xfinal(5);         % Back-propagate the scailing factor into y1

% Goodness of fit calculation
xfinal_ymodel   = depf(Evacuum,Emedium,Ecyto,Emembrane1,Scyto,Smembrane,Smedium1,Rmembrane,Membranethick,x1);
xfinal_SSE      = sum((y1-xfinal_ymodel).^2);
xfinal_SSTO     = sum((y1-mean(y1)).^2); 
xfinal_r_square = 1-xfinal_SSE/xfinal_SSTO; 

fprintf(['=> Converged Values (xfinal)\n',                                                     ...
    '  --------------------------------------------------------------------------------\n',    ...
    '   Permittivity of the Cytoplasm [F/m], [unitless] =  [%0.3e], [%3.2f]\n',               ...
    '   Permittivity of the Membrane [F/m], [unitless]  =  [%0.3e], [%3.2f]\n',               ...
    '   Conductivity of the Cytoplasm [S/m]                 =  [%0.3e] \n',                      ...
    '   Conductivity of the Membrane [S/m]                  =  [%0.3e] \n',                      ...
    '      **R-squared-value                                =  [%3.3f] \n',                      ...
    '  --------------------------------------------------------------------------------\n\n'], ...
    xfinal(1), xfinal(1)/Evacuum, xfinal(2), xfinal(2)/Evacuum, xfinal(3), xfinal(4), xfinal_r_square)

% calculating membrane capacitance
f   = @(x)depf(Evacuum,Emedium,Ecyto,Emembrane1,Scyto,Smembrane,Smedium1,Rmembrane,Membranethick,x);
fx0 = fzero(f,1e4);
Cm  = sqrt(2)*Smedium1/(2*pi*Rmembrane*fx0); % Estimation using crossover frequency (F/m^2)
Cm2 = xfinal(2)/Membranethick;               % Calculation using permittivity

fprintf(['=> Calculated Values \n',                                                         ...
    '  --------------------------------------------------------------------------------\n', ...
    '   Crossover Frequency [Hz]                                                    = [%3.0f]\n',            ...
    '   Membrane Capacitance Estimated with Crossover Frequency [mF/m^2]            = [%3.3f]\n',            ...
    '   Membrane Capacitance Estimated with Permittivity [mF/m^2]                   = [%3.3f]\n'],           ...
    fx0, Cm*1000, Cm2*1000)



%Plot the model& data points on overlaid semilog graph
freq          = 10.^linspace(log10(1e3),log10(1e10),10000); 
RealFcm1      = depf(Evacuum,Emedium,Ecyto,Emembrane1,Scyto,Smembrane,Smedium1,Rmembrane,Membranethick,freq);


figure(1)
semilogx(x1,y1,'o', freq,RealFcm1,'r')
xlim([1e3, 1e8]); ylim([-0.5, 1.5]);

% Calculate the transient slope
% 1. Only retain the left side of Clausius-Mosotti model curve.
    slopecalc_y = RealFcm1(1:find(RealFcm1 == max(RealFcm1),1));
    slopecalc_x = freq(1:find(RealFcm1 == max(RealFcm1),1));
% 2. Get the 20% and 80% cutoff value for linear fitting from Clausius-Mossoti vector slopecalc_y
    slopecalc_lb = min(slopecalc_y) + 0.2 * (max(slopecalc_y)-min(slopecalc_y));
    slopecalc_ub = min(slopecalc_y) + 0.8 * (max(slopecalc_y)-min(slopecalc_y));
% 3. Further trim the x and y vector to retain only values between lb and ub
    slopecalc_x = slopecalc_x(slopecalc_y > slopecalc_lb & slopecalc_y < slopecalc_ub);
    slopecalc_y = slopecalc_y(slopecalc_y > slopecalc_lb & slopecalc_y < slopecalc_ub);
% 4. Perform linear transformation so x is log10(freq, Hz)
    slopecalc_x = log10(slopecalc_x);
    [P,S] = polyfit(slopecalc_x,slopecalc_y,1);
	r_square = 1 - (S.normr/norm(slopecalc_y - mean(slopecalc_y)))^2;
    
fprintf([                                                                                    ...
    '   Transient Slope [a.u./Hz]                                                   = [%3.4f\n]',             ...
    '      **R-squared-value                                                       = [%3.3f]\n',             ...
    '  --------------------------------------------------------------------------------\n'], ...
    P(1),r_square)
    
figure(1)
semilogx(x1,y1,'o', freq,RealFcm1,'r',freq,polyval(P,log10(freq)),'g')
xlim([1e3, 1e8]); ylim([-0.5, 1.5]);
title ('DEP Spectrum');
xlabel('Frequency (Hz)');
ylabel('Re(F_C_M)');

