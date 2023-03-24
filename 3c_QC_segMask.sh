#!/bin/bash

# Quality control script for segMask for FSLeyes visual checking

data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

s=(IGNTFA_00065)

###############################################################
# Check the production of GM ROI masks in the functional space
###############################################################
fsleyes ${vol_path}/percent_signal_change/${s}/${s}_preprocessed_psc_mean.nii.gz ${mask_path}/segmentation/${s}/func_segment_masks/gm/${s}_func_gm_mask_bin.nii.gz -cm blue-lightblue ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_bin -cm red ${mask_path}/ROIsegmentation/gm/AC/${s}/${s}_gm_funcMask_AC.nii.gz -cm blue -a 50 ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_bin -cm red ${mask_path}/ROIsegmentation/gm/HG/${s}/${s}_gm_funcMask_HG.nii.gz -cm blue -a 50 ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_bin -cm red ${mask_path}/ROIsegmentation/gm/PT/${s}/${s}_gm_funcMask_PT.nii.gz -cm blue -a 50 ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_bin -cm red ${mask_path}/ROIsegmentation/gm/V1/${s}/${s}_gm_funcMask_V1.nii.gz -cm blue -a 50 