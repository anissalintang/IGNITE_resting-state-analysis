#!/bin/bash

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
fs_path="/Volumes/gdrive4tb/IGNITE/resting-state/surface/freesurfer"

export SUBJECTS_DIR="${fs_path}/recon"

s=(IGNTFA_00065)


# Check the projection of ALFF to the subject specific cortical surface Whole Brain UNSMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_lh_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_rh_fs.mgz

# Check the projection of ALFF to the fsaverage surface Whole Brain UNSMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_lh_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_rh_fsavg.mgz

# Check the projection of ALFF to the subject specific cortical surface Whole Brain SMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/whole_brain/${s}/${s}_ALFF_lh_sm_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/whole_brain/${s}/${s}_ALFF_rh_sm_fs.mgz


# Check the projection of ALFF to the fsaverage surface Whole Brain SMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/whole_brain/${s}/${s}_ALFF_lh_sm_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/whole_brain/${s}/${s}_ALFF_rh_sm_fsavg.mgz

# Check the projection of fALFF to the subject specific cortical surface Whole Brain UNSMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_lh_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_rh_fs.mgz

# Check the projection of fALFF to fsaverage Whole Brain UNSMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_lh_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_rh_fsavg.mgz


# Check the projection of fALFF to the subject specific cortical surface Whole Brain SMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/whole_brain/${s}/${s}_fALFF_lh_sm_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/whole_brain/${s}/${s}_fALFF_rh_sm_fs.mgz

# Check the projection of fALFF to fsaverage Whole Brain SMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/whole_brain/${s}/${s}_fALFF_lh_sm_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/whole_brain/${s}/${s}_fALFF_rh_sm_fsavg.mgz

########################################################################################################################

# Check the projection of ALFF to the subject specific cortical surface Auditory Cortex UNSMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/aud_cortex/${s}/${s}_ALFF_AC_lh_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/aud_cortex/${s}/${s}_ALFF_AC_rh_fs.mgz

# Check the projection of ALFF to the fsaverage surface Auditory Cortex UNSMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_AC_lh_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/whole_brain/${s}/${s}_ALFF_AC_rh_fsavg.mgz

# Check the projection of ALFF to the subject specific cortical surface Auditory COrtex SMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/aud_cortex/${s}/${s}_ALFF_AC_lh_sm_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/aud_cortex/${s}/${s}_ALFF_AC_rh_sm_fs.mgz

# Check the projection of ALFF to the fsaverage surface Auditory Cortex SMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/aud_cortex/${s}/${s}_ALFF_AC_lh_sm_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/ALFF/surface/smoothed/aud_cortex/${s}/${s}_ALFF_AC_rh_sm_fsavg.mgz


# Check the projection of fALFF to the subject specific cortical surface Auditory Cortex UNSMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/aud_cortex/${s}/${s}_fALFF_AC_lh_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/aud_cortex/${s}/${s}_fALFF_AC_rh_fs.mgz

# Check the projection of fALFF to fsaverage Auditory Cortex UNSMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_AC_lh_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/whole_brain/${s}/${s}_fALFF_AC_rh_fsavg.mgz 


# Check the projection of fALFF to the subject specific cortical surface Auditory Cortex SMOOTHED

freeview -f \
${fs_path}/Recon/${s}/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/aud_cortex/${s}/${s}_fALFF_AC_lh_sm_fs.mgz \
${fs_path}/Recon/${s}/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/aud_cortex/${s}/${s}_fALFF_AC_rh_sm_fs.mgz

# Check the projection of fALFF to fsaverage Auditory Cortex SMOOTHED

freeview -f \
${fs_path}/Recon/fsaverage/surf/lh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/aud_cortex/${s}/${s}_fALFF_AC_lh_sm_fsavg.mgz \
${fs_path}/Recon/fsaverage/surf/rh.smoothwm:overlay=${analysis_path}/fALFF/surface/smoothed/aud_cortex/${s}/${s}_fALFF_AC_rh_sm_fsavg.mgz
