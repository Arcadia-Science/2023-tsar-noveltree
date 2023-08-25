# Summarization of NovelTree outputs
To download our publically hosted NovelTree workflow outputs and generate an interactive summary of them, you may run the bash script `summarize-zenodo-workflow-outputs.sh` within this directory as follows:
```
bash summarize-zenodo-workflow-outputs.sh
```

For more detail about the scripts contained herein, see below:

## Scripts
Within this directory, we provide several scripts that contain functions that are useful in summarizing the results produced by a run of NovelTree. 
Specifically, within the present directory, we provide:
  1. `noveltree_summary_functions.R`:  
      + This script contains R functions that facilitate the collation, summarization, and visualization of the many outputs of NovelTree. An example of how 
these may be used is provided in the R-Markdown file and associated HTML that provides a detailed walkthough of its application.  
  2. `noveltree-results-summary.Rmd`:
      + As described above, this R-Markdown provides a detailed walkthrough of how the functions in the R script above may be used by the user to summarize 
results, and to both conduct exploratory analyses, and to facilitate more explicit downstream analyses.  
  3. `noveltree-results-summary.html`:  
      + This is an interactive HTML document produced by the R-Markdown file above that provides users with a walkthough on how to summarize the outputs of 
NovelTree, complete with example visualizations.  
  4. `arcadia-color-gradients.R`:
      + This is a short R-script that contains definitions for several color pallettes used in the generation of figures presented in our pub and in the HTML 
file described above.

## Outputs
Within the `summarized-results/` subdirectory, we provide the summarized workflow outputs, visualization, and tables produced when knitting 
`noveltree-results-summary.Rmd`. A description of these outputs and a detailed walkthrough of the steps taken to generate them are provided within 
`noveltree-results-summary.html`. Briefly:
  1. `summarized-results/asteroid_spptree_w_boots.png/pdf`:  
      + A figure presenting the manually rooted species tree inferred using Asteroid. Topological support values at nodes are bootstrap support values. 
  3. `summarized-results/speciesrax_spptree_w_epqic.png/pdf`:  
      + A figure presenting the manually rooted species tree inferred using Asteroid, with branch lengths inferred using SpeciesRax. Topological support at 
nodes are EPQIC values inferred with SpeciesRax, described in detail [here](https://github.com/BenoitMorel/GeneRax/wiki/SpeciesRax).  
  4. `summarized-results/busco_results_w_spp_tree.png/pdf`:  
      + A figure presenting the results of BUSCO analyses as both broad and shallow taxonomic scale, with the database used to in each analyses listed within 
the bars depicting each species' proteome completeness.  
  5. `summarized-results/orthofinder`:  
      + This directory contains the summarized results from gene family inference with OrthoFinder. See walkthrough for a detailed description.  
  6. `summarized-results/generax-per-family`:  
      + This directory contains the summarized results from inference of gene family evolutionary dynamics with GeneRax under the per-family model. See 
walkthrough for a detailed description.  
  7. `summarized-results/generax-per-species`:  
      + This directory contains the summarized results from inference of gene family evolutionary dynamics with GeneRax under the per-species model. See 
walkthrough for a detailed description.  

