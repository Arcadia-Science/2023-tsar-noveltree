# 2023-tsar-noveltree
The following repository contains the supplementary code and an example walkthrough of how results of the analysis were summarized for our pub describing NovelTree [DOI HERE].  

## Contents
### 1) `run-configuration/`  
  - This directory contains the nextflow samplesheet (`tsar-samplesheet-06062023.csv`) and parameterfile (`tsar-parameterfile-06062023.json`) used to apply `NovelTree` to our dataset of 36 species of TSAR Eukaryotes (*Telonemia*, *Stramenopila*, *Alveolata*, and *Rhizaria*).  
    - Note, if users intend to re-run these analyses, they should first update the `output` parameter such that local file paths are used.  
  - We additionally provide a samplesheet that instead links to the protein sequence data hosted on [Zenodo](https://zenodo.org/record/8237421).  

### 2) `scripts/data-preprocessing`  
  - This directory contains the scripts used to pre-process the original, unfiltered proteomes (again, hosted on [Zenodo](https://zenodo.org/record/8237421)) for analysis prior to analysis with `NovelTree`.  
  - Within this directory, we provide a READ describing the use of these scripts.  

### 3) `scripts/noveltree-summarization/`  
  - This directory contains the scripts used to summarize the `NovelTree` workflow outputs into more user-friendly formats.  
  - Additionally, this includes an [R Markdown file](./scripts/noveltree-results-summary.Rmd) and resultant [interactive HTML]((./scripts/noveltree-results-summary.html)) that may downloaded and opened in your browser that walks through and describes the use of these summarization scripts, as well as provides some example visualizations. 
  - In the future, we intend to further develop these summarization scripts, building them into an R package that will more readily facilate both exploratative and quantitative analysis of any `NovelTree` run. 


