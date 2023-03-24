#!/bin/bash

# Calculate ALFF and fALFF in volumetric space (SMOOTHED functional data version)
vol_meanALFF_smoothed() {

	mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis

	data_path="/Volumes/gdrive4tb/IGNITE";s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"

	hemi=(lh rh)
	region=(AC HG PT MGB V1 thalamus)
	region_GM=(AC HG PT V1)

	###############################################################
	# ALFF calculation

	##########################################
	# Whole brain
	mkdir -p ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/

	fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz -Tstd ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed

	fslstats ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -M > ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_meanALFF_smoothed.txt

	# Checkpoint for ALFF_smoothed calculation for whole brain
	echo "${s} ALFF_smoothed for whole brain has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt

	##########################################
	# All regions
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/ALFF_smoothed/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_ALFF_${r}_smoothed

	fslstats ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_ALFF_${r}_smoothed -M > ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_meanALFF_${r}_smoothed.txt
	done

	# and mask for each hemispheres
	for r in ${region[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_smoothed

			fslstats ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_ALFF_${r}_${h}_smoothed -M > ${analysis_path}/ALFF_smoothed/${r}/${s}/${s}_meanALFF_${r}_${h}_smoothed.txt

		done
	done

	# Checkpoint for ALFF_smoothed calculation for all regions
	echo "${s} ALFF_smoothed for all regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt


	###############################################################
	# fALFF calculation
	## Step 1 - calculate ALFF from filt_0-0.25
	## Step 2 - divide ALFF (filt_0.01-0.1) by ALFF (filt0-0.25)

	##########################################
	# Whole brain
	mkdir -p ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/

	fslmaths ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz -Tstd ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_ALFF_025_smoothed

	fslmaths ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -div ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_ALFF_025_smoothed ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed

	fslstats ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed -M > ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_meanfALFF_smoothed.txt

	# Checkpoint for fALFF_smoothed calculation for whole brain
	echo "${s} fALFF_smoothed for whole brain has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt

	##########################################
	# All regions
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/fALFF_smoothed/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_fALFF_${r}_smoothed

	fslstats ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_fALFF_${r}_smoothed -M > ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_meanfALFF_${r}_smoothed.txt
	done

	# and mask for each hemispheres
	for r in ${region[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_smoothed

			fslstats ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_fALFF_${r}_${h}_smoothed -M > ${analysis_path}/fALFF_smoothed/${r}/${s}/${s}_meanfALFF_${r}_${h}_smoothed.txt

		done
	done

	# Checkpoint for fALFF_smoothed calculation for all regions
	echo "${s} fALFF_smoothed for all regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt

	###############################################################
	##########################################
	##########################################
	# Repeat the above now for GM masks
	##########################################
	##########################################

	###############################################################
	# ALFF calculation

	##########################################
	# All regions
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_ALFF_${r}_GM_smoothed

	fslstats ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_ALFF_${r}_GM_smoothed -M > ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_meanALFF_${r}_GM_smoothed.txt
	done

	# and mask for each hemispheres
	for r in ${region_GM[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_ALFF_${r}_${h}_GM_smoothed

			fslstats ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_ALFF_${r}_${h}_GM_smoothed -M > ${analysis_path}/ALFF_smoothed/GM/${r}/${s}/${s}_meanALFF_${r}_${h}_GM_smoothed.txt

		done
	done

	# Checkpoint for ALFF_smoothed calculation for all regions
	echo "${s} ALFF_smoothed for all regions in GM mask has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt


	###############################################################
	# fALFF calculation
	## Step 1 - calculate ALFF from filt_0-0.25
	## Step 2 - divide ALFF (filt_0.01-0.1) by ALFF (filt0-0.25)

	##########################################
	# All regions
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_fALFF_${r}_GM_smoothed

	fslstats ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_fALFF_${r}_GM_smoothed -M > ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_meanfALFF_${r}_GM_smoothed.txt
	done

	# and mask for each hemispheres
	for r in ${region_GM[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/fALFF_smoothed/wholeBrain/${s}/${s}_fALFF_smoothed -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_fALFF_${r}_${h}_GM_smoothed

			fslstats ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_fALFF_${r}_${h}_GM_smoothed -M > ${analysis_path}/fALFF_smoothed/GM/${r}/${s}/${s}_meanfALFF_${r}_${h}_GM_smoothed.txt

		done
	done
	# Checkpoint for fALFF_smoothed calculation for all regions
	echo "${s} fALFF_smoothed for all regions in GM mask has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_smoothed_LOG.txt

}

# Exports the function
export -f vol_meanALFF_smoothed

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'vol_meanALFF_smoothed {1}' ::: ${s[@]}