#!/bin/bash

# Calculate ALFF and fALFF in surface space
surface_ALFF() {


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
region=(HG PT V1)

###############################################################
# Project to fsaverage space
# UNSMOOTHED

##########################################
# ALFF
# Whole brain to fsaverage space

mkdir -p ${surf_analysis_path}/ALFF/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf --mov ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF_${h}_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done

# Checkpoint for mri_vol2surf for ALFF whole brain
	echo "${s} mri_vol2surf for ALFF whole brain has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF_${h}_fs.mgz \
	--o ${surf_analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF_${h}_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for ALFF whole brain
	echo "${s} mris_apply_reg for ALFF whole brain has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

##########################################
# fALFF
# Whole brain to fsaverage space

mkdir -p ${surf_analysis_path}/fALFF/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf \
	--mov ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF_${h}_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done
# Checkpoint for mri_vol2surf for fALFF whole brain
	echo "${s} mri_vol2surf for fALFF whole brain has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF_${h}.mgz \
	--o ${surf_analysis_path}/fALFF/surface/wholeBrain/${s}/${s}_fALFF_${h}_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for fALFF whole brain
	echo "${s} mris_apply_reg for fALFF whole brain has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

###############################################################
###############################################################
# Project to fsaverage space
# SMOOTHED

##########################################
# ALFF
# Whole brain to cortical surface and smooth

mkdir -p ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf \
	--mov ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}/${s}_ALFF_${h}_sm_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done
# Checkpoint for mri_vol2surf for ALFF whole brain SMOOTHED
	echo "${s} mri_vol2surf for ALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

# Smooth the vol2surf projected image
fwhm=5
for h in ${hemi[@]}; do
	mri_surf2surf \
	--sval ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}/${s}_ALFF_${h}_sm_fs.mgz \
	--tval ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}/${s}_ALFF_${h}_sm_fs.mgz \
	--s ${s} \
	--hemi ${h} \
	--fwhm $fwhm \
	--cortex
done
# Checkpoint for mri_surf2surf for ALFF whole brain SMOOTHED
	echo "${s} mri_surf2surf for ALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}/${s}_ALFF_${h}_sm_fs.mgz \
	--o ${surf_analysis_path}/ALFF/smoothed/wholeBrain/${s}/${s}_ALFF_${h}_sm_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for ALFF whole brain SMOOTHED
	echo "${s} mris_apply_reg for ALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

##########################################
# fALFF
# Whole brain to cortical surface and smooth

mkdir -p ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}

for h in ${hemi[@]}; do
	mri_vol2surf \
	--mov ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz \
	--hemi ${h} \
	--o ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}/${s}_fALFF_${h}_sm_fs.mgz \
	--projfrac-avg 0 1 0.1 \
	--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
	--srcsubject ${s}
done
# Checkpoint for mri_vol2surf for fALFF whole brain SMOOTHED
	echo "${s} mri_vol2surf for fALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

# Smooth the vol2surf projected image
fwhm=5
for h in ${hemi[@]}; do
	mri_surf2surf \
	--sval ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}/${s}_fALFF_${h}_sm_fs.mgz \
	--tval ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}/${s}_fALFF_${h}_sm_fs.mgz \
	--s ${s} \
	--hemi ${h} \
	--fwhm $fwhm \
	--cortex
done
# Checkpoint for mri_surf2surf for fALFF whole brain SMOOTHED
	echo "${s} mri_surf2surf for fALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

for h in ${hemi[@]}; do
	mris_apply_reg \
	--src ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}/${s}_fALFF_${h}_sm_fs.mgz \
	--o ${surf_analysis_path}/fALFF/smoothed/wholeBrain/${s}/${s}_fALFF_${h}_sm_fsavg.mgz \
	--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
done
# Checkpoint for mris_apply_reg for fALFF whole brain SMOOTHED
	echo "${s} mris_apply_reg for fALFF whole brain SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt


###############################################################
###############################################################

# Project specific ROIs (f)ALFF fsaverage space

###############################################################
###############################################################

# Project to fsaverage space
# ALFF UNSMOOTHED

for r in ${region[@]}; do
	mkdir -p ${surf_analysis_path}/ALFF/${r}/${s}

	for h in ${hemi[@]}; do
		mri_vol2surf \
		--mov ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}.nii.gz \
		--hemi ${h} \
		--o ${surf_analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h}_fs.mgz \
		--projfrac-avg 0 1 0.1 \
		--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
		--srcsubject ${s}
	done
	# Checkpoint for mri_vol2surf for ALFF regions
	echo "${s} mri_vol2surf for ALFF ${r} has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	for h in ${hemi[@]}; do
		mris_apply_reg \
		--src ${surf_analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h}_fs.mgz \
		--o ${surf_analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h}_fsavg.mgz \
		--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
	done
	# Checkpoint for mris_apply_reg for ALFF regions
	echo "${s} mris_apply_reg for ALFF ${r} has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt
done

##########################################
# Project to fsaverage space
# fALFF UNSMOOTHED

for r in ${region[@]}; do
	mkdir -p ${surf_analysis_path}/fALFF/${r}/${s}

	for h in ${hemi[@]}; do
		mri_vol2surf \
		--mov ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}.nii.gz \
		--hemi ${h} \
		--o ${surf_analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h}_fs.mgz \
		--projfrac-avg 0 1 0.1 \
		--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
		--srcsubject ${s}
	done
	# Checkpoint for mri_vol2surf for fALFF regions
	echo "${s} mri_vol2surf for fALFF ${r} has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	for h in ${hemi[@]}; do
		mris_apply_reg \
		--src ${surf_analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h}_fs.mgz \
		--o ${surf_analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h}_fsavg.mgz \
		--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
	done
	# Checkpoint for mris_apply_reg for fALFF regions
	echo "${s} mris_apply_reg for fALFF ${r} has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt
done

##########################################
##########################################
# Project to fsaverage space
# SMOOTHED

for r in ${region[@]}; do
	mkdir -p ${surf_analysis_path}/ALFF/smoothed/${r}/${s}

	for h in ${hemi[@]}; do
		mri_vol2surf \
		--mov ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}.nii.gz \
		--hemi ${h} \
		--o ${surf_analysis_path}/ALFF/smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_sm_fs.mgz \
		--projfrac-avg 0 1 0.1 \
		--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
		--srcsubject ${s}
	done
	# Checkpoint for mri_vol2surf for ALFF regions SMOOTHED
	echo "${s} mri_vol2surf for ALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	# Smooth the vol2surf projected image
	fwhm=5
	for h in ${hemi[@]}; do
		mri_surf2surf \
		--sval ${surf_analysis_path}/ALFF/smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_sm_fs.mgz \
		--tval ${surf_analysis_path}/ALFF/smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_sm_fs.mgz \
		--s ${s} \
		--hemi ${hemi} \
		--fwhm $fwhm \
		--cortex
	done
	# Checkpoint for mri_surf2surf for ALFF regions SMOOTHED
	echo "${s} mri_surf2surf for ALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	for h in ${hemi[@]}; do
		mris_apply_reg \
		--src ${surf_analysis_path}/ALFF/smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_sm_fs.mgz \
		--o ${surf_analysis_path}/ALFF/smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_sm_fsavg.mgz \
		--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
	done
	# Checkpoint for mris_apply_reg for ALFF regions SMOOTHED
	echo "${s} mris_apply_reg for ALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

done

##########################################
# fALFF
# Whole brain to cortical surface and smooth

for r in ${region[@]}; do
	mkdir -p ${surf_analysis_path}/fALFF/smoothed/${r}/${s}

	for h in ${hemi[@]}; do
		mri_vol2surf \
		--mov ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}.nii.gz \
		--hemi ${h} \
		--o ${surf_analysis_path}/fALFF/smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_sm_fs.mgz \
		--projfrac-avg 0 1 0.1 \
		--reg ${fs_path}/registration/${s}/${s}_mean2fs.lta \
		--srcsubject ${s}
	done
	# Checkpoint for mri_vol2surf for fALFF regions SMOOTHED
		echo "${s} mri_vol2surf for fALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	# Smooth the vol2surf projected image
	fwhm=5
	for h in ${hemi[@]}; do
		mri_surf2surf \
		--sval ${surf_analysis_path}/fALFF/smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_sm_fs.mgz \
		--tval ${surf_analysis_path}/fALFF/smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_sm_fs.mgz \
		--s ${s} \
		--hemi ${hemi} \
		--fwhm $fwhm \
		--cortex
	done
	# Checkpoint for mri_surf2surf for fALFF regions SMOOTHED
		echo "${s} mri_surf2surf for fALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt

	for h in ${hemi[@]}; do
		mris_apply_reg \
		--src ${surf_analysis_path}/fALFF/smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_sm_fs.mgz \
		--o ${surf_analysis_path}/fALFF/smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_sm_fsavg.mgz \
		--streg $SUBJECTS_DIR/${s}/surf/${h}.fsaverage.sphere.reg $SUBJECTS_DIR/fsaverage/surf/${h}.sphere.reg
	done
	# Checkpoint for mris_apply_reg for fALFF regions SMOOTHED
		echo "${s} mris_apply_reg for fALFF ${r} SMOOTHED has been done" >> ${log_path}/6_surAnalysis_ALFF_LOG.txt
done

}

# Exports the function
export -f surface_ALFF

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'surface_ALFF {1}' ::: ${s[@]}