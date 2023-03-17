# 1. Map the paired-end reads to reference genome using BWA. Use "bwa mem" without using extra options.

# 2. Convert "SRR13668359_mapping.sam" to "SRR13668359_mapping.bam" using "samtools view".

# 3. Sort "SRR13668359_mapping.bam" to "SRR13668359_mapping_sorted.bam" using "samtools sort".

# 4. Call SNPs using "bcftools mpileup & call". It will generate a BCF file which is a binary version of VCF format.

# 5. Convert the BCF file to a VCF file so that it becomes readable.

# 6. From the VCF file, extract two columns that correspond to the two columns of the clade SNP file.
#    Redirect the result to "read_mapping.snps" in the result directory. (Result file: "read_mapping.snps")

# 7. You collected the SNP information in two different ways, and the results are "read_mapping.snps" and "assembly_align.snps".
#    Compare the two files, and print the SNPs shared in both file into "shared_snp.txt" in the result directory.
#    And print the SNPs appeared in only one of the files into "unique_snp.txt". (Result file: "shared_snp.txt", "unique_snp.txt")

