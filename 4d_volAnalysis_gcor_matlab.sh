#!/bin/bash

# This script will calculate GCOR of the whole brain, using a matlab function built for this

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

mkdir -p ${analysis_path}/GCOR
gcor_path="${analysis_path}/GCOR"


for s in ${subj[@]}; do
	mkdir -p ${analysis_path}/GCOR/wholeBrain/${s}

	dim1=$(fslval ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz dim1)
	dim2=$(fslval ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz dim2)
	dim3=$(fslval ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz dim3)
	M=$((dim1*dim2*dim3))

	N=$(fslval ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz dim4)

	# Get U >> the unit variance time series, by subtracting time series data
	# with the mean of time series and divide by the standard deviation of the time
	# series
	
	fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -Tmean ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz

	fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -Tstd ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_std.nii.gz

	fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -sub ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz -div ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_std.nii.gz ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_demeaned.nii.gz

	## Remove temporary files
		rm ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_mean.nii.gz ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_std.nii.gz

	matlab -batch "cd('/Volumes/gdrive4tb/IGNITE/code/resting-state'); calc_gcor('${M}', '${N}','${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_demeaned.nii.gz', '${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_GCORmap.nii')" -nojvm

	gzip ${gcor_path}/wholeBrain/${s}/${s}_wholeBrain_GCORmap.nii


	# Checkpoint for taking ALFF of mean time series
	echo "${s} GCOR from the whole brain has been performed in matlab" >> ${log_path}/4d_volAnalysis_gcor_matlab_LOG.txt

done
