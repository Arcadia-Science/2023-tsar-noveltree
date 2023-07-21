#!/bin/bash

################################################################################
# Create a conda environment using the following set of commands and          #
# provided environment yml file                                               #    
# mamba env create -n protein_preprocessing --file protein_preprocess_env.yml #
# conda activate protein_preprocessing                                        #
################################################################################

# This script carries out all preprocessing of amino acid sequences used in
# phylogenomic inference of TSAR eukaryotes with the PhylOrthology workflow.

# Download data from S3:
echo "#################################"
echo "# Downloading proteomes from S3 #"
echo "#################################"

mkdir -p unfilt_proteins
while read line
do
    spp=$(echo $line | cut -f3 -d" ")
    aws s3 cp $spp ./unfilt_proteins/
done < tsar_species.tsv

# Remove any stop codons (encoded as asterisks) from the end of sequences
# and replace any others with an ambiguous AA (X), ignoring the sequence name
echo "#############################################"
echo "# Replacing stop codons with ambiguous AA's #"
echo "#############################################"
sed -i "s/*$//g" ./unfilt_proteins/*
sed -E -i '/>/!s/\*/X/g' ./unfilt_proteins/*

# Remove sequences shorter than 50 AA
echo "#####################################"
echo "# Removing short (< 50 AA) proteins #"
echo "#####################################"
for spp in $(ls unfilt_proteins/)
do
    seqkit seq --threads 16 --min-len 50 unfilt_proteins/$spp > tmp 
    mv tmp unfilt_proteins/$spp
done

# Get protein lengths - used for isoform filtering below:
echo "###############################"
echo "# Calculating protein lengths #"
echo "###############################"
mkdir -p prot_lengths && parallel -j 16 < get_tsar_prot_length_cmds.txt

# Where possible, reduce isoform redundancy, keeping only the longest isoform
# Start by determining the length of alternative isoforms
echo "###############################################"
echo "# Identifying lengths of alternative isoforms #"
echo "###############################################"
bash get_isoform_lengths.sh 

# and then retain only the longest
echo "###############################"
echo "# Extracting longest isoforms #"
echo "###############################"
Rscript extract_longest_isoforms.R

# and use CD-HIT to reduce proteome redundancy:
# CD-HIT 90% for transcriptomes, 95% for genome derived proteomes.
echo "############################################"
echo "# Reducing proteome redundancy with CD-HIT #"
echo "############################################"
bash cdhit_proteomes.sh

# Remove the trailing info from the UniProt proteome filenames
echo "#########################"
echo "# Cleaning up filenames #"
echo "#########################"
for f in $(ls final_proteins/*UniProt*)
do
    spp=$(echo $f | sed "s|final_proteins/||g" | sed "s/_UniProt.*//g")
    mv $f final_proteins/${spp}.fasta
done

# Rename protein sequences in the format of "Species_genus:ProteinID"
echo "##############################"
echo "# Renaming protein sequences #"
echo "##############################"
Rscript rename_proteins.R 

# Clean up
echo "###############################"
echo "# Cleaning up interim outputs #"
echo "###############################"
mkdir interim_outs
mv cdhit_clstrs/ interim_outs/
mv intermediates/ interim_outs/
mv isoform_reduced/ interim_outs/
mv prot_lengths/ interim_outs/
mv unfilt_proteins/ interim_outs/
tar -czvf interim_outs.tar.gz interim_outs/
