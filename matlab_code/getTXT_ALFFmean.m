%% This script created TXT files for mean ALFF for all regions for each subject's group and all subjects
%% Subject's group are: sub_NH, sub_HL, sub_tin_HL, sub_tin_NH

clc
clear all
close all

% Define the path to the folder containing the sub_NH.txt file
list_folder_path = '/Volumes/gdrive4tb/IGNITE/resting-state/subList/';

%% sub_NH_ALFF 
% Read the list of names from the sub_NH.txt file
fid = fopen([list_folder_path, 'sub_NH.txt'], 'r');
names = textscan(fid, '%s');
names = names{1};
fclose(fid);

% ============== AC ===============
% Define the path to the AC folder
ac_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/AC/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_AC = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [ac_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_AC.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_AC{i} = value;
end

% ============== HG ===============
% Define the path to the AC folder
hg_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/HG/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_HG = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [hg_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_HG.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_HG{i} = value;
end

% ============== MGB ===============
% Define the path to the AC folder
mgb_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/MGB/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_MGB = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [mgb_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_MGB.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_MGB{i} = value;
end

% ============== PT ===============
% Define the path to the AC folder
pt_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/PT/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_PT = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [pt_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_PT.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_PT{i} = value;
end

% ============== V1 ===============
% Define the path to the AC folder
v1_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/V1/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_V1 = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [v1_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_V1.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_V1{i} = value;
end

% ============== thalamus ===============
% Define the path to the AC folder
thalamus_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/thalamus/'];

% Initialize a cell array to store the values from the txt files
sub_NH_ALFF_thalamus = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [thalamus_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_thalamus.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_NH_ALFF_thalamus{i} = value;
end


%% sub_HL_ALFF 
% Read the list of names from the sub_HL.txt file
fid = fopen([list_folder_path, 'sub_HL.txt'], 'r');
names = textscan(fid, '%s');
names = names{1};
fclose(fid);

% ============== wholeBrain ===============
% Define the path to the AC folder
wholeBrain_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/wholeBrain/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_wholeBrain = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [wholeBrain_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_wholeBrain{i} = value;
end

% ============== AC ===============
% Define the path to the AC folder
ac_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/AC/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_AC = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [ac_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_AC.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_AC{i} = value;
end

% ============== HG ===============
% Define the path to the AC folder
hg_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/HG/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_HG = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [hg_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_HG.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_HG{i} = value;
end

% ============== MGB ===============
% Define the path to the AC folder
mgb_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/MGB/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_MGB = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [mgb_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_MGB.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_MGB{i} = value;
end

% ============== PT ===============
% Define the path to the AC folder
pt_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/PT/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_PT = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [pt_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_PT.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_PT{i} = value;
end

% ============== V1 ===============
% Define the path to the AC folder
v1_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/V1/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_V1 = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [v1_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_V1.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_V1{i} = value;
end

% ============== thalamus ===============
% Define the path to the AC folder
thalamus_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/thalamus/'];

% Initialize a cell array to store the values from the txt files
sub_HL_ALFF_thalamus = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [thalamus_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_thalamus.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_HL_ALFF_thalamus{i} = value;
end

%% sub_tin_HL 
% Read the list of names from the sub_tin_HL.txt file
fid = fopen([list_folder_path, 'sub_tin_HL.txt'], 'r');
names = textscan(fid, '%s');
names = names{1};
fclose(fid);

% ============== wholeBrain ===============
% Define the path to the AC folder
wholeBrain_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/wholeBrain/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_wholeBrain = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [wholeBrain_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_wholeBrain{i} = value;
end

% ============== AC ===============
% Define the path to the AC folder
ac_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/AC/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_AC = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [ac_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_AC.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_AC{i} = value;
end

% ============== HG ===============
% Define the path to the AC folder
hg_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/HG/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_HG = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [hg_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_HG.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_HG{i} = value;
end

% ============== MGB ===============
% Define the path to the AC folder
mgb_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/MGB/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_MGB = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [mgb_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_MGB.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_MGB{i} = value;
end

% ============== PT ===============
% Define the path to the AC folder
pt_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/PT/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_PT = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [pt_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_PT.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_PT{i} = value;
end

% ============== V1 ===============
% Define the path to the AC folder
v1_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/V1/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_V1 = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [v1_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_V1.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_V1{i} = value;
end

% ============== thalamus ===============
% Define the path to the AC folder
thalamus_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/thalamus/'];

% Initialize a cell array to store the values from the txt files
sub_tin_HL_ALFF_thalamus = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [thalamus_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_thalamus.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_HL_ALFF_thalamus{i} = value;
end

%% sub_tin_NH 
% Read the list of names from the sub_tin_NH.txt file
fid = fopen([list_folder_path, 'sub_tin_NH.txt'], 'r');
names = textscan(fid, '%s');
names = names{1};
fclose(fid);

% ============== wholeBrain ===============
% Define the path to the AC folder
wholeBrain_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/wholeBrain/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_wholeBrain = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [wholeBrain_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_wholeBrain{i} = value;
end

% ============== AC ===============
% Define the path to the AC folder
ac_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/AC/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_AC = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [ac_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_AC.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_AC{i} = value;
end

% ============== HG ===============
% Define the path to the AC folder
hg_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/HG/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_HG = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [hg_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_HG.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_HG{i} = value;
end

% ============== MGB ===============
% Define the path to the AC folder
mgb_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/MGB/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_MGB = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [mgb_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_MGB.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_MGB{i} = value;
end

% ============== PT ===============
% Define the path to the AC folder
pt_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/PT/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_PT = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [pt_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_PT.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_PT{i} = value;
end

% ============== V1 ===============
% Define the path to the AC folder
v1_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/V1/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_V1 = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [v1_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_V1.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_V1{i} = value;
end

% ============== thalamus ===============
% Define the path to the AC folder
thalamus_folder_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'ALFF/thalamus/'];

% Initialize a cell array to store the values from the txt files
sub_tin_NH_ALFF_thalamus = cell(numel(names), 1);

% Loop over the names and read the values from the corresponding txt files
for i = 1:numel(names)
    % Define the path to the folder for the current name
    name_folder_path = [thalamus_folder_path, names{i}, '/'];
    
    % Define the path to the txt file for the current name
    txt_file_path = [name_folder_path, names{i}, '_meanALFF_thalamus.txt'];
    
    % Read the value from the txt file
    fid = fopen(txt_file_path, 'r');
    value = fscanf(fid, '%f');
    fclose(fid);
    
    % Store the value in the cell array
    sub_tin_NH_ALFF_thalamus{i} = value;
end

%% Get all subjects per regions

allSubs_ALFF_wholeBrain = vertcat(sub_HL_ALFF_wholeBrain, sub_NH_ALFF_wholeBrain, ...
    sub_tin_NH_ALFF_wholeBrain, sub_tin_HL_ALFF_wholeBrain);
allSubs_ALFF_AC = vertcat(sub_HL_ALFF_AC, sub_NH_ALFF_AC, sub_tin_NH_ALFF_AC, sub_tin_HL_ALFF_AC);
allSubs_ALFF_HG = vertcat(sub_HL_ALFF_HG, sub_NH_ALFF_HG, sub_tin_NH_ALFF_HG, sub_tin_HL_ALFF_HG);
allSubs_ALFF_PT = vertcat(sub_HL_ALFF_PT, sub_NH_ALFF_PT, sub_tin_NH_ALFF_PT, sub_tin_HL_ALFF_PT);
allSubs_ALFF_V1 = vertcat(sub_HL_ALFF_V1, sub_NH_ALFF_V1, sub_tin_NH_ALFF_V1, sub_tin_HL_ALFF_V1);
allSubs_ALFF_MGB = vertcat(sub_HL_ALFF_MGB, sub_NH_ALFF_MGB, sub_tin_NH_ALFF_MGB, sub_tin_HL_ALFF_MGB);
allSubs_ALFF_thalamus = vertcat(sub_HL_ALFF_thalamus, sub_NH_ALFF_thalamus, ...
    sub_tin_NH_ALFF_thalamus, sub_tin_HL_ALFF_thalamus);

%% Write to TXT files for allSubs
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis'), 'TXTforComparison')
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison'), 'ALFF')
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison/ALFF'), 'allSubs')

compare_ALFF_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'TXTforComparison/ALFF/allSubs/'];

writecell(allSubs_ALFF_wholeBrain, [compare_ALFF_path, 'allSubs_meanALFF_wholeBrain.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_AC, [compare_ALFF_path, 'allSubs_meanALFF_AC.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_HG, [compare_ALFF_path, 'allSubs_meanALFF_HG.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_PT, [compare_ALFF_path, 'allSubs_meanALFF_PT.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_V1, [compare_ALFF_path, 'allSubs_meanALFF_V1.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_MGB, [compare_ALFF_path, 'allSubs_meanALFF_MGB.txt'], ...
    'Delimiter', ' ');
writecell(allSubs_ALFF_thalamus, [compare_ALFF_path, 'allSubs_meanALFF_thalamus.txt'], ...
    'Delimiter', ' ');

%% Write to TXT files for sub_HL
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison/ALFF'), 'sub_HL')

compare_ALFF_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'TXTforComparison/ALFF/sub_HL/'];

writecell(sub_HL_ALFF_wholeBrain, [compare_ALFF_path, 'sub_HL_meanALFF_wholeBrain.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_AC, [compare_ALFF_path, 'sub_HL_meanALFF_AC.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_HG, [compare_ALFF_path, 'sub_HL_meanALFF_HG.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_PT, [compare_ALFF_path, 'sub_HL_meanALFF_PT.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_V1, [compare_ALFF_path, 'sub_HL_meanALFF_V1.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_MGB, [compare_ALFF_path, 'sub_HL_meanALFF_MGB.txt'], ...
    'Delimiter', ' ');
writecell(sub_HL_ALFF_thalamus, [compare_ALFF_path, 'sub_HL_meanALFF_thalamus.txt'], ...
    'Delimiter', ' ');

%% Write to TXT files for sub_NH
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison/ALFF'), 'sub_NH')

compare_ALFF_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'TXTforComparison/ALFF/sub_NH/'];

writecell(sub_NH_ALFF_wholeBrain, [compare_ALFF_path, 'sub_NH_meanALFF_wholeBrain.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_AC, [compare_ALFF_path, 'sub_NH_meanALFF_AC.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_HG, [compare_ALFF_path, 'sub_NH_meanALFF_HG.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_PT, [compare_ALFF_path, 'sub_NH_meanALFF_PT.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_V1, [compare_ALFF_path, 'sub_NH_meanALFF_V1.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_MGB, [compare_ALFF_path, 'sub_NH_meanALFF_MGB.txt'], ...
    'Delimiter', ' ');
writecell(sub_NH_ALFF_thalamus, [compare_ALFF_path, 'sub_NH_meanALFF_thalamus.txt'], ...
    'Delimiter', ' ');

%% Write to TXT files for sub_tin_HL
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison/ALFF'), 'sub_tin_HL')

compare_ALFF_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'TXTforComparison/ALFF/sub_tin_HL/'];

writecell(sub_tin_HL_ALFF_wholeBrain, [compare_ALFF_path, 'sub_tin_HL_meanALFF_wholeBrain.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_AC, [compare_ALFF_path, 'sub_tin_HL_meanALFF_AC.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_HG, [compare_ALFF_path, 'sub_tin_HL_meanALFF_HG.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_PT, [compare_ALFF_path, 'sub_tin_HL_meanALFF_PT.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_V1, [compare_ALFF_path, 'sub_tin_HL_meanALFF_V1.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_MGB, [compare_ALFF_path, 'sub_tin_HL_meanALFF_MGB.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_HL_ALFF_thalamus, [compare_ALFF_path, 'sub_tin_HL_meanALFF_thalamus.txt'], ...
    'Delimiter', ' ');

%% Write to TXT files for sub_tin_NH
mkdir(fullfile('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/TXTforComparison/ALFF'), 'sub_tin_NH')

compare_ALFF_path = ['/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/' ...
    'TXTforComparison/ALFF/sub_tin_NH/'];

writecell(sub_tin_NH_ALFF_wholeBrain, [compare_ALFF_path, 'sub_tin_NH_meanALFF_wholeBrain.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_AC, [compare_ALFF_path, 'sub_tin_NH_meanALFF_AC.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_HG, [compare_ALFF_path, 'sub_tin_NH_meanALFF_HG.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_PT, [compare_ALFF_path, 'sub_tin_NH_meanALFF_PT.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_V1, [compare_ALFF_path, 'sub_tin_NH_meanALFF_V1.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_MGB, [compare_ALFF_path, 'sub_tin_NH_meanALFF_MGB.txt'], ...
    'Delimiter', ' ');
writecell(sub_tin_NH_ALFF_thalamus, [compare_ALFF_path, 'sub_tin_NH_meanALFF_thalamus.txt'], ...
    'Delimiter', ' ');
