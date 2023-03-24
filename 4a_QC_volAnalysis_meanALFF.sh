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
echo "${s} Whole Brain fALFF"
fslstats -t ${analysis_path}/fALFF/wholeBrain/${s}/${s}_fALFF -r


# Check the values of the masked ALFF and fALFF
  #ALFF
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral AC"
        fslstats -t ${analysis_path}/ALFF/AC/${s}/${s}_ALFF_AC -r
        echo "ALFF ${s} in the Left AC"
        fslstats -t ${analysis_path}/ALFF/AC/${s}/${s}_ALFF_AC_lh -r
        echo "ALFF ${s} in the Right AC"
        fslstats -t ${analysis_path}/ALFF/AC/${s}/${s}_ALFF_AC_rh -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral HG"
        fslstats -t ${analysis_path}/ALFF/HG/${s}/${s}_ALFF_HG -r
        echo "ALFF ${s} in Left HG"
        fslstats -t ${analysis_path}/ALFF/HG/${s}/${s}_ALFF_HG_lh -r
        echo "ALFF ${s} in Right HG"
        fslstats -t ${analysis_path}/ALFF/HG/${s}/${s}_ALFF_HG_rh -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral PT"
        fslstats -t ${analysis_path}/ALFF/PT/${s}/${s}_ALFF_PT -r
        echo "ALFF ${s} in Left PT"
        fslstats -t ${analysis_path}/ALFF/PT/${s}/${s}_ALFF_PT_lh -r
        echo "ALFF ${s} in Right PT"
        fslstats -t ${analysis_path}/ALFF/PT/${s}/${s}_ALFF_PT_rh -r
  
  # ALFF for MGB, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral MGB"
        fslstats -t ${analysis_path}/ALFF/MGB/${s}/${s}_ALFF_MGB -r
        echo "ALFF ${s} in Left MGB"
        fslstats -t ${analysis_path}/ALFF/MGB/${s}/${s}_ALFF_MGB_lh -r
        echo "ALFF ${s} in Right MGB"
        fslstats -t ${analysis_path}/ALFF/MGB/${s}/${s}_ALFF_MGB_rh -r
   
     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/ALFF/V1/${s}/${s}_ALFF_V1 -r
        echo "ALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/ALFF/V1/${s}/${s}_ALFF_V1_lh -r
        echo "ALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/ALFF/V1/${s}/${s}_ALFF_V1_rh -r
   
    # ALFF for THALAMUS, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral Thalamus"
        fslstats -t ${analysis_path}/ALFF/thalamus/${s}/${s}_ALFF_thalamus -r
        echo "ALFF ${s} in Left Thalamus"
        fslstats -t ${analysis_path}/ALFF/thalamus/${s}/${s}_ALFF_thalamus_lh -r
        echo "ALFF ${s} in Right Thalamus"
        fslstats -t ${analysis_path}/ALFF/thalamus/${s}/${s}_ALFF_thalamus_rh -r
   
  #fALFF
    # fALFF for AC, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in the bilateral AC"
        fslstats -t ${analysis_path}/fALFF/AC/${s}/${s}_fALFF_AC -r
        echo "fALFF ${s} in the left AC"
        fslstats -t ${analysis_path}/fALFF/AC/${s}/${s}_fALFF_AC_lh -r
        echo "fALFF ${s} in the right AC"
        fslstats -t ${analysis_path}/fALFF/AC/${s}/${s}_fALFF_AC_rh -r
    
    # fALFF for HG, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in the bilateral HG"
        fslstats -t ${analysis_path}/fALFF/HG/${s}/${s}_fALFF_HG -r
        echo "fALFF ${s} in the left HG"
        fslstats -t ${analysis_path}/fALFF/HG/${s}/${s}_fALFF_HG_lh -r
        echo "fALFF ${s} in the right HG"
        fslstats -t ${analysis_path}/fALFF/HG/${s}/${s}_fALFF_HG_rh -r
    
    # fALFF for PT, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in bilateral PT"
        fslstats -t ${analysis_path}/fALFF/PT/${s}/${s}_fALFF_PT -r
        echo "fALFF ${s} in left PT"
        fslstats -t ${analysis_path}/fALFF/PT/${s}/${s}_fALFF_PT_lh -r
        echo "fALFF ${s} in right PT"
        fslstats -t ${analysis_path}/fALFF/PT/${s}/${s}_fALFF_PT_rh -r
  
  # fALFF for MGB, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral MGB"
        fslstats -t ${analysis_path}/fALFF/MGB/${s}/${s}_fALFF_MGB -r
        echo "fALFF ${s} in Left MGB"
        fslstats -t ${analysis_path}/fALFF/MGB/${s}/${s}_fALFF_MGB_lh -r
        echo "fALFF ${s} in Right MGB"
        fslstats -t ${analysis_path}/fALFF/MGB/${s}/${s}_fALFF_MGB_rh -r

  # fALFF for V1, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/fALFF/V1/${s}/${s}_fALFF_V1 -r
        echo "fALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/fALFF/V1/${s}/${s}_fALFF_V1_lh -r
        echo "fALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/fALFF/V1/${s}/${s}_fALFF_V1_rh -r
    
    # fALFF for Thalamus, 1) bilateral 2) left 3) right
        echo "fALFF ${s} in Bilateral Thalamus"
        fslstats -t ${analysis_path}/fALFF/thalamus/${s}/${s}_fALFF_thalamus -r
        echo "fALFF ${s} in Left Thalamus"
        fslstats -t ${analysis_path}/fALFF/thalamus/${s}/${s}_fALFF_thalamus_lh -r
        echo "fALFF ${s} in Right Thalamus"
        fslstats -t ${analysis_path}/fALFF/thalamus/${s}/${s}_fALFF_thalamus_rh -r


# REPEAT FOR THE GREY MATTER SPECIFIC MASKS

# Check the values of the masked ALFF and fALFF
  #ALFF
  
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral AC"
        fslstats -t ${analysis_path}/ALFF/GM/AC/${s}/${s}_ALFF_AC_GM -r
        echo "ALFF ${s} in the Left AC"
        fslstats -t ${analysis_path}/ALFF/GM/AC/${s}/${s}_ALFF_AC_lh_GM -r
        echo "ALFF ${s} in the Right AC"
        fslstats -t ${analysis_path}/ALFF/GM/AC/${s}/${s}_ALFF_AC_rh_GM -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral HG"
        fslstats -t ${analysis_path}/ALFF/GM/HG/${s}/${s}_ALFF_HG_GM -r
        echo "ALFF ${s} in Left HG"
        fslstats -t ${analysis_path}/ALFF/GM/HG/${s}/${s}_ALFF_HG_lh_GM -r
        echo "ALFF ${s} in Right HG"
        fslstats -t ${analysis_path}/ALFF/GM/HG/${s}/${s}_ALFF_HG_rh_GM -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral PT"
        fslstats -t ${analysis_path}/ALFF/GM/PT/${s}/${s}_ALFF_PT_GM -r
        echo "ALFF ${s} in Left PT"
        fslstats -t ${analysis_path}/ALFF/GM/PT/${s}/${s}_ALFF_PT_lh_GM -r
        echo "ALFF ${s} in Right PT"
        fslstats -t ${analysis_path}/ALFF/GM/PT/${s}/${s}_ALFF_PT_rh_GM -r
   
     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "ALFF ${s} in Bilateral V1"
        fslstats -t ${analysis_path}/ALFF/GM/V1/${s}/${s}_ALFF_V1_GM -r
        echo "ALFF ${s} in Left V1"
        fslstats -t ${analysis_path}/ALFF/GM/V1/${s}/${s}_ALFF_V1_lh_GM -r
        echo "ALFF ${s} in Right V1"
        fslstats -t ${analysis_path}/ALFF/GM/V1/${s}/${s}_ALFF_V1_rh_GM -r
   
# Check the values of the masked ALFF and fALFF
  #fALFF
  
    # ALFF for AC, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral AC"
        fslstats -t ${analysis_path}/fALFF/GM/AC/${s}/${s}_fALFF_AC_GM -r
        echo "fALFF ${s}-${c} in the Left AC"
        fslstats -t ${analysis_path}/fALFF/GM/AC/${s}/${s}_fALFF_AC_lh_GM -r
        echo "fALFF ${s}-${c} in the Right AC"
        fslstats -t ${analysis_path}/fALFF/GM/AC/${s}/${s}_fALFF_AC_rh_GM -r
    
    # ALFF for HG, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral HG"
        fslstats -t ${analysis_path}/fALFF/GM/HG/${s}/${s}_fALFF_HG_GM -r
        echo "fALFF ${s}-${c} in Left HG"
        fslstats -t ${analysis_path}/fALFF/GM/HG/${s}/${s}_fALFF_HG_lh_GM -r
        echo "fALFF ${s}-${c} in Right HG"
        fslstats -t ${analysis_path}/fALFF/GM/HG/${s}/${s}_fALFF_HG_rh_GM -r
    
    # ALFF for PT, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral PT"
        fslstats -t ${analysis_path}/fALFF/GM/PT/${s}/${s}_fALFF_PT_GM -r
        echo "fALFF ${s}-${c} in Left PT"
        fslstats -t ${analysis_path}/fALFF/GM/PT/${s}/${s}_fALFF_PT_lh_GM -r
        echo "fALFF ${s}-${c} in Right PT"
        fslstats -t ${analysis_path}/fALFF/GM/PT/${s}/${s}_fALFF_PT_rh_GM -r
  

     # ALFF for V1, 1) bilateral 2) left 3) right
        echo "fALFF ${s}-${c} in Bilateral V1"
        fslstats -t ${analysis_path}/fALFF/GM/V1/${s}/${s}_fALFF_V1_GM -r
        echo "fALFF ${s}-${c} in Left V1"
        fslstats -t ${analysis_path}/fALFF/GM/V1/${s}/${s}_fALFF_V1_lh_GM -r
        echo "fALFF ${s}-${c} in Right V1"
        fslstats -t ${analysis_path}/fALFF/GM/V1/${s}/${s}_fALFF_V1_rh_GM -r