#!/bin/bash

# This script is to create new masks for grey matter within the specific ROIs

seg_mask () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

	mkdir -p ${mask_path}/ROIsegmentation

	region=(AC HG PT MGB V1)
	hemi=(lh rh)

	###############################################################
	# Create new masks for grey matter within the specific ROIs

	for r in ${region[@]}; do
		mkdir -p ${mask_path}/ROIsegmentation/gm/${r}/${s}

		fslmaths ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin -mul ${mask_path}/segmentation/${s}/func_segment_masks/gm/${s}_func_gm_mask_bin.nii.gz ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz

		for h in ${hemi[@]}; do
			fslmaths ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin -mul ${mask_path}/segmentation/${s}/func_segment_masks/gm/${s}_func_gm_mask_bin.nii.gz ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz
		done

		# Checkpoint for creating new masks for grey matter from the list of regions
		echo "${s} creating GM mask for ${r} region has been performed" >> ${log_path}/3c_segMask_LOG.txt
		
	done
}


# Exports the function
export -f seg_mask

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'seg_mask {1}' ::: ${s[@]}