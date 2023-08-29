# Nexflow run configurations
Within this directory we provide the Nextflow run configurations used to conduct analyses for [the pub associated with this repository](https://doi.org/10.57844/arcadia-z08x-v798). 

## This includes:
  1) `tsar-parameterfile-06062023.json`: The parameter file used when running NovelTree on the full dataset of 36 species of TSAR eukaryotes.  
  2) `tsar-samplesheet-06062023.csv`: The corresopnding samplesheet.  
  3) `tsar-samplesheet-zenodo.csv`: A supplemental samplesheet, not used in analyses for the pub, but replacing Amazon s3 URIs linking to each species' fasta file with URLs for the correspoding data hosted on Zenodo.

### Note regarding our analysis on Nextflow Tower  
We are currently deploying all of our Nextflow workflows, including [NovelTree](https://github.com/Arcadia-Science/noveltree), through Nextflow Tower using AWS Batch. When we ran our analyses on Nextflow Tower for the pub associated with this repository, we specified a handful of additional configurations.  

This included:  
  1) `max_cpus = 5000`: This set the maximum number of available cpus (as spot instances) to all concurrent processes. Effectively the number of CPUs available to our virtual "cloud" computer.
  2) `max_memory = 30000.GB`: The same, but for memory alloted for all concurrent processes.  
  3) `max_time = 2400.h`: Again, the same, but the maximum time alloted for all concurrent processes.
  4) Additionally, we allocated 32 CPUs to the head node to ensure efficient monitoring and submission of jobs. 
