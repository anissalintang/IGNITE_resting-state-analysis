#!/bin/bash

# Create text file for std (f)ALFF and (f)ALFF of the mean for all subjects + in region_GM 

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"

region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)
hemi=(lh rh)

mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison
compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison"

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

###############################################################
# ALFF 
for s in ${subj[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_stdALFF.txt)" >> ${compare_path}/allSubs_stdALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_stdALFF_${r}.txt)" >> ${compare_path}/allSubs_stdALFF_${r}.txt


		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_stdALFF_${r}_${h}.txt)" >> ${compare_path}/allSubs_stdALFF_${r}_${h}.txt
		done
	done
done

###############################################################
# fALFF 
for s in ${subj[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_stdfALFF.txt)" >> ${compare_path}/allSubs_stdfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_stdfALFF_${r}.txt)" >> ${compare_path}/allSubs_stdfALFF_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_stdfALFF_${r}_${h}.txt)" >> ${compare_path}/allSubs_stdfALFF_${r}_${h}.txt
		done
	done
done


###############################################################
# REPEAT FOR REGION_GM
mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/GM_roi
GM_compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/GM_roi"

###############################################################
# ALFF 
for s in ${subj[@]}; do

	for r in ${region_GM[@]}; do
		echo "$(<${analysis_path}/ALFF/GM/${r}/${s}/${s}_stdALFF_${r}.txt)" >> ${GM_compare_path}/GM_allSubs_stdALFF_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/GM/${r}/${s}/${s}_stdALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allSubs_stdALFF_${r}_${h}.txt
		done
	done
done

###############################################################
# fALFF 
for s in ${subj[@]}; do

	for r in ${region_GM[@]}; do
		echo "$(<${analysis_path}/fALFF/GM/${r}/${s}/${s}_stdfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allSubs_stdfALFF_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/GM/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allSubs_meanfALFF_${r}_${h}.txt
		done
	done
done