#!/bin/bash

# Calculate functional connectivity density via AFNI commands

calc_fcd () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"

	mkdir -p ${analysis_path}/ConnDensity
    fcd_path="${analysis_path}/ConnDensity"

    region=(AC HG PT MGB V1 thalamus)
    region_GM=(AC HG PT V1)

    # reference: https://afni.nimh.nih.gov/afni/community/board/read.php?1,152839,152845#msg-152845

    mkdir -p ${fcd_path}/wholeBrain/${s}/

	    3dNetCorr \
	    -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
	    -in_rois ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz \
	    -mask ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz \
	    -prefix ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_fcdGlobal.nii.gz \
	    -ts_wb_corr \
	    -nifti

	    # Checkpoint for calculating fcd from each voxels to the rest of the brain
    	echo "${s} Connectivity Density for the whole brain has been calculated" >> ${log_path}/4d_volAnalysis_fcd_LOG.txt

    for r in ${region[@]}; do
    	mkdir -p ${fcd_path}/${r}/${s}/

	    3dNetCorr \
	    -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
	    -in_rois ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin.nii.gz \
	    -mask ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz \
	    -prefix ${fcd_path}/${r}/${s}/${s}_${r}_fcdGlobal.nii.gz \
	    -ts_wb_corr \
	    -nifti

	    # Checkpoint for calculating fcd from all regions
    	echo "${s} Connectivity Density between ${r} and the whole brain has been calculated" >> ${log_path}/4d_volAnalysis_fcd_LOG.txt

	    for r in ${region_GM[@]}; do
	    	mkdir -p ${fcd_path}/GM/${r}/${s}/

		    3dNetCorr \
		    -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
		    -in_rois ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz \
		    -mask ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz \
		    -prefix ${fcd_path}/GM/${r}/${s}/${s}_GM_${r}_fcdGlobal.nii.gz \
		    -ts_wb_corr \
		    -nifti

		    # Checkpoint for calculating fcd from region_GM
    		echo "${s} Connectivity Density between ${r} in GM and the whole brain has been calculated" >> ${log_path}/4d_volAnalysis_fcd_LOG.txt
		done

	done


    

}

# Exports the function
export -f calc_fcd

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))
#s=(IGNTFA_00065)

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'calc_fcd {1}' ::: ${s[@]}