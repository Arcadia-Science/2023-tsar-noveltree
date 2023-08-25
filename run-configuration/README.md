# Nexflow run configurations
Within this directory we provide the nextflow run configurations used to conduct analyses for the pub associated with this repository. 

## This includes:
  1) `tsar-parameterfile-06062023.json`: The parameterfile used when running NovelTree on the full dataset of 36 species of TSAR eukaryotes.  
  2) `tsar-samplesheet-06062023.csv`: The corresopnding samplesheet.  
  3) `tsar-samplesheet-zenodo.csv`: A supplemental samplesheet, not used in analyses for the pub, but replacing Amazon s3 URIs linking to each species' fasta file with URLs for the correspoding data hosted on Zenodo.

### Note regarding our analysis on Nextflow Tower  
When we ran out analyses on nextflow tower for the pub associated with this repository, we specified a handful of additional configurations.  

This included:  
  1) `max_cpus = 5000`: This set the maximum number of available cpus (as spot instances) to all concurrent processes. Effectively the number of CPUs available to our virtual "cloud" computer.
  2) `max_memory = 30000.GB`: The same, but for memory alloted for all concurrent processes.  
  3) `max_time = 2400.h`: Again, the same, but the maximum time alloted for all concurrent processes.
  4) Additionally, we allocated 32 CPUs to the head node to ensure efficient monitoring and submission of jobs. 
