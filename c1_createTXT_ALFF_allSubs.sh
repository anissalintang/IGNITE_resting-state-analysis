#!/bin/bash

# Create text file for mean (f)ALFF and (f)ALFF of the mean for all subjects + in region_GM 

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"

region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)
hemi=(lh rh)

mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF
compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF"

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

###############################################################
# ALFF 
for s in ${subj[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/allSubs_meanALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/allSubs_meanALFF_${r}.txt

		echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/allSubs_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/allSubs_meanALFF_${r}_${h}.txt
		done
	done
done

###############################################################
# fALFF 
for s in ${subj[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allSubs_meanfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allSubs_meanfALFF_${r}.txt

		echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allSubs_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allSubs_meanfALFF_${r}_${h}.txt
		done
	done
done


###############################################################
# REPEAT FOR REGION_GM
mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF/GM_roi
GM_compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF/GM_roi"

###############################################################
# ALFF 
for s in ${subj[@]}; do

	for r in ${region_GM[@]}; do
		echo "$(<${analysis_path}/ALFF/GM/${r}/${s}/${s}_meanALFF_${r}_GM.txt)" >> ${GM_compare_path}/GM_allSubs_meanALFF_${r}.txt

		#echo "$(<${analysis_path}/ALFF_mean_matlab/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allSubs_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/GM/${r}/${s}/${s}_meanALFF_${r}_${h}_GM.txt)" >> ${GM_compare_path}/GM_allSubs_meanALFF_${r}_${h}.txt
		done
	done
done

###############################################################
# fALFF 
for s in ${subj[@]}; do

	for r in ${region_GM[@]}; do
		echo "$(<${analysis_path}/fALFF/GM/${r}/${s}/${s}_meanfALFF_${r}_GM.txt)" >> ${GM_compare_path}/GM_allSubs_meanfALFF_${r}.txt

		#echo "$(<${analysis_path}/fALFF_mean_matlab/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allSubs_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/GM/${r}/${s}/${s}_meanfALFF_${r}_${h}_GM.txt)" >> ${GM_compare_path}/GM_allSubs_meanfALFF_${r}_${h}.txt
		done
	done
done