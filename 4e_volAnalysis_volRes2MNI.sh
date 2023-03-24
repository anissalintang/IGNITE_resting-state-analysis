#!/bin/bash

# Project ALFF and fALFF from functional to MNI space
vol_volRes2MNI() {

	data_path="/Volumes/gdrive4tb/IGNITE";s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	reho_path="${analysis_path}/ReHo"

	hemi=(lh rh)
	neighbourhood=(7 19 27)
	region=(AC HG PT MGB V1 thalamus MGB)
	region_GM=(AC HG PT V1)

	###############################################################
	# ALFF and fALFF whole brain to MNI

	applywarp \
	--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	--in=${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz \
	--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
	--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
	--interp=nn \
	--out=${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF_MNI.nii.gz

	# Checkpoint projection ALFF from functional to MNI space
	echo "${s} whole brain ALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

	applywarp \
	--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	--in=${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz \
	--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
	--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
	--interp=nn \
	--out=${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF_MNI.nii.gz

	# Checkpoint projection fALFF from functional to MNI space
	echo "${s} whole brain fALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

	###############################################################
	# ReHo whole brain to MNI

	for n in ${neighbourhood[@]}; do
        applywarp --ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
                  --in=${reho_path}/wholeBrain/${s}/${s}_ReHo_${n}.nii.gz \
                  --warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
                  --premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
                  --interp=nn \
                  --out=${analysis_path}/ReHo/wholeBrain/${s}/${s}_ReHo_${n}_MNI.nii.gz
    done
    # Checkpoint projection ReHo from functional to MNI space
	echo "${s} whole brain ReHo has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt


    ###############################################################
    ###############################################################
    # ALFF and fALFF to MNI
	# All regions

	for r in ${region[@]}; do
		applywarp \
		--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
		--in=${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}.nii.gz \
		--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
		--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
		--interp=nn \
		--out=${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_MNI.nii.gz

		# Checkpoint projection ALFF from functional to MNI space
		echo "${s} ${r} ALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

		applywarp \
		--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
		--in=${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}.nii.gz \
		--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
		--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
		--interp=nn \
		--out=${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_MNI.nii.gz

	done	

	# Checkpoint projection fALFF from functional to MNI space
	echo "${s} ${r} fALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

	###############################################################
	# ReHo to MNI
	# All regions

	for r in ${region[@]}; do
		for n in ${neighbourhood[@]}; do
	        applywarp --ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	                  --in=${reho_path}/${r}/${s}/${s}_ReHo_${n}_${r}.nii.gz \
	                  --warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
	                  --premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
	                  --interp=nn \
	                  --out=${analysis_path}/ReHo/${r}/${s}/${s}_ReHo_${n}_${r}_MNI.nii.gz
	    done
	done 

	# Checkpoint projection ReHo from functional to MNI space
	echo "${s} ${r} ReHo has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt


	###############################################################
    ###############################################################
    # ALFF and fALFF to MNI
	# All regions in GM

	for r in ${region_GM[@]}; do
		applywarp \
		--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
		--in=${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM.nii.gz \
		--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
		--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
		--interp=nn \
		--out=${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM_MNI.nii.gz

		# Checkpoint projection ALFF from functional to MNI space
		echo "${s} ${r} in GM ALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

		applywarp \
		--ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
		--in=${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM.nii.gz \
		--warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
		--premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
		--interp=nn \
		--out=${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM_MNI.nii.gz

	done	

	# Checkpoint projection fALFF from functional to MNI space
	echo "${s} ${r} in GM fALFF has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt

	###############################################################
	# ReHo to MNI
	# All regions in GM

	for r in ${region_GM[@]}; do
		for n in ${neighbourhood[@]}; do
	        applywarp --ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	                  --in=${reho_path}/GM/${r}/${s}/${s}_ReHo_${n}_${r}_GM.nii.gz \
	                  --warp=${vol_path}/registration/$s/struct2mni/${s}_struct2mni_warp \
	                  --premat=${vol_path}/registration/$s/meanfunc2struct/${s}_meanfunc2struct.mat \
	                  --interp=nn \
	                  --out=${analysis_path}/ReHo/GM/${r}/${s}/${s}_ReHo_${n}_${r}_GM_MNI.nii.gz
	    done
	done 
	
	# Checkpoint projection ReHo from functional to MNI space
	echo "${s} ${r} in GM ReHo has been projected from functional to MNI space" >> ${log_path}/4e_volAnalysis_volRes2MNI_LOG.txt
}

# Exports the function
export -f vol_volRes2MNI

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'vol_volRes2MNI {1}' ::: ${s[@]}