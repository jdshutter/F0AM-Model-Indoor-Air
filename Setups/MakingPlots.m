%% Figures Pertinent to Indoor Air Project %%




%% Varying Initial O3 Mixing Ratio %%

% LOW VOC Scenario
figure, plot(O3_0ppb_LOWVOC_TIME,O3_0ppb_LOWVOC_O3,'k')
hold on 
plot(O3_200ppt_LOWVOC_TIME,O3_200ppt_LOWVOC_O3,'b')
hold on 
plot(O3_400ppt_LOWVOC_TIME,O3_400ppt_LOWVOC_O3,'r')
hold on 
plot(O3_600ppt_LOWVOC_TIME,O3_600ppt_LOWVOC_O3,'g')
hold on 
plot(O3_800ppt_LOWVOC_TIME,O3_800ppt_LOWVOC_O3,'c')
hold on 
plot(O3_1ppb_LOWVOC_TIME,O3_1ppb_LOWVOC_O3,'m')
hold on 
plot(O3_5ppb_LOWVOC_TIME,O3_5ppb_LOWVOC_O3,'k')
hold on 
plot(O3_20ppb_LOWVOC_TIME,O3_20ppb_LOWVOC_O3,'b')
xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Initial [O3] for Low VOC')

% HIGH VOC Scenario
figure, plot(O3_0ppb_HIGHVOC_TIME,O3_0ppb_HIGHVOC_O3,'k')
hold on 
plot(O3_200ppt_HIGHVOC_TIME,O3_200ppt_HIGHVOC_O3,'b')
hold on 
plot(O3_400ppt_HIGHVOC_TIME,O3_400ppt_HIGHVOC_O3,'r')
hold on 
plot(O3_600ppt_HIGHVOC_TIME,O3_600ppt_HIGHVOC_O3,'g')
hold on 
plot(O3_800ppt_HIGHVOC_TIME,O3_800ppt_HIGHVOC_O3,'c')
hold on 
plot(O3_1ppb_HIGHVOC_TIME,O3_1ppb_HIGHVOC_O3,'m')
hold on 
plot(O3_5ppb_HIGHVOC_TIME,O3_5ppb_HIGHVOC_O3,'k')
hold on 
plot(O3_20ppb_HIGHVOC_TIME,O3_20ppb_HIGHVOC_O3,'b')
xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Initial [O3] for High VOC')

%% Varying Light Source %%

%LOW VOC Scenario
figure, plot(CFT_LOWVOC_TIME,CFT_LOWVOC_O3,'k')
hold on 
plot(NCAR_LOWVOC_TIME,NCAR_LOWVOC_O3,'b')
hold on 
plot(Sunlight_LOWVOC_TIME,Sunlight_LOWVOC_O3,'r')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Light Source for Low VOC')

%HIGH VOC Scenario 
figure, plot(CFT_HIGHVOC_TIME,CFT_HIGHVOC_O3,'k')
hold on 
plot(NCAR_HIGHVOC_TIME,NCAR_HIGHVOC_O3,'b')
hold on 
plot(Sunlight_HIGHVOC_TIME,Sunlight_HIGHVOC_O3,'r')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Light Source for High VOC')

%% Varying Surface Deposition Rates %%

%LOW VOC Scenario
figure, plot(Surface_0_LOWVOC_TIME, Surface_0_LOWVOC_O3, 'k')
hold on
plot(Surface_BASE_LOWVOC_TIME, Surface_BASE_LOWVOC_O3, 'b')
hold on
plot(Surface_10_LOWVOC_TIME, Surface_10_LOWVOC_O3, 'r')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Dep Rate for Low VOC')

%HIGH VOC Scenario
figure, plot(Surface_0_HIGHVOC_TIME, Surface_0_HIGHVOC_O3, 'k')
hold on
plot(Surface_BASE_HIGHVOC_TIME, Surface_BASE_HIGHVOC_O3, 'b')
hold on
plot(Surface_10_HIGHVOC_TIME, Surface_10_HIGHVOC_O3, 'r')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying Dep Rate for High VOC')

%% Varying NOx %%

%LOW VOC Scenario
figure, plot(NOx_0_LOWVOC_TIME,NOx_0_LOWVOC_O3,'k')
hold on 
plot(NOx_500ppt_LOWVOC_TIME,NOx_500ppt_LOWVOC_O3,'b')
hold on 
plot(NOx_50ppb_LOWVOC_TIME,NOx_50ppb_LOWVOC_O3,'r')
hold on 
plot(NOx_100ppb_LOWVOC_TIME,NOx_100ppb_LOWVOC_O3,'c')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying NOx for Low VOC')

%HIGH VOC Scenario
figure, plot(NOx_0_HIGHVOC_TIME,NOx_0_HIGHVOC_O3,'k')
hold on 
plot(NOx_500ppt_HIGHVOC_TIME,NOx_500ppt_HIGHVOC_O3,'b')
hold on 
plot(NOx_50ppb_HIGHVOC_TIME,NOx_50ppb_HIGHVOC_O3,'r')
hold on 
plot(NOx_100ppb_HIGHVOC_TIME,NOx_100ppb_HIGHVOC_O3,'c')

xlabel('Model Time (s)'), ylabel('[Ozone] (ppb)'), title('Varying NOx for High VOC')