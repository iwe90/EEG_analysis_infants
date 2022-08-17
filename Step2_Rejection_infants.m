% for i=1:91
%     mkdir(strcat('E:\Work\Oddball\Infants\Data_EEG\reanalysis_24_02_2021\raw\', 'Sub', num2str(i)))
% end

clear all
close all
eeglab
sub = '86';  
EEG = pop_loadset('filename',['Sub' sub '0330filter_e.set'],'filepath',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\']);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw

EEG = pop_rejepoch( EEG, [1:4 6:9 11:25 28 30 32:34 37:40 42 43 51 55 56 60 61 63 66 73 74 77 79 80:86 89:90 92:94 99 103 105:108 111:112 119 120 126:128 132 133 135:138 144 145:150 176 188:190 192 194:196 199 201:203 205 206 209 212 214:228 236:238 242 245 246 249 253 256:260 263:266 269:272 275:278 284:288 292 298 301 302 305 306 310 314:316 318 ] ,0);

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\' 'Sub' sub '0330filter_e_rejected.set'],'gui','off');  
fprintf('Done ')

% Reject 1_30
% clear all
% close all
% eeglab
% sub='04';
EEG = pop_loadset('filename',['Sub' sub 'ICA_1_30_e.set'],'filepath',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\']);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );

EEG = pop_rejepoch( EEG, [1:4 6:9 11:25 28 30 32:34 37:40 42 43 51 55 56 60 61 63 66 73 74 77 79 80:86 89:90 92:94 99 103 105:108 111:112 119 120 126:128 132 133 135:138 144 145:150 176 188:190 192 194:196 199 201:203 205 206 209 212 214:228 236:238 242 245 246 249 253 256:260 263:266 269:272 275:278 284:288 292 298 301 302 305 306 310 314:316 318 ] ,0);

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\' 'Sub' sub 'ICA_1_30_e_rejected.set'],'gui','off');
fprintf('Done')

eegh
y=vertcat(EEG.event.type);
%VOW
% A=[11 33 55];
%CON
A=[2 4 6];
countmember(A,y)
size(y)

%% ICA Final data set; rejection after ICA
clear all
close all
eeglab
sub = '84';  
EEG = pop_loadset('filename',[sub 'ICA_final.set'],'filepath',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\']);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset(EEG);
        
EEG = pop_rejepoch( EEG, [5 6 11 13 14 21 23 24:28 30 32 33 35 36 37 40 42 43 46 48 49 50 54 55 58 62 64 65 76 79 85:87 89 90 93 95 100 102 104 105:107 110 113 117 119 120 121 126 127 129 130:132 134 135 137 139 140:146 148 149:155 157 159 160 163 164 169 171 174 175 177 178 180 182 183:187] ,0);

eeglab redraw
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',['E:\\Work\\Oddball\\Infants\\Data_EEG\\raw_strict_VOW\\Sub' sub '\\' 'Sub' sub '_ICA_final_re'],'gui','off');
eegh
y=vertcat(EEG.event.type);
%VOW
A=[11 33 55];
%CON
% A=[2 4 6];
countmember(A,y)
size(y)

%%
% subjects=['Sub06';'Sub08';'Sub10';'Sub12';'Sub14';'Sub18';'Sub20';'Sub22';'Sub24';'Sub26';'Sub28';'Sub30';'Sub34';'Sub38';'Sub40';'Sub42';'Sub44';...
% 'Sub46';'Sub48';'Sub50';'Sub54';'Sub56';'Sub60';'Sub62';'Sub64';'Sub66';'Sub68';'Sub70';'Sub72';'Sub76';'Sub78';'Sub80';'Sub82';'Sub88';'Sub90'];
subjects=['Sub42';'Sub48';'Sub60'];

pfad_raw = 'E:\Work\Oddball\Infants\Data_EEG\raw\';
finalpath = 'E:\Work\Oddball\Infants\Data_EEG\final\';

t_minmax = [-0.1 0.8]; % Epoch to cut out
baseline = [-100 0];

final_markers = [11 33 55];

for ns = 1 : size(subjects,1)
         folder = subjects(ns,:);
         filepath_source =[pfad_raw,folder,'/'];
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
        EEG = pop_saveset(EEG, [subjects(ns,:) '_C' num2str(final_markers(i)) '.set'], finalpath);
    end
end