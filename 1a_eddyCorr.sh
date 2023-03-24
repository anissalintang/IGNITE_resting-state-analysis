#!/bin/bash

# Volumetric data processing script
eddy_correction() {
	data_path="$HOME/IGNITE_sample";s=$1
	vol_path="$HOME/IGNITE_sample/volumetric"

	# Create EDDY correction folder
	mkdir -p ${data_path}/preprocessed/$s/EDDY

	#Slice timing correction
	##Selects the repetition time from the file header, using the fslhd function with grep
	##If using z-shell uses tr=${line[2]}
	##If using bash tr=${line[1]}
	##pixdim4 refers to the parameter which describes the repetition time
	# line=($(fslhd ${data_path}/preprocessed/$s/${s}_preprocessed.nii.gz | grep pixdim4)); tr=${line[1]}

	# ## Our fMRI data was acquired using multiband EPI, thus the slice timing would be different
	# ##Create a single-column file of slice timing order taken from the json files
	# ### Get all 54 lines starting with "SliceTiming"
	# grep -A54 '"SliceTiming"' ${data_path}/nifti/$s/*fMRI_2mm*.json | grep "[0-9]*" > ${data_path}/nifti/$s/rawSliceTiming.txt
	# ### Print all the numbers, and essentially removed the string, in this case the "SliceTiming"
	# awk '{print $0+0}' ${data_path}/nifti/$s/rawSliceTiming.txt > ${data_path}/nifti/$s/tempSliceTiming.txt
	# ### Remove the first 0 that was created from the awk step above
	# tail -n +2 ${data_path}/nifti/$s/tempSliceTiming.txt > ${data_path}/preprocessed/$s/SliceTimingOrder.txt

	# ## Remove temporary files
	# rm ${data_path}/nifti/$s/rawSliceTiming.txt ${data_path}/nifti/$s/tempSliceTiming.txt


	##Generating index, bval, bvec files
	dimt=$(fslval ${data_path}/preprocessed/$s/${s}_preprocessed.nii.gz dim4)
	for ((i=0; i<${dimt}; i++))
	do
		if (($i == "${dimt} - 1 ")); then
			printf "2" >> ${data_path}/preprocessed/$s/EDDY/index.txt
			printf "0" >> ${data_path}/preprocessed/$s/EDDY/${s}_preprocessed.bvals
		else
			printf "1" >> ${data_path}/preprocessed/$s/EDDY/index.txt
			printf "0" >> ${data_path}/preprocessed/$s/EDDY/${s}_preprocessed.bvals
		fi
	done

	for (( i=0; i<3; i++ ))
	do
		for (( j=0; j<${dimt}; j++ ))
		do
			if (( $j == "${dimt} - 1" )); then
				if [ $i == 0 ]; then
					printf "1"
				else
					printf "0"
				fi
			else
				if [ $i == 0 ]; then
					printf "1"
				else
					printf "0"
				fi
			fi
		done
		printf '\n'

	done >> ${data_path}/preprocessed/$s/EDDY/${s}_preprocessed.bvecs

	# Perform EDDY current correction
	eddy --imain=${data_path}/preprocessed/$s/${s}_preprocessed.nii.gz \
	--mask=${data_path}/preprocessed/$s/meanBeforeFilter/bet/${s}_mean_func_bet_mask.nii.gz \
	--index=${data_path}/preprocessed/$s/EDDY/index.txt \
	--acqp=${data_path}/preprocessed/$s/topUp/fmap/acqparam.txt \
	--bvecs=${data_path}/preprocessed/$s/EDDY/${s}_preprocessed.bvecs \
	--bvals=${data_path}/preprocessed/$s/EDDY/${s}_preprocessed.bvals \
	--topup=${data_path}/preprocessed/${s}/topUp/topUpResults/${s}_topUp_results \
	--out=${data_path}/preprocessed/$s/EDDY/${s}_preprocessed_eddy.nii.gz \
	--mb=6 \
	--verbose

}


# Exports the function
export -f eddy_correction

# Create an array with subjects (as they are in nifti folder)
s=($(ls $HOME/IGNITE_sample/nifti))

# Check the content of the subject array
echo ${s[@]}

# Run the analysis in parallel using GNU parallel
# Jobs is set to 0, which allows parallel to assign the jobs as it sees fit, and divide it across the CPUs itself
# Provide it with the name of the function, and specify it will take one argument, then provide this after the three colons

parallel --jobs 0 'eddy_correction {1}' ::: ${s[@]}