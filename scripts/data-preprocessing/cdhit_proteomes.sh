#!/bin/bash
# Run CD-HIT on all of the Isoform-reduced transcriptome-derived proteomes
mkdir -p final_proteins

for p in $(ls ./isoform_reduced/)
do
    spp=$(echo $p | sed "s/_iso_reduced.fasta//g")
    
    cd-hit -T 10 -l 50 -i ./isoform_reduced/$p -o ./final_proteins/${spp}.fasta
done

# and the lingering transcriptomes for which we couldn't remove redundant isoforms
while read spp
do
    cd-hit -T 10 -l 50 -i ./unfilt_proteins/$spp.fasta -o ./final_proteins/${spp}.fasta
done < util_lists/non_reduced_prots_to_cdhit.txt 

# And non-reference proteomes from UniProt, or proteins downloaded from UniProtKb,
# but with a slightly relaxed threshold
while read spp
do
    cd-hit -T 10 -c 0.95 -l 50 -i ./unfilt_proteins/$spp.fasta -o ./final_proteins/${spp}.fasta
done < util_lists/non_ref_genome_prots_to_reduce.txt

# Move the clstr files to their own directory for everything is clean and tidy
mkdir -p cdhit_clstrs
mv ./final_proteins/*clstr cdhit_clstrs
