#!/bin/bash

# This script will calculate ALFF and fALFF of the mean time series, using a matlab function built for this

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
alff_matlab_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/ALFF_mean_matlab"

#subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))
subj=(IGNTFA_00065)

region=(AC HG PT V1)

echo "All subjects Whole Brain ALFF (alternative calculation)"
cat ${alff_matlab_path}/Whole_Brain/AllSubs_ALFFofMean_wholeBrain.txt

for r in ${region[@]}; do
    echo "All subjects ${r} ALFF (alternative calculation)"
    ${alff_matlab_path}/${r}/AllSubs_ALFFofMean_${r}.txt
done

for r in ${region[@]}; do
    echo "All subjects ${r} ALFF (alternative calculation)"
    ${alt_analysis_path}/ALFF/${r}/allsubs-${c}-MTS-ALFF-${r}.txt
done