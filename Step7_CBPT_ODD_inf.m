%% Cluster-based permutation test
% adapted by Ivonne Weyers 2019

clear all 
close all 
%Do not add full path with subfolders, only main folder
ft_defaults;

% Load timelockanalysis data
dir_save ='E:\Work\Oddball_infants\Data_EEG\CONS\final\'; 
load ([dir_save 'avgCONstanALL']);
load ([dir_save 'avgCONruleALL']);
load ([dir_save 'avgCONintALL']);
load ([dir_save 'grandavgCONstanALL']);
load ([dir_save 'grandavgCONruleALL']);
load([dir_save 'grandavgCONintALL']);
clear dir_save

dir_save ='E:\Work\Oddball_infants\Data_EEG\VOW\final\';
load ([dir_save 'avgVOWstanALL']);
load ([dir_save 'avgVOWruleALL']);
load ([dir_save 'avgVOWintALL']);
load([dir_save 'grandavgVOWstanALL']);
load([dir_save 'grandavgVOWruleALL']);
load([dir_save 'grandavgVOWintALL']);

%SPRACHE gut
load ([dir_save 'avgVOWstanL']);
load ([dir_save 'avgVOWruleL']);
load ([dir_save 'avgVOWintL']);
load([dir_save 'grandavgVOWstanL']);
load([dir_save 'grandavgVOWruleL']);
load([dir_save 'grandavgVOWintL']);

%% Create Layout
% filename = [dir_save 'Sub79_C4.set'];
% EEG = pop_loadset(filename);
% % FT = eeglab2fieldtrip(EEG, 'chanloc');
% load('chanlocs_28_Ivonne.mat');

% cfg.layout = elec;
% cfg.elec = elec;
% layout_2806 = ft_prepare_layout(cfg, elec);

% elec = ft_read_sens('E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final\Sub79_C4.set');
% % there are some of which the orientation cannot be determined (T3, T4, T5, T6)
% ft_plot_sens(elec, 'label', 'yes', 'elecshape', 'disc', 'elecsize', 10, 'facecolor', [0.8 0.8 1.0])
% % give it a stronger 3D appearance
% camlight headlight
 
% Testplot
% load chanlocs_FT_28_Ivonne.mat
% cfg = [];
% cfg.layout = layout28;
% cfg.ylim = [-4 9];
% cfg.baseline = [-0.1 0];
% cfg.showlabels = 'yes';
% cfg.showoutline = 'yes';
% ft_multiplotER(cfg, avgCONstanALL, avgCONintALL);

cfg=[];
cfg.resamplefs = 250;
cfg.baselinewindow  = [-0.1 0];
avgVOWstanALL = ft_resampledata(cfg,avgVOWstanALL);
avgVOWruleALL = ft_resampledata(cfg,avgVOWruleALL);
% cfg=[];
% cfg.hpfilter      ='yes';
% cfg.hpfreq        = 1;
% avgVOWstanALL = ft_preprocessing(cfg, avgVOWstanALL);
% 
% cfg=[];
% cfg.hpfilter      ='yes';
% cfg.hpfreq        = 1;
% avgVOWruleALL = ft_preprocessing(cfg, avgVOWruleALL);
%% define neighbors
load('chanlocs_FT_28_Ivonne.mat');
cfg = [];
cfg.method = 'triangulation';
% cfg.method = 'distance';
cfg.layout = layout28;
% cfg.neighbourdist = 0.4; %default = 40mm
cfg.feedback = 'yes';
cfg.channel= {'all','-EOG', '-TP9', '-TP10'};
% cfg.channel= {'-EOG', '-TP9', '-TP10', 'Fp1', 'Fp2','F9','F10','Fz','F4','F3','F7','F8'};
% neighbours = ft_prepare_neighbours(cfg, avgCONstanALL);
neighbours = ft_prepare_neighbours(cfg, avgVOWstanALL);
% neighbours = ft_prepare_neighbours(cfg, avgVOWstanL);
%%
% %[1 4 5 8 9 11 12 13 15 17 24 26 28 30] criterion >0.5 amplitude diff. wave
% %rule condition in TW of intensity effect
% avgVOWstanALL.individual = avgVOWstanALL.individual([1:33 35 36],:,:);
% avgVOWruleALL.individual = avgVOWruleALL.individual([1:33 35 36],:,:);
% avgVOWintALL.individual = avgVOWintALL.individual([1:33 35 36],:,:);
% %[6 7 10 19 23 25 27 31 36] criterion <0.5 amplitude diff. wave
% %rule condition in TW of intensity effect
% avgVOWstanALL.individual = avgVOWstanALL.individual([6 7 10 19 23 25 27 31 36],:,:);
% avgVOWruleALL.individual = avgVOWruleALL.individual([6 7 10 19 23 25 27 31 36],:,:);
% avgVOWintALL.individual = avgVOWintALL.individual([6 7 10 19 23 25 27 31 36],:,:);
% 
% %[1 4 5 6 11 15 16 17 18 21 24 26 27 28 29 31 34] criterion >0.5 amplitude diff. wave intensity condition in TW of intensity effect
% avgVOWstanALL.individual = avgVOWstanALL.individual([1 4 5 6 11 15 16 17 18 21 24 26 27 28 29 31 34],:,:);
% avgVOWruleALL.individual = avgVOWruleALL.individual([1 4 5 6 11 15 16 17 18 21 24 26 27 28 29 31 34],:,:);
% avgVOWintALL.individual = avgVOWintALL.individual([1 4 5 6 11 15 16 17 18 21 24 26 27 28 29 31 34],:,:);
% 
% %[7 8 9 12 14 19 32 37 38] NEGATIVITY diff. wave intensity condition in TW of intensity effect
% % avgVOWstanALL.individual = avgVOWstanALL.individual([7 8 9 12 14 19 32 37 38],:,:);
% % avgVOWruleALL.individual = avgVOWruleALL.individual([7 8 9 12 14 19 32 37 38],:,:);
% % avgVOWintALL.individual = avgVOWintALL.individual([7 8 9 12 14 19 32 37 38],:,:);

%%
%VOW
%Restults LANG dimension ET6-6 SPRACHE above 10 [2:5 7:8 12:14 16:22 25:27 30:31 33]
avgVOWintHigh = avgVOWintALL;
avgVOWruleHigh = avgVOWruleALL;
avgVOWstanHigh = avgVOWstanALL;
avgVOWstanHigh.individual = avgVOWstanALL.individual([1:4 6 7 11:13 15:21 24:26 29 30 32],:,:);
avgVOWruleHigh.individual = avgVOWruleALL.individual([1:4 6 7 11:13 15:21 24:26 29 30 32],:,:);
avgVOWintHigh.individual = avgVOWintALL.individual([1:4 6 7 11:13 15:21 24:26 29 30 32],:,:);

%Restults LANG dimension ET6-6 SPRACHE 10 and below [1 6 9:11 15 23 24 28 29 32 34:36]
avgVOWintLow = avgVOWintALL;
avgVOWruleLow = avgVOWruleALL;
avgVOWstanLow = avgVOWstanALL;
avgVOWstanLow.individual = avgVOWstanALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);
avgVOWruleLow.individual = avgVOWruleALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);
avgVOWintLow.individual = avgVOWintALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);

clear avgVOWintALL;
clear avgVOWruleALL;
clear avgVOWstanALL;

% create difference wave
cfg  = [];
cfg.operation = 'subtract';
cfg.parameter = 'individual';
DiffruleVSstanHigh = ft_math(cfg,avgVOWruleHigh, avgVOWstanHigh);

cfg  = [];
cfg.operation = 'subtract';
cfg.parameter = 'individual';
DiffruleVSstanLow = ft_math(cfg,avgVOWruleLow, avgVOWstanLow);

%CON
%Restults LANG dimension ET6-6 SPRACHE above 10 [3 4 6 7 9 10 12 13 15:21
%23 26 30 33] n=19
avgCONstanALL.individual = avgCONstanALL.individual([3 4 6 7 9 10 12 13 15:21 23 26 30 33],:,:);
avgCONruleALL.individual = avgCONruleALL.individual([3 4 6 7 9 10 12 13 15:21 23 26 30 33],:,:);
avgCONintALL.individual = avgCONintALL.individual([3 4 6 7 9 10 12 13 15:21 23 26 30 33],:,:);

%Restults LANG dimension ET6-6 SPRACHE 10 and below [1 2 5 8 11 14 22 24 25
%27 28 29 31 32] n=14
avgCONstanALL.individual = avgCONstanALL.individual([1 2 5 8 11 14 22 24 25 27 28 29 31 32],:,:);
avgCONruleALL.individual = avgCONruleALL.individual([1 2 5 8 11 14 22 24 25 27 28 29 31 32],:,:);
avgCONintALL.individual = avgCONintALL.individual([1 2 5 8 11 14 22 24 25 27 28 29 31 32],:,:);

%%
%Splitting into 3 groups
%score<=10; n=13; [5 8:10 14 22 23 27 28 31 33:35] --> RULE NOT SIGN 1 pos.
%cluster p=0.85
avgVOWstanALL.individual = avgVOWstanALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([5 8:10 14 22 23 27 28 31 33:35],:,:);
%score=12; n=11; [2 4 11 13 17 19 20 25 26 30 32] --> RULE NOT SIGN 4 pos clusters,
%p=0.4; 6 neg clusters, p=0.19
avgVOWstanALL.individual = avgVOWstanALL.individual([2 4 11 13 17 19 20 25 26 30 32],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([2 4 11 13 17 19 20 25 26 30 32],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([2 4 11 13 17 19 20 25 26 30 32],:,:);
%score=14; n=11; [1 3 6 7 12 15 16 18 21 24 29] --> RULE 8 pos clusters, p=0.24; 3
%neg. clusters, p=0.1
avgVOWstanALL.individual = avgVOWstanALL.individual([1 3 6 7 12 15 16 18 21 24 29],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([1 3 6 7 12 15 16 18 21 24 29],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([1 3 6 7 12 15 16 18 21 24 29],:,:);

%%
%Restults LANG dimension ET6-6 KOGNITION above 10 [1 2 5 6 16 18 20 23:25
%27 31 34] n=13
avgVOWstanALL.individual = avgVOWstanALL.individual([1 2 5 6 16 18 20 23:25 27 31 34],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([1 2 5 6 16 18 20 23:25 27 31 34],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([1 2 5 6 16 18 20 23:25 27 31 34],:,:);

%Restults LANG dimension ET6-6 KOGNITION 10 and below [3 4 7:15 17 19 21 22 26 28:30 32 33 35 36]
% avgVOWstanALL.individual = avgVOWstanALL.individual([3 4 7:15 17 19 21 22 26 28:30 32 33 35 36],:,:);
% avgVOWruleALL.individual = avgVOWruleALL.individual([3 4 7:15 17 19 21 22 26 28:30 32 33 35 36],:,:);
% avgVOWintALL.individual = avgVOWintALL.individual([3 4 7:15 17 19 21 22 26 28:30 32 33 35 36],:,:);

%% Split SEX
% Girls
avgVOWstanALL.individual = avgVOWstanALL.individual([1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35],:,:);
% Boys
avgVOWstanALL.individual = avgVOWstanALL.individual([4:6 8 10 12:14 16 19 20 22 23 26 29 30 34],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([4:6 8 10 12:14 16 19 20 22 23 26 29 30 34],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([4:6 8 10 12:14 16 19 20 22 23 26 29 30 34],:,:);

%% Split AGE
%VOW
avgVOWstanALL_old = avgVOWstanALL;
avgVOWruleALL_old = avgVOWruleALL;
avgVOWintALL_old = avgVOWintALL;
avgVOWstanALL_old.individual = avgVOWstanALL.individual([2 3 5 6 12:19 22 23 24 27 31],:,:);
avgVOWruleALL_old.individual = avgVOWruleALL.individual([2 3 5 6 12:19 22 23 24 27 31],:,:);
avgVOWintALL_old.individual = avgVOWintALL.individual([2 3 5 6 12:19 22 23 24 27 31],:,:);
avgVOWstanALL_young = avgVOWstanALL;
avgVOWruleALL_young = avgVOWruleALL;
avgVOWintALL_young = avgVOWintALL;
avgVOWstanALL_young.individual = avgVOWstanALL.individual([1 4 7:11 20 21 25 26 28:30 32:35],:,:);
avgVOWruleALL_young.individual = avgVOWruleALL.individual([1 4 7:11 20 21 25 26 28:30 32:35],:,:);
avgVOWintALL_young.individual = avgVOWintALL.individual([1 4 7:11 20 21 25 26 28:30 32:35],:,:);
%CON
avgCONstanALL_old = avgCONstanALL;
avgCONruleALL_old = avgCONruleALL;
avgCONintALL_old = avgCONintALL;
avgCONstanALL_old.individual = avgCONstanALL.individual([3:5 7 8 10 15:21 23:26],:,:);
avgCONruleALL_old.individual = avgCONruleALL.individual([3:5 7 8 10 15:21 23:26],:,:);
avgCONintALL_old.individual = avgCONintALL.individual([3:5 7 8 10 15:21 23:26],:,:);
avgCONstanALL_young = avgCONstanALL;
avgCONruleALL_young = avgCONruleALL;
avgCONintALL_young = avgCONintALL;
avgCONstanALL_young.individual = avgCONstanALL.individual([1 2 6 9 11:14 22 27:33],:,:);
avgCONruleALL_young.individual = avgCONruleALL.individual([1 2 6 9 11:14 22 27:33],:,:);
avgCONintALL_young.individual = avgCONintALL.individual([1 2 6 9 11:14 22 27:33],:,:);

%% Exclude Leipzig
avgVOWstanALL.individual = avgVOWstanALL.individual([2:35],:,:);
avgVOWruleALL.individual = avgVOWruleALL.individual([2:35],:,:);
avgVOWintALL.individual = avgVOWintALL.individual([2:35],:,:);
size(avgVOWintALL.individual)
avgCONstanALL.individual = avgCONstanALL.individual([3:33],:,:);
avgCONruleALL.individual = avgCONruleALL.individual([3:33],:,:);
avgCONintALL.individual = avgCONintALL.individual([3:33],:,:);
size(avgCONintALL.individual)
%% Set parameters for CBPT
cfg = [];
cfg.channel= {'all', '-EOG', '-TP9', '-TP10'};
cfg.latency = [0 0.8];
cfg.method = 'montecarlo'; % use the Monte Carlo Method to calculate the significance probability
cfg.statistic = 'ft_statfun_depsamplesT'; % use the independent samples T-statistic as a measure to evaluate the effect at the sample level
cfg.correctm = 'cluster';
cfg.clusteralpha = 0.05; % alpha level of the sample-specific test statistic that will be used for thresholding, default = 0.05
cfg.clusterstatistic = 'maxsum'; % test statistic that will be evaluated under the permutation distribution.
cfg.minnbchan = 2; % minimum number of neighborhood channels that is required for a selected sample to be included in the clustering algorithm (default=0).
cfg.neighbours    = neighbours;
cfg.correcttail = 'prob';
cfg.clustertail = 0;  % -1, 1 or 0 (default = 0); one-sided or two-sided test
cfg.alpha = 0.05; % alpha level of the permutation test
cfg.numrandomization = 1000; % number of draws from the permutation distribution %FOR VOW cond warning by fieldtrip with advice to increase number of permutations

%denominations for conditions in design matrix
% subj = 33; %CON 33
% subj = 35; %VOW 35

subj = 21; %VOW ET-SPR above 10, 22
% subj = 13;

% subj = 19; %CON ET-SPR above 10
% subj = 14;

% subj = 18; %female
% subj = 17; %male

% subj = 18; %young VOW
% subj = 17; %old VOW; old CON
% subj = 16; %young CON

design = zeros(2, 2*subj);
design(1,:) = [1:subj 1:subj];             
design(2,:) = [ones(1,subj) 2*ones(1,subj)];

cfg.design = design;
cfg.uvar  = 1;% uvar = The first row of this matrix is the unit variable: it specifies which subject produced which data structure...
cfg.ivar  = 2;% ivar = The second row of the design matrix is the independent variable (conditions).

% Run CBPT
% [stat] = ft_timelockstatistics(cfg, avgCONruleALL, avgCONstanALL); % incorrect/violation condition first
% filename= strcat(dir_save, 'stat_CONrulevsCONstanALL', '.mat');
% save (filename, 'stat');
% 
% [stat] = ft_timelockstatistics(cfg, avgCONintALL, avgCONstanALL);
% filename= strcat(dir_save, 'stat_CONintvsCONstanALL', '.mat');
% save (filename, 'stat');

% [stat] = ft_timelockstatistics(cfg, avgVOWruleALL, avgVOWstanALL);
% filename= strcat(dir_save, 'stat_VOWrulevsVOWstanALL', '.mat');
% save (filename, 'stat');
% 
% [stat] = ft_timelockstatistics(cfg, avgVOWintALL, avgVOWstanALL);
% filename= strcat(dir_save, 'stat_VOWintvsVOWstanALL', '.mat');
% save (filename, 'stat');

% [stat] = ft_timelockstatistics(cfg, avgVOWruleL, avgVOWstanL);
% filename= strcat(dir_save, 'stat_VOWrulevsVOWstanL', '.mat');
% save (filename, 'stat');

[stat] = ft_timelockstatistics(cfg, avgVOWintL, avgVOWstanL);
% filename= strcat(dir_save, 'stat_VOWintvsVOWstanL', '.mat');
% save (filename, 'stat');

%age
% [stat] = ft_timelockstatistics(cfg, avgVOWruleALL_young, avgVOWstanALL_young);
% [stat] = ft_timelockstatistics(cfg, avgVOWruleALL_old, avgVOWstanALL_old);
% [stat] = ft_timelockstatistics(cfg, avgCONruleALL_young, avgCONstanALL_young);
% [stat] = ft_timelockstatistics(cfg, avgCONruleALL_old, avgCONstanALL_old);



%% Plotting
% load ([dir_save 'stat_CONrulevsCONstanALL']);
% load ([dir_save 'stat_CONintvsCONstanALL']);
% load ([dir_save 'stat_VOWrulevsVOWstanALL']);
% load ([dir_save 'stat_VOWintvsVOWstanALL']);
load ([dir_save 'stat_VOWrulevsVOWstanSPRACHEgut']);
% load ([dir_save 'stat_VOWintvsVOWstanSPRACHEgut']);

cfg = [];
cfg.zlim = [-5 5]; % T-values
cfg.alpha = 0.05;
cfg.layout = layout28;
% cfg.saveaspng = '\\samba.ikw.uos.de\store\nl\users\iweyers\COSY\Data\results\';
ft_clusterplot(cfg,stat); colorbar

%%
cfg  = [];
cfg.operation = 'subtract';
cfg.parameter = 'avg';
% % raweffectCONruleVSCONstan = ft_math(cfg,grandavgCONruleALL, grandavgCONstanALL);
% raweffectCONintVSCONstan = ft_math(cfg,grandavgCONintALL, grandavgCONstanALL);
% % raweffectVOWruleVSVOWstan = ft_math(cfg,grandavgVOWruleALL, grandavgVOWstanALL);
% raweffectVOWintVSVOWstan = ft_math(cfg,grandavgVOWintALL, grandavgVOWstanALL);
raweffectVOWruleVSstanL = ft_math(cfg,grandavgVOWruleL, grandavgVOWstanL);

%length(raweffectCONintVSCONstan.time) = 461; Has to be equal to length of
%stat in order to match properly! =410
%[0:51] baseline; 52=0; 
% raweffectCONintVSCONstan.time = raweffectCONintVSCONstan.time(52:end);
% raweffectCONintVSCONstan.avg = raweffectCONintVSCONstan.avg([1:11 13:17 19:27],52:end);
% raweffectCONintVSCONstan.label = raweffectCONintVSCONstan.label([1:11 13:17 19:27]);
% raweffectVOWintVSVOWstan.time = raweffectVOWintVSVOWstan.time(52:end);
% raweffectVOWintVSVOWstan.avg = raweffectVOWintVSVOWstan.avg([1:11 13:17 19:27],52:end);
% raweffectVOWintVSVOWstan.label = raweffectVOWintVSVOWstan.label([1:11 13:17 19:27]);
raweffectVOWruleVSstanL.time = raweffectVOWruleVSstanL.time(52:end);
raweffectVOWruleVSstanL.avg = raweffectVOWruleVSstanL.avg([1:11 13:17 19:27],52:end);
raweffectVOWruleVSstanL.label = raweffectVOWruleVSstanL.label([1:11 13:17 19:27]);

% define pos and negative clusters based on result matrix
% pos_cluster_pvals = [stat.posclusters(:).prob];
% % % % 
% % % % % Then, find which clusters are significant, outputting their indices as held in stat.posclusters
% % % % % In case you have downloaded and loaded the data, ensure stat.cfg.alpha exist
% % % % if ~isfield(stat.cfg,'alpha'); stat.cfg.alpha = 0.025; end; % stat.cfg.alpha was moved as the downloaded data was processed by an additional FieldTrip function to anonymize the data.
% % % % 
% pos_signif_clust = find(pos_cluster_pvals < stat.cfg.alpha);
% % % % % (stat.cfg.alpha is the alpha level we specified earlier for cluster comparisons; In this case, 0.025)
% % % % % make a boolean matrix of which (channel,time)-pairs are part of a significant cluster
% pos = ismember(stat.posclusterslabelmat, pos_signif_clust);
% % 
% % % and now for the negative clusters...
% neg_cluster_pvals = [stat.negclusters(:).prob];
% neg_signif_clust = find(neg_cluster_pvals < stat.cfg.alpha);
% neg = ismember(stat.negclusterslabelmat, neg_signif_clust);

% or manually select significant clusters to plot
pos = stat.posclusterslabelmat == 1; % or == 2, or 3, etc.
% neg = stat.negclusterslabelmat == 1;

%define time steps for topoplots based on sample-based time windows
timestep = 0.005; % timestep between time windows for each subplot (in seconds)
sampling_rate = 512; % Data has a temporal resolution of 300 Hz
sample_count = length(stat.time);
% number of temporal samples in the statistics object
j = [0:timestep:0.8]; % Temporal endpoints (in seconds) of the ERP average computed in each subplot
m = [1:timestep*sampling_rate:sample_count]; % temporal endpoints in MEEG samples

% define 20 plots
% First ensure the channels to have the same order in the average and in the statistical output.
% This might not be the case, because ft_math might shuffle the order
% [i1,i2] = match_str(raweffectCONruleVSCONstan.label, stat.label);
% [i1,i2] = match_str(raweffectCONintVSCONstan.label, stat.label);
% [i1,i2] = match_str(raweffectVOWruleVSVOWstan.label, stat.label);
% [i1,i2] = match_str(raweffectVOWintVSVOWstan.label, stat.label);
[i1,i2] = match_str(raweffectVOWruleVSstanL.label, stat.label);

set(gcf, 'renderer', 'zbuffer');
for k = 1:length(j)
   pp = mod(k - 1, 48) + 1;
   if pp == 1
    FigH = figure;
   end
   subplot(6,8,pp,'Parent', FigH);
   cfg = [];
   cfg.xlim=[j(k) j(k+1)];   % time interval of the subplot
   cfg.zlim = [-5 5];
%    cfg.maskstyle = 'saturation';
   % If a channel reaches this significance, then
   % the element of pos_int with an index equal to that channel
   % number will be set to 1 (otherwise 0).

   % Next, check which channels are significant over the
   % entire time interval of interest.
%    pos_int = zeros(numel(raweffectCONintVSCONstan.label),1);
%    neg_int = zeros(numel(raweffectCONintVSCONstan.label),1);
%    pos_int = zeros(numel(raweffectVOWruleVSVOWstan.label),1);
%    neg_int = zeros(numel(raweffectVOWruleVSVOWstan.label),1);
%    pos_int = zeros(numel(raweffectVOWintVSVOWstan.label),1);
%    neg_int = zeros(numel(raweffectVOWintVSVOWstan.label),1);
   pos_int = zeros(numel(raweffectVOWruleVSstanL.label),1);
%    neg_int = zeros(numel(raweffectVOWruleVSstanL.label),1);
   pos_int(i1) = all(pos(i2, m(k):m(k+1)), 2);
%    neg_int(i1) = all(neg(i2, m(k):m(k+1)), 2);

   cfg.highlight = 'on';
   % Get the index of each significant channel
   cfg.highlightchannel = find(pos_int);% | neg_int);
   cfg.comment = 'xlim';
   cfg.commentpos = 'title';
   cfg.layout = layout28;
   cfg.interactive = 'no';
%    ft_topoplotER(cfg, raweffectCONintVSCONstan); colorbar
%    ft_topoplotER(cfg, raweffectVOWruleVSVOWstan);colorbar
%    ft_topoplotER(cfg, raweffectVOWintVSVOWstan); colorbar
   ft_topoplotER(cfg, raweffectVOWruleVSstanL);colorbar
end

% print('-painters', '-f5', 'SYL', '-dsvg') %'-painters' forces high res. rendering; '-fNO' refers to figure no. in window, 'test1' filename; '-dsvg' saves as svg file
%'geom', [3 5], [rows cols] plot ERP in grid (overwrite previous option). Grid size for rectangular matrix. Example: [6 4].
