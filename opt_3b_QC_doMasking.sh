#!/bin/bash

# Quality control script for doMasking for FSLeyes visual checking

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"

s=(IGNTFA_00065)

###############################################################
# Check extraction of the AC
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_bin ${vol_path}/Masked_functional_data/AC/${s}/${s}_preprocessed_psc_filt01_AC.nii.gz -cm blue-lightblue -a 75 ${vol_path}/Masked_functional_data/AC/${s}/${s}_preprocessed_psc_filt025_AC.nii.gz -cm blue-lightblue -a 75 &

###############################################################
# Check extraction of the HG
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_bin ${vol_path}/Masked_functional_data/HG/${s}/${s}_preprocessed_psc_filt01_HG.nii.gz -cm blue-lightblue -a 75 ${vol_path}/Masked_functional_data/HG/${s}/${s}_preprocessed_psc_filt025_HG.nii.gz -cm blue-lightblue -a 75 &

###############################################################
# Check extraction of the MGB
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_bin ${vol_path}/Masked_functional_data/MGB/${s}/${s}_preprocessed_psc_filt01_MGB.nii.gz -cm blue-lightblue -a 75 ${vol_path}/Masked_functional_data/MGB/${s}/${s}_preprocessed_psc_filt025_MGB.nii.gz -cm blue-lightblue -a 75 &

###############################################################
# Check extraction of the V1
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_bin ${vol_path}/Masked_functional_data/V1/${s}/${s}_preprocessed_psc_filt01_V1.nii.gz -cm blue-lightblue -a 75 ${vol_path}/Masked_functional_data/V1/${s}/${s}_preprocessed_psc_filt025_V1.nii.gz -cm blue-lightblue -a 75 &

###############################################################
# Check extraction of the thalamus
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_bin ${vol_path}/Masked_functional_data/thalamus/${s}/${s}_preprocessed_psc_filt01_thalamus.nii.gz -cm blue-lightblue -a 75 ${vol_path}/Masked_functional_data/thalamus/${s}/${s}_preprocessed_psc_filt025_thalamus.nii.gz -cm blue-lightblue -a 75 &