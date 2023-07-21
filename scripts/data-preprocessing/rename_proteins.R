#!/env/Rscript
# This script is just a bit of final tidying up, renaming something descriptive,
# following the format: "Genus_species:ProteinID" - all additional information 
# will subsequently be retained. 
library(seqinr)

# formats for reference and non-reference proteomes from uniprot are the same,
# as are proteins downloaded from UniProtKb, so we'll combine them.
# NOTE: In TSAR dataset, only UniProtRefProteomes were used.
spps_up <- 
    c(gsub("_UniProtRefProteome.fasta", "", 
            list.files("./unfilt_proteins/", 
            pattern = "UniProtRefProteome")),
      gsub("_UniProtProteome.fasta", "", 
        list.files("./unfilt_proteins/", 
        pattern = "UniProtProteome")),
      gsub("_UniProtKbProteins.fasta", "", 
        list.files("./unfilt_proteins/", 
        pattern = "UniProtKbProteins.fasta")))
        

# Begin with the species for which proteins were downloaded from uniprot. 
# These ones are the most straightforward to handle, as UniProtIDs are already
# in their sequence name
for(spp in 1:length(spps_up)){
    print(paste0("Working on ", spps_up[spp], ": Species ", spp, " of ", length(spps_up), "."))
    # read in the species' fasta file
    fa <- read.fasta(file = paste0("./final_proteins/", spps_up[spp], ".fasta"), 
                       seqtype = "AA", as.string = TRUE, set.attributes = TRUE)

    # rename these: Genus_species:ProteinID
    og_names <- names(fa)
    acc <- do.call('rbind', strsplit(as.character(og_names),'|',fixed=TRUE))[,2]
    names(fa) <- paste(spps_up[spp], acc, sep = ":")
   
    # And again, because seqinr strips all the additional details from the sequence name,
    # pull these out and combine with the names we just made
    for(i in 1:length(fa)){
        names(fa)[i] <- paste(names(fa)[i], gsub(">", "", attr(fa[[i]], 'Annot')))
    }
    write.fasta(sequences = fa, names = names(fa), 
                file.out = paste0("./final_proteins/", spps_up[spp], ".fasta"))
}

# Now replace the names of all Eukprot proteins to follow the same format
ep_prots <- list.files('final_proteins/', pattern = "EP0")
ep_spps <- 
    sub(".fasta", "", sub(".*:","", sub("_", ":", ep_prots)))

for(spp in 1:length(ep_spps)){
    print(paste0("Working on ", ep_spps[spp], ": Species ", spp, " of ", length(ep_spps), "."))
    # read in the species' fasta file
    fa <- read.fasta(file = paste0("./final_proteins/", ep_prots[spp]), 
                       seqtype = "AA", as.string = TRUE, set.attributes = TRUE)

    # rename these: Genus_species:ProteinID
    og_names <- names(fa)
    acc <- do.call('rbind', strsplit(as.character(og_names),'_',fixed=TRUE))
    acc <- acc[,ncol(acc)]
    names(fa) <- paste(ep_spps[spp], acc, sep = ":")
   
    # And again, because seqinr strips all the additional details from the sequence name,
    # pull these out and combine with the names we just made
    for(i in 1:length(fa)){
        names(fa)[i] <- paste(names(fa)[i], gsub(">", "", attr(fa[[i]], 'Annot')))
    }
    write.fasta(sequences = fa, names = names(fa), 
                file.out = paste0("./final_proteins/", ep_spps[spp], ".fasta"))
}
