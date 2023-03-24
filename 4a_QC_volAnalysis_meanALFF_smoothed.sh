#!/bin/bash

data_path="/Volumes/gdrive4tb/IGNITE"
preproc_path="/Volumes/gdrive4tb/IGNITE/resting-state/preprocessed"
vol_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric"
mask_path="/Volumes/gdrive4tb/IGNITE/mask"
log_path="/Volumes/gdrive4tb/IGNITE/resting-state/log"
analysis_path="/Volumes/gdrive4tb/IGNITE/resting-state/volumetric/analysis"

s=(IGNTFA_00065)

# Check the values of Whole Brain ALFF
echo "${s} Whole Brain ALFF"
fslstats -t ${analysis_path}/ALFF/wholeBrain/${s}/${s}_ALFF -r


# Check the values of the Whole Brain fALFF - should all be between 0 and 1
echo "${s} Whole Brain fALFF smooothed"
fslstats -t ${analysis_path}/ALFF_smoothed/wholeBrain/${s}/${s}_ALFF_smoothed -r


# Check the values of the masked ALFF and fALFF
  #ALFF
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/AC/${s}/${s}_ALFF_AC_smoothed -r
        echo "ALFF ${s} in the Left AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/AC/${s}/${s}_ALFF_AC_lh_smoothed -r
        echo "ALFF ${s} in the Right AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/AC/${s}/${s}_ALFF_AC_rh_smoothed -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/HG/${s}/${s}_ALFF_HG_smoothed -r
        echo "ALFF ${s} in Left HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/HG/${s}/${s}_ALFF_HG_lh_smoothed -r
        echo "ALFF ${s} in Right HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/HG/${s}/${s}_ALFF_HG_rh_smoothed -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/PT/${s}/${s}_ALFF_PT_smoothed -r
        echo "ALFF ${s} in Left PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/PT/${s}/${s}_ALFF_PT_lh_smoothed -r
        echo "ALFF ${s} in Right PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/PT/${s}/${s}_ALFF_PT_rh_smoothed -r
  
  # ALFF for MGB, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral MGB"
        fslstats -t ${analysis_path}/ALFF_smoothed/MGB/${s}/${s}_ALFF_MGB_smoothed -r
        echo "ALFF ${s} in Left MGB"
        fslstats -t ${analysis_path}/ALFF_smoothed/MGB/${s}/${s}_ALFF_MGB_lh_smoothed -r
        echo "ALFF ${s} in Right MGB"
        fslstats -t ${analysis_path}/ALFF_smoothed/MGB/${s}/${s}_ALFF_MGB_rh_smoothed -r
   
     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/V1/${s}/${s}_ALFF_V1_smoothed -r
        echo "ALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/V1/${s}/${s}_ALFF_V1_lh_smoothed -r
        echo "ALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/V1/${s}/${s}_ALFF_V1_rh_smoothed -r
   
    # ALFF for THALAMUS, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral Thalamus"
        fslstats -t ${analysis_path}/ALFF_smoothed/thalamus/${s}/${s}_ALFF_thalamus_smoothed -r
        echo "ALFF ${s} in Left Thalamus"
        fslstats -t ${analysis_path}/ALFF_smoothed/thalamus/${s}/${s}_ALFF_thalamus_lh_smoothed -r
        echo "ALFF ${s} in Right Thalamus"
        fslstats -t ${analysis_path}/ALFF_smoothed/thalamus/${s}/${s}_ALFF_thalamus_rh_smoothed -r
   
  #fALFF
    # fALFF for AC, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in the bilateral AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/AC/${s}/${s}_fALFF_AC_smoothed -r
        echo "fALFF ${s} in the left AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/AC/${s}/${s}_fALFF_AC_lh_smoothed -r
        echo "fALFF ${s} in the right AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/AC/${s}/${s}_fALFF_AC_rh_smoothed -r
    
    # fALFF for HG, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in the bilateral HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/HG/${s}/${s}_fALFF_HG_smoothed -r
        echo "fALFF ${s} in the left HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/HG/${s}/${s}_fALFF_HG_lh_smoothed -r
        echo "fALFF ${s} in the right HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/HG/${s}/${s}_fALFF_HG_rh_smoothed -r
    
    # fALFF for PT, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in bilateral PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/PT/${s}/${s}_fALFF_PT_smoothed -r
        echo "fALFF ${s} in left PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/PT/${s}/${s}_fALFF_PT_lh_smoothed -r
        echo "fALFF ${s} in right PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/PT/${s}/${s}_fALFF_PT_rh_smoothed -r
  
  # fALFF for MGB, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral MGB"
        fslstats -t ${analysis_path}/fALFF_smoothed/MGB/${s}/${s}_fALFF_MGB_smoothed -r
        echo "fALFF ${s} in Left MGB"
        fslstats -t ${analysis_path}/fALFF_smoothed/MGB/${s}/${s}_fALFF_MGB_lh_smoothed -r
        echo "fALFF ${s} in Right MGB"
        fslstats -t ${analysis_path}/fALFF_smoothed/MGB/${s}/${s}_fALFF_MGB_rh_smoothed -r

  # fALFF for V1, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/V1/${s}/${s}_fALFF_V1_smoothed -r
        echo "fALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/V1/${s}/${s}_fALFF_V1_lh_smoothed -r
        echo "fALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/V1/${s}/${s}_fALFF_V1_rh_smoothed -r
    
    # fALFF for Thalamus, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral Thalamus"
        fslstats -t ${analysis_path}/fALFF_smoothed/thalamus/${s}/${s}_fALFF_thalamus_smoothed -r
        echo "fALFF ${s} in Left Thalamus"
        fslstats -t ${analysis_path}/fALFF_smoothed/thalamus/${s}/${s}_fALFF_thalamus_lh_smoothed -r
        echo "fALFF ${s} in Right Thalamus"
        fslstats -t ${analysis_path}/fALFF_smoothed/thalamus/${s}/${s}_fALFF_thalamus_rh_smoothed -r


# REPEAT FOR THE GREY MATTER SPECIFIC MASKS

# Check the values of the masked ALFF and fALFF
  #ALFF
  
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/AC/${s}/${s}_ALFF_AC_GM_smoothed -r
        echo "ALFF ${s} in the Left AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/AC/${s}/${s}_ALFF_AC_lh_GM_smoothed -r
        echo "ALFF ${s} in the Right AC"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/AC/${s}/${s}_ALFF_AC_rh_GM_smoothed -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/HG/${s}/${s}_ALFF_HG_GM_smoothed -r
        echo "ALFF ${s} in Left HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/HG/${s}/${s}_ALFF_HG_lh_GM_smoothed -r
        echo "ALFF ${s} in Right HG"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/HG/${s}/${s}_ALFF_HG_rh_GM_smoothed -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/PT/${s}/${s}_ALFF_PT_GM_smoothed -r
        echo "ALFF ${s} in Left PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/PT/${s}/${s}_ALFF_PT_lh_GM_smoothed -r
        echo "ALFF ${s} in Right PT"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/PT/${s}/${s}_ALFF_PT_rh_GM_smoothed -r
   
     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/V1/${s}/${s}_ALFF_V1_GM_smoothed -r
        echo "ALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/V1/${s}/${s}_ALFF_V1_lh_GM_smoothed -r
        echo "ALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/ALFF_smoothed/GM/V1/${s}/${s}_ALFF_V1_rh_GM_smoothed -r
   
# Check the values of the masked ALFF and fALFF
  #fALFF
  
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/AC/${s}/${s}_fALFF_AC_GM_smoothed -r
        echo "fALFF ${s}-${c} in the Left AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/AC/${s}/${s}_fALFF_AC_lh_GM_smoothed -r
        echo "fALFF ${s}-${c} in the Right AC"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/AC/${s}/${s}_fALFF_AC_rh_GM_smoothed -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/HG/${s}/${s}_fALFF_HG_GM_smoothed -r
        echo "fALFF ${s}-${c} in Left HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/HG/${s}/${s}_fALFF_HG_lh_GM_smoothed -r
        echo "fALFF ${s}-${c} in Right HG"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/HG/${s}/${s}_fALFF_HG_rh_GM_smoothed -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/PT/${s}/${s}_fALFF_PT_GM_smoothed -r
        echo "fALFF ${s}-${c} in Left PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/PT/${s}/${s}_fALFF_PT_lh_GM_smoothed -r
        echo "fALFF ${s}-${c} in Right PT"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/PT/${s}/${s}_fALFF_PT_rh_GM_smoothed -r
  

     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/V1/${s}/${s}_fALFF_V1_GM_smoothed -r
        echo "fALFF ${s}-${c} in Left V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/V1/${s}/${s}_fALFF_V1_lh_GM_smoothed -r
        echo "fALFF ${s}-${c} in Right V1"
        fslstats -t ${analysis_path}/fALFF_smoothed/GM/V1/${s}/${s}_fALFF_V1_rh_GM_smoothed -r