#!/bin/bash

# This script is to get the mean time series

get_meanTS () {
	data_path="/Volumes/gdrive4tb/IGNITE"; s=$1
	preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
	vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
	mask_path="/Volumes/gdrive4tb/IGNITE/mask"
	log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

	mkdir -p ${vol_path}/meanTimeSeries/filt_0.01-0.1/wholeBrain/${s}
	mkdir -p ${vol_path}/meanTimeSeries/filt_0.01-0.1_smoothed/wholeBrain/${s}
	mkdir -p ${vol_path}/meanTimeSeries/filt_0-0.25/wholeBrain/${s}
	mkdir -p ${vol_path}/meanTimeSeries/filt_0-0.25_smoothed/wholeBrain/${s}

	meanTS_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries"

	###############################################################
	# Get the mean TS for the entire brain for both filtering conditions

	##################################
	# filt_0.01-0.1
	fslmeants \
	-i ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
	-o ${meanTS_path}/filt_0.01-0.1/wholeBrain/${s}/${s}_preprocessed_psc_filt01_meanTS.txt

	fslmeants \
	-i ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz \
	-o ${meanTS_path}/filt_0.01-0.1_smoothed/wholeBrain/${s}/${s}_preprocessed_psc_filt01_smoothed_meanTS.txt

	# Checkpoint to get the mean TS for the entire brain for filt_0.01-0.1
		echo "${s} get the mean TS for the entire brain for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

	##################################
	# filt_0-0.25
	fslmeants \
	-i ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz \
	-o ${meanTS_path}/filt_0-0.25/wholeBrain/${s}/${s}_preprocessed_psc_filt025_meanTS.txt

	fslmeants \
	-i ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz \
	-o ${meanTS_path}/filt_0-0.25_smoothed/wholeBrain/${s}/${s}_preprocessed_psc_filt025_smoothed_meanTS.txt

	# Checkpoint to get the mean TS for the entire brain for filt_0-0.25
		echo "${s} get the mean TS for the entire brain for filt_0-0.25 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

	###############################################################
	# Get mean TS for different brain regions including each hemispheres for both filtering conditions
	region=(AC HG PT MGB V1 thalamus)
	hemi=(lh rh)

	for r in ${region[@]}; do
		mkdir -p ${meanTS_path}/filt_0.01-0.1/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0.01-0.1_smoothed/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0-0.25/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0-0.25_smoothed/${r}/${s}

		##################################
		# filt_0.01-0.1
		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
		-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin \
		-o ${meanTS_path}/filt_0.01-0.1/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}.txt

		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz \
		-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin \
		-o ${meanTS_path}/filt_0.01-0.1_smoothed/${r}/${s}/${s}_preprocessed_psc_filt01_smoothed_meanTS_${r}.txt

		# Checkpoint to get the mean TS for different regions for filt_0.01-0.1
		echo "${s} get the mean TS for the ${r} for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

		##################################
		# filt_0-0.25
		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz \
		-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin \
		-o ${meanTS_path}/filt_0-0.25/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}.txt

		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz \
		-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_bin \
		-o ${meanTS_path}/filt_0-0.25_smoothed/${r}/${s}/${s}_preprocessed_psc_filt025_smoothed_meanTS_${r}.txt

		# Checkpoint to get the mean TS for different regions for filt_0-0.25
		echo "${s} get the mean TS for the ${r} for filt_0-0.25 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

		##################################
		# For each hemispheres
		for h in ${hemi[@]}; do
			##################################
			# filt_0.01-0.1
			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
			-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin \
			-o ${meanTS_path}/filt_0.01-0.1/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}_${h}.txt

			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz \
			-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin \
			-o ${meanTS_path}/filt_0.01-0.1_smoothed/${r}/${s}/${s}_preprocessed_psc_filt01_smoothed_meanTS_${r}_${h}.txt

			# Checkpoint to get the mean TS for different regions and hemispheres for filt_0.01-0.1
		echo "${s} get the mean TS for the ${r} on ${h} for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

			##################################
			# filt_0-0.25
			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz \
			-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin \
			-o ${meanTS_path}/filt_0-0.25/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}_${h}.txt

			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz \
			-m ${mask_path}/${r}/func_mask/${s}/${s}_${r}mask2func_${h}_bin \
			-o ${meanTS_path}/filt_0-0.25_smoothed/${r}/${s}/${s}_preprocessed_psc_filt025_smoothed_meanTS_${r}_${h}.txt

			# Checkpoint to get the mean TS for different regions and hemispheres for filt_0-0.25
		echo "${s} get the mean TS for the ${r} on ${h} for filt_0-0.25 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt
		done
	done

	###############################################################
	# Get mean TS for different brain regions including each hemispheres for both filtering conditions but specifically in the grey matter

	region_GM=(AC HG PT V1)
	hemi=(lh rh)

	for r in ${region_GM[@]}; do
		mkdir -p ${meanTS_path}/filt_0.01-0.1/GM/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0.01-0.1_smoothed/GM/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0-0.25/GM/${r}/${s}
		mkdir -p ${meanTS_path}/filt_0-0.25_smoothed/GM/${r}/${s}

		##################################
		# filt_0.01-0.1
		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
		-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz \
		-o ${meanTS_path}/filt_0.01-0.1/GM/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}_GM.txt

		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz \
		-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz \
		-o ${meanTS_path}/filt_0.01-0.1_smoothed/GM/${r}/${s}/${s}_preprocessed_psc_filt01_smoothed_meanTS_${r}_GM.txt

		# Checkpoint to get the mean TS for different regions for filt_0.01-0.1 in GM
		echo "${s} get the mean TS for the ${r} grey matter for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

		##################################
		# filt_0-0.25
		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz \
		-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz \
		-o ${meanTS_path}/filt_0-0.25/GM/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}_GM.txt

		fslmeants \
		-i ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz \
		-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}.nii.gz \
		-o ${meanTS_path}/filt_0-0.25_smoothed/GM/${r}/${s}/${s}_preprocessed_psc_filt025_smoothed_meanTS_${r}_GM.txt

		# Checkpoint to get the mean TS for different regions for filt_0-0.25 in GM
		echo "${s} get the mean TS for the ${r} grey matter for filt_0-0.25 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

		##################################
		# For each hemispheres
		for h in ${hemi[@]}; do
			##################################
			# filt_0.01-0.1
			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0.01-0.1/${s}/${s}_preprocessed_psc_filt01.nii.gz \
			-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz \
			-o ${meanTS_path}/filt_0.01-0.1/GM/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}_${h}_GM.txt

			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0.01-0.1_smoothed/${s}/${s}_preprocessed_psc_filt01_smoothed.nii.gz \
			-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz \
			-o ${meanTS_path}/filt_0.01-0.1_smoothed/GM/${r}/${s}/${s}_preprocessed_psc_filt01_smoothed_meanTS_${r}_${h}_GM.txt

			# Checkpoint to get the mean TS for different regions for filt_0.01-0.1 in GM
		echo "${s} get the mean TS for the ${r} on ${h} grey matter for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt

			##################################
			# filt_0-0.25
			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0-0.25/${s}/${s}_preprocessed_psc_filt025.nii.gz \
			-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz \
			-o ${meanTS_path}/filt_0-0.25/GM/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}_${h}_GM.txt

			fslmeants \
			-i ${vol_path}/temporalFiltering/filt_0-0.25_smoothed/${s}/${s}_preprocessed_psc_filt025_smoothed.nii.gz \
			-m ${mask_path}/ROIsegmentation/gm/${r}/${s}/${s}_gm_funcMask_${r}_${h}.nii.gz \
			-o ${meanTS_path}/filt_0-0.25_smoothed/GM/${r}/${s}/${s}_preprocessed_psc_filt025_smoothed_meanTS_${r}_${h}_GM.txt

			# Checkpoint to get the mean TS for different regions for filt_0.01-0.1 in GM
		echo "${s} get the mean TS for the ${r} on ${h} grey matter for filt_0.01-0.1 has been done" >> ${log_path}/3e_getMeanTS_LOG.txt
		done
	done

}



# Exports the function
export -f get_meanTS

# Create an array with subjects (as they are in preprocessed folder)
s=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 6 'get_meanTS {1}' ::: ${s[@]}