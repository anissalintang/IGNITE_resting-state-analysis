#!/bin/bash

# This script is to create mask of the HESCHL'S GYRUS and PLANAR TEMPORALE area from the Harvard-Oxford atlas

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"


###############################################################
# Extract Heschl's Gyrus region from the Harvard-Oxford atlas

mkdir -p ${data_path}/mask/HG/prob_mask
mask_path="/Volumes/gdrive4tb/IGNITE/mask"

fslroi $FSL_DIR/data/atlases/HarvardOxford/HarvardOxford-cort-prob-1mm ${mask_path}/HG/prob_mask/HO_HGprob 44 1

# Extract the left HG
line=($(fslinfo ${mask_path}/HG/prob_mask/HO_HGprob | grep dim1)); dim1=${line[1]}

fslmaths ${mask_path}/HG/prob_mask/HO_HGprob -roi $(($dim1/2)) $(($dim1/2)) 0 -1 0 -1 0 -1 ${mask_path}/HG/prob_mask/HO_HGprob_lh

# Extract the right HG
fslmaths ${mask_path}/HG/prob_mask/HO_HGprob -roi 0 $(($dim1/2)) 0 -1 0 -1 0 -1 ${mask_path}/HG/prob_mask/HO_HGprob_rh

# Checkpoint for HG extraction
	echo "Heschl's Gyrus probabilistic map has been extracted" >> ${log_path}/3a_createMask_LOG.txt

###############################################################
# Extract Planar Temporale region from the Harvard-Oxford atlas

mkdir -p ${data_path}/mask/PT/prob_mask

fslroi $FSL_DIR/data/atlases/HarvardOxford/HarvardOxford-cort-prob-1mm ${mask_path}/PT/prob_mask/HO_PTprob 45 1

# Extract the left PT
line=($(fslinfo ${mask_path}/PT/prob_mask/HO_PTprob | grep dim1)); dim1=${line[1]}

fslmaths ${mask_path}/PT/prob_mask/HO_PTprob -roi $(($dim1/2)) $(($dim1/2)) 0 -1 0 -1 0 -1 ${mask_path}/PT/prob_mask/HO_PTprob_lh

# Extract the right PT
fslmaths ${mask_path}/PT/prob_mask/HO_PTprob -roi 0 $(($dim1/2)) 0 -1 0 -1 0 -1 ${mask_path}/PT/prob_mask/HO_PTprob_rh

# Checkpoint for PT extraction
	echo "Planar Temporale probabilistic map has been extracted" >> ${log_path}/3a_createMask_LOG.txt

###############################################################
# Extract Medial Geniculate Body region from the Juelich atlas

mkdir -p ${data_path}/mask/MGB/prob_mask

fslroi $FSLDIR/data/atlases/Juelich/Juelich-prob-1mm.nii.gz ${mask_path}/MGB/prob_mask/Juelich_MGBprob_rh 105 1

fslroi $FSLDIR/data/atlases/Juelich/Juelich-prob-1mm.nii.gz ${mask_path}/MGB/prob_mask/Juelich_MGBprob_lh 106 1

# Checkpoint for MGB extraction
	echo "Medial Geniculate Body probabilistic map has been extracted" >> ${log_path}/3a_createMask_LOG.txt

###############################################################
# Extract Primary Visual region (V1) from the Juelich atlas

mkdir -p ${data_path}/mask/V1/prob_mask

fslroi $FSLDIR/data/atlases/Juelich/Juelich-prob-1mm.nii.gz ${mask_path}/V1/prob_mask/Juelich_V1prob_lh 80 1

fslroi $FSLDIR/data/atlases/Juelich/Juelich-prob-1mm.nii.gz ${mask_path}/V1/prob_mask/Juelich_V1prob_rh 81 1

# Checkpoint for V1 extraction
	echo "Primary Visual cortex probabilistic map has been extracted" >> ${log_path}/3a_createMask_LOG.txt

###############################################################
# Extract the Thalamus from the Harvard-Oxford atlas

mkdir -p ${data_path}/mask/thalamus/prob_mask

fslroi $FSLDIR/data/atlases/HarvardOxford/HarvardOxford-sub-prob-1mm ${mask_path}/thalamus/prob_mask/HO_thalamusprob_lh 3 1

fslroi $FSLDIR/data/atlases/HarvardOxford/HarvardOxford-sub-prob-1mm ${mask_path}/thalamus/prob_mask/HO_thalamusprob_rh 14 1

# Checkpoint for thalamus extraction
	echo "Thalamus probabilistic map has been extracted" >> ${log_path}/3a_createMask_LOG.txt

###############################################################
# Create a parallel function to enable reslicing back to the subject specific spaces

create_mask () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

	###############################################################
	# HG, PT and AC masks
	###############################################################
	mkdir -p ${mask_path}/HG/T1_mask/${s}
	mkdir -p ${mask_path}/HG/func_mask/${s}
	mkdir -p ${mask_path}/PT/T1_mask/${s}
	mkdir -p ${mask_path}/PT/func_mask/${s}

	hemi=(lh rh)
	area=(HG PT)

	for a in ${area[@]}; do
		## Both hemispheres
		# Region to T1
		applywarp \
		--in=${mask_path}/${a}/prob_mask/HO_${a}prob \
		--ref=${vol_path}/registration/${s}/${s}_t1.nii.gz \
		--out=${mask_path}/${a}/T1_mask/${s}/${s}_${a}mask2T1 \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz

		# Region mask to functional mask
		applywarp \
		--in=${mask_path}/${a}/prob_mask/HO_${a}prob \
		--ref=${preproc_path}/${s}/meanFunc/${s}_mean_func.nii.gz \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz \
		--postmat=${vol_path}/registration/${s}/struct2meanfunc/${s}_struct2meanfunc.mat \
		--out=${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func

		fslmaths ${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func.nii.gz -bin ${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func_bin.nii.gz

		## Hemisphere specific, lh and rh --> T1 and functional mask
		for h in ${hemi[@]}; do
			# Region to T1
			applywarp \
			--in=${mask_path}/${a}/prob_mask/HO_${a}prob_${h} \
			--ref=${vol_path}/registration/${s}/${s}_t1.nii.gz \
			--out=${mask_path}/${a}/T1_mask/${s}/${s}_${a}mask2T1_${h} \
			--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz

			# Region mask to functional mask
			applywarp \
			--in=${mask_path}/${a}/prob_mask/HO_${a}prob_${h} \
			--ref=${preproc_path}/${s}/meanFunc/${s}_mean_func.nii.gz \
			--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz \
			--postmat=${vol_path}/registration/${s}/struct2meanfunc/${s}_struct2meanfunc.mat \
			--out=${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func_${h}

			fslmaths ${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func_${h} -bin ${mask_path}/${a}/func_mask/${s}/${s}_${a}mask2func_${h}_bin.nii.gz
		done
	done

	# Produce a conjunction of HG and PT masks --> Auditory Cortex
	mkdir -p ${mask_path}/AC/func_mask/${s}

	## Both hemispheres
	fslmaths ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_bin -max ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_bin ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_bin

	## Hemisphere specific
	for h in ${hemi[@]}; do
		fslmaths ${mask_path}/HG/func_mask/${s}/${s}_HGmask2func_${h}_bin -max ${mask_path}/PT/func_mask/${s}/${s}_PTmask2func_${h}_bin ${mask_path}/AC/func_mask/${s}/${s}_ACmask2func_${h}_bin
	done

	# Checkpoint for HG, PT, AC reslicing to subject and functional space
	echo "${s} Reslicing prob mask to subject and functional space for HG, PT, and AC maps has been performed" >> ${log_path}/3a_createMask_LOG.txt

	###############################################################
	# MGB mask
	###############################################################
	mkdir -p ${mask_path}/MGB/T1_mask/${s}
	mkdir -p ${mask_path}/MGB/func_mask/${s}

	for h in ${hemi[@]}; do
		applywarp \
		--in=${mask_path}/MGB/prob_mask/Juelich_MGBprob_${h} \
		--ref=${vol_path}/registration/${s}/${s}_t1.nii.gz \
		--out=${mask_path}/MGB/T1_mask/${s}/${s}_MGBmask2T1_${h} \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz
	
	# Region mask to functional mask
		applywarp \
		--in=${mask_path}/MGB/prob_mask/Juelich_MGBprob_${h} \
		--ref=${preproc_path}/${s}/meanFunc/${s}_mean_func.nii.gz \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz \
		--postmat=${vol_path}/registration/${s}/struct2meanfunc/${s}_struct2meanfunc.mat \
		--out=${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_${h}

		fslmaths ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_${h} -thr 10 -bin ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_${h}_bin.nii.gz

	done

	# Produce a conjunction of the masks to create a bilateral mask of the MGB
	fslmaths ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_lh_bin -max ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_rh_bin ${mask_path}/MGB/func_mask/${s}/${s}_MGBmask2func_bin

	# Checkpoint for MGB reslicing to subject specific space
	echo "${s} Reslicing prob mask to subject and functional space for MGB map has been performed" >> ${log_path}/3a_createMask_LOG.txt

	###############################################################
	# V1 mask
	###############################################################
	mkdir -p ${mask_path}/V1/T1_mask/${s}
	mkdir -p ${mask_path}/V1/func_mask/${s}

	for h in ${hemi[@]}; do
		applywarp \
		--in=${mask_path}/V1/prob_mask/Juelich_V1prob_${h} \
		--ref=${vol_path}/registration/${s}/${s}_t1.nii.gz \
		--out=${mask_path}/V1/T1_mask/${s}/${s}_V1mask2T1_${h} \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz
	
	# Region mask to functional mask
		applywarp \
		--in=${mask_path}/V1/prob_mask/Juelich_V1prob_${h} \
		--ref=${preproc_path}/${s}/meanFunc/${s}_mean_func.nii.gz \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz \
		--postmat=${vol_path}/registration/${s}/struct2meanfunc/${s}_struct2meanfunc.mat \
		--out=${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_${h}

		fslmaths ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_${h} -thr 10 -bin ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_${h}_bin
	done

	# Produce a conjunction of the masks to create a bilateral mask of the V1
	fslmaths ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_lh_bin -max ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_rh_bin ${mask_path}/V1/func_mask/${s}/${s}_V1mask2func_bin

	# Checkpoint for V1 reslicing to subject specific space
	echo "${s} Reslicing prob mask to subject and functional space for V1 map has been performed" >> ${log_path}/3a_createMask_LOG.txt

	###############################################################
	# Thalamus mask
	###############################################################
	mkdir -p ${mask_path}/thalamus/T1_mask/${s}
	mkdir -p ${mask_path}/thalamus/func_mask/${s}

	for h in ${hemi[@]}; do
		applywarp \
		--in=${mask_path}/thalamus/prob_mask/HO_thalamusprob_${h} \
		--ref=${vol_path}/registration/${s}/${s}_t1.nii.gz \
		--out=${mask_path}/thalamus/T1_mask/${s}/${s}_thalamusmask2T1_${h} \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz
	
	# Region mask to functional mask
		applywarp \
		--in=${mask_path}/thalamus/prob_mask/HO_thalamusprob_${h} \
		--ref=${preproc_path}/${s}/meanFunc/${s}_mean_func.nii.gz \
		--warp=${vol_path}/registration/${s}/mni2struct/${s}_mni2struct_warp.nii.gz \
		--postmat=${vol_path}/registration/${s}/struct2meanfunc/${s}_struct2meanfunc.mat \
		--out=${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_${h}

		fslmaths ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_${h} -bin ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_${h}_bin
	done

	# Produce a conjunction of the masks to create a bilateral mask of the thalamus
	fslmaths ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_lh_bin -max ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_rh_bin ${mask_path}/thalamus/func_mask/${s}/${s}_thalamusmask2func_bin

	# Checkpoint for thalamus reslicing to subject specific space
	echo "${s} Reslicing prob mask to subject and functional space for thalamus map has been performed" >> ${log_path}/3a_createMask_LOG.txt
}


# Exports the function
export -f create_mask

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'create_mask {1}' ::: ${s[@]}