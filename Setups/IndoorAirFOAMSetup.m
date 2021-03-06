% IndoorAirFOAMSetup.m
%
clear

%% METEOROLOGY
%{
Pressure, temperature, and either RH or H2O are required Met inputs.
We will assume them constant throughout the simulation,
  thus we need only specify a single (scalar) value for each.
We have also specified a text file containing a spectral actinic flux (wavelength and photons/cm^2/s),
  which will be used to calculate J-values.
%}

Met = {...
%   names     values          
    'P'       1013                           ; %Pressure, mbar
    'T'       298                            ; %Temperature, K
    'RH'      50                             ; %Relative Humidity, percent
    'LFlux'   'Sunlight_PhotonFlux.txt'           ; %Text file for radiation spectrum
    'jcorr'   1                              ; %light attenuation factor
    'kdil'    0                              ; %dilution factor /s
    };

%% CHEMICAL CONCENTRATIONS
%{
Common chemical species and concentrations found indoors
%}

InitConc = {...
%   names         conc(ppbv)           HoldMe
    'O3'              20.0               0;
    'NO'              10                 0;
    'NO2'             40                 0;
    'HONO'            5.0                0;
    'H2O2'            1.0                0;
    'LIMONENE'        70.0               0;
    'APINENE'         0.9                0;
    'C5H8'            0.93               0;
    'OXYL'            2.3                0;
    'PXYL'            4.6                0;
    'MXYL'            4.6                0;
    'BENZENE'         3.1                0;
    'TOLUENE'         0.89               0;
    };

%% CHEMISTRY
%{
The ChemFiles input is a cell array of strings
 specifying functions and scripts for the chemical mechanism.
THE FIRST CELL is always a function for generic K-values.
THE SECOND CELL is always a function for J-values (photolysis frequencies).
All other inputs are scripts for mechanisms and sub-mechanisms.
Here we give an example using MCMv3.3.1.  Note that this mechanism was extracted from the MCM website for
the specific set of initial species included above (isoprene and inorganics).
%}

ChemFiles = {...
    'MCMv331_K(Met)';...
    'MCMv331_J(Met,1)';...
    'mcm_indoor_air_model'};


%% DILUTION CONCENTRATIONS
% We are not diluting the chamber air, so this input is irrelevant (but still necessary).

BkgdConc = {...
%   names           values
    'DEFAULT'       0;   %0 for all zeros, 1 to use InitConc
    };

%% OPTIONS
%{
"Verbose" can be set from 0-3; this just affects the level of detail printed to the command
  window regarding model progress.
"EndPointsOnly" is set to 0 because we want output to include all concentrations along each model step.
"LinkSteps" is set to 0 because each step is fully independent.
"Repeat" is set to 1 because we only want to go through each step once.
"IntTime" is the integration time for each step. Let's pretend each experiment lasts 3 hours.
"SavePath" is commented out, so output will be saved in a dated folder in the \Runs\ folder.
%}

ModelOptions.Verbose        = 1;
ModelOptions.EndPointsOnly  = 0;
ModelOptions.LinkSteps      = 0;
ModelOptions.Repeat         = 1;
ModelOptions.IntTime        = 1*3600;
ModelOptions.SavePath       = 'Surface_0_HIGHVOC.mat';

%% MODEL RUN
% Now we call the model.
% Output will be saved in the "SavePath" above and will also be written to the structure S.
% Let's also throw away the inputs (don't worry, they are saved in the output structure).

S = F0AM_ModelCore(Met,InitConc,ChemFiles,BkgdConc,ModelOptions);

%Lumping Species into Chemical Families
S.Conc.NOx = S.Conc.NO + S.Conc.NO2;
S.Conc.AROMAS = S.Conc.OXYL + S.Conc.PXYL + S.Conc.MXYL + S.Conc.BENZENE + S.Conc.TOLUENE;
S.Conc.HOx = S.Conc.OH + S.Conc.HO2;

% clear Met InitConc ChemFiles BkgdConc ModelOptions

% Next, let's look at some time series for our fav molecules.
% Note that you can also do this yourself with the model output structures,
%   e.g. plot(S1.Time,S1.Conc.C5H8)
% The UWCM-provided functions are just more convenient for comparing multiple simulations.

 %Splot = {S};
 %lnames = {'Standard'};
 %PlotConc('O3',Splot,'unit','ppbv','lnames',lnames)

Sp2plot = {'O3','NOx','HONO','H2O2', 'APINENE','LIMONENE','AROMAS','C5H8', 'HCHO'};
n2plot = {};
PlotConcGroup(Sp2plot,S,n2plot,'ptype','line')

%Sp2plot = {'NO', 'NO2', 'NOx','HNO3','HOx',};
%n2plot = {};
%PlotConcGroup(Sp2plot,S,n2plot,'ptype','line')


% PlotConcGroup(S3.Cnames(S3.iRO2),S3,5,'ptype','fill','unit','ppb','name','RO_2')
% 
% % Now, let's dig in and look at the chemistry.
% 
%PlotRates('NO2',S,6,'ptype','fill','unit','ppb_h','sumEq',1);
% 
%pts2avg = S.Time>1800 & S.Time<3600; %average 2nd 30 minutes
%PlotRatesAvg('O3',S,5,'ptype','hbar','unit','ppb_h','pts2avg',pts2avg)
% 
% Inorg = {'Inorganic';'CO';'H2';'O3';'HO2';'H2O2'};
% Reactants = {Inorg; 'NO2'; 'C5H8'; 'HCHO'; 'MVK'; 'MACR'};
% PlotReactivity('OH',S3,Reactants,'ptype','line');
% 
% %finally, let's look at the total yield of HPALDs in the low-NOx case
 %yieldWindow = [500 1000]; %time window, seconds
 %PlotYield(S,'O3',{'C5HPALD1','C5HPALD2'},yieldWindow);
% 
