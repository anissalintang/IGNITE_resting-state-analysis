#!/bin/bash

# Create text file for mean (f)ALFF and (f)ALFF of the mean for all subjects + in region_GM 

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"
compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF"

region=(AC HG PT MGB V1 thalamus)
region_GM=(AC HG PT V1)
hemi=(lh rh)



sub_tin_HL_orig=(IGTTAJ_00061 IGTTBA_00003 IGTTGA_00005 IGTTMD_00004 IGTTSJ_00007 IGTTJG_00008 IGTTJI_00009 IGTTBC_00014 IGTTCP_00020 IGTTSM_00028 IGTTPG_00055 IGTTPP_00040 IGTTRE_00043 IGTTKK_00041 IGTTPS_00044 IGTTMD_00029 IGTTDA_00063 IGTTHG_00064 IGTTMD_00076 IGNTFJ_00015 IGTTAS_00062)
for s in ${sub_tin_HL_orig[@]}; do
	if ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed/${s} 1> /dev/null 2>&1; then
        echo "sub_tin_HL_orig exists for ${s}"
    else 
        echo "sub_tin_HL_orig does NOT exist for ${s}"
    fi
done
sub_tin_HL=(IGTTAJ_00061 IGTTBA_00003 IGTTMD_00004 IGTTSJ_00007 IGTTJG_00008 IGTTJI_00009 IGTTBC_00014 IGTTSM_00028 IGTTPG_00055 IGTTPP_00040 IGTTRE_00043 IGTTKK_00041 IGTTPS_00044 IGTTMD_00029 IGTTDA_00063 IGTTHG_00064 IGTTMD_00076 IGNTFJ_00015 IGTTAS_00062)

###############################################################

sub_tin_NH_orig=(IGTTLC_00002 IGTTRK_00006 IGTTCW_00010 IGTTKA_00017 IGTTSM_00050 IGTTHA_00042 IGTTSM_00058 IGTTMG_00032 IGTTHA_00070 IGTTWL_00073 IGTTFJ_00074 IGTTBA_00052)

for s in ${sub_tin_NH_orig[@]}; do
	if ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed/${s} 1> /dev/null 2>&1; then
        echo "sub_tin_NH_orig exists for ${s}"
    else 
        echo "sub_tin_NH_orig does NOT exist for ${s}"
    fi
done
sub_tin_NH=(IGTTLC_00002 IGTTRK_00006 IGTTCW_00010 IGTTKA_00017 IGTTSM_00050 IGTTHA_00042 IGTTSM_00058 IGTTMG_00032 IGTTHA_00070 IGTTWL_00073 IGTTBA_00052)

###############################################################

sub_HL_orig=(IGNTEP_00023 IGNTMA_00025 IGNTFB_00027 IGNTBP_00072 IGNTHS_00068)
for s in ${sub_HL_orig[@]}; do
	if ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed/${s} 1> /dev/null 2>&1; then
        echo "sub_HL_orig exists for ${s}"
    else 
        echo "sub_HL_orig does NOT exist for ${s}"
    fi
done
sub_HL=(IGNTEP_00023 IGNTMA_00025 IGNTFB_00027 IGNTBP_00072 IGNTHS_00068)

###############################################################

sub_NH_orig=(IGNTCJ_00018 IGNTQI_00033 IGNTGS_00049 IGNTIV_00045 IGNTNF_00054 IGNTMN_00051 IGNTOH_00059 IGNTFM_00060 IGNTFA_00065 IGNTCK_00066 IGNTCE_00067 IGNTLX_00069 IGNTBR_00075 IGNTPO_00071)
for s in ${sub_NH_orig[@]}; do
	if ls /Volumes/gdrive4tb/IGNITE/resting-state/preprocessed/${s} 1> /dev/null 2>&1; then
        echo "sub_NH_orig exists for ${s}"
    else 
        echo "sub_NH_orig does NOT exist for ${s}"
    fi
done
sub_NH=(IGNTCJ_00018 IGNTQI_00033 IGNTGS_00049 IGNTIV_00045 IGNTNF_00054 IGNTMN_00051 IGNTOH_00059 IGNTFM_00060 IGNTFA_00065 IGNTCK_00066 IGNTLX_00069 IGNTBR_00075 IGNTPO_00071)

###############################################################

sub_allHL=(${sub_tin_HL[@]} ${sub_HL[@]})
sub_allNH=(${sub_tin_NH[@]} ${sub_NH[@]})

# ###############################################################
# ALFF for sub_allHL
for s in ${sub_allHL[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/allHL_meanALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/allHL_meanALFF_${r}.txt

		echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/allHL_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/allHL_meanALFF_${r}_${h}.txt
		done
	done
done

# ###############################################################
# ALFF for sub_allNH
for s in ${sub_allNH[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/allNH_meanALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/allNH_meanALFF_${r}.txt

		echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/allNH_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/allNH_meanALFF_${r}_${h}.txt
		done
	done
done


	###############################################################
	# Extracted ALFF for all 4 types of subjects
	# ###############################################################
	# ALFF for sub_tin_HL
	for s in ${sub_tin_HL[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/subTinHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/subTinHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/subTinHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/subTinHL_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_tin_NH
	for s in ${sub_tin_NH[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/subTinNH_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/subTinNH_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/subTinNH_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/subTinNH_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_HL
	for s in ${sub_HL[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/subHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/subHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/subHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/subHL_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_NH
	for s in ${sub_NH[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${compare_path}/subNH_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${compare_path}/subNH_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${compare_path}/subNH_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${compare_path}/subNH_meanALFF_${r}_${h}.txt
			done
		done
	done

###############################################################
###############################################################
###############################################################
# fALFF for sub_allHL
for s in ${sub_allHL[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allHL_meanfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allHL_meanfALFF_${r}.txt

		echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allHL_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allHL_meanfALFF_${r}_${h}.txt
		done
	done
done

# ###############################################################
# fALFF for sub_allNH
for s in ${sub_allNH[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allNH_meanfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allNH_meanfALFF_${r}.txt

		echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allNH_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allNH_meanfALFF_${r}_${h}.txt
		done
	done
done


	###############################################################
	# Extracted fALFF for all 4 types of subjects
	# ###############################################################
	# fALFF for sub_tin_HL
	for s in ${sub_tin_HL[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_tin_NH
	for s in ${sub_tin_NH[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_HL
	for s in ${sub_HL[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_NH
	for s in ${sub_NH[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${compare_path}/allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${compare_path}/allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${compare_path}/allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

# ###############################################################
# REPEAT FOR REGION_GM
GM_compare_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis/comparison/ALFF/GM_roi"

# ###############################################################
# ALFF for sub_allHL
for s in ${sub_allHL[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allHL_meanALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allHL_meanALFF_${r}.txt

		echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allHL_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allHL_meanALFF_${r}_${h}.txt
		done
	done
done

# ###############################################################
# ALFF for sub_allNH
for s in ${sub_allNH[@]}; do
	echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allNH_meanALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allNH_meanALFF_${r}.txt

		echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allNH_ALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allNH_meanALFF_${r}_${h}.txt
		done
	done
done


	###############################################################
	# Extracted ALFF for all 4 types of subjects
	# ###############################################################
	# ALFF for sub_tin_HL
	for s in ${sub_tin_HL[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_tin_NH
	for s in ${sub_tin_NH[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_HL
	for s in ${sub_HL[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# ALFF for sub_NH
	for s in ${sub_NH[@]}; do
		echo "$(<${analysis_path}/ALFF/wholeBrain/${s}/${s}_meanALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}.txt

			echo "$(<${analysis_path}/ALFFmean/${r}/${s}/${s}_ALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_ALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/ALFF/${r}/${s}/${s}_meanALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanALFF_${r}_${h}.txt
			done
		done
	done

###############################################################
###############################################################
###############################################################
# fALFF for sub_allHL
for s in ${sub_allHL[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allHL_meanfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allHL_meanfALFF_${r}.txt

		echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allHL_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allHL_meanfALFF_${r}_${h}.txt
		done
	done
done

# ###############################################################
# fALFF for sub_allNH
for s in ${sub_allNH[@]}; do
	echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allNH_meanfALFF_wholeBrain.txt

	for r in ${region[@]}; do
		echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allNH_meanfALFF_${r}.txt

		echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allNH_fALFFofMean_${r}.txt

		for h in ${hemi[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allNH_meanfALFF_${r}_${h}.txt
		done
	done
done


	###############################################################
	# Extracted fALFF for all 4 types of subjects
	# ###############################################################
	# fALFF for sub_tin_HL
	for s in ${sub_tin_HL[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_tin_NH
	for s in ${sub_tin_NH[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_HL
	for s in ${sub_HL[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done

	# ###############################################################
	# fALFF for sub_NH
	for s in ${sub_NH[@]}; do
		echo "$(<${analysis_path}/fALFF/wholeBrain/${s}/${s}_meanfALFF.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_wholeBrain.txt

		for r in ${region[@]}; do
			echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}.txt

			echo "$(<${analysis_path}/fALFFmean/${r}/${s}/${s}_fALFFofMean_${r}.txt)" >> ${GM_compare_path}/GM_allTinHL_fALFFofMean_${r}.txt

			for h in ${hemi[@]}; do
				echo "$(<${analysis_path}/fALFF/${r}/${s}/${s}_meanfALFF_${r}_${h}.txt)" >> ${GM_compare_path}/GM_allTinHL_meanfALFF_${r}_${h}.txt
			done
		done
	done