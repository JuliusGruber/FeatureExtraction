readInFeatures = 1;
if readInFeatures
    clear
    readInFeatures = 1;
end

%%%%%%%%%%%%%%%%%choose WAV dir here %%%%%%%%%%%%%
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\BD_2\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_1\';
% dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\SD_2\';
dirName = 'C:\Users\Julius Gruber\Desktop\GaeS-Sammlungen\Drums\HH_1\';

% set t-SNE Paramters, this feature set has 13 features
no_dims = 2;
initial_dims = 13;
perplexity =5;

viewName = 'ESS_gfcc_mw';

filePathWAVs = readAllWAVfilePaths(dirName);





% get the YAML files
dirNameYAML =strcat(dirName,'YAMLessentiaFreesound');
YAMLfileInformationArray = getAllFileNames(dirNameYAML);

if readInFeatures

nxd = [];
fileInformationArray = {};
featureData = cell(size( 10, 10));
counterNoNaNs = 0;
for k =1: length(YAMLfileInformationArray)
   featureVector = [];
   
   YAMLcurrentFilePath = YAMLfileInformationArray{k,1};
   
   YAMLindexOfSlashes = strfind(YAMLcurrentFilePath, '\');
   YAMLindexOfLastSlash = YAMLindexOfSlashes(end);

   
   YAMLcurrentFileName = YAMLcurrentFilePath(YAMLindexOfLastSlash+1 : end);
   
   fileNameFromYAML = strrep(YAMLcurrentFileName, '.yaml_statistics.yaml', '');
   fileNameFromYAML = strcat(fileNameFromYAML, '.wav')
   
%        get the fullFilePath from the filePathWAVs struct
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
         
%    %%%%%%% add features here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
  

        gfccMean = cell2mat(YAMLStruct.lowlevel.gfcc.mean);
        numFeatureValues = length( gfccMean);
        for b = 1 : numFeatureValues(1,1)
            featureVector(1,end+1)= gfccMean(1,b);
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
          
    end%end of wavAvailable
   
   
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