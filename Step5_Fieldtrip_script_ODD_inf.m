%% Create Mean and Grand Mean Files
% Creates mean and grandmean files for each condition (across) subjects
% Mean files (with separate subjects) are needed for the cluster-based permutation test
% Grand mean files averaged across subjects are needed for plotting
% (c) Ivonne Weyers 2019

clear all 
close all 

% addpath '/net/store/nl/users/iweyers/MATLAB/fieldtrip-20170216/';
ft_defaults;
% dir_save = 'E:\Work\Oddball\Infants\Data_EEG\final\';
% dir_save ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
% dir_save ='C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';
dir_save ='C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';
% dir_save= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\';
% dir_save ='E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final\';%% insert your final folder;
% dir_save ='E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\2_after_ICA_29042021\';
% load ([dir_save 'avgCONstan']);
% load ([dir_save 'avgCONrule']);
% load ([dir_save 'avgCONint']);
load ([dir_save 'avgVOWstan']);
load ([dir_save 'avgVOWrule']);
load ([dir_save 'avgVOWint']);

%% Mean files keeping individual subject data (for CBPT)

% CON
cfg = [];
cfg.keepindividual = 'yes';
avgCONstanALL = ft_timelockgrandaverage(cfg, avgCONstan{1,1}, avgCONstan{1,2}, avgCONstan{1,3},avgCONstan{1,4},avgCONstan{1,5},avgCONstan{1,6},avgCONstan{1,7},avgCONstan{1,8},avgCONstan{1,9},avgCONstan{1,10},...
avgCONstan{1,11}, avgCONstan{1,12}, avgCONstan{1,13},avgCONstan{1,14}, avgCONstan{1,15}, avgCONstan{1,16}, avgCONstan{1,17},avgCONstan{1,18},avgCONstan{1,19},avgCONstan{1,20},avgCONstan{1,21},avgCONstan{1,22},...
avgCONstan{1,23},avgCONstan{1,24}, avgCONstan{1,25}, avgCONstan{1,26}, avgCONstan{1,27},avgCONstan{1,28},avgCONstan{1,29},avgCONstan{1,30},avgCONstan{1,31},avgCONstan{1,32},avgCONstan{1,33});
filename= strcat(dir_save, 'avgCONstanALL', '.mat');
save (filename, 'avgCONstanALL');
% avgCONcorL = ft_timelockgrandaverage(cfg, avgCONcor{1,2}, avgCONcor{1,7}, avgCONcor{1,14}, avgCONcor{1,15}, avgCONcor{1,16});
% filename= strcat(dir_save, 'avgCONcorL', '.mat');
% save (filename, 'avgCONcorL');
clear filename

cfg = [];
cfg.keepindividual = 'yes';
avgCONruleALL = ft_timelockgrandaverage(cfg, avgCONrule{1,1}, avgCONrule{1,2}, avgCONrule{1,3},avgCONrule{1,4},avgCONrule{1,5},avgCONrule{1,6},avgCONrule{1,7},avgCONrule{1,8},avgCONrule{1,9},avgCONrule{1,10},...
avgCONrule{1,11}, avgCONrule{1,12}, avgCONrule{1,13},avgCONrule{1,14}, avgCONrule{1,15}, avgCONrule{1,16}, avgCONrule{1,17},avgCONrule{1,18},avgCONrule{1,19},avgCONrule{1,20},avgCONrule{1,21},avgCONrule{1,22},...
avgCONrule{1,23},avgCONrule{1,24}, avgCONrule{1,25}, avgCONrule{1,26}, avgCONrule{1,27},avgCONrule{1,28},avgCONrule{1,29},avgCONrule{1,30},avgCONrule{1,31},avgCONrule{1,32},avgCONrule{1,33});
filename= strcat(dir_save, 'avgCONruleALL', '.mat');
save (filename, 'avgCONruleALL');
% avgCONincL = ft_timelockgrandaverage(cfg, avgCONinc{1,2}, avgCONinc{1,7}, avgCONinc{1,14}, avgCONinc{1,15}, avgCONinc{1,16});
% filename= strcat(dir_save, 'avgCONincL', '.mat');
% save (filename, 'avgCONincL');
clear filename

cfg = [];
cfg.keepindividual = 'yes';
avgCONintALL = ft_timelockgrandaverage(cfg, avgCONint{1,1}, avgCONint{1,2}, avgCONint{1,3},avgCONint{1,4},avgCONint{1,5},avgCONint{1,6},avgCONint{1,7},avgCONint{1,8},avgCONint{1,9},avgCONint{1,10},...
avgCONint{1,11}, avgCONint{1,12}, avgCONint{1,13},avgCONint{1,14}, avgCONint{1,15}, avgCONint{1,16}, avgCONint{1,17},avgCONint{1,18},avgCONint{1,19},avgCONint{1,20},avgCONint{1,21},avgCONint{1,22},...
avgCONint{1,23},avgCONint{1,24}, avgCONint{1,25}, avgCONint{1,26}, avgCONint{1,27},avgCONint{1,28},avgCONint{1,29},avgCONint{1,30},avgCONint{1,31},avgCONint{1,32},avgCONint{1,33});
filename= strcat(dir_save, 'avgCONintALL', '.mat');
save (filename, 'avgCONintALL');
% avgCONincL = ft_timelockgrandaverage(cfg, avgCONinc{1,2}, avgCONinc{1,7}, avgCONinc{1,14}, avgCONinc{1,15}, avgCONinc{1,16});
% filename= strcat(dir_save, 'avgCONincL', '.mat');
% save (filename, 'avgCONincL');
clear filename

%% VOW
cfg = [];
cfg.keepindividual = 'yes';
% avgVOWstanALL = ft_timelockgrandaverage(cfg, avgVOWstan{1,1}, avgVOWstan{1,2}, avgVOWstan{1,3},avgVOWstan{1,4},avgVOWstan{1,5},avgVOWstan{1,6},avgVOWstan{1,7},avgVOWstan{1,8},avgVOWstan{1,9},avgVOWstan{1,10},...
% avgVOWstan{1,11}, avgVOWstan{1,12}, avgVOWstan{1,13},avgVOWstan{1,14}, avgVOWstan{1,15}, avgVOWstan{1,16}, avgVOWstan{1,17},avgVOWstan{1,18},avgVOWstan{1,19},avgVOWstan{1,20},avgVOWstan{1,21},avgVOWstan{1,22},...
% avgVOWstan{1,23},avgVOWstan{1,24}, avgVOWstan{1,25}, avgVOWstan{1,26}, avgVOWstan{1,27},avgVOWstan{1,28},avgVOWstan{1,29},avgVOWstan{1,30},avgVOWstan{1,31},avgVOWstan{1,32},avgVOWstan{1,33},avgVOWstan{1,34},...
% avgVOWstan{1,35},avgVOWstan{1,36},avgVOWstan{1,37},avgVOWstan{1,38});
% filename= strcat(dir_save, 'avgVOWstanALL', '.mat');
% save (filename, 'avgVOWstanALL');
%[1:4 6 7 11:13 15:21 24:26 29 30 32]
avgVOWstanL = ft_timelockgrandaverage(cfg, avgVOWstan{1,1}, avgVOWstan{1,2},avgVOWstan{1,3},avgVOWstan{1,4},avgVOWstan{1,6},avgVOWstan{1,7},...
avgVOWstan{1,11}, avgVOWstan{1,12}, avgVOWstan{1,13}, avgVOWstan{1,15}, avgVOWstan{1,16},avgVOWstan{1,17},avgVOWstan{1,18},avgVOWstan{1,19},avgVOWstan{1,20},avgVOWstan{1,21},...
avgVOWstan{1,24}, avgVOWstan{1,25}, avgVOWstan{1,26}, avgVOWstan{1,29},avgVOWstan{1,30},avgVOWstan{1,32});
filename= strcat(dir_save, 'avgVOWstanL', '.mat');
save (filename, 'avgVOWstanL');
clear filename

cfg = [];
cfg.keepindividual = 'yes';
% avgVOWruleALL = ft_timelockgrandaverage(cfg, avgVOWrule{1,1}, avgVOWrule{1,2}, avgVOWrule{1,3},avgVOWrule{1,4},avgVOWrule{1,5},avgVOWrule{1,6},avgVOWrule{1,7},avgVOWrule{1,8},avgVOWrule{1,9},avgVOWrule{1,10},...
% avgVOWrule{1,11}, avgVOWrule{1,12}, avgVOWrule{1,13},avgVOWrule{1,14}, avgVOWrule{1,15}, avgVOWrule{1,16}, avgVOWrule{1,17},avgVOWrule{1,18},avgVOWrule{1,19},avgVOWrule{1,20},avgVOWrule{1,21},avgVOWrule{1,22},...
% avgVOWrule{1,23},avgVOWrule{1,24}, avgVOWrule{1,25}, avgVOWrule{1,26}, avgVOWrule{1,27},avgVOWrule{1,28},avgVOWrule{1,29},avgVOWrule{1,30},avgVOWrule{1,31},avgVOWrule{1,32},avgVOWrule{1,33},avgVOWrule{1,34},...
% avgVOWrule{1,35},avgVOWrule{1,36},avgVOWrule{1,37},avgVOWrule{1,38});
% filename= strcat(dir_save, 'avgVOWruleALL', '.mat');
% save (filename, 'avgVOWruleALL');
avgVOWruleL = ft_timelockgrandaverage(cfg, avgVOWrule{1,1}, avgVOWrule{1,2},avgVOWrule{1,3},avgVOWrule{1,4},avgVOWrule{1,6},avgVOWrule{1,7},...
avgVOWrule{1,11}, avgVOWrule{1,12}, avgVOWrule{1,13}, avgVOWrule{1,15}, avgVOWrule{1,16},avgVOWrule{1,17},avgVOWrule{1,18},avgVOWrule{1,19},avgVOWrule{1,20},avgVOWrule{1,21},...
avgVOWrule{1,24}, avgVOWrule{1,25}, avgVOWrule{1,26}, avgVOWrule{1,29},avgVOWrule{1,30},avgVOWrule{1,32});
filename= strcat(dir_save, 'avgVOWruleL', '.mat');
save (filename, 'avgVOWruleL');
clear filename

cfg = [];
cfg.keepindividual = 'yes';
% avgVOWintALL = ft_timelockgrandaverage(cfg, avgVOWint{1,1}, avgVOWint{1,2}, avgVOWint{1,3},avgVOWint{1,4},avgVOWint{1,5},avgVOWint{1,6},avgVOWint{1,7},avgVOWint{1,8},avgVOWint{1,9},avgVOWint{1,10},...
% avgVOWint{1,11}, avgVOWint{1,12}, avgVOWint{1,13},avgVOWint{1,14},avgVOWint{1,15},avgVOWint{1,16},avgVOWint{1,17},avgVOWint{1,18},avgVOWint{1,19},avgVOWint{1,20},avgVOWint{1,21},avgVOWint{1,22},...
% avgVOWint{1,23},avgVOWint{1,24}, avgVOWint{1,25}, avgVOWint{1,26}, avgVOWint{1,27},avgVOWint{1,28},avgVOWint{1,29},avgVOWint{1,30},avgVOWint{1,31},avgVOWint{1,32},avgVOWint{1,33},avgVOWint{1,34},...
% avgVOWint{1,35},avgVOWint{1,36},avgVOWint{1,37},avgVOWint{1,38});
% filename= strcat(dir_save, 'avgVOWintALL', '.mat');
% save (filename, 'avgVOWintALL');
avgVOWintL = ft_timelockgrandaverage(cfg, avgVOWint{1,1}, avgVOWint{1,2},avgVOWint{1,3},avgVOWint{1,4},avgVOWint{1,6},avgVOWint{1,7},...
avgVOWint{1,11}, avgVOWint{1,12}, avgVOWint{1,13}, avgVOWint{1,15}, avgVOWint{1,16},avgVOWint{1,17},avgVOWint{1,18},avgVOWint{1,19},avgVOWint{1,20},avgVOWint{1,21},...
avgVOWint{1,24}, avgVOWint{1,25}, avgVOWint{1,26}, avgVOWint{1,29},avgVOWint{1,30},avgVOWint{1,32});
filename= strcat(dir_save, 'avgVOWintL', '.mat');
save (filename, 'avgVOWintL');
clear filename

%% Grand mean across subjects per condition

% CON
cfg = [];
cfg.keepindividual = 'no';
grandavgCONstanALL = ft_timelockgrandaverage(cfg, avgCONstan{1,1}, avgCONstan{1,2}, avgCONstan{1,3},avgCONstan{1,4},avgCONstan{1,5},avgCONstan{1,6},avgCONstan{1,7},avgCONstan{1,8},avgCONstan{1,9},avgCONstan{1,10},...
avgCONstan{1,11}, avgCONstan{1,12}, avgCONstan{1,13},avgCONstan{1,14}, avgCONstan{1,15}, avgCONstan{1,16}, avgCONstan{1,17},avgCONstan{1,18},avgCONstan{1,19},avgCONstan{1,20},avgCONstan{1,21},avgCONstan{1,22},...
avgCONstan{1,23},avgCONstan{1,24}, avgCONstan{1,25}, avgCONstan{1,26}, avgCONstan{1,27},avgCONstan{1,28},avgCONstan{1,29},avgCONstan{1,30},avgCONstan{1,31},avgCONstan{1,32},avgCONstan{1,33});
filename= strcat(dir_save, 'grandavgCONstanALL', '.mat');
save (filename, 'grandavgCONstanALL');
% grandavgCONcorL = ft_timelockgrandaverage(cfg, avgCONcor{1,2}, avgCONcor{1,7}, avgCONcor{1,14}, avgCONcor{1,15}, avgCONcor{1,16});
% filename= strcat(dir_save, 'grandavgCONcorL', '.mat');
% save (filename, 'grandavgCONcorL');
clear filename

cfg = [];
cfg.keepindividual = 'no';
grandavgCONruleALL = ft_timelockgrandaverage(cfg, avgCONrule{1,1}, avgCONrule{1,2}, avgCONrule{1,3},avgCONrule{1,4},avgCONrule{1,5},avgCONrule{1,6},avgCONrule{1,7},avgCONrule{1,8},avgCONrule{1,9},avgCONrule{1,10},...
avgCONrule{1,11}, avgCONrule{1,12}, avgCONrule{1,13},avgCONrule{1,14}, avgCONrule{1,15}, avgCONrule{1,16}, avgCONrule{1,17},avgCONrule{1,18},avgCONrule{1,19},avgCONrule{1,20},avgCONrule{1,21},avgCONrule{1,22},...
avgCONrule{1,23},avgCONrule{1,24}, avgCONrule{1,25}, avgCONrule{1,26}, avgCONrule{1,27},avgCONrule{1,28},avgCONrule{1,29},avgCONrule{1,30},avgCONrule{1,31},avgCONrule{1,32},avgCONrule{1,33});
filename= strcat(dir_save, 'grandavgCONruleALL', '.mat');
save (filename, 'grandavgCONruleALL');
% grandavgCONincL = ft_timelockgrandaverage(cfg, avgCONinc{1,2}, avgCONinc{1,7}, avgCONinc{1,14}, avgCONinc{1,15}, avgCONinc{1,16});
% filename= strcat(dir_save, 'grandavgCONincL', '.mat');
% save (filename, 'grandavgCONincL');
clear filename

cfg = [];
cfg.keepindividual = 'no';
grandavgCONintALL = ft_timelockgrandaverage(cfg, avgCONint{1,1}, avgCONint{1,2}, avgCONint{1,3},avgCONint{1,4},avgCONint{1,5},avgCONint{1,6},avgCONint{1,7},avgCONint{1,8},avgCONint{1,9},avgCONint{1,10},...
avgCONint{1,11}, avgCONint{1,12}, avgCONint{1,13},avgCONint{1,14}, avgCONint{1,15}, avgCONint{1,16}, avgCONint{1,17},avgCONint{1,18},avgCONint{1,19},avgCONint{1,20},avgCONint{1,21},avgCONint{1,22},...
avgCONint{1,23},avgCONint{1,24}, avgCONint{1,25}, avgCONint{1,26}, avgCONint{1,27},avgCONint{1,28},avgCONint{1,29},avgCONint{1,30},avgCONint{1,31},avgCONint{1,32},avgCONint{1,33});
filename= strcat(dir_save, 'grandavgCONintALL', '.mat');
save (filename, 'grandavgCONintALL');
% grandavgCONincL = ft_timelockgrandaverage(cfg, avgCONinc{1,2}, avgCONinc{1,7}, avgCONinc{1,14}, avgCONinc{1,15}, avgCONinc{1,16});
% filename= strcat(dir_save, 'grandavgCONincL', '.mat');
% save (filename, 'grandavgCONincL');
clear filename

%% VOW
cfg = [];
cfg.keepindividual = 'no';
% grandavgVOWstanALL = ft_timelockgrandaverage(cfg, avgVOWstan{1,1}, avgVOWstan{1,2}, avgVOWstan{1,3},avgVOWstan{1,4},avgVOWstan{1,5},avgVOWstan{1,6},avgVOWstan{1,7},avgVOWstan{1,8},avgVOWstan{1,9},avgVOWstan{1,10},...
% avgVOWstan{1,11}, avgVOWstan{1,12}, avgVOWstan{1,13},avgVOWstan{1,14}, avgVOWstan{1,15}, avgVOWstan{1,16}, avgVOWstan{1,17},avgVOWstan{1,18},avgVOWstan{1,19},avgVOWstan{1,20},avgVOWstan{1,21},avgVOWstan{1,22},...
% avgVOWstan{1,23},avgVOWstan{1,24}, avgVOWstan{1,25}, avgVOWstan{1,26}, avgVOWstan{1,27},avgVOWstan{1,28},avgVOWstan{1,29},avgVOWstan{1,30},avgVOWstan{1,31},avgVOWstan{1,32},avgVOWstan{1,33},avgVOWstan{1,34},...
% avgVOWstan{1,35},avgVOWstan{1,36},avgVOWstan{1,37},avgVOWstan{1,38});
% filename= strcat(dir_save, 'grandavgVOWstanALL', '.mat');
% save (filename, 'grandavgVOWstanALL');
grandavgVOWstanL = ft_timelockgrandaverage(cfg, avgVOWstan{1,1}, avgVOWstan{1,2},avgVOWstan{1,3},avgVOWstan{1,4},avgVOWstan{1,6},avgVOWstan{1,7},...
avgVOWstan{1,11}, avgVOWstan{1,12}, avgVOWstan{1,13}, avgVOWstan{1,15}, avgVOWstan{1,16},avgVOWstan{1,17},avgVOWstan{1,18},avgVOWstan{1,19},avgVOWstan{1,20},avgVOWstan{1,21},...
avgVOWstan{1,24}, avgVOWstan{1,25}, avgVOWstan{1,26}, avgVOWstan{1,29},avgVOWstan{1,30},avgVOWstan{1,32});
filename= strcat(dir_save, 'grandavgVOWstanL', '.mat');
save (filename, 'grandavgVOWstanL');
clear filename

cfg = [];
cfg.keepindividual = 'no';
% grandavgVOWruleALL = ft_timelockgrandaverage(cfg, avgVOWrule{1,1}, avgVOWrule{1,2}, avgVOWrule{1,3},avgVOWrule{1,4},avgVOWrule{1,5},avgVOWrule{1,6},avgVOWrule{1,7},avgVOWrule{1,8},avgVOWrule{1,9},avgVOWrule{1,10},...
% avgVOWrule{1,11}, avgVOWrule{1,12}, avgVOWrule{1,13},avgVOWrule{1,14}, avgVOWrule{1,15}, avgVOWrule{1,16}, avgVOWrule{1,17},avgVOWrule{1,18},avgVOWrule{1,19},avgVOWrule{1,20},avgVOWrule{1,21},avgVOWrule{1,22},...
% avgVOWrule{1,23},avgVOWrule{1,24}, avgVOWrule{1,25}, avgVOWrule{1,26}, avgVOWrule{1,27},avgVOWrule{1,28},avgVOWrule{1,29},avgVOWrule{1,30},avgVOWrule{1,31},avgVOWrule{1,32},avgVOWrule{1,33},avgVOWrule{1,34},...
% avgVOWrule{1,35},avgVOWrule{1,36},avgVOWrule{1,37},avgVOWrule{1,38});
% filename= strcat(dir_save, 'grandavgVOWruleALL', '.mat');
% save (filename, 'grandavgVOWruleALL');
grandavgVOWruleL = ft_timelockgrandaverage(cfg, avgVOWrule{1,1}, avgVOWrule{1,2},avgVOWrule{1,3},avgVOWrule{1,4},avgVOWrule{1,6},avgVOWrule{1,7},...
avgVOWrule{1,11}, avgVOWrule{1,12}, avgVOWrule{1,13}, avgVOWrule{1,15}, avgVOWrule{1,16},avgVOWrule{1,17},avgVOWrule{1,18},avgVOWrule{1,19},avgVOWrule{1,20},avgVOWrule{1,21},...
avgVOWrule{1,24}, avgVOWrule{1,25}, avgVOWrule{1,26}, avgVOWrule{1,29},avgVOWrule{1,30},avgVOWrule{1,32});
filename= strcat(dir_save, 'grandavgVOWruleL', '.mat');
save (filename, 'grandavgVOWruleL');
clear filename

cfg = [];
cfg.keepindividual = 'no';
% grandavgVOWintALL = ft_timelockgrandaverage(cfg, avgVOWint{1,1}, avgVOWint{1,2}, avgVOWint{1,3},avgVOWint{1,4},avgVOWint{1,5},avgVOWint{1,6},avgVOWint{1,7},avgVOWint{1,8},avgVOWint{1,9},avgVOWint{1,10},...
% avgVOWint{1,11}, avgVOWint{1,12}, avgVOWint{1,13},avgVOWint{1,14},avgVOWint{1,15},avgVOWint{1,16},avgVOWint{1,17},avgVOWint{1,18},avgVOWint{1,19},avgVOWint{1,20},avgVOWint{1,21},avgVOWint{1,22},...
% avgVOWint{1,23},avgVOWint{1,24}, avgVOWint{1,25}, avgVOWint{1,26}, avgVOWint{1,27},avgVOWint{1,28},avgVOWint{1,29},avgVOWint{1,30},avgVOWint{1,31},avgVOWint{1,32},avgVOWint{1,33},avgVOWint{1,34},...
% avgVOWint{1,35},avgVOWint{1,36},avgVOWint{1,37},avgVOWint{1,38});
% filename= strcat(dir_save, 'grandavgVOWintALL', '.mat');
% save (filename, 'grandavgVOWintALL');
grandavgVOWintL = ft_timelockgrandaverage(cfg, avgVOWint{1,1}, avgVOWint{1,2},avgVOWint{1,3},avgVOWint{1,4},avgVOWint{1,6},avgVOWint{1,7},...
avgVOWint{1,11}, avgVOWint{1,12}, avgVOWint{1,13}, avgVOWint{1,15}, avgVOWint{1,16},avgVOWint{1,17},avgVOWint{1,18},avgVOWint{1,19},avgVOWint{1,20},avgVOWint{1,21},...
avgVOWint{1,24}, avgVOWint{1,25}, avgVOWint{1,26}, avgVOWint{1,29},avgVOWint{1,30},avgVOWint{1,32});
filename= strcat(dir_save, 'grandavgVOWintL', '.mat');
save (filename, 'grandavgVOWintL');
clear filename

%% Plotting
% not really necessary, just to check if data looks ok, not used as
% representative visualizations
load([dir_save 'grandavgCONcorALL']);
load([dir_save 'grandavgCONincALL']);
load([dir_save 'grandavgVOWcorALL']);
load([dir_save 'grandavgVOWincALL']);

load([dir_save 'grandavgCONcorL']);
load([dir_save 'grandavgCONincL']);
load([dir_save 'grandavgVOWcorL']);
load([dir_save 'grandavgVOWincL']);

cfg = [];
cfg.showlabels = 'yes';
cfg.channels = 'all';
cfg.fontsize = 6;
cfg.layout = 'pop_chanlocs_66.mat';
cfg.baseline = [-0.1 0];
% figure; ft_multiplotER(cfg, grandavgCONcorALL, grandavgCONincALL);
% figure; ft_multiplotER(cfg, grandavgVOWcorALL, grandavgVOWincALL);
figure; ft_multiplotER(cfg, grandavgCONcorL, grandavgCONincL);
% figure; ft_multiplotER(cfg, grandavgVOWcorL, grandavgVOWincL);
