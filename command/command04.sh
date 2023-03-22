# command04.sh
# 1. Quast is a quality assessment tool for genome assembly. Run Quast for
#    sars_cov_2_k23.fasta, sars_cov_2_k79.fasta and sars_cov_2_k125.fasta.
#    For each K, save the result at "./sars_cov_2_k*/quast". (No result file)

for k in 23 79 125
do
quast.py ~/exercise03/result/sars_cov_2_k${k}.fasta \
    -r ~/exercise03/data/NC_045512.2.fasta \
    -g ~/exercise03/data/sars_cov_2.genes.gtf \
    -o ~/exercise03/sars_cov_2_k${k}/quast
done 

# 2. Among the output of Quast, find "report.tsv" and parse the values of the assemblies 
#   - Values of interest: # contigs,N50,GC (%)   (respectively, contig_count, N50, GC_percent)
#   - Save the parsed values as a csv format (Result file: assembly_result.csv)
#    - Output format(columns) : case_id,contig_count,N50,GC_percent
#    - Output example : sars_cov_2_k23,2,10000,10.00

for k in 23 79 125
do
awk -F '\t' -v k=$k '$1=="N50" || $1=="GC (%)" || $1=="# contigs" \
            {save[$1]=$2} BEGIN {OFS=","} \
            END {print "sars_cov_2_k"k,save["# contigs"],save["N50"],save["GC (%)"]}' \
            sars_cov_2_k$k/quast/report.tsv >> ~/exercise03/result/assembly_result.csv
done