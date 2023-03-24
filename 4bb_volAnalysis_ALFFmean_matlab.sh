#!/bin/bash

# This script will calculate ALFF and fALFF of the mean time series, using a matlab function built for this

data_path="/Volumes/gdrive4tb/IGNITE";s=$1
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"

subj=($(ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed))

mkdir -p ${analysis_path}/ALFFmean
mkdir -p ${analysis_path}/ALFFmean

region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)

for s in ${subj[@]}; do
	#ALFF
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/ALFFmean/${r}/${s}
		matlab -batch "cd('/Volumes/gdrive4tb/IGNITE/code/resting-state'); MTS_ALFF('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0.01-0.1/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}.txt', 'ALFF', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt')" -nojvm

		# Checkpoint for taking ALFF of mean time series
	echo "${s} ALFF of meanTimeSeries from ${r} has been performed in matlab" >> ${log_path}/4b_volAnalysis_ALFFmean_matlab_LOG.txt
	done

	#fALFF
	for r in ${region[@]}; do
		mkdir -p ${analysis_path}/fALFFmean/${r}/${s}
		matlab -batch "cd('/Volumes/gdrive4tb/IGNITE/code/resting-state'); MTS_ALFF('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0.01-0.1/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}.txt', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0-0.25/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}.txt', 'fALFF', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt')" -nojvm

		# Checkpoint for taking fALFF of mean time series
	echo "${s} fALFF of meanTimeSeries from ${r} has been performed in matlab" >> ${log_path}/4b_volAnalysis_ALFFmean_matlab_LOG.txt
	done

	###############################################################
	# For the GM mask
	###############################################################
	#ALFF
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/ALFFmean/GM/${r}/${s}
		matlab -batch "cd('/Volumes/gdrive4tb/IGNITE/code/resting-state'); MTS_ALFF('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0.01-0.1/GM/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}_GM.txt', 'ALFF', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/ALFFmean/GM/${r}/${s}/${s}_ALFFofMean_${r}_GM.txt')" -nojvm

		# Checkpoint for taking ALFF of mean time series
	echo "${s} ALFF of meanTimeSeries from ${r} GM has been performed in matlab" >> ${log_path}/4b_volAnalysis_ALFFmean_matlab_LOG.txt
	done

	#fALFF
	for r in ${region_GM[@]}; do
		mkdir -p ${analysis_path}/fALFFmean/GM/${r}/${s}
		matlab -batch "cd('/Volumes/gdrive4tb/IGNITE/code/resting-state'); MTS_ALFF('/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0.01-0.1/GM/${r}/${s}/${s}_preprocessed_psc_filt01_meanTS_${r}_GM.txt', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/meanTimeSeries/filt_0-0.25/GM/${r}/${s}/${s}_preprocessed_psc_filt025_meanTS_${r}_GM.txt', 'fALFF', '/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/fALFFmean/GM/${r}/${s}/${s}_fALFFofMean_${r}_GM.txt')" -nojvm

		# Checkpoint for taking fALFF of mean time series
	echo "${s} fALFF of meanTimeSeries from ${r} GM has been performed in matlab" >> ${log_path}/4b_volAnalysis_ALFFmean_matlab_LOG.txt
	done
done
