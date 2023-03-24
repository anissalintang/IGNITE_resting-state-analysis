#!/bin/bash

# This script will calculate ReHo, using AFNI

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"
reho_path="${analysis_path}/ReHo"

s=(IGNTFA_00065)

# Check the values of the masked ReHo
  #ALFF
    # ALFF for AC, HG, PT and MGB
        echo "ReHo 7nn ${s} in Whole Brain"
        fslstats -t ${reho_path}/wholeBrain/${s}/${s}_ReHo_7.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Whole Brain"
        fslstats -t ${reho_path}/wholeBrain/${s}/${s}_ReHo_19.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Whole Brain"
        fslstats -t ${reho_path}/wholeBrain/${s}/${s}_ReHo_27.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Auditory Cortex"
        fslstats -t ${reho_path}/AC/${s}/${s}_ReHo_7_AC.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Auditory Cortex"
        fslstats -t ${reho_path}/AC/${s}/${s}_ReHo_19_AC.nii.gz -M -r
        
        echo "ReHo 27nn ${s}in Auditory Cortex"
        fslstats -t ${reho_path}/AC/${s}/${s}_ReHo_27_AC.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/HG/${s}/${s}_ReHo_7_HG.nii.gz -M -r
         
        echo "ReHo 19nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/HG/${s}/${s}_ReHo_19_HG.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/HG/${s}/${s}_ReHo_27_HG.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/PT/${s}/${s}_ReHo_7_PT.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/PT/${s}/${s}_ReHo_19_PT.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/PT/${s}/${s}_ReHo_27_PT.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/V1/${s}/${s}_ReHo_7_V1.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/V1/${s}/${s}_ReHo_19_V1.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/V1/${s}/${s}_ReHo_27_V1.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Thalamus"
        fslstats -t ${reho_path}/thalamus/${s}/${s}_ReHo_7_thalamus.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Thalamus"
        fslstats -t ${reho_path}/thalamus/${s}/${s}_ReHo_19_thalamus.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Thalamus"
        fslstats -t ${reho_path}/thalamus/${s}/${s}_ReHo_27_thalamus.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Medial Geniculate Body"
        fslstats -t ${reho_path}/MGB/${s}/${s}_ReHo_7_MGB.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Medial Geniculate Body"
        fslstats -t ${reho_path}/MGB/${s}/${s}_ReHo_19_MGB.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Medial Geniculate Body"
        fslstats -t ${reho_path}/MGB/${s}/${s}_ReHo_27_MGB.nii.gz -M -r
   



# Check the values of the masked ReHo in the grey matter
  #ALFF
    # ALFF for AC, HG, PT and MGB
        echo "ReHo 7nn ${s} in Auditory Cortex Grey Matter"
        fslstats -t ${reho_path}/GM/AC/${s}/${s}_ReHo_7_AC_GM.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Auditory Cortex Grey Matter"
        fslstats -t ${reho_path}/GM/AC/${s}/${s}_ReHo_19_AC_GM.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Auditory Cortex"
        fslstats -t ${reho_path}/GM/AC/${s}/${s}_ReHo_27_AC_GM.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/GM/HG/${s}/${s}_ReHo_7_HG_GM.nii.gz -M -r
         
        echo "ReHo 19nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/GM/HG/${s}/${s}_ReHo_19_HG_GM.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Heschl's Gyrus"
        fslstats -t ${reho_path}/GM/HG/${s}/${s}_ReHo_27_HG_GM.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/GM/PT/${s}/${s}_ReHo_7_PT_GM.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/GM/PT/${s}/${s}_ReHo_19_PT_GM.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Planum Temporale"
        fslstats -t ${reho_path}/GM/PT/${s}/${s}_ReHo_27_PT_GM.nii.gz -M -r
        
        echo "ReHo 7nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/GM/V1/${s}/${s}_ReHo_7_V1_GM.nii.gz -M -r
        
        echo "ReHo 19nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/GM/V1/${s}/${s}_ReHo_19_V1_GM.nii.gz -M -r
        
        echo "ReHo 27nn ${s} in Primary Visual Cortex"
        fslstats -t ${reho_path}/GM/V1/${s}/${s}_ReHo_27_V1_GM.nii.gz -M -r
