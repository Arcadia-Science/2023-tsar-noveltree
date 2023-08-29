# 2023-tsar-noveltree
The following repository contains the supplementary code and an example walkthrough of how results of the analysis were summarized for [our pub describing NovelTree](https://doi.org/10.57844/arcadia-z08x-v798).  

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

---

# Feedback, contributions, and reuse

We try to be as open as possible with our work and make all of our code both available and usable. 
We love receiving feedback at any level, through comments on our pubs or Twitter and issues or pull requests here on GitHub.
In turn, we routinely provide public feedback on other people’s work by [commenting on preprints](https://sciety.org/lists/f8459240-f79c-4bb2-bb55-b43eae25e4f6), filing issues on repositories when we encounter bugs, and contributing to open-source projects through pull requests and code review.

Anyone is welcome to contribute to our code.
When we publish new versions of pubs, we include a link to the "Contributions" page for the relevant GitHub repo in the Acknowledgements/Contributors section.
If someone’s contribution has a substantial impact on our scientific direction, the biological result of a project, or the functionality of our code, the pub’s point person may add that person as a formal contributor to the pub with "Critical Feedback" specified as their role.

Our policy is that external contributors cannot be byline-level authors on pubs, simply because we need to ensure that our byline authors are accountable for the quality and integrity of our work, and we must be able to enforce quick turnaround times for internal pub review.
We apply this same policy to feedback on the text and other non-code content in pubs.

If you make a substantial contribution, you are welcome to publish it or use it in your own work (in accordance with the license — our pubs are CC BY 4.0 and our code is openly licensed).
We encourage anyone to build upon our efforts.
