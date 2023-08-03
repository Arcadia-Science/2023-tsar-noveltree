#!/env/Rscript
library(seqinr)

# For each species, read in the protein info (designated as either 
# isoform/gene and length), and identify the longest isoform for each gene
dir.create('isoform_reduced', showWarnings = F)

fs <- list.files('./intermediates/')

for(f in 1:length(fs)){
    prots <- read.table(paste0('./intermediates/', fs[f]))
    spp <- gsub("_prot_lengths.txt", "", fs[f])
    
    print(paste0("Working on ", spp, "!"))
    genes <- unique(prots[,3])
    
    # Now, identify for each gene, which protein is longest
    longestProts <- by(prots, prots$V3, function(X) X[which.max(X$V2),])
    longestProts <- do.call("rbind", longestProts)[,1]
    
    # read in the species' fasta file
    fa <- read.fasta(file = list.files(path = "./unfilt_proteins/", pattern = spp, full.names=T), 
                       seqtype = "AA", as.string = TRUE, set.attributes = TRUE)
    
    # Pull out the proteins we're keeping, and write out
    final.fa <- fa[names(fa) %in% longestProts]
    for(i in 1:length(final.fa)){
        names(final.fa)[i] <- gsub(">", "", attr(final.fa[[i]], 'Annot'))
    }
    
    write.fasta(sequences = final.fa, names = names(final.fa), file.out = paste0('isoform_reduced/', spp, '_iso_reduced.fasta'))
}

