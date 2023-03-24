#!/bin/bash

brain_segmentation () {

	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

	mkdir -p ${mask_path}/segmentation/${s}

	cp ${vol_path}/registration/$s/${s}_t1.nii.gz ${mask_path}/segmentation/${s}/${s}_t1_brain.nii.gz

	###############################################################
	# Brain extraction= remove neck and skull
	bet ${mask_path}/segmentation/${s}/${s}_t1_brain.nii.gz ${mask_path}/segmentation/${s}/${s}_t1_brain.nii.gz -m -f 0.25

	# Checkpoint for brain extraction
	echo "${s} brain extracted" >> ${log_path}/3b_brainSegmentation_LOG.txt

	###############################################################
	# Perform the segmentation
	# type=1 specifies that the image is a T1 weighted image
	fast --type=1 ${mask_path}/segmentation/${s}/${s}_t1_brain.nii.gz

	# Checkpoint for brain segmentation
	echo "${s} brain segmentated" >> ${log_path}/3b_brainSegmentation_LOG.txt

	###############################################################
	# RESULTS -> pve_0 corresponds to the CSF, pve_1 corresponds to the grey matter, and pve_2 corresponds to the white matter
	# Move and rename the results files to make more sense
	mkdir -p ${mask_path}/segmentation/${s}/segments
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_pve_0.nii.gz ${mask_path}/segmentation/${s}/segments/${s}_t1_csf.nii.gz
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_pve_1.nii.gz ${mask_path}/segmentation/${s}/segments/${s}_t1_gm.nii.gz
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_pve_2.nii.gz ${mask_path}/segmentation/${s}/segments/${s}_t1_wm.nii.gz

	###############################################################
	# Move the structural files
	mkdir -p ${mask_path}/segmentation/${s}/structural
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain.nii.gz ${mask_path}/segmentation/${s}/structural/${s}_t1_brain_bet.nii.gz
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_mask.nii.gz ${mask_path}/segmentation/${s}/structural/${s}_t1_brain_mask.nii.gz

	###############################################################
	# Move other files to other FAST files
	mkdir -p ${mask_path}/segmentation/${s}/other_FAST_files
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_mixeltype.nii.gz ${mask_path}/segmentation/${s}/other_FAST_files/${s}_t1_brain_mixeltype.nii.gz
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_pveseg.nii.gz ${mask_path}/segmentation/${s}/other_FAST_files/${s}_t1_brain_pveseg.nii.gz
	mv ${mask_path}/segmentation/${s}/${s}_t1_brain_seg.nii.gz ${mask_path}/segmentation/${s}/other_FAST_files/${s}_t1_brain_seg.nii.gz

	###############################################################
	# Create T1 masks from the segmented regions
	mkdir -p ${mask_path}/segmentation/${s}/t1_segment_masks
	fslmaths ${mask_path}/segmentation/${s}/segments/${s}_t1_csf.nii.gz -thr 0.5 -bin ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_csf_mask_bin.nii.gz
	fslmaths ${mask_path}/segmentation/${s}/segments/${s}_t1_gm.nii.gz -thr 0.5 -bin ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_gm_mask_bin.nii.gz
	fslmaths ${mask_path}/segmentation/${s}/segments/${s}_t1_wm.nii.gz -thr 0.5 -bin ${mask_path}/segmentation/${s}/t1_segment_masks/${s}_t1_wm_mask_bin.nii.gz

	# Checkpoint for creating T1 masks from the segmented regions
	echo "${s} Creating T1 masks from the segmented regions has been performed" >> ${log_path}/3b_brainSegmentation_LOG.txt

	###############################################################
	# Reslice the mask from T1 to individual functional space
	masks=(csf gm wm)

	for m in ${masks[@]}; do
		mkdir -p ${mask_path}/segmentation/${s}/func_segment/${m}
		mkdir -p ${mask_path}/segmentation/${s}/func_segment_masks/${m}

		applywarp \
		--in=${mask_path}/segmentation/${s}/segments/${s}_t1_${m}.nii.gz \
		--ref=${preproc_path}/$s/meanFunc/${s}_mean_func.nii.gz \
		--postmat=${vol_path}/registration/$s/struct2meanfunc/${s}_struct2meanfunc.mat \
		--out=${mask_path}/segmentation/${s}/func_segment/${m}/${s}_func_${m}

		fslmaths ${mask_path}/segmentation/${s}/func_segment/${m}/${s}_func_${m}.nii.gz -thr 0.5 -bin ${mask_path}/segmentation/${s}/func_segment_masks/${m}/${s}_func_${m}_mask_bin.nii.gz
	done

	# Checkpoint for reslicing the masks from T1 to individual functional space
	echo "${s} reslicing the masks from T1 to individual functional space has been performed" >> ${log_path}/3b_brainSegmentation_LOG.txt
}



# Exports the function
export -f brain_segmentation

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'brain_segmentation {1}' ::: ${s[@]}