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
    'MCMv331_J(Met,2)';...
    'O3Deposition'};

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
ModelOptions.IntTime       = 5*3600;
ModelOptions.SavePath      = 'IndoorAirFOAMModelOutput.mat';

%% MODEL RUN
% Now we call the model.
% Output will be saved in the "SavePath" above and will also be written to the structure S.
% Let's also throw away the inputs (don't worry, they are saved in the output structure).

S = F0AM_ModelCore(Met,InitConc,ChemFiles,BkgdConc,ModelOptions);
% clear Met InitConc ChemFiles BkgdConc ModelOptions

