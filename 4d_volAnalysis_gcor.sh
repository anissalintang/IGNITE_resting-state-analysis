#!/bin/bash

# Calculate functional connectivity density via FSL commands following Saad paper

calc_gcor () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"

	mkdir -p ${analysis_path}/ConnDensityGCOR
    fcd_path="${analysis_path}/ConnDensityGCOR"

    region=(AC HG PT MGB V1 thalamus)
    region_GM=(AC HG PT V1)

        # From Saad et al., (2013) steps to calculate GCOR are:
	    # (1) De-mean each voxel's time series and scale it by its Eucledian norm
		# (2) Average scaled time series over the whole brain mask
		# (3) GCOR is the length (L2 norm) of this averaged series

    mkdir -p ${fcd_path}/wholeBrain/${s}/

    # De-mean each voxel's time series and scale it by its Eucledian norm
    # calculates the Euclidean norm of each voxel's time series (-sqrt -mul <input_data> -div <norm_file>) -> square root of the sum of the squared values of each time point

    fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -Tmean -mul 1 ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz

    fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -sub ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz -div ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -mul ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz -sqrt -mul ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_scaled.nii.gz

    # Average scaled time series over the whole brain mask
    fslmeants -i ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_scaled.nii.gz -m ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz -o ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz

    fslmaths ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz -sqrt -mul ${preproc_path}/${s}/meanFunc/bet/${s}_mean_func_bet_mask.nii.gz ${fcd_path}/wholeBrain/${s}/${s}_wholeBrain_gcor.nii.gz


	    # # Checkpoint for calculating fcd from each voxels to the rest of the brain
    	# echo "${s} Connectivity Density for the whole brain has been calculated" >> ${log_path}/4d_volAnalysis_fcd_LOG.txt

}

# Exports the function
export -f calc_gcor

# Create an array with subjects (as they are in preprocessed folder)
#s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))
s=(IGNTFA_00065)

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'calc_gcor {1}' ::: ${s[@]}