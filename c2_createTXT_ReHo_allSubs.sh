#!/bin/bash

# Create text file for ReHo in different neighbourhood for all subjects + in region_GM 

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"

region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)
hemi=(lh rh)
neighbourhood=(7 19 27)

mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ReHo
compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ReHo"

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

###############################################################
# ReHo
for s in ${subj[@]}; do

	for n in ${neighbourhood[@]}; do

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ReHo/${r}/${s}/${s}_meanReHo_${n}_${r}.txt)" >> ${compare_path}/allSubs_meanReHo_${n}_${r}.txt
		done
	done
done


###############################################################
# REPEAT FOR REGION_GM
mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ReHo/GM_roi
GM_compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ReHo/GM_roi"

###############################################################
for s in ${subj[@]}; do

	for n in ${neighbourhood[@]}; do

		for r in ${region_GM[@]}; do
			echo "$(<${analysis_path}/ReHo/GM/${r}/${s}/${s}_meanReHo_${n}_${r}_GM.txt)" >> ${GM_compare_path}/GM_allSubs_meanReHo_${n}_${r}.txt
		done
	done
done
