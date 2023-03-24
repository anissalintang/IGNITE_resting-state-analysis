#!/bin/bash

# Quality control script for brainSegmentation for FSLeyes visual checking

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"

s=(IGNTFA_00065)

###############################################################
# Check the segmentation in the T1 space
###############################################################
fsleyes ${mask_path}/segmentation/${s}/structural/${s}_t1_brain_bet.nii.gz ${mask_path}/segmentation/${s}/segments/${s}_t1_csf.nii.gz -cm yellow ${mask_path}/segmentation/${s}/segments/${s}_t1_gm.nii.gz -cm green ${mask_path}/segmentation/${s}/segments/${s}_t1_wm.nii.gz -cm blue-lightblue &

###############################################################
# Check the production of T1 masks
###############################################################
fsleyes ${mask_path}/segmentation/${s}/structural/${s}_t1_brain_bet.nii.gz ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_csf_mask_bin.nii.gz -cm yellow ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_gm_mask_bin.nii.gz -cm green ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_wm_mask_bin.nii.gz -cm blue-lightblue &

###############################################################
# Check the segmentation in the functional space
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz ${mask_path}/segmentation/${s}/func_segment/csf/${s}_func_csf.nii.gz -cm yellow ${mask_path}/segmentation/${s}/func_segment/gm/${s}_func_gm.nii.gz -cm green ${mask_path}/segmentation/${s}/func_segment/wm/${s}_func_wm.nii.gz -cm blue-lightblue &


###############################################################
# Check the production of segmented masks in the functional space
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc.nii.gz ${mask_path}/segmentation/${s}/func_segment_masks/csf/${s}_func_csf_mask_bin.nii.gz -cm yellow ${mask_path}/segmentation/${s}/func_segment_masks/gm/${s}_func_gm_mask_bin.nii.gz -cm green ${mask_path}/segmentation/${s}/func_segment_masks/wm/${s}_func_wm_mask_bin.nii.gz -cm blue-lightblue &
