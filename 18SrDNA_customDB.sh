#making 18S rDNA barcode db from ncbi genbank entry. this script is based on the crabsv0.1.7, seqkit v2.3.0, blast2.13.0
#crabs were usd.
#for mammalian host, only human, cattle and dogs will be downloaded.
crabs db_download --source ncbi \
 --database nucleotide \
 --query \
 '((18S[Title] OR SSU[Title]) AND (rRNA[Title] OR ribosomal rna[Title])) AND ("1000"[SLEN] : "3000"[SLEN]) NOT ("whole genome"[Title]) AND ("1000"[SLEN] : "3000"[SLEN]) NOT PREDICTED[Title] AND ("eukaryotes"[porgn])' \
 --output SSU_euk_ncbi_1000_3000.fasta --keep_original yes --email *****@***** --batchsize 5000

crabs db_download --source taxonomy

crabs insilico_pcr --input SSU_euk_ncbi_1000_3000.fasta --output SSU_euk_ncbi_1000_3000_PCR.fasta --fwd CAGCAGCCGCGGTAATTCC --rev ACCTTGTTACGAC --error 2.5
crabs pga --input SSU_euk_ncbi_1000_3000.fasta --output SSU_euk_ncbi_1000_3000_PGA.fasta --database SSU_euk_ncbi_1000_3000_PCR.fasta --fwd CAGCAGCCGCGGTAATTCC --rev ACCTTGTTACGAC --speed medium --percid 0.85 --coverage 0.90 --filter_method strict

crabs assign_tax --input SSU_euk_ncbi_1000_3000_PGA.fasta --output SSU_euk_ncbi_1000_3000_PGA_tax.tsv --acc2tax nucl_gb.accession2taxid --taxid nodes.dmp --name names.dmp
crabs dereplicate --input SSU_euk_ncbi_1000_3000_PGA_tax.tsv --output SSU_euk_ncbi_1000_3000_PGA_tax_uniq.tsv --method uniq_species

crabs seq_cleanup --input SSU_euk_ncbi_1000_3000_PGA_tax_uniq.tsv --output SSU_euk_ncbi_1000_3000_PGA_tax_uniq_clean.tsv --minlen 800 --maxlen 2000 --maxns 0 --enviro yes --species yes --nans 0

curated_tsv=SSU_euk_ncbi_1000_3000_PGA_tax_uniq_clean.tsv
grep -v Mammalia $curated_tsv > ${curated_tsv%%.tsv}_woMammal_human.tsv
grep Homo_sapiens $curated_tsv >> ${curated_tsv%%.tsv}_woMammal_human.tsv

curated_tsv=SSU_euk_ncbi_1000_3000_PGA_tax_uniq_clean_woMammal_human.tsv
curated_fasta=SSU_euk_ncbi_1000_3000_PGA_tax_uniq_clean_woMammal_human.fasta
curated_taxmap=SSU_euk_ncbi_1000_3000_PGA_tax_uniq_clean_woMammal_human.taxmap.txt
cut -f1,2 $curated_tsv |sed -e "s/\t/ /g" | tail -n +2> $curated_taxmap
cut -f1,9,10 $curated_tsv |sed -e "s/\t/ /"|seqkit tab2fx| tail -n +3 > $curated_fasta

makeblastdb -in $curated_fasta \
 -input_type fasta \
 -dbtype nucl \
 -parse_seqids \
 -out ${curated_fasta%%.fasta} \
 -taxid_map $curated_taxmap
