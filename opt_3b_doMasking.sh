#!/bin/bash

# This script is to extract ROIs from the functional time series

do_masking () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

	hemi=(lh rh)
	region=(AC HG PT MGB V1 thalamus)

	for r in ${region[@]}; do
		mkdir -p ${vol_path}/Masked_functional_data/${r}/${s}

		# For the filter 0.01-0.1
		fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${vol_path}/Masked_functional_data/${r}/${s}/${s}_preprocessed_psc_filt01_${r}.nii.gz

		# For the filter --0.25
		fslmaths ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${vol_path}/Masked_functional_data/${r}/${s}/${s}_preprocessed_psc_filt025_${r}.nii.gz

		###############################################################
		# For each hemispheres

		for h in ${hemi[@]}; do
			# For the filter 0.01-0.1
			fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${vol_path}/Masked_functional_data/${r}/${s}/${s}_preprocessed_psc_filt01_${r}_${h}.nii.gz

			# For the filter --0.25
			fslmaths ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${vol_path}/Masked_functional_data/${r}/${s}/${s}_preprocessed_psc_filt025_${r}_${h}.nii.gz
		done

		# Checkpoint for extract ROIs from the functional time series
		echo "${s} Extracted ROI: ${r} from the functional time series has been performed" >> ${log_path}/3b_doMasking_LOG.txt
	done

}



# Exports the function
export -f do_masking

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'do_masking {1}' ::: ${s[@]}