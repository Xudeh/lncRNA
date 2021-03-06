#run blast on protein fraction
module load GNU/4.4.5 
module load BEDTools/2.24.0  

bedtools getfasta -s -fi equCab2.0_genome.fa -bed P.bed -name -split -fo P.fa

curl -O ftp://ftp.ensembl.org/pub/release-86/fasta/homo_sapiens/ncrna/Homo_sapiens.GRCh38.ncrna.fa.gz
gunzip Homo_sapiens.GRCh38.ncrna.fa.gz

module load GNU/4.8.3
module load BLAST+/2.3.0

makeblastdb -in Homo_sapiens.GRCh38.ncrna.fa -input_type fasta -dbtype nucl -out hg38_ncrna_db
blastn -query P.fa  -db hg38_ncrna_db  -max_target_seqs 1 -outfmt "6 qseqid sseqid pident qcovs evalue" -evalue 1e-5 -num_threads 10 > lncRNA_hg_nt.outfmt6
