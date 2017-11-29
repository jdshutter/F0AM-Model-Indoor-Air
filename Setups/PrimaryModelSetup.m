% IndoorAirFOAMSetup.m
%

clear

%% METEOROLOGY
%{
Pressure, temperature, and either RH or H2O are required Met inputs.
We will assume them constant throughout the simulation,
  thus we need only specify a single (scalar) value for each.
We have also specified a text file containing a spectral actinic flux (wavelength and photons/cm^2/s),
  which will be used to calculate J-values. This particular spectrum was measured on a real
  chamber (thanks to John Crounse).
%}

Met = {...
%   names       values          
    'P'         1013                       ; %Pressure, mbar
    'T'         298                        ; %Temperature, K
    'RH'        10                         ; %Relative Humidity, percent
    'LFlux'     'ExampleLightFlux.txt'     ; %Text file for radiation spectrum
    'jcorr'     1                          ; %light attenuation factor
    };

%% CHEMICAL CONCENTRATIONS
%{
Common chemical species and concentrations found indoors
%}

InitConc = {...
%   names         conc(ppbv)           HoldMe
    'O3'             20.0                0;
    'NO'              6.9                0;
    'NO2'            28.0                0;
    'HONO'            5.2                0;
    'TOLUENE'         0.89               0;
    'LIMONENE'        0.35               0;
    'APINENE'         0.9                0;
    'C5H8'            0.93               0;
    'OXYL'            2.3                0;
    'PXYL'            4.6                0;
    'MXYL'            4.6                0;
    'BENZENE'         3.1                0;
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
    'mcm_indoor_air_model';
    };

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

ModelOptions.Verbose       = 1;
ModelOptions.EndPointsOnly = 0;
ModelOptions.LinkSteps     = 0;
ModelOptions.Repeat        = 1;
ModelOptions.IntTime       = 3*3600;
ModelOptions.SavePath      = 'ChamberExampleOutput.mat';

%% MODEL RUN
% Now we call the model.
% Output will be saved in the "SavePath" above and will also be written to the structure S.
% Let's also throw away the inputs (don't worry, they are saved in the output structure).

S = F0AM_ModelCore(Met,InitConc,ChemFiles,BkgdConc,ModelOptions);
% clear Met InitConc ChemFiles BkgdConc ModelOptions

%% PLOTTING
% Now, a few examples of how to look at the model output.

% First, let's separate each of the steps since they each represent a different experiment.
% "SplitRun" will make three new structures, S1, S2 and S3, corresponding to each of the
% three steps with different initial NO2 (0.1, 1 and 10 ppbv).

SplitRun(S,'step')

% Next, let's look at some time series for our fav molecules.
% Note that you can also do this yourself with the model output structures,
%   e.g. plot(S1.Time,S1.Conc.C5H8)
% The UWCM-provided functions are just more convenient for comparing multiple simulations.
% Look at the documentation for each function to get an idea of available options.

Splot = {S1,S2,S3};
lnames = {'low','mid','hi'};
PlotConc('C5H8',Splot,'lnames',lnames)
PlotConc('OH',Splot,'unit','percc','scale',1e-6,'lnames',lnames)
PlotConc('NO+NO2',Splot,'unit','pptv','lnames',lnames)

PlotConcGroup(S3.Cnames(S3.iRO2),S3,5,'ptype','fill','unit','ppb','name','RO_2')

% Now, let's dig in and look at the chemistry.

PlotRates('PAN',S1,4,'ptype','fill','unit','ppt_h','sumEq',1);

pts2avg = S1.Time>1800 & S1.Time<3600; %average 2nd 30 minutes
PlotRatesAvg('HCHO',S1,5,'ptype','hbar','unit','ppb_h','pts2avg',pts2avg)

Inorg = {'Inorganic';'CO';'H2';'O3';'HO2';'H2O2'};
Reactants = {Inorg; 'NO2'; 'C5H8'; 'HCHO'; 'MVK'; 'MACR'};
PlotReactivity('OH',S3,Reactants,'ptype','line');

%finally, let's look at the total yield of HPALDs in the low-NOx case
yieldWindow = [500 1000]; %time window, seconds
PlotYield(S1,'C5H8',{'C5HPALD1','C5HPALD2'},yieldWindow);

%% EVENTS
% Finally, let's say you continue the second experiment for longer, but with more lights.

[InitConc,Met] = Run2Init(S2,length(S2.Time)); %get initialization values
Met{4,2} = 10; %increase jcorr x10
ModelOptions.IntTime = 3600;
ModelOptions.SavePath  = 'ChamberExampleHighLightsOutput.mat';

S2b = F0AM_ModelCore(Met,InitConc,ChemFiles,BkgdConc,ModelOptions);

S2b.Time = S2b.Time+S2.Time(end);
figure
PlotConc('C5H8',{S2,S2b})


