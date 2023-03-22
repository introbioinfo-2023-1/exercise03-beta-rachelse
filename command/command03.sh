# command03.sh
# 1. Align the reference genome and scaffolds assembled with SPAdes with MUMMER.
#    Save the output of MUMMER as sars_cov_2_k*.mums in result directory. (Result files: sars_cov_2_k*.mums)

for k in 23 79 125
do
mummer -F ~/exercise03/data/NC_045512.2.fasta ~/exercise03/result/sars_cov_2_k$k.fasta > ~/exercise03/result/sars_cov_2_k$k.mums
done

# 2. Visualize the alignment result with mummerplot.
#    Save the output plot as sars_cov_2_k*.png in the result directory. (Result files: sars_cov_2_k*.png)

for k in 23 79 125
do
mummerplot --png -p ~/exercise03/result/sars_cov_2_k$k -R ~/exercise03/data/NC_045512.2.fasta -Q ~/exercise03/result/sars_cov_2_k$k.fasta ~/exercise03/result/sars_cov_2_k$k.mums
done

# 3. Generate snp report for sars_cov_2_k125.fasta and save the snp report as
#    sars_cov_2_k125.snps in the result directory. (Result file: sars_cov_2_k125.snps)

nucmer --maxmatch -p sars_cov_2_k125 ~/exercise03/data/NC_045512.2.fasta ~/exercise03/result/sars_cov_2_k125.fasta
delta-filter -r -q sars_cov_2_k125.delta > sars_cov_2_k125.filter
show-snps -r -I -T -x 10 sars_cov_2_k125.filter > ~/exercise03/result/sars_cov_2_k125.snps

# 3-1. Extract two columns that correspond to the two columns of the clade SNP file.
#      Redirect the result to "assembly_align.snps" in the result directory.
#      Read the instruction for command03-4 to get hint. (Result file: assembly_align.snps)

awk '$1~"[0-9]" && $1!~"[A-Z]"{print $1, $3}' ~/exercise03/result/sars_cov_2_k125.snps > ~/exercise03/result/assembly_align.snps

# 4. Find out the shared SNPs between the clade and the sars_cov_2_k125 assembly by joining.
#    With the SNPs, find the clade which shares most SNPs with the sars_cov_2_k125 assembly (Result file: clade_name.txt).

for clade_filtered in $(for clade in $(ls ./data/clade)
do
./join.awk <(awk -v var=${clade} '{print $0 "\t" var}' ~/exercise03/data/clade/${clade}) <(awk '{print $0}' ~/exercise03/result/sars_cov_2_k125.snps)
done |\
awk '$2==$6 {print $3}' | uniq -c | sort -k1nr | awk '$1==4{print$2}')
do wc -l ~/exercise03/data/clade/${clade_filtered} | awk -v var=${clade_filtered} '{print $1 "\t" var}'; done  | \
sort -k1n | head -n1 | awk '{print $2}' | tr -d ".txt" > ~/exercise03/result/clade_name.txt
