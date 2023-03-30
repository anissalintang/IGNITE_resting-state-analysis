#!/bin/bash

# Project GCOR from functional to MNI space

vol_gcor2MNI() {

	data_path="/Volumes/gdrive4tb/IGNITE";s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	reho_path="${analysis_path}/ReHo"

	hemi=(lh rh)

	###############################################################
	# GCOR whole brain to MNI

	applywarp \
	--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	--in=${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap.nii.gz \
	--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
	--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
	--interp=nn \
	--out=${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap_MNI.nii.gz

	# Checkpoint projection GCOR from functional to MNI space
	echo "${s} whole brain GCOR has been projected from functional to MNI space" >> ${log_path}/4dd_volAnalysis_gcor2MNI_LOG.txt

	###############################################################
	# Show the average of all subjects
	mkdir -p ${analysis_path}/GCOR/aveWholeBrain

	fslmerge -t ${analysis_path}/GCOR/aveWholeBrain/mergeWholeBrain_GCORmap_MNI.nii.gz ${analysis_path}/GCOR/wholeBrain/${s}/${s}_wholeBrain_GCORmap_MNI.nii.gz
 
 	fslmaths ${analysis_path}/GCOR/aveWholeBrain/mergeWholeBrain_GCORmap_MNI.nii.gz -Tmean ${analysis_path}/GCOR/aveWholeBrain/aveWholeBrain_GCORmap_MNI.nii.gz

 	# Checkpoint calculating average GCOR
	echo "GCOR is now averaged for all subjects" >> ${log_path}/4dd_volAnalysis_gcor2MNI_LOG.txt

}

# Exports the function
export -f vol_gcor2MNI

# Create an array with subjects (as they are in preprocessed folder)
subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))


# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'vol_gcor2MNI {1}' ::: ${s[@]}