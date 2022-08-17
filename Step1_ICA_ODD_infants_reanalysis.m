clear all
close all

% addpath(genpath('E:\Work\eeglab14_1_1b'));
eeglab 

%% VOW
% path_load = 'E:\Work\Oddball_infants\Data_EEG\VOW\pre-processed\';
% path_save= 'E:\Work\Oddball_infants\Data_EEG\VOW\500Hz\';
%Leipzig
% subjects = ['Sub06'];
%OSNA
%VOW out: 02,04,16,20,32,36,52,58,74
%STRICT
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';'Sub46';'Sub48';'Sub50';...
%     'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub84';'Sub88';'Sub90'];

% %OB
%triggers before vowel / before consonant SYL 3
%standards = 11 22 / 1 2
%intensity deviants = 55 66 / 5 6 
%rule deviants = 33 44 / 3 4
% relevant_triggers = [11 22 33 44 55 66];
% final_markers = [11 33 55];
%% CON
path_load = 'E:\Work\Oddball_infants\Data_EEG\CONS\pre-processed\';
path_save = 'E:\Work\Oddball_infants\Data_EEG\CONS\500Hz\';
%Leipzig
%CON
% subjects = ['Sub03';'Sub07'];
%CON out_re: 01,05,15,17,21,35,37,57,59,69,71,75,89
%CON out: 01,05,09,15,17,35,37,57,59,71,73,75,77
% subjects=['Sub03';'Sub07';'Sub11';'Sub13';'Sub19';'Sub21';'Sub23';'Sub25';'Sub27';'Sub29';'Sub31';'Sub33';'Sub39';'Sub41';'Sub43';'Sub45';'Sub47';'Sub49';...
% 'Sub51';'Sub53';'Sub55';'Sub61';'Sub63';'Sub65';'Sub67';'Sub69';'Sub79';'Sub81';'Sub83';'Sub85';'Sub87';'Sub89';'Sub91'];
subjects=['Sub11';];

%OB
relevant_triggers = [1 2 3 4 5 6];
final_markers = [2 4 6];
%%
% a={'Fz'}; 
a={'Fz' 'P7'};

% adjust=25;

%longer epochs for SYL and CONS condition
t_minmax = [-0.1 0.8]; % Epoch to cut out
baseline = [-100 0];

fprintf('1 = Import & merge files /n 2= Detrend, re-reference, add channel information, filter for ICA /n 3 = Epochize 1 & 2 /n  4 = Perform ICA /n  5 = Component Selection /n 6 = Split condition /n 7 = 2 & 3 ');
start_analysis = input('please choose which analysis do you want to run:');

%% CONTINUOUS DATA: Detrend, re-reference, add channel information & filter for ICA
if ((start_analysis == 2)|(start_analysis == 7))
for ns = 1 : size(subjects,1)
        filepath = [path_load subjects(ns,:)];
        filename = strcat(subjects(ns,:),'.set');
        EEG = pop_loadset(filename, filepath);
        %Discard 4 additional channels (Digi, Aux, Saw)
        EEG = pop_select( EEG,'channel',1:28); 
        %Detrend
        EEG = eeg_detrend(EEG);
        
        %Osnabrück
        EEG = pop_resample(EEG, 500);
        EEG = pop_editset(EEG, 'srate', 500);
        %Add channel information (chanlocs)
        
        %Leipzig
%         EEG = pop_chanedit(EEG, 'changefield',{28 'labels' 'EOG'}); %Leipzig
%         index = [1 2 6 4 3 5 7 10 8 9 11 19 15 13 12 14 16 20 17 18 24 22 21 23 25 26 27 28]; %Leipzig
%         EEG.data = EEG.data(index,:,:); %Leipzig
%         EEG.chanlocs = EEG.chanlocs(index); %Leipzig
        
        EEG = pop_chanedit(EEG, 'load',{'E:\Work\DataAnalysis\chanlocs_28_Ivonne.xyz', 'filetype', 'xyz'}); 
        %Delete bad channels & interpolate (optional)
        if exist('a', 'var') == 1
            EEG_eye = pop_select(EEG,'channel',28); %saving EOG channel data in separate datastructure
            EEG = pop_select(EEG,'channel',1:27); %w/o eyes
            originalEEG = EEG;
            EEG = pop_select(EEG,'nochannel',a);
            EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical'); %interpolate data set w/o EOG!
            EEG.data(28,:) = EEG_eye.data(1,:); %add EOG back to the data
            EEG.chanlocs(28)=EEG_eye.chanlocs;
            [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
            eeglab redraw
        else 
        end
        %Re-reference to averaged mastoids
        EEG = pop_reref(EEG, [12 18],'keepref','on'); %keep reference channels in the data / reference without 28 in data set 30.06.
        %Save detrended,re-referenced version
        filename2 = strcat(subjects(ns,:),'re.set');
        save_path = [path_save subjects(ns,:)];
        EEG = pop_saveset(EEG, 'filename', filename2, 'filepath', save_path);
        
        %Filter for ICA     
        EEG = pop_loadset(filename2, save_path);
        [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0 );
        EEG = pop_firws(EEG, 'fcutoff', 1, 'ftype', 'highpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 930, 'minphase', 0);
        EEG = pop_firws(EEG, 'fcutoff', 30, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 188, 'minphase', 0);
        %Save [1 30] Hz filtered data for ICA
        filename_ICA = [subjects(ns,:) 'ICA_1_30.set'];
        EEG = pop_saveset(EEG, 'filename', filename_ICA, 'filepath', save_path);
        
        %Load detrended, re-referenced version
        EEG = pop_loadset(filename2, save_path); 
        [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0 );
        %Filter for final version
        EEG = pop_firws(EEG, 'fcutoff', 0.3, 'ftype', 'highpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 3092, 'minphase', 0);
        EEG = pop_firws(EEG, 'fcutoff', 30, 'ftype', 'lowpass', 'wtype', 'kaiser', 'warg', 5.65326, 'forder', 188, 'minphase', 0);
        %Save [0.3 30] Hz filtered data, which ICA weights will be applied to
        filename_ICA2 = [subjects(ns,:) '0330filter.set'];
        EEG = pop_saveset( EEG, 'filename',filename_ICA2, 'filepath', save_path); 
        clear filename
        clear filename2
        clear filename_ICA
        clear filename_ICA2      
end
end

%% Epochize 1
if ((start_analysis == 3)|(start_analysis == 7))
for ns = 1 : size(subjects,1)
        filepath = [path_save subjects(ns,:)];
%         filepath = [pfad_raw subjects(ns,:)];
        filename = strcat(subjects(ns,:),'ICA_1_30.set');
%         diary([filepath 'diary_epochize.txt']) % keep command window output as diary
%         fprintf('--------------------------------------------')
%         fprintf(['Epochize data of ' subjects(ns,:)])
%         fprintf('--------------------------------------------')
        %Load dataset
        EEG = pop_loadset(filename, filepath);
        %Select relevant events and create event matrix
        EEG = pop_selectevent(EEG, 'type', relevant_triggers, 'deleteevents', 'on', 'deleteepochs', 'on', 'invertepochs', 'off');
        %Cut out epochs
        dummy=num2cell(relevant_triggers);
        EEG = pop_epoch(EEG, dummy, t_minmax, 'epochinfo', 'yes');
        %Replace old triggers with new ones (optional)
        EEG = replace_events_CON_inf(EEG);
%         EEG = replace_events_VOW_inf(EEG);
%         EEG = replace_events_CON_inf_LP(EEG);
%         EEG = replace_events_VOW_inf_LP(EEG);
        %Save new epochized data set
        filename2 = [subjects(ns,:),'ICA_1_30_e.set'];
        EEG = pop_saveset(EEG, 'filename', filename2, 'filepath', filepath);
end
end

%% Epochize 2
if ((start_analysis == 3)|(start_analysis == 7))
for ns = 1 : size(subjects,1)
        filepath = [path_save subjects(ns,:)];
        filename = strcat(subjects(ns,:),'0330filter.set');
%         diary([filepath 'diary_epochize.txt']) % keep command window output as diary
%         fprintf('--------------------------------------------')
%         fprintf(['Epochize data of ' subjects(ns,:)])
%         fprintf('--------------------------------------------')
        %Load dataset
        EEG = pop_loadset(filename, filepath);
        %Select relevant events and create event matrix
        EEG = pop_selectevent(EEG, 'type', relevant_triggers, 'deleteevents', 'on', 'deleteepochs', 'on', 'invertepochs', 'off');
        %Cut out epochs
        dummy=num2cell(relevant_triggers);
        EEG = pop_epoch(EEG, dummy, t_minmax, 'epochinfo', 'yes');
        %Replace old triggers with new ones (optional)
        EEG = replace_events_CON_inf(EEG);
%         EEG = replace_events_VOW_inf(EEG);
%         EEG = replace_events_CON_inf_LP(EEG);
%         EEG = replace_events_VOW_inf_LP(EEG);
        %Save new epochized data set  
        filename2 = [subjects(ns,:),'0330filter_e.set'];
        EEG = pop_saveset(EEG, 'filename', filename2, 'filepath', filepath);
end
end 

%% Run ICA
%ICA is run on higher filtered data to improve performance
if (start_analysis == 4)
    for ns = 1 : size(subjects,1) 
        [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;      
        folder = subjects(ns,:);
        filepath_source =[pfad_raw_re,folder,'/'];
        filename = [filepath_source subjects(ns,:) 'ICA_1_30_e_rejected.set'];
        filename_ICA = [filepath_source subjects(ns,:) '_ICA.set'];
        
       %Load [1 30] Hz filtered data
        EEG = pop_loadset(filename);             
        [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0);
        EEG = eeg_checkset(EEG);
    
        %Run ICA - without TP9, TP10 and eye-electrode (could be included but
        %is not re-referenced to the same channels
%         rank(EEG.data([1:27],:))
%         r=rank(EEG.data(:,:)); %rank() is not reliable!
        %Run AMICA using calculated data rank with 'pcakeep' option (or runica() using 'pca' option)
%         pop_runamica(EEG);
%         if r == 27
        EEG = pop_runica(EEG, 'extended',1,'chanind', [1:11 13:17 19:28],'interupt','on');
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%         else 
        %Adjust rank of data in case of previous channel interpolation
%         adjust=r-2;
%         EEG = pop_runica(EEG, 'extended',1,'chanind', [1:27],'interupt','on', 'pca', adjust);
%         [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%         end
        %Save ICA components
        EEG = pop_saveset(EEG,'filename',filename_ICA);    
        clear filename
        clear filename_ICA
    end
end

%% Component selection
%Select ICA components to be excluded for each individual subject
if (start_analysis == 5) 
        sub = input('please type in which subject you want to look at:  ', 's');   
        [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;      
        folder = ['Sub',sub];
        filepath_source =[pfad_raw_re,folder,'\'];
        filename = [filepath_source folder '_ICA.set'];
        filename_0330filtered = [filepath_source folder '0330filter_e_rejected.set'];
        filename_icaclean = [filepath_source sub '_ICAclean.set'];
        filename_icaweights = [filepath_source sub '_ICArej.mat'];
        filename_icafinal = [filepath_source sub 'ICA_final.set'];
%         filename_icaclean = [filepath_source sub '_ICAclean2.set'];
%         filename_icaweights = [filepath_source sub '_ICArej2.mat'];
%         filename_icafinal = [filepath_source sub 'ICA_final2.set'];
%         filename = [filepath_source folder '_ICA.set'];
%         filename_icaclean = [pfad '\' sub '_ICAclean.set'];
%         filename_icaweights = [pfad '\' sub '_ICArej.mat'];
%         filename_0330filtered = [pfad '\' folder '0330filter_e_rejected.set'];
%         filename_icafinal = [pfad '\' sub 'ICA_final.set'];
        %Load each subject file individually
        EEG = pop_loadset(filename); 
        %save ICA structure in temporary matrix
        TMP.icawinv = EEG.icawinv;
        TMP.icasphere = EEG.icasphere;
        TMP.icaweights = EEG.icaweights;
        TMP.icachansind = EEG.icachansind;
        %Plot and select components
        EEG = pop_iclabel(EEG, 'default');
        pop_selectcomps(EEG, 1:25); %26
        pop_eegplot(EEG, 0, 1, 1);
        pop_eegplot(EEG); 
        pop_plotdata(EEG);
        pop_envtopo(EEG, [200 500]);
        %Save rejected components
        savevar=EEG.reject.gcompreject;
        save(filename_icaweights, 'savevar');
        %Remove components
        compartefact = find(savevar==1);
        EEG = pop_subcomp(EEG, compartefact, 0);
        [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
        EEG = eeg_checkset(EEG);
        % save data
        EEG = pop_saveset(EEG, 'filename',filename_icaclean);
        % Bereinigte Daten anschauen 1Hz
%         pop_eegplot(EEG);
        ALLEEG = pop_delset( ALLEEG, [1] ); 
        %load [0.1 30] Hz filtered data
        EEG = pop_loadset(filename_0330filtered);
        
        %convert ICA parameters of 0.1 set to calculated ICA matrix
        EEG.icawinv = TMP.icawinv;
        EEG.icasphere = TMP.icasphere;
        EEG.icaweights = TMP.icaweights;
        EEG.icachansind = TMP.icachansind;
        EEG = eeg_checkset(EEG, 'ica');
        clear TMP;
        
        %apply ICA weights to 0.3 set
        EEG = pop_subcomp(EEG, compartefact, 0);
        [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
        EEG = eeg_checkset(EEG);
             
        %Apply baseline correction
        EEG = pop_rmbase(EEG, baseline);
        %Save
        EEG = pop_saveset(EEG, 'filename',filename_icafinal);
        eeglab redraw; 

        %channel data scroll 0.3Hz
        %Re-reference F9 and F10 to each other, as well as EOG and Fp1
        EEG_eye=EEG;
        EEG_eyeH = pop_select(EEG,'channel',[9 10]);
        EEG_EOGH = EEG_eyeH.data(1,:)-EEG_eyeH.data(2,:);
        EEG_eyeV = pop_select(EEG,'channel',[1 28]);
        EEG_EOGV = EEG_eyeV.data(1,:)-EEG_eyeV.data(2,:);
        %add new bipolar eye channels back to the data
%         EEG = pop_select(EEG,'channel',[2:8 11:27]);
        EEG.data(29,:) = EEG_EOGH(1,:); %add EOG back to the data
        EEG.chanlocs(29)=EEG_eye.chanlocs(28);
        EEG.chanlocs(1,29).labels = 'EOGH';
        EEG.data(30,:) = EEG_EOGV(1,:); %add EOG back to the data
        EEG.chanlocs(30)=EEG_eye.chanlocs(9);
        EEG.chanlocs(1,30).labels = 'EOGV';
        [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
        eeglab redraw
        pop_eegplot(EEG, 1, 1, 1);
%         EEG = pop_select(EEG,'channel',[1:28]);
end
%% Split condition
%Split ICA filtered individual subject files into separate files per
%condition

if (start_analysis == 6)
    for ns = 1 : size(subjects,1)
         folder = subjects(ns,:);
         filepath_source =[pfad_raw_re,folder,'/'];
%            filepath_source =[pfad_raw,'/'];
         filename = [filepath_source subjects(ns,:) '_ICA_final_re.set'];
		 
		 disp('--------------------------------------------')
         disp(['splitting condition of'  subjects(ns,:)])
         disp('--------------------------------------------')    
		  
	  % 0.1*** Flatliner Detection: Avg. Voltage<1.5 microvolt in over 50% of trials
        A=squeeze(sum(mean(abs(EEG.data),2)<1.5,3));
        Flatliners=find(A>size(EEG.data,3)*0.5)';
        disp(['Flatliners: ' num2str(Flatliners,'%4d')]);
	
    for i = 1:size(final_markers,2)
        EEG = pop_loadset(filename);
        EEG = pop_selectevent(EEG, 'type', final_markers(i), 'deleteevents', 'off', 'deleteepochs', 'on');
        EEG = pop_saveset(EEG, [folder '_C' num2str(final_markers(i)) '.set'], finalpath_re);
%         EEG = pop_saveset(EEG, [subjects(ns,:) '_C' num2str(final_markers(i)) '.set'], finalpath);
    end
    end
end