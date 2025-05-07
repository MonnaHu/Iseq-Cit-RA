#################################################################
############### R and package version ###########################
#################################################################
> sessionInfo()
R version 4.3.1 (2023-06-16 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 11 x64 (build 22631)

Matrix products: default


locale:
[1] LC_COLLATE=Chinese (Simplified)_China.utf8 
[2] LC_CTYPE=Chinese (Simplified)_China.utf8   
[3] LC_MONETARY=Chinese (Simplified)_China.utf8
[4] LC_NUMERIC=C                               
[5] LC_TIME=Chinese (Simplified)_China.utf8    

time zone: Asia/Shanghai
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices
[4] utils     datasets  methods  
[7] base     

loaded via a namespace (and not attached):
 [1] KEGGREST_1.40.0            
 [2] SummarizedExperiment_1.30.2
 [3] rhdf5_2.44.0               
 [4] Biobase_2.60.0             
 [5] GSVA_1.48.3                
 [6] lattice_0.21-8             
 [7] rhdf5filters_1.12.1        
 [8] vctrs_0.6.5                
 [9] tools_4.3.1                
[10] bitops_1.0-7               
[11] stats4_4.3.1               
[12] parallel_4.3.1             
[13] AnnotationDbi_1.62.2       
[14] RSQLite_2.3.1              
[15] blob_1.2.4                 
[16] Matrix_1.6-0               
[17] S4Vectors_0.38.1           
[18] sparseMatrixStats_1.12.2   
[19] readxl_1.4.3               
[20] graph_1.78.0               
[21] lifecycle_1.0.3            
[22] GenomeInfoDbData_1.2.10    
[23] compiler_4.3.1             
[24] stringr_1.5.0              
[25] Biostrings_2.68.1          
[26] codetools_0.2-19           
[27] GenomeInfoDb_1.36.1        
[28] RCurl_1.98-1.12            
[29] crayon_1.5.2               
[30] BiocParallel_1.34.2        
[31] SingleCellExperiment_1.22.0
[32] cachem_1.0.8               
[33] DelayedArray_0.26.7        
[34] abind_1.4-5                
[35] rsvd_1.0.5                 
[36] stringi_1.7.12             
[37] BiocSingular_1.16.0        
[38] reshape2_1.4.4             
[39] fastmap_1.1.1              
[40] grid_4.3.1                 
[41] cli_3.6.1                  
[42] magrittr_2.0.3             
[43] S4Arrays_1.0.5             
[44] XML_3.99-0.14              
[45] GSEABase_1.62.0            
[46] DelayedMatrixStats_1.22.6  
[47] bit64_4.0.5                
[48] XVector_0.40.0             
[49] httr_1.4.7                 
[50] matrixStats_1.0.0          
[51] bit_4.0.5                  
[52] cellranger_1.1.0           
[53] png_0.1-8                  
[54] beachmat_2.16.0            
[55] ScaledMatrix_1.8.1         
[56] memoise_2.0.1              
[57] HDF5Array_1.28.1           
[58] GenomicRanges_1.52.0       
[59] IRanges_2.34.1             
[60] irlba_2.3.5.1              
[61] rlang_1.1.1                
[62] Rcpp_1.0.11                
[63] xtable_1.8-4               
[64] glue_1.6.2                 
[65] DBI_1.1.3                  
[66] BiocGenerics_0.46.0        
[67] rstudioapi_0.15.0          
[68] annotate_1.78.0            
[69] R6_2.5.1                   
[70] Rhdf5lib_1.22.0            
[71] plyr_1.8.8                 
[72] MatrixGenerics_1.12.3      
[73] zlibbioc_1.46.0  
[74] dplyr_1.1.4  
[75] ggplot2_3.5.2
[76] ggpubr_0.6.0
[77] venn_1.12
[78] caret_7.0-1
[79] smotefamily_1.4.0
[80] ROSE_0.0-4
[81] glmnet_4.1-8
[82] randomForest_4.7-1.2
[83] xgboost_1.7.10.1
[84] lightgbm_4.6.0
[85] nnet_7.3-20
[86] e1071_1.7-16
[87] pROC_1.18.5
[88] scales_1.4.0
 

#################################################################
############### python version ###########################
#################################################################
Python version: 3.8.5 (default, Sep  3 2020, 21:29:08) [MSC v.1916 64 bit (AMD64)]
Platform: Windows-10-10.0.26100-SP0

Installed packages:
autocommand==2.2.2
backports.tarfile==1.2.0
cloudpickle==3.1.1
colorama==0.4.6
contourpy==1.1.1
cycler==0.12.1
et-xmlfile==2.0.0
fonttools==4.56.0
importlib-metadata==8.5.0
importlib-resources==6.4.5
inflect==7.3.1
jaraco.collections==5.1.0
jaraco.context==5.3.0
jaraco.functools==4.0.1
jaraco.text==3.12.1
joblib==1.4.2
kiwisolver==1.4.7
llvmlite==0.41.1
matplotlib==3.7.5
shap==0.44.1
six==1.17.0
slicer==0.0.7
threadpoolctl==3.5.0
tomli==2.0.1
torch==1.8.0+cu111
torchaudio==0.8.0
torchvision==0.9.0+cu111
tqdm==4.67.1
typeguard==4.3.0
typing-extensions==4.12.2
tzdata==2025.1
wheel==0.44.0
zipp==3.20.2


data_preprocess: python data_preproscess.py
data_encode: python dataset.py
model_train: python train_10models_hm.py
model_test: python test_10models_hm.py
description of model: python model.py



