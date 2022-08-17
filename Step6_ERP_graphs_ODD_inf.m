%% Tutorial: Analyses with Matlab
% (c) Gruber 2014, modified by Mueller 2015, modified by Weyers 2019
clear all
close all
% addpath(genpath('C:\Users\Weyers\Documents\MATLAB\eeglab2021.0'));
eeglab 
load chanlocs_28_Ivonne.mat;
% Load condfiles
filepath ='E:\Work\Oddball_infants\Data_EEG\VOW\final\';
load(strcat(filepath,'VOW_standard.mat'));
load(strcat(filepath,'VOW_rule.mat'));
load(strcat(filepath,'VOW_int.mat'));
load(strcat(filepath,'VOW_standard_fil.mat'));
load(strcat(filepath,'VOW_rule_fil.mat'));
load(strcat(filepath,'VOW_int_fil.mat'));
clear filepath
filepath ='E:\Work\Oddball_infants\Data_EEG\CONS\final\'; 
load(strcat(filepath,'CON_standard.mat'));
load(strcat(filepath,'CON_rule.mat'));
load(strcat(filepath,'CON_int.mat'));
load(strcat(filepath,'CON_standard_fil.mat'));
load(strcat(filepath,'CON_rule_fil.mat'));
load(strcat(filepath,'CON_int_fil.mat'));
%% Define conditions
%(electrodes,noOfObservations, participants)
%[1 4 5 8 9 12 15 17 22 24 25 29 30 38] eyeballing positivity rule
%condition
%[1 4 5 8 9 11 12 13 15 17 24 26 28 30] criterion >0.5 amplitude diff. wave
%rule condition in TW of intensity effect
%[1 4 5 6 11 15 16 17 18 21 24 26 27 28 29 31 34] criterion >0.5 amplitude diff. wave intensity condition in TW of intensity effect
%[7 8 9 12 14 19 32 37 38] NEGATIVITY diff. wave intensity condition in TW of intensity effect
%[2 3 10 13 20 22 23 25 30 33 35 36] non-specific neg/pos in intensity cond
se_grandavg_VOWstanALL = nanstd(VOW_standard/sqrt(size(VOW_standard,3)),0,3);
se_grandavg_VOWruleALL = nanstd(VOW_rule/sqrt(size(VOW_rule,3)),0,3);

%Restults LANG dimension ET6-6 above 10[2:5 7:8 12:14 16:22 25:27 30:31 33]
meanVOW_standard = mean(VOW_standard_fil(:,:,[2:5 7:8 12:14 16:22 25:27 30:31 33]),3);
meanVOW_rule = mean(VOW_rule_fil(:,:,[2:5 7:8 12:14 16:22 25:27 30:31 33]),3);
meanVOW_int = mean(VOW_int_fil(:,:,[2:5 7:8 12:14 16:22 25:27 30:31 33]),3);

meanCON_standard = mean(CON_standard_fil(:,:,[3 4 6 7 9 10 12 13 15:21 23 26 30 33]),3);
meanCON_rule = mean(CON_rule_fil(:,:,[3 4 6 7 9 10 12 13 15:21 23 26 30 33]),3);
meanCON_int = mean(CON_int_fil(:,:,[3 4 6 7 9 10 12 13 15:21 23 26 30 33]),3);

%Restults LANG dimension ET6-6 10 and below
meanVOW_standard = mean(VOW_standard(:,:,[1 6 9:11 15 23 24 28 29 32 34:36]),3);
meanVOW_rule = mean(VOW_rule(:,:,[1 6 9:11 15 23 24 28 29 32 34:36]),3);
meanVOW_int = mean(VOW_int(:,:,[1 6 9:11 15 23 24 28 29 32 34:36]),3);

% Girls
meanVOW_standard = mean(VOW_standard(:,:,[1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35]),3);
meanVOW_rule = mean(VOW_rule(:,:,[1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35]),3);
meanVOW_int = mean(VOW_int(:,:,[1:3 7 9 11 15 17 18 21 24 25 27 28 31:33 35]),3);
% Boys
meanVOW_standard = mean(VOW_standard(:,:,[4:6 8 10 12:14 16 19 20 22 23 26 29 30 34]),3);
meanVOW_rule = mean(VOW_rule(:,:,[4:6 8 10 12:14 16 19 20 22 23 26 29 30 34]),3);
meanVOW_int = mean(VOW_int(:,:,[4:6 8 10 12:14 16 19 20 22 23 26 29 30 34]),3);
%%
meanVOW_standard = mean(VOW_standard(:,:,[2:36]),3);
meanVOW_rule = mean(VOW_rule(:,:,[2:36]),3);
meanVOW_int = mean(VOW_int(:,:,[2:36]),3);

meanVOW_standard = mean(VOW_standard(:,:,[ 6 9:11 15 23 24 28 29 32 34:36]),3);
meanVOW_rule = mean(VOW_rule(:,:,[ 6 9:11 15 23 24 28 29 32 34:36]),3);
meanVOW_int = mean(VOW_int(:,:,[ 6 9:11 15 23 24 28 29 32 34:36]),3);
%%
meanVOW_standard = mean(VOW_standard(:,:,:),3);
meanVOW_rule = mean(VOW_rule(:,:,:),3);
meanVOW_int = mean(VOW_int(:,:,:),3);

%taking out malfunctioning EOG electrodes (subj 6 and 33)
meanCON_standard = mean(CON_standard(1:27,:,:),3);
meanCON_standard(28,:) = mean(CON_standard(28,:,[1:5 7:32]),3); %7:32
meanCON_rule = mean(CON_rule(1:27,:,:),3);
meanCON_rule(28,:) = mean(CON_rule(28,:,[1:5 7:32]),3);
meanCON_int = mean(CON_int(1:27,:,:),3);
meanCON_int(28,:) = mean(CON_int(28,:,[1:5 7:32]),3);

% 10Hz Filter
meanVOW_standard = mean(VOW_standard_fil(:,:,:),3);
meanVOW_rule = mean(VOW_rule_fil(:,:,:),3);
meanVOW_int = mean(VOW_int_fil(:,:,:),3);

meanCON_standard = mean(CON_standard_fil(1:27,:,:),3);
meanCON_standard(28,:) = mean(CON_standard_fil(28,:,[1:5 7:32]),3); %7:32
meanCON_rule = mean(CON_rule_fil(1:27,:,:),3);
meanCON_rule(28,:) = mean(CON_rule_fil(28,:,[1:5 7:32]),3);
meanCON_int = mean(CON_int_fil(1:27,:,:),3);
meanCON_int(28,:) = mean(CON_int_fil(28,:,[1:5 7:32]),3);
% Create one matrix with data to be compared (only two conditions at a time)
VOW = [];
VOW(:,:,1) = meanVOW_standard;
VOW(:,:,2) = meanVOW_rule;
VOW(:,:,3) = meanVOW_int;

CON = [];
CON(:,:,1) = meanCON_standard;
CON(:,:,2) = meanCON_rule;
CON(:,:,3) = meanCON_int;

% DIFFSYL = [];
% DIFFSYL=VOW_int(:,:,[1:5])-VOW_standard(:,:,[1:5]);

%% Create comparative plot with two conditions
w=cell(1,28)'; %create cell array, has to be in this format!
for y=1:28 %all electrodes for convenience, choose only significant ones for whole head illustration!
   w{y,1}= [402;553];%[0,272;125,613]; %define time windows, [start_tw1,start_tw2;end_tw1,end_tw2]
end
% figure
% plottopo(DIFFSYL,'chanlocs', chanlocs,'limits',[-100 800 -15.00 15.00],'title', 'VOW standard-rule-intensity', 'colors', {{'b' 'linewidth' 0.3 } {'r' 'linewidth' 0.3 } {'g' 'linewidth' 0.3 }},'title', 'VOW Condition old', 'vert', [200 400 600 800])%, 'regions',w )

figure
plottopo(VOW,'chanlocs', chanlocs,'limits',[-100 800 -8.00 8.00],'title', 'VOW standard-rule-intensity', 'colors', {{'b' 'linewidth' 0.7 } {'r' 'linewidth' 0.7 } {'g' 'linewidth' 0.7 }},'title', 'VOW Condition n=22 filter', 'vert', [200 400 600 800])%, 'regions',w );
% print('-painters', '-f2', strcat(filepath,'VOWstandard-rule-intensity'), '-dsvg');
% figure
% plottopo(VOW,'chanlocs', chanlocs,'limits',[-100 800 -7.00 7.00],'title', 'VOW standard-rule-intensity', 'colors', {{'b' 'linewidth' 0.3 } {'r' 'linewidth' 0.3 } {'g' 'linewidth' 0.3 } {'c' 'linewidth' 0.3 } {'c' 'linewidth' 0.3 } {'c' 'linewidth' 0.3 }},'title', 'VOW Condition old', 'vert', [200 400 600 800])%, 'regions',w )

% v=cell(1,28)'; %create cell array, has to be in this format!
% for y=1:28 %all electrodes for convenience, choose only significant ones for whole head illustration!
%    v{y,1}= [463;631]; %define time windows, [start_tw1,start_tw2;end_tw1,end_tw2]
% end

figure
plottopo(CON,'chanlocs', chanlocs,'limits',[-100 800 -8.00 8.00],'title', 'CON standard-rule-intensity', 'colors', {{'b' 'linewidth' 0.7 } {'r' 'linewidth' 0.7 } {'g' 'linewidth' 0.7 }},'title', 'CON Condition n=19 filter', 'vert', [200 400 600 800]);%, 'regions',v)
% print('-painters', '-f3', strcat(filepath,'CONstandard-rule-intensity'), '-dsvg');


set(0, 'CurrentFigure', h);
plottopo( erptoplot, 'chanlocs', chanlocs, 'frames', pnts, ...
          'limits', [xmin xmax 0 0]*1000, 'title', g.title, 'colors', colors, ...
          'chans', g.chans, 'legend', legend, 'regions', regions, 'ylim', g.ylim, g.tplotopt{:});
