# Code in this directory is used to pre-process TSAR proteomes for analysis with PhylOrthology
The directory [`util-lists/`](./util-lists) contains sample/species lists that are used by different scripts, indicating species that should be processed in slightly different manners
  - Efforts have been made to automate the process as much as possible. But, given the diversity of different sources for these data, varied and tailored approaches have been made in certain cases. 
  - Below is a description of each script herein. 

## Note: 
The scripts herein have only been tested on a Mac OSX working environment (Monterey: version 12.5.1). Modifications to commands may need to be made to work properly on other operating systems.

## Scripts/Steps:
### 0) Create conda environment:
  - Prior to running the combined preprocessing script (Step 1: `preprocess_tsar_proteomes.sh`) it is assumed a conda environment has been already been made (using `protein_preprocess_env.yml`) and is currently active. 
  - Assuming you have mamba installed, this can be accomplished using the following set of commands:
    ```
    mamba env create -n protein_preprocessing --file protein_preprocess_env.yml 
    conda activate protein_preprocessing
    ```
  - Once the `protein_preprocessing` conda environment it active, you may proceed with the rest of the prop

### 1) `preprocess_tsar_proteomes.sh`: 
  - This script conducts all stages of data pre-processing, calling the constinuent scripts in appropriate order, and carrying out any necessary cleanup of output directory structure. 
  - Data are downloaded from our bucket on S3 as part of this process. 
  - This is the only script that you need to call directly, such as with the following command:
    ```
      bash ./preprocess_tsar_proteomes.sh
    ```

### 2) `get_tsar_prot_length_cmds.txt`:
  - This is a text file called within `preprocess_tsar_proteomes.sh` that is a list of commands that calculates the length of each protein in each unfiltered dataset. This protein length information is used downstream.
  - `preprocess_tsar_proteomes.sh` calls these commands in parallel using 10 threads by default. This value can be changed within the bash script. 

### 3) `get_isoform_lengths.sh`:
  - For all protein-sets derived from transcriptomes, and for which sequence names enable identification of alternative isorforms for each assembled 'gene', parses gene number, isoform number, and isoform length. 
  - This produces a table that is used in the subsequent step. It works though the sample list `isoform_reduction_list.txt`, which is described below. 

### 4) `extract_longest_isoforms.R`:
  - This script goes through each species analyzed in the step above and pulls out/writes a fasta file comprised of the longest isoform/protein product for each gene in the original, unfiltered proteomes.

### 5) `cdhit_proteomes.sh`:
  - This script performs a number of functions, but in general finalizes all proteomes for downstream analyses. Again, 10 threads are used by default, but this can be modified within the script. Steps include....
    - Running CD-HIT with global similarity threshold (-c 0.90) of 90% on:
      - all proteomes for which we have reduced down to the longest isoform/protein product per-gene. 
      - all proteomes for which the original source was a transcriptome, but we were unable to parse 
alternative isoforms.
    - Running CD-HIT with global similarity threshold (-c 0.95) of 95% on:
      - all non-reference (i.e. UniProt Reference) proteomes for which the original source was a 
genome, and we could not ensure we had only a single protein per-gene. 
    - Removal of any sequence < 50 AA long for all proteomes, including reference proteomes.
  - To determine what type of filtering to apply to each species, `util_lists/non_reduced_prots_to_cdhit.txt` and `util_lists/non_ref_genome_prots_to_reduce.txt` are referenced. 

### 6) `rename_proteins.R`:
  - For all proteomes, renames protein sequences to facilitate downstream use. 
  - All protein sequences follow the format of "Genus_species:ProteinID"
    - For instance, UniProt protein sequences follow the format of "Genus_species:UniProtAccession"
