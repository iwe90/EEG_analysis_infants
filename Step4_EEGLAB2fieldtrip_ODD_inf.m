%% Convert EEGLAB to Fieldtrip
% Input: split condition .set files per subject
% Output: Fieldtrip cell structures with one file per condition;
% each cell, e.g. {1,1}, {1,2}, contains one subject; subject data
% contains averaged condition data for each subject 
% ft_timelockanalysis converts file and adds timing information
% Adjust: paths, filenames, condition denominations
% (c) Ivonne Weyers 2019

clear all
close all

% addpath(genpath('E:\Work\eeglab14_1_1b'));
eeglab 
%CON
subjects=['Sub03';'Sub07';'Sub11';'Sub13';'Sub19';'Sub21';'Sub23';'Sub25';'Sub27';'Sub29';'Sub31';'Sub33';'Sub39';'Sub41';'Sub43';'Sub45';'Sub47';'Sub49';...
'Sub51';'Sub53';'Sub55';'Sub61';'Sub63';'Sub65';'Sub67';'Sub69';'Sub79';'Sub81';'Sub83';'Sub85';'Sub87';'Sub89';'Sub91'];
% 
conditions =  [2 4 6];

%VOW
%LENIENT
% subjects=['Sub04';'Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub86';'Sub88';'Sub90'];
%STRICT
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub84';'Sub88';'Sub90'];
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub88';'Sub90'];

% conditions =  [11 33 55];

% pfad = 'E:\Work\Oddball\Infants\Data_EEG\final\';%% insert your final folder;
% pfad ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
% pfad= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';
pfad= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';
% pfad = 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final\';%% insert your final folder;
% pfad =  'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\2_after_ICA_29042021\';

%% EEGLAB2fieldtrip
for i = 1: size(conditions,2)
 for ns = 1: size(subjects,1) 
        folder = subjects(ns,:);
        filename = [pfad folder '_C' num2str(conditions(:,i)) '.set'];
        EEG = pop_loadset(filename);
        FT = eeglab2fieldtrip(EEG, 'timelockanalysis', 'none');
        ODD_ALL_inf{ns}=FT;
        clear EEG
 end
sfile = strcat('C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\', 'ALLSUB_ODD_inf_', num2str(conditions(:,i)), '.mat');
save(sfile, 'ODD_ALL_inf'); 
end 

%% Run timelockanalysis
% Run separately for each condition, e.g. SYL correct, SYL incorrect
clear all 
close all
% addpath 'E:\Work\MATLAB\fieldtrip-20170216\';
ft_defaults;
% pfad ='E:\Work\Oddball\Infants\Data_EEG\final\';
% dir_save = 'E:\Work\Oddball\Infants\Data_EEG\final\';

% pfad ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
% dir_save = 'E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
pfad= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';
dir_save= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';
% pfad = 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final\';
% dir_save = 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final\';
% pfad ='E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\2_after_ICA_29042021\';
% dir_save ='E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\2_after_ICA_29042021\';

%% CON
%CONstandard
subjects=['Sub03';'Sub07';'Sub11';'Sub13';'Sub19';'Sub21';'Sub23';'Sub25';'Sub27';'Sub29';'Sub31';'Sub33';'Sub39';'Sub41';'Sub43';'Sub45';'Sub47';'Sub49';...
'Sub51';'Sub53';'Sub55';'Sub61';'Sub63';'Sub65';'Sub67';'Sub69';'Sub79';'Sub81';'Sub83';'Sub85';'Sub87';'Sub89';'Sub91'];
load ([pfad 'ALLSUB_ODD_inf_2.mat']);
for j = 1: size(subjects,1)  %no of subjects in this condition
    avgCONstan{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgCONstan{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j}); %grand means for each subject, then put back in one matrix, then create grand means
end
filename= strcat(dir_save, 'avgCONstan', '.mat');
save (filename, 'avgCONstan');
clear ODD_ALL_inf
clear filename

%CONrule
load ([pfad 'ALLSUB_ODD_inf_4.mat']);
for j = 1: size(subjects,1)
    avgCONrule{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgCONrule{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j});
end
filename= strcat(dir_save, 'avgCONrule', '.mat');
save (filename, 'avgCONrule');
clear ODD_ALL_inf
clear filename

%CONint
load ([pfad 'ALLSUB_ODD_inf_6.mat']);
for j = 1: size(subjects,1)
    avgCONint{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgCONint{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j});
end
filename= strcat(dir_save, 'avgCONint', '.mat');
save (filename, 'avgCONint');
clear ODD_ALL_inf
clear filename

%% VOW
% VOWstan
%LENIENT
% subjects=['Sub04';'Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub86';'Sub88';'Sub90'];
%STRICT
subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
    'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub84';'Sub88';'Sub90'];
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub88';'Sub90'];

load ([pfad 'ALLSUB_ODD_inf_11.mat']);
for j = 1: size(subjects,1)
    avgVOWstan{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgVOWstan{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j});
end
filename= strcat(dir_save, 'avgVOWstan', '.mat');
save (filename, 'avgVOWstan');
clear ODD_ALL_inf
clear filename

% VOWrule
load ([pfad 'ALLSUB_ODD_inf_33.mat']);
for j = 1: size(subjects,1)
    avgVOWrule{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgVOWrule{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j});
end
filename= strcat(dir_save, 'avgVOWrule', '.mat');
save (filename, 'avgVOWrule');
clear ODD_ALL_inf
clear filename

% VOWint
load ([pfad 'ALLSUB_ODD_inf_55.mat']);
for j = 1: size(subjects,1)
    avgVOWint{j} = 1:j;
    cfg = [];
    cfg.keeptrials = 'yes';
    avgVOWint{j} = ft_timelockanalysis(cfg, ODD_ALL_inf{1,j});
end
filename= strcat(dir_save, 'avgVOWint', '.mat');
save (filename, 'avgVOWint');
clear ODD_ALL_inf
clear filename