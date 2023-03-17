# command03.sh
# 1. Align the reference genome and scaffolds assembled with SPAdes with MUMMER.
#    Save the output of MUMMER as sars_cov_2_k*.mums in result directory. (Result files: sars_cov_2_k*.mums)

# 2. Visualize the alignment result with mummerplot.
#    Save the output plot as sars_cov_2_k*.png in the result directory. (Result files: sars_cov_2_k*.png)

# 3. Generate snp report for sars_cov_2_k127.fasta and save the snp report as
#    sars_cov_2_k127.snps in the result directory. (Result file: sars_cov_2_k127.snps)
# 3-1. Extract two columns that correspond to the two columns of the clade SNP file.
#      Redirect the result to "assembly_align.snps" in the result directory.
#      Read the instruction for command03-4 to get hint. (Result file: assembly_align.snps)

# 4. Find out the shared SNPs between the clade and the sars_cov_2_k127 assembly by joining.
#    With the SNPs, find the clade which shares most SNPs with the sars_cov_2_k127 assembly (Result file: clade_name.txt).
