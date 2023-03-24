#!/bin/bash

# Quality control script for createMask for FSLeyes visual checking

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"

###############################################################
# Check initial extraction of HG: left, right, and bilateral
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the initial extraction of Heschl's Gyrus"
fsleyes $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz ${mask_path}/HG/prob_mask/HO_HGprob -cm green ${mask_path}/HG/prob_mask/HO_HGprob_lh -cm blue -a 75 ${mask_path}/HG/prob_mask/HO_HGprob_rh -cm red -a 75 &

###############################################################
# Check initial extraction of PT: left, right, and bilateral
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the initial extraction of Planum Temporale"
fsleyes $FSLDIR/data/standard/MNI152_T1_1mm.nii.gz ${mask_path}/PT/prob_mask/HO_PTprob -cm yellow ${mask_path}/PT/prob_mask/HO_PTprob_lh -cm blue -a 75 ${mask_path}/PT/prob_mask/HO_PTprob_rh -cm red -a 75 &


###############################################################
# Look at individual subjects
s=(IGNTFA_00065)
###############################################################
# Heschl's gyrus
# Check the reslicing of the mask from MNI space to subject specific T1 space
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps

echo "Use FSLeyes to check the reslicing of the mask from MNI space to subject specific T1 space"
fsleyes ${vol_path}/registration/${s}/${s}_t1.nii.gz ${mask_path}/HG/T1_mask/${s}/${s}_HGmask2T1 -cm green ${mask_path}/HG/T1_mask/${s}/${s}_HGmask2T1_lh -cm blue -a 75 ${mask_path}/HG/T1_mask/${s}/${s}_HGmask2T1_rh -cm red -a 75 &

# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func -cm green ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_lh -cm blue -a 75 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_rh -cm red -a 75 &

fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_bin.nii.gz -cm green ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_lh_bin.nii.gz -cm blue -a 75 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_rh_bin.nii.gz -cm red -a 75 &


###############################################################
# Planum Temporale
# Check the reslicing of the mask from MNI space to subject specific T1 space
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps

echo "Use FSLeyes to check the reslicing of the mask from MNI space to subject specific T1 space"
fsleyes ${vol_path}/registration/${s}/${s}_t1.nii.gz ${mask_path}/PT/T1_mask/${s}/${s}_PTmask2T1 -cm green ${mask_path}/PT/T1_mask/${s}/${s}_PTmask2T1_lh -cm blue -a 75 ${mask_path}/PT/T1_mask/${s}/${s}_PTmask2T1_rh -cm red -a 75 &

# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func -cm green ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_lh -cm blue -a 75 ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_rh -cm red -a 75 &

fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_bin.nii.gz -cm green ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_lh_bin.nii.gz -cm blue -a 75 ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_rh_bin.nii.gz -cm red -a 75 &


###############################################################
# Auditory Cortex: combination of the HG and PT masks
# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_bin.nii.gz -cm green ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_bin.nii.gz -cm yellow ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_bin.nii.gz -cm blue-lightblue -a 60 &

# Check the unilateral mask -left
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_lh_bin.nii.gz -cm green ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_lh_bin.nii.gz -cm yellow ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_lh_bin.nii.gz -cm blue-lightblue -a 60 &

# Check the unilateral mask -right
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_rh_bin.nii.gz -cm green ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_rh_bin.nii.gz -cm yellow ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_rh_bin.nii.gz -cm blue-lightblue -a 60 &


###############################################################
# Medial Geniculus Body
# Check the reslicing of the mask from MNI space to subject specific T1 space
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps

echo "Use FSLeyes to check the reslicing of the mask from MNI space to subject specific T1 space"
fsleyes ${vol_path}/registration/${s}/${s}_t1.nii.gz ${mask_path}/MGB/T1_mask/${s}/${s}_MGBmask2T1 -cm green ${mask_path}/MGB/T1_mask/${s}/${s}_MGBmask2T1_lh -cm blue -a 75 ${mask_path}/MGB/T1_mask/${s}/${s}_MGBmask2T1_rh -cm red -a 75 &

# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func -cm green ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_lh -cm blue -a 75 ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_rh -cm red -a 75 &

fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_bin.nii.gz -cm green ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_lh_bin.nii.gz -cm blue -a 75 ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_rh_bin.nii.gz -cm red -a 75 &


###############################################################
# Primary Visual (V1)
# Check the reslicing of the mask from MNI space to subject specific T1 space
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps

echo "Use FSLeyes to check the reslicing of the mask from MNI space to subject specific T1 space"
fsleyes ${vol_path}/registration/${s}/${s}_t1.nii.gz ${mask_path}/V1/T1_mask/${s}/${s}_V1mask2T1 -cm green ${mask_path}/V1/T1_mask/${s}/${s}_V1mask2T1_lh -cm blue -a 75 ${mask_path}/V1/T1_mask/${s}/${s}_V1mask2T1_rh -cm red -a 75 &

# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func -cm green ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_lh -cm blue -a 75 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_rh -cm red -a 75 &

fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_bin.nii.gz -cm green ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_lh_bin.nii.gz -cm blue -a 75 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_rh_bin.nii.gz -cm red -a 75 &


###############################################################
# Thalamus
# Check the reslicing of the mask from MNI space to subject specific T1 space
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps

echo "Use FSLeyes to check the reslicing of the mask from MNI space to subject specific T1 space"
fsleyes ${vol_path}/registration/${s}/${s}_t1.nii.gz ${mask_path}/thalamus/T1_mask/${s}/${s}_thalamusmask2T1 -cm green ${mask_path}/thalamus/T1_mask/${s}/${s}_thalamusmask2T1_lh -cm blue -a 75 ${mask_path}/thalamus/T1_mask/${s}/${s}_thalamusmask2T1_rh -cm red -a 75 &

# Check the reslicing of the mask from MNI space to functional time series
###############################################################
# Set left image to blue and check where this overlaps
# Set right image to red and check where this overlaps
echo "Use FSLeyes to check the reslicing of the mask from MNI space to functional time series"
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func -cm green ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_lh -cm blue -a 75 ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_rh -cm red -a 75 &

fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz -dr -10 20 ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_bin.nii.gz -cm green ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_lh_bin.nii.gz -cm blue -a 75 ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_rh_bin.nii.gz -cm red -a 75 &
