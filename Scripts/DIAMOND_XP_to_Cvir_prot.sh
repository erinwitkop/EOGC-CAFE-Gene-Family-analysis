#!/bin/bash
#SBATCH --job-name="diamond"
#SBATCH --time=9999:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --output="diamond_XP_to_Cvir_families_shared_con_2"
#SBATCH --error="diamond_XP_to_Cvir_output_shared_con_2"
#SBATCH --mail-user=erin_roberts@my.uri.edu

set -e
echo "START $(date)"

module load DIAMOND/0.9.23-foss-2016b
module load python/2.7.10

F=/data3/marine_diseases_lab/erin/CAFE_Annotation_Analysis/regular_size_shared/regular_size_shared_con/shared_con_IGV_tracks

array1=($(ls $F/*.NOT.virginica))

for i in ${array1[@]}; do
  diamond blastp -d /data3/marine_diseases_lab/shared/cvir_diamond_database/cvir_protein_diamond.dmnd -q ${i} -o ${i}.xml --outfmt 5  
done 

#combine all the XML files 

python /data3/marine_diseases_lab/erin/CAFE_Annotation_Analysis/blast_combine.py -o shared_con_NOT_virginica_xml_combined $F/*.xml

# Extract annotations 

python /data3/marine_diseases_lab/erin/CAFE_Annotation_Analysis/blast_extract_anno.py -i shared_con_NOT_virginica_xml_combined -o shared_con_NOT_virginica_xml_combined.csv -n 1

echo "Done" $(date) 
