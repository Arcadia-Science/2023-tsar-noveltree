#!/bin/bash
# The following script will, for each species of TSAR for which proteins are 
# derived from transcriptomic sequences and for which we may distinguish 
# alternative isoforms:
# 1) pull out the fields relevant to gene and constituent protein/isoform name
# 2) output these to a file

# Subsequently we will work through these, using an R script to extract the 
# names of these proteins to retain, and then use these to extract the 
# protein sequences, spitting them into a new fasta file. 

# Because there a bunch of different formats of transcript/protein names,
# we unfortunately have to do these in batches, using a bit of trickery for each. 
# In several cases, we can generalize this so as to find what we need from 
# the bespoke sequence name formats, and strip away everything else.

# Make a directory to hold the isoform-reduced proteomes
mkdir -p intermediates

# Lets begin. Well work though a file that lists species (first column) 
# and the format we'll use to extract the longest isoform (second column).
while read species
do 
    spp=$(echo $species | cut -f1 -d" ")
    format=$(echo $species | cut -f2 -d" ")
    
    if [ "$format" == "Trinity" ]; then
        grep ">" ./unfilt_proteins/${spp}.fasta | cut -f2 -d' ' | cut -f3 -d":" | sed "s/_Nuclearia.*//g" | sed "s/_m.*//g" > prots
        sed "s/_[^_]*$//g" prots | sed "s/.p.*//g" > genes

    elif [ "$format" == "TransDecoder" ]; then
        grep ">" ./unfilt_proteins/${spp}.fasta | sed "s/.*comp/comp/g" | sed "s/:.*//g" > prots
        sed "s/_[^_]*$//g" prots > genes
    
    elif [ "$format" == "PipeSeparated" ]; then
        grep ">" ./unfilt_proteins/${spp}.fasta | cut -f2,3 -d"|" | cut -f1 -d" " > prots
        sed "s/.[^.]*$//g" prots > genes
        
    elif [ "$format" == "MMETS" ]; then
        grep ">" ./unfilt_proteins/${spp}.fasta | cut -f2 -d"=" | cut -f1 -d" " > prots
        sed "s/_[^_]*$//g" prots > genes
    fi
    
    # Combine
    paste prot_lengths/${spp}_prot_lengths.txt genes prots > intermediates/${spp}_prot_lengths.txt
    rm prots genes
done < util_lists/isoform_reduction_list.txt 
