% Batch to generate a grandmean ERP file out of preprocessed *.set files
% (c) 2004 Gruber
clear all
close all

eeglab
% path = 'E:\Work\Oddball\Infants\Data_EEG\final\';
% store_path= 'E:\Work\Oddball\Infants\Data_EEG\final\';

% path = 'E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
% store_path= 'E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';
store_path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';
% path = 'B:\weyersi\Oddball\Infants\Data_EEG\final';
% store_path= 'B:\weyersi\Oddball\Infants\Data_EEG\final';
% path = 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final_2904\';
% store_path= 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\final_2904\';
% path = 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\3_eye_mastoid_13072021\';
% store_path= 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\3_eye_mastoid_13072021\';

%CON
subjects=['Sub03';'Sub07';'Sub11';'Sub13';'Sub19';'Sub21';'Sub23';'Sub25';'Sub27';'Sub29';'Sub31';'Sub33';'Sub39';'Sub41';'Sub43';'Sub45';'Sub47';'Sub49';...
'Sub51';'Sub53';'Sub55';'Sub61';'Sub63';'Sub65';'Sub67';'Sub69';'Sub79';'Sub81';'Sub83';'Sub85';'Sub87';'Sub89';'Sub91'];
conditions =  ['_C2'; '_C4'; '_C6'];

%VOW
%LENIENT
% subjects=['Sub04';'Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub86';'Sub88';'Sub90'];
%STRICT
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub84';'Sub88';'Sub90'];
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub88';'Sub90'];
% conditions =  ['_C11'; '_C33'; '_C55'];

res_filename_prefix = 'ODD_inf_gm'; 
ep = [];

%load one arbitrary file to read number of electrodes and samples
filename = strcat(subjects(1,:), conditions(1,:), '.set');
EEG = pop_loadset(filename, path); 
NElec = EEG.nbchan;     
Nsamples = EEG.pnts;

for cond_loop = 1 : size(conditions,1)
        res_average = zeros(NElec,Nsamples,size(subjects,1));
        ep
    for subject_loop = 1 : size(subjects,1)
        fileforload = strcat(subjects(subject_loop,:), conditions(cond_loop,:), '.set');
        EEG = pop_loadset(fileforload, path);  
        EEG = eeg_checkset(EEG);
%         z= round(size(EEG.data,3)/2);
        res_average(:,:,subject_loop)=mean(EEG.data,3);
%         res_average(:,:,subject_loop)=mean(EEG.data(:,:,z:end),3); %averaging across only half of trials
    end
        %load one arbitrary file and update EEG Structure
        EEG = pop_loadset(fileforload, path);
        EEG.data = res_average;
        EEG.setname = [res_filename_prefix conditions(cond_loop,:)];
        EEG.trials = size(subjects,1); 
        EEG.event = [];
        EEG.epoch = [];

     for j = 1 : EEG.trials
        EEG.event(j).latency = 1;
        EEG.event(j).type = 1;
        EEG.event(j).urevent = 1;
        EEG.event(j).epoch = j;
        EEG.epoch(j).event = j;
        EEG.epoch(j).eventlatency = 1;
        EEG.epoch(j).eventtype = 1;
        EEG.epoch(j).eventurevent = j;
     end

    %save average across subjects for one condition
     if ~isempty(ep)
        EEG = pop_select(EEG, 'time',ep);
     end
    EEG = pop_editset(EEG, 'chanlocs', 'chanlocs_28_Ivonne.xyz'); %insert right position of chan loc file
    pop_saveset(EEG, [res_filename_prefix conditions(cond_loop,:) '.set'], store_path);
end
 
%% Convert to .mat format
%% VOW
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\3_eye_mastoid_13072021\';
% path = 'E:\Work\Oddball\Infants\Data_EEG\final\';
% path ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';

EEG = pop_loadset('filename',['ODD_inf_gm_C11.set'], 'filepath',path);
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% VOW_standard_fil = EEG.data;
% sfile = strcat(path, 'VOW_standard_fil', '.mat');
% save(sfile, '-mat')
VOW_standard = EEG.data;
sfile = strcat(path, 'VOW_standard', '.mat');
save(sfile, '-mat')
%% 
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\3_eye_mastoid_13072021\';
% path = 'E:\Work\Oddball\Infants\Data_EEG\final\';
% path ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';

EEG = pop_loadset('filename',['ODD_inf_gm_C33.set'], 'filepath',path);
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% VOW_rule_fil = EEG.data;
% sfile = strcat(path, 'VOW_rule_fil', '.mat');
% save(sfile, '-mat')
VOW_rule= EEG.data;
sfile = strcat(path, 'VOW_rule', '.mat');
save(sfile, '-mat')
%% 
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\3_eye_mastoid_13072021\';
% path = 'E:\Work\Oddball\Infants\Data_EEG\final\';
% path ='E:\Work\Oddball\Infants\Data_EEG\final_strict_VOW\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\VOW\';

EEG = pop_loadset('filename',['ODD_inf_gm_C55.set'], 'filepath',path);
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% VOW_int_fil = EEG.data;
% sfile = strcat(path, 'VOW_int_fil', '.mat');
% save(sfile, '-mat')
VOW_int = EEG.data;
sfile = strcat(path, 'VOW_int', '.mat');
save(sfile, '-mat')

%% CON
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\final\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';

EEG = pop_loadset('filename',['ODD_inf_gm_C2.set'], 'filepath',path);
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% CON_standard_fil = EEG.data;
% sfile = strcat(path, 'CON_standard_fil', '.mat');
% save(sfile, '-mat')
CON_standard = EEG.data;
sfile = strcat(path, 'CON_standard', '.mat');
save(sfile, '-mat')
%% 
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\final\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';

EEG = pop_loadset('filename',['ODD_inf_gm_C4.set'], 'filepath',path);
EEG = pop_select( EEG,'channel', {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% CON_rule_fil = EEG.data;
% sfile = strcat(path, 'CON_rule_fil', '.mat');
% save(sfile, '-mat')
CON_rule = EEG.data;
sfile = strcat(path, 'CON_rule', '.mat');
save(sfile, '-mat')
%% 
clear all
close all
eeglab
% path= 'E:\Work\Oddball\Infants\Data_EEG\final\';
path= 'C:\Users\Weyers\Desktop\ODD_infant\Outlier_adjustment\CONS\';

EEG = pop_loadset('filename',['ODD_inf_gm_C6.set'], 'filepath',path);
EEG = pop_select( EEG,'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'F9' 'F10' 'FC6' 'TP9' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP10' 'CP5' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'O1' 'O2' 'EOG'});
% EEG = pop_firws(EEG, 'fcutoff', 10, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 620, 'minphase', 0);
% CON_int_fil = EEG.data;
% sfile = strcat(path, 'CON_int_fil', '.mat');
% save(sfile, '-mat')
CON_int = EEG.data;
sfile = strcat(path, 'CON_int', '.mat');
save(sfile, '-mat')
