
# 1. Map the paired-end reads to reference genome using BWA. Use "bwa mem" without using extra options.
bwa index ~/exercise03/data/NC_045512.2.fasta
bwa mem -t 16 ~/exercise03/data/NC_045512.2.fasta ~/exercise03/data/SRR13668359_1.fastq.gz ~/exercise03/data/SRR13668359_2.fastq.gz > ~/exercise03/result/SRR13668359_mapping.sam

# 2. Convert "SRR13668359_mapping.sam" to "SRR13668359_mapping.bam" using "samtools view". 
samtools view -Sb ~/exercise03/result/SRR13668359_mapping.sam -o ~/exercise03/result/SRR13668359_mapping.bam

# 3. Sort "SRR13668359_mapping.bam" to "SRR13668359_mapping_sorted.bam" using "samtools sort". 
samtools sort ~/exercise03/result/SRR13668359_mapping.bam -o ~/exercise03/result/SRR13668359_mapping_sorted.bam

# 4. Call SNPs using "bcftools mpileup & call". It will generate a BCF file which is a binary version of VCF format. 

bcftools mpileup -f ~/exercise03/data/NC_045512.2.fasta ~/exercise03/result/SRR13668359_mapping_sorted.bam | \
bcftools call -mv -Ob -o ~/exercise03/result/SRR13668359_mapping.bcf

# 5. Using "bcftools convert", convert the BCF file to a VCF file so that it becomes readable.

bcftools convert ~/exercise03/result/SRR13668359_mapping.bcf -Ov -o ~/exercise03/result/SRR13668359_mapping.vcf

# 6. From the VCF file, extract two columns that correspond to the two columns of the clade SNP file.
#    Redirect the result to "read_mapping.snps" in the result directory. (Result file: "read_mapping.snps")

awk ' $1 !~ /^#/ {print $2,$5}' ./result/SRR13668359_mapping.vcf > ./result/read_mapping.snps

# 7. You collected the SNP information in two different ways, and the results are "read_mapping.snps" and "assembly_align.snps".
#    Compare the two files, and print the SNPs shared in both file into "shared_snp.txt" in the result directory.
#    And print the SNPs appeared in only one of the files into "unique_snp.txt". (Result file: "shared_snp.txt", "unique_snp.txt")

awk 'NR==FNR{snp[$0]==$0; next}{if($0 in snp){print $0 > ("./result/shared_snp.txt")}else{print $0 > ("./result/unique_snp.txt")}}' ~/exercise03/result/assembly_align.snps  ~/exercise03/result/read_mapping.snps