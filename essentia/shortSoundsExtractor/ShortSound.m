

%%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName ='C:\Users\Julius Gruber\Desktop\HighHats\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds1\';
% dirName ='C:\Users\Julius Gruber\Desktop\rastafarianWAV\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\OLPCsounds2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\SnareDrum\';
% dirName = 'C:\Users\Julius Gruber\Desktop\Sample_Datenbanken\NintyNineDrumSamples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\15Samples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\33DrumSamples\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\TSD Acidized Wav Files\TSD - Reggae Snares - 100\';
dirName = 'C:\Users\Julius Gruber\Desktop\SampleDatenbanken\snareGroups\';
% dirName = 'C:\Users\Julius\Desktop\SampleDatenbanken\synth-groups\';


readInFeatures = 1;

% set t-SNE Paramters
no_dims = 2;
initial_dims = 45;
perplexity = 5;

viewName = 'essAllFeatures';

filePathWAVs = readAllWAVfilePaths(dirName);









% get the YAML files

dirNameYAML =strcat(dirName,'YAMLessentiaShortSounds');
YAMLfileInformationArray = getAllFileNames(dirNameYAML);

if readInFeatures
    fileInformationArray = {};
    featureData = cell(size( 10, 10));
    counterNoNaNs = 0;
    nxd = [];
    
for k =1: length(YAMLfileInformationArray)
   featureVector = [];
   
   YAMLcurrentFilePath = YAMLfileInformationArray{k,1}
   
   YAMLindexOfSlashes = strfind(YAMLcurrentFilePath, '\');
   YAMLindexOfLastSlash = YAMLindexOfSlashes(end);
%    indexOfFolderSlash = YAMLindexOfSlashes(end -1);
   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end);
   
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml', '');
   fileNameFromYAML = strcat(fileNameFromYAML, '.wav');
   
%    splittArray = strsplit(YAMLcurrentFileName,'.');
%    YAMLfileNameWithExt = strcat(splittArray(1,1),'.', splittArray(1,end))% e.g. "come-selectah.wav"
%    YAMLfileNameWithExtString = YAMLfileNameWithExt{:}
   
   
%    get the fullFilePath from the filePathWAVs struct
    wavAvailable = 0;
    for i =1: length(filePathWAVs)
        
      if(strcmp(filePathWAVs(i).name, fileNameFromYAML ))      
        currentFilePath = filePathWAVs(i).fullFilePath;
        wavAvailable = 1;
        break;
      end
    end


   
    if(wavAvailable)
   
        YAMLStruct = yaml.ReadYaml(YAMLcurrentFilePath);
         
%    %%%%%%% average loudness %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
   featureVector(1,end+1) = YAMLStruct.lowlevel.average_loudness;
    
%    %%%%%%%%%%% barkbands kurtosis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dmean;
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dmean2;
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dvar;
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.dvar2;
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.max;
  featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.mean;
   featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.min;
   featureVector(1,end+1) = YAMLStruct.lowlevel.barkbands_kurtosis.var;
    
%    %%%%%%%% barkbands skewness %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.dmean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.dmean2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.dvar;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.dvar2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.max;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.mean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.min;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_skewness.var;
   
%    %%%%%%%%%%% barkbands spread %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dmean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dmean2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dvar;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.dvar2;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.max; 
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.mean;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.min;
   featureVector(1,end+1) =YAMLStruct.lowlevel.barkbands_spread.var;
   
%    %%%%%%%%%% dissonance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1) = YAMLStruct.lowlevel.dissonance.dmean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dmean2; 
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dvar;
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.dvar2; 
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.max;
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.mean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.min;
   featureVector(1,end+1)= YAMLStruct.lowlevel.dissonance.var;
   
%    %%%%%%%% hfc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dmean; 
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dmean2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dvar;
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.dvar2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.max;
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.mean; 
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.min;
     featureVector(1,end+1)= YAMLStruct.lowlevel.hfc.var;
    
     
   %%%%%%%%%%% pitch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.dmean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.dmean2;
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.dvar;
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.dvar2;
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.max; 
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.mean;
   featureVector(1,end+1)= YAMLStruct.lowlevel.pitch.min;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch.var;
   
   %%%%%%%%%%%%%%%%%%% pitch_instantaneous_confidence %%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.dmean;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.dmean2;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.dvar;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.dvar2; 
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.max;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.mean; 
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.min;
   featureVector(1,end+1)=  YAMLStruct.lowlevel.pitch_instantaneous_confidence.var;
   
   %%%%%%%%%%%%% pitch salience %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.dmean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.dmean2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.dvar;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.dvar2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.max;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.mean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.min;
   featureVector(1,end+1)=YAMLStruct.lowlevel.pitch_salience.var;
   
   
%    %%%%%%%%% silence_rate_20dB %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dvar;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.max;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.mean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.min;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_20dB.var;
   
%    %%%%%%%%%%%%% silence_rate_30dB %%%%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dvar;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.max;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.mean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.min;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_30dB.var;
   
%    %%%%%%%%%%%%%%%% lowlevel.silence_rate_60dB %%%%%%%%%%%%%%
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dmean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dmean2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dvar; 
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.dvar2;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.max;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.mean;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.min;
%    featureVector(1,end+1)=YAMLStruct.lowlevel.silence_rate_60dB.var;
   
   %%%%%%%%%%%% spectral_centroid%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dmean; 
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dmean2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dvar; 
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.dvar2;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.max;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.mean;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.min;
   featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_centroid.var;
   
   %%%%%%%%%%%%%% spectral_complexity %%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dmean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dmean2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dvar;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.dvar2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.max;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.mean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.min;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_complexity.var;
    
    %%%%%%%%%%%% spectral_crest %%%%%%%%%%%%%%%%%
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.dmean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.dmean2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.dvar;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.dvar2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.max;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.mean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.min;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_crest.var;
    
    %%%%%%%%%%%%%%%%% spectral_decrease %%%%%%%%%%%%%%
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dmean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dmean2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dvar;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.dvar2;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.max;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.mean;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.min;
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_decrease.var;
    
    %%%%%%%%%%%%%%%%%%% spectral_energy %%%%%%%%%%%%%%%%%%%%%%%%%%
    featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dmean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dvar; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.dvar2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.max;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.min;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energy.var;
     
     
     %%%%%%%%%%%%% spectral_energyband_high%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.dmean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.dvar;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.dvar2; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.max;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.mean; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.min;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_high.var;
     
     %%%%%%%%%%%%%%%%%%% spectral_energyband_low %%%%%%%%%%%%%%%
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dmean;
     featureVector(1, end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dmean2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dvar;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.dvar2;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.max; 
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.mean;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.min;
     featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_low.var;
     
     %%%%%%%%%%%%%%%%%% spectral_energyband_middle_high%%%%%%%%%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dmean2;
     featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_energyband_middle_high.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.mean; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_high.var;
      
      %%%%%%%%%%%%%%%%%% spectral_energyband_middle_low %%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.min; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_energyband_middle_low.var;

      
      %%%%%%%%%%%%% spectral_flatness_db %%%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.dmean; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.dmean2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.dvar;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.dvar2;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flatness_db.var;
      
      %%%%%%%%%%%% spectral_flux %%%%%%%%%%%%%%%%%%%%%%
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dmean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dmean2;
      featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_flux.dvar; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.dvar2; 
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.max;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.mean;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.min;
      featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_flux.var;
      
      %%%%%%%%%%%%% spectral_kurtosis %%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.dvar2; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.mean; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_kurtosis.var;
        
        %%%%%%%%%%%%%% spectral_rms %%%%%%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.min; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rms.var;
        
        %%%%%%%%%%%%% spectral_rolloff %%%%%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)= YAMLStruct.lowlevel.spectral_rolloff.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dvar; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_rolloff.var;
        
        %%%%%%%%%%%%%% spectral_skewness %%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.min; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_skewness.var;
        
        
        %%%%%%%%%%%%% spectral_spread%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_spread.var;
        
        %%%%%%%%%% spectral_strongpeak %%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dmean2; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.mean; 
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.spectral_strongpeak.var;
        
        %%%%%%%%%%%%% ZCR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dmean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dmean2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dvar;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.dvar2;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.max;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.mean;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.min;
        featureVector(1,end+1)=YAMLStruct.lowlevel.zerocrossingrate.var;
        
        %%%%%%%%%%%%% barkbands %%%%%%%%%%%%%%%%%%%%%%%%
        values = cell2mat(YAMLStruct.lowlevel.barkbands.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.lowlevel.barkbands.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat( YAMLStruct.lowlevel.barkbands.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
      
        values = cell2mat( YAMLStruct.lowlevel.barkbands.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat( YAMLStruct.lowlevel.barkbands.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end

         
        values = cell2mat(YAMLStruct.lowlevel.barkbands.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end        
         
       
        values = cell2mat(YAMLStruct.lowlevel.barkbands.min);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
         
        values = cell2mat(YAMLStruct.lowlevel.barkbands.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end         
         
       
  
        
        %%%%%%%%%%%%%%%% frequency_bands    %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
       values = cell2mat(YAMLStruct.lowlevel.frequency_bands.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
           values = cell2mat(YAMLStruct.lowlevel.frequency_bands.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
           values = cell2mat(YAMLStruct.lowlevel.frequency_bands.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
          values = cell2mat(YAMLStruct.lowlevel.frequency_bands.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
       
           values = cell2mat(YAMLStruct.lowlevel.frequency_bands.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
      
         values = cell2mat(YAMLStruct.lowlevel.frequency_bands.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
           values = cell2mat(YAMLStruct.lowlevel.frequency_bands.min);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
    
          values = cell2mat(YAMLStruct.lowlevel.frequency_bands.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        

        
   
        
        % %%%%%%%%   mfcc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             values = cell2mat(YAMLStruct.lowlevel.mfcc.cov);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
%         
%               values = cell2mat(YAMLStruct.lowlevel.mfcc.icov);
%         numFeatureValues = length(values);
%         for b = 1 :  numFeatureValues(1,1)
%             featureVector(1,end+1)= values(1,b);
%         end  
      
        
        
              values = cell2mat(YAMLStruct.lowlevel.mfcc.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
   %%%%%%%%%%%%%%%%%%%% sc coeffs %%%%%%%%%%%%%%%%%%%%%%%%
        values = cell2mat(YAMLStruct.lowlevel.sccoeffs.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
   
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.min);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
         values = cell2mat(YAMLStruct.lowlevel.sccoeffs.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        




%%%%%%%%%%%%%%%% sc valleys %%%%%%%%%%%%%%%%%%%%%%
    values = cell2mat(YAMLStruct.lowlevel.scvalleys.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end 
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.min);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
          values = cell2mat(YAMLStruct.lowlevel.scvalleys.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end  


% %%%%%%%%%%%%%% sfx Features %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
featureVector(1,end+1)= YAMLStruct.sfx.inharmonicity.dmean;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.dmean2;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.dvar;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.dvar2;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.max;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.mean;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.min;
featureVector(1,end+1)=YAMLStruct.sfx.inharmonicity.var;

featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.dmean;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.dmean2;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.dvar;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.dvar2;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.max;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.mean;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.min;
featureVector(1,end+1)=YAMLStruct.sfx.oddtoevenharmonicenergyratio.var;

featureVector(1,end+1)=YAMLStruct.sfx.pitch_after_max_to_before_max_energy_ratio;
featureVector(1,end+1)=YAMLStruct.sfx.pitch_centroid;
featureVector(1,end+1)=YAMLStruct.sfx.pitch_max_to_total;
featureVector(1,end+1)=YAMLStruct.sfx.pitch_min_to_total;

% %%%%%%%%%%% tri stimulus
        values = cell2mat(YAMLStruct.sfx.tristimulus.dmean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.sfx.tristimulus.dmean2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.sfx.tristimulus.dvar);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.sfx.tristimulus.dvar2);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
    values = cell2mat(YAMLStruct.sfx.tristimulus.max);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end

    values = cell2mat(YAMLStruct.sfx.tristimulus.mean);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.sfx.tristimulus.min);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end
        
        values = cell2mat(YAMLStruct.sfx.tristimulus.var);
        numFeatureValues = length(values);
        for b = 1 :  numFeatureValues(1,1)
            featureVector(1,end+1)= values(1,b);
        end


     

  


% use featureVectors with no  NaN Values only
    featureVectorHasNaN = ismember(1,isnan(featureVector));
    
    
    if featureVectorHasNaN
       warn = strcat('WARNING NaN for:', filePathWAVs(i).fullFilePath)
     
    end
    
    if not(featureVectorHasNaN)
        
         counterNoNaNs(1,1) = counterNoNaNs(1,1)+1;
        
         nxd = [nxd; featureVector]; 
       
        fileInformationArray{counterNoNaNs(1,1),1} = currentFilePath;
        fileInformationArray{counterNoNaNs(1,1),2} =   fileNameFromYAML;


 
         %  add feature data for mat file
        featureData{counterNoNaNs(1,1),1} = currentFilePath;
        for m = 1: length(featureVector)
            featureData{counterNoNaNs(1,1),m+1}=featureVector(1,m);
        end
    
    
    end
    
    end   
    
    
end

end





% run t-SNE
mappedX = tsne(nxd, [], no_dims, initial_dims, perplexity);

% Plot reults

figure();
gscatter(mappedX(:,1), mappedX(:,2));


% essentiaViewPortTransformAndCreateTXTfile(mappedX, fileInformationArray, 'essentiaShortSound', dirName);
viewPortTransformAndCreateViewMatFile(mappedX, fileInformationArray, viewName, dirName);


%%%%%  STORE feature data %%%%%%

save([dirName viewName ], 'featureData');
