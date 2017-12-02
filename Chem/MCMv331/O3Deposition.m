% mcm_indoor_air_model.m
% generated from mcm_indoor_air_model.fac
% 20171128
% # of species = 1813
% # of reactions = 5486

SpeciesToAdd = {'O3' };

RO2ToAdd = { };

AddSpecies

i=i+1;
Rnames{i} = 'O3';
k(:,i) = 10.;
Gstr{i,1} = 'O3'; 
fO3(i)=fO3(i)-1;
