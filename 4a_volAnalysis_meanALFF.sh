#!/bin/bash

# Calculate ALFF and fALFF in volumetric space (UN-SMOOTHED functional data version)
vol_meanALFF() {

	mkdir -p /Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis

	data_path="/Volumes/gdrive4tb/IGNITE";s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
	analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"

	hemi=(lh rh)
	region=(AC HG PT MGB V1 thalamus)
	region_GM=(AC HG PT V1)

	###############################################################
	# ALFF calculation

	##########################################
	# Whole brain
	mkdir -p ${analysis_path}/ALFF/wholeBrain/${s}/

	fslmaths ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz -Tstd ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF

	fslstats ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -M > ${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt

	fslstats ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -S > ${analysis_path}/ALFF/wholeBrain/${s}/${s}_stdALFF.txt

	# Checkpoint for ALFF calculation for whole brain
	echo "${s} ALFF for whole brain has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt

	##########################################
	# All regions
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/ALFF/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}

	fslstats ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r} -M > ${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt

	fslstats ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r} -S > ${analysis_path}/ALFF/${r}/${s}/${s}_stdALFF_${r}.txt
	done

	# and mask for each hemispheres
	for r in ${region[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h}

			fslstats ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h} -M > ${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt

			fslstats ${analysis_path}/ALFF/${r}/${s}/${s}_ALFF_${r}_${h} -S > ${analysis_path}/ALFF/${r}/${s}/${s}_stdALFF_${r}_${h}.txt

		done
	done


	# Checkpoint for ALFF calculation for all regions
	echo "${s} ALFF for all regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt


	###############################################################
	# fALFF calculation
	## Step 1 - calculate ALFF from filt_0-0.25
	## Step 2 - divide ALFF (filt_0.01-0.1) by ALFF (filt0-0.25)

	##########################################
	# Whole brain
	mkdir -p ${analysis_path}/fALFF/wholeBrain/${s}/

	fslmaths ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz -Tstd ${analysis_path}/fALFF/wholeBrain/${s}/${s}_ALFF_025

	fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -div ${analysis_path}/fALFF/wholeBrain/${s}/${s}_ALFF_025 ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF

	fslstats ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -M > ${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt

	fslstats ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -S > ${analysis_path}/fALFF/wholeBrain/${s}/${s}_stdfALFF.txt

	# Checkpoint for fALFF calculation for whole brain
	echo "${s} fALFF for whole brain has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt

	##########################################
	# All regions
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/fALFF/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}

	fslstats ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r} -M > ${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt

	fslstats ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r} -S > ${analysis_path}/fALFF/${r}/${s}/${s}_stdfALFF_${r}.txt
	done

	# and mask for each hemispheres
	for r in ${region[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h}

			fslstats ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h} -M > ${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt

			fslstats ${analysis_path}/fALFF/${r}/${s}/${s}_fALFF_${r}_${h} -S > ${analysis_path}/fALFF/${r}/${s}/${s}_stdfALFF_${r}_${h}.txt

		done
	done

	# Checkpoint for fALFF calculation for all regions
	echo "${s} fALFF for all regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt

	###############################################################
	##########################################
	##########################################
	# Repeat the above now for GM masks
	##########################################
	##########################################

	###############################################################
	# ALFF calculation

	##########################################
	# All regions
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/ALFF/GM/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM

	fslstats ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM -M > ${analysis_path}/ALFF/GM/${r}/${s}/${s}_meanALFF_${r}_GM.txt

	fslstats ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM -S > ${analysis_path}/ALFF/GM/${r}/${s}/${s}_stdALFF_${r}_GM.txt
	done

	# and mask for each hemispheres
	for r in ${region_GM[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_${h}_GM

			fslstats ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_${h}_GM -M > ${analysis_path}/ALFF/GM/${r}/${s}/${s}_meanALFF_${r}_${h}_GM.txt

			fslstats ${analysis_path}/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_${h}_GM -S > ${analysis_path}/ALFF/GM/${r}/${s}/${s}_stdALFF_${r}_${h}_GM.txt

		done
	done

	# Checkpoint for ALFF calculation for all regions
	echo "${s} ALFF for all regions in GM mask has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt


	###############################################################
	# fALFF calculation
	## Step 1 - calculate ALFF from filt_0-0.25
	## Step 2 - divide ALFF (filt_0.01-0.1) by ALFF (filt0-0.25)

	##########################################
	# All regions
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/fALFF/GM/${r}/${s}/

	# Mask ALFF for the auditory regions
	fslmaths ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM

	fslstats ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM -M > ${analysis_path}/fALFF/GM/${r}/${s}/${s}_meanfALFF_${r}_GM.txt

	fslstats ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM -S > ${analysis_path}/fALFF/GM/${r}/${s}/${s}_stdfALFF_${r}_GM.txt
	done

	# and mask for each hemispheres
	for r in ${region_GM[@]}; do
		for h in ${hemi[@]}; do
			fslmaths ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_${h}_GM

			fslstats ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_${h}_GM -M > ${analysis_path}/fALFF/GM/${r}/${s}/${s}_meanfALFF_${r}_${h}_GM.txt

			fslstats ${analysis_path}/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_${h}_GM -S > ${analysis_path}/fALFF/GM/${r}/${s}/${s}_stdfALFF_${r}_${h}_GM.txt

		done
	done
	# Checkpoint for fALFF calculation for all regions
	echo "${s} fALFF for all regions in GM mask has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt

}

# Exports the function
export -f vol_meanALFF

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'vol_meanALFF {1}' ::: ${s[@]}

##########################################
##########################################
### Create a Z-Transformed version of ALFF and fALFF

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"

hemi=(lh rh)
region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))


for s in ${subj[@]}; do
    mkdir -p ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}
    mkdir -p ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}

    ##########################################
	# Create a Z-Transformed version of ALFF
	meanALFF=($(fslstats ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz -M))
    stdALFF=($(fslstats ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz -S))
        
    fslmaths ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF.nii.gz -sub ${meanALFF} ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz
        
    fslmaths ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz -div ${stdALFF} ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz
        
   	fslstats ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz -M > ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Zmean.txt

   	# Checkpoint for Z-Transformed version of ALFF
	echo "${s} Z-Transformed version of ALFF has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt
        
    ##########################################
    # Create a Z-Transformed version of fALFF
    meanfALFF=($(fslstats ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz -M))
    stdfALFF=($(fslstats ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz -S))
        
    fslmaths ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF.nii.gz -sub ${meanfALFF} ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz
        
    fslmaths ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz -div ${stdfALFF} ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz
        
    fslstats ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz -M > ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Zmean.txt

    # Checkpoint for Z-Transformed version of fALFF
	echo "${s} Z-Transformed version of fALFF has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt
       
    ##########################################
  	# Masked ALFF and fALFF for the all regions
    for r in ${region[@]}; do
	    mkdir -p ${analysis_path}/Z-Transformed/ALFF/${r}/${s}
	    mkdir -p ${analysis_path}/Z-Transformed/fALFF/${r}/${s}

	    # ALFF
	    fslmaths ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/Z-Transformed/ALFF/${r}/${s}/${s}_ALFF_${r}_Z.nii.gz
	        
	    fslstats ${analysis_path}/Z-Transformed/ALFF/${r}/${s}/${s}_ALFF_${r}_Z.nii.gz -M > ${analysis_path}/Z-Transformed/ALFF/${r}/${s}/${s}_ALFF_${r}_Zmean.txt
	        
	    #fALFF
	    fslmaths ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz -mas ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin ${analysis_path}/Z-Transformed/fALFF/${r}/${s}/${s}_fALFF_${r}_Z.nii.gz
	        
	    fslstats ${analysis_path}/Z-Transformed/fALFF/${r}/${s}/${s}_fALFF_${r}_Z.nii.gz -M > ${analysis_path}/Z-Transformed/fALFF/${r}/${s}/${s}_fALFF_${r}_Zmean.txt

    done

    # Checkpoint for Z-Transformed version of ALFF and fALFF for all regions
	echo "${s} Z-Transformed version of ALFF and fALFF for all regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt
       
    ##########################################
   	# Masked ALFF for GM regions
    for r in ${region_GM[@]}; do
    	mkdir -p ${analysis_path}/Z-Transformed/ALFF/GM/${r}/${s}
        mkdir -p ${analysis_path}/Z-Transformed/fALFF/GM/${r}/${s}

        #ALFF
        fslmaths ${analysis_path}/Z-Transformed/ALFF/wholeBrain/${s}/${s}_ALFF_Z.nii.gz -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/Z-Transformed/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM_Z.nii.gz

        fslstats ${analysis_path}/Z-Transformed/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM_Z.nii.gz -M > ${analysis_path}/Z-Transformed/ALFF/GM/${r}/${s}/${s}_ALFF_${r}_GM_Zmean.txt
    
    	#fALFF
        fslmaths ${analysis_path}/Z-Transformed/fALFF/wholeBrain/${s}/${s}_fALFF_Z.nii.gz -mas ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz ${analysis_path}/Z-Transformed/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM_Z.nii.gz

        fslstats ${analysis_path}/Z-Transformed/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM_Z.nii.gz -M > ${analysis_path}/Z-Transformed/fALFF/GM/${r}/${s}/${s}_fALFF_${r}_GM_Zmean.txt
    done

    # Checkpoint for Z-Transformed version of ALFF and fALFF for all GM regions
	echo "${s} Z-Transformed version of ALFF and fALFF for all GM regions has been calculated" >> ${log_path}/4a_volAnalysis_meanALFF_LOG.txt
done

