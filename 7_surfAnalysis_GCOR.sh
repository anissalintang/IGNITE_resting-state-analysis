#!/bin/bash

# Project GCOR into surface space
surface_GCOR() {


data_path="/Volumes/gdrive4tb/IGNITE";s=$1
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
fs_path="/Volumes/gdrive4tb/IGNITE/resting-state/surface"

mkdir -p "/Volumes/gdrive4tb/IGNITE/resting-state/surface/analysis"
surf_analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/surface/analysis"

export SUBJECTS_DIR="${fs_path}/recon"

hemi=(lh rh)

###############################################################
# Project to fsaverage space
# UNSMOOTHED

##########################################
# GCOR
# Whole brain to fsaverage space

mkdir -p ${surf_analysis_path}/GCOR/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf --mov ${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/GCOR/wholeBrain/${s}/${s}_GCOR_${h}_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done

# Checkpoint for mri_vol2surf for GCOR whole brain
	echo "${s} mri_vol2surf for GCOR whole brain has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/GCOR/wholeBrain/${s}/${s}_GCOR_${h}_fs.mgz \
	--o ${surf_analysis_path}/GCOR/wholeBrain/${s}/${s}_GCOR_${h}_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for GCOR whole brain
	echo "${s} mris_apply_reg for GCOR whole brain has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt


###############################################################
###############################################################
# Project to fsaverage space
# SMOOTHED

##########################################
# GCOR
# Whole brain to cortical surface and smooth

mkdir -p ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf \
	--mov ${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}/${s}_GCOR_${h}_sm_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done
# Checkpoint for mri_vol2surf for GCOR whole brain SMOOTHED
	echo "${s} mri_vol2surf for GCOR whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

# Smooth the vol2surf projected image
fwhm=5
for h in ${hemi[@]}; do
	mri_surf2surf \
	--sval ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}/${s}_GCOR_${h}_sm_fs.mgz \
	--tval ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}/${s}_GCOR_${h}_sm_fs.mgz \
	--s ${s} \
	--hemi ${h} \
	--fwhm $fwhm \
	--cortex
done
# Checkpoint for mri_surf2surf for GCOR whole brain SMOOTHED
	echo "${s} mri_surf2surf for GCOR whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}/${s}_GCOR_${h}_sm_fs.mgz \
	--o ${surf_analysis_path}/GCOR/smoothed/wholeBrain/${s}/${s}_GCOR_${h}_sm_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for GCOR whole brain SMOOTHED
	echo "${s} mris_apply_reg for GCOR whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt




###############################################################
###############################################################

# Project GM area only GCOR to fsaverage space

###############################################################
###############################################################

# Project to fsaverage space
# UNSMOOTHED

##########################################
# GCOR
# Whole brain to fsaverage space

mkdir -p ${surf_analysis_path}/GCOR/wholeBrain_GM/${s}

for h in ${hemi[@]}; do
	mri_vol2surf --mov ${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap_GM.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/GCOR/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done

# Checkpoint for mri_vol2surf for GCOR_GM whole brain
	echo "${s} mri_vol2surf for GCOR_GM whole brain has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/GCOR/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_fs.mgz \
	--o ${surf_analysis_path}/GCOR/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for GCOR_GM whole brain
	echo "${s} mris_apply_reg for GCOR_GM whole brain has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt


###############################################################
###############################################################
# Project to fsaverage space
# SMOOTHED

##########################################
# GCOR
# Whole brain to cortical surface and smooth

mkdir -p ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}

for h in ${hemi[@]}; do
	mri_vol2surf \
	--mov ${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap_GM.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_sm_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done
# Checkpoint for mri_vol2surf for GCOR_GM whole brain SMOOTHED
	echo "${s} mri_vol2surf for GCOR_GM whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

# Smooth the vol2surf projected image
fwhm=5
for h in ${hemi[@]}; do
	mri_surf2surf \
	--sval ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_sm_fs.mgz \
	--tval ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_sm_fs.mgz \
	--s ${s} \
	--hemi ${h} \
	--fwhm $fwhm \
	--cortex
done
# Checkpoint for mri_surf2surf for GCOR_GM whole brain SMOOTHED
	echo "${s} mri_surf2surf for GCOR_GM whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_sm_fs.mgz \
	--o ${surf_analysis_path}/GCOR/smoothed/wholeBrain_GM/${s}/${s}_GCOR_GM_${h}_sm_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for GCOR_GM whole brain SMOOTHED
	echo "${s} mris_apply_reg for GCOR_GM whole brain SMOOTHED has been done" >> ${log_path}/7_surAnalysis_GCOR_LOG.txt


}

# Exports the function
export -f surface_GCOR

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))


# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'surface_GCOR {1}' ::: ${s[@]}