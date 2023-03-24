#!/bin/bash

# This script will calculate ReHo, using AFNI

calc_reho () {
    data_path="/Volumes/gdrive4tb/IGNITE";s=$1
    preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
    vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
    log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
    analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
    mask_path="/Volumes/gdrive4tb/IGNITE/mask"

    mkdir -p ${analysis_path}/ReHo
    reho_path="${analysis_path}/ReHo"

    region=(AC HG PT MGB V1 thalamus)
    region_GM=(AC HG PT V1)

    neighbourhood=(7 19 27)

    # ReHo calculation

    mkdir -p ${reho_path}/wholeBrain/${s}/
    for n in ${neighbourhood[@]}; do
        3dReHo \
        -prefix ${reho_path}/wholeBrain/${s}/${s}_ReHo_${n}.nii.gz \
        -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
        -nneigh ${n}

        # Checkpoint for calculating ReHo from whole brain
    echo "${s} ReHo with ${n} kernel for wholeBrain has been calculated" >> ${log_path}/4c_volAnalysis_ReHo_LOG.txt
            
        for r in ${region[@]}; do   
            mkdir -p ${reho_path}/${r}/${s}
            3dReHo \
            -prefix ${reho_path}/${r}/${s}/${s}_ReHo_${n}_${r}.nii.gz \
            -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
            -nneigh ${n} \
            -mask ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin.nii.gz

            fslstats ${reho_path}/${r}/${s}/${s}_ReHo_${n}_${r}.nii.gz -M > ${reho_path}/${r}/${s}/${s}_meanReHo_${n}_${r}.txt

            # Checkpoint for calculating ReHo from all regions
    echo "${s} ReHo with ${n} kernel for ${r} has been calculated" >> ${log_path}/4c_volAnalysis_ReHo_LOG.txt

        done

        for r in ${region_GM[@]}; do   
            mkdir -p ${reho_path}/GM/${r}/${s}
            3dReHo \
            -prefix ${reho_path}/GM/${r}/${s}/${s}_ReHo_${n}_${r}_GM.nii.gz \
            -inset ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
            -nneigh ${n} \
            -mask ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz

            fslstats ${reho_path}/GM/${r}/${s}/${s}_ReHo_${n}_${r}_GM.nii.gz -M > ${reho_path}/GM/${r}/${s}/${s}_meanReHo_${n}_${r}_GM.txt

            # Checkpoint for calculating ReHo from all regions
    echo "${s} ReHo with ${n} kernel for ${r} GM has been calculated" >> ${log_path}/4c_volAnalysis_ReHo_LOG.txt
        done
    done

}

# Exports the function
export -f calc_reho

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'calc_reho {1}' ::: ${s[@]}