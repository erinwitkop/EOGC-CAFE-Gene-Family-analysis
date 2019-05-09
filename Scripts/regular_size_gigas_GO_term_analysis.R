# Analysis of GO terms for regular_size_gigas BLASTED ANNOTATED INTERPROSCANNED file

#Load Packages
library(tidyr)
library(dplyr)

#see what ontologies are supported

# Load GFF file from BLAST2GO
regular_size_gigas <- read.csv(file= "./CAFE_Annotation_Analysis/regular_size_gigas_BLAST_ANNOT_GO_MAPPED.gff", sep="\t", header = FALSE)
#set colnames for the attributes
colnames(regular_size_gigas) <- c('seqname', 'source', 'feature','start','end','score','strand','frame', 'attribute')

#Extract rows that have GO terms
regular_size_gigas_GO <- regular_size_gigas[grepl("GO", ignore.case = TRUE, regular_size_gigas$attribute),]
  #only 932 lines out of 2070 have GO terms

#Extract Gene Ontology Info
regular_size_gigas_GO_separated <- sub(".*Ontology_id *(.*?) *;.*", "\\1", regular_size_gigas_GO$attribute)

#split each row into multiple rows using tidyr unnest function 
regular_size_gigas_GO_separated_split <- regular_size_gigas_GO_separated %>% mutate(regular_size_gigas_GO_separated = strsplit(as.character(regular_size_gigas_GO_separated),",")) %>%
  unnest(regular_size_gigas_GO_separated)

#List as a frequency table
regular_size_gigas_GO_separated_split_table <- table(regular_size_gigas_GO_separated_split)
regular_size_gigas_GO_separated_split_table <- sort(table(regular_size_gigas_GO_separated_split), decreasing = TRUE)
regular_size_gigas_GO_separated_split_table_df <- as.data.frame(regular_size_gigas_GO_separated_split_table)

write.csv(file="regular_size_gigas_GO_separated_split_table_df.csv", regular_size_gigas_GO_separated_split_table_df)
#Calculate the frequency of each GO term and rank by frequency (this will then be input into ReVIGO)

# Give REVIGO the table of GO terms and their frequency and it will graph for you 
# Save separate lists of the Biological Process Terms, the Cellular Component terms, and the Molecular Function terms
# Set size of the graph as the value

#Apoptosis Gene Family Search


##### Regular Size Virginica GO Term Analysis ######
# Load GFF file from BLAST2GO
regular_size_virginica <- read.csv(file= "./CAFE_Annotation_Analysis/regular_size_virginica_BLAST_ANNOT.gff", sep="\t", header = FALSE)
#set colnames for the attributes
colnames(regular_size_virginica) <- c('seqname', 'source', 'feature','start','end','score','strand','frame', 'attribute')

#Extract rows that have GO terms
regular_size_virginica_GO <- regular_size_virginica[grepl("GO", ignore.case = TRUE, regular_size_virginica$attribute),]
#only 2863 lines out of 9298 have GO terms

#Extract Gene Ontology Info
regular_size_virginica_GO_separated <- sub(".*Ontology_id *(.*?) *;.*", "\\1", regular_size_virginica_GO$attribute)
regular_size_virginica_GO_separated <- as.data.frame(regular_size_virginica_GO_separated)

#split each row into multiple rows using tidyr unnest function 
regular_size_virginica_GO_separated_split <- regular_size_virginica_GO_separated %>% mutate(regular_size_virginica_GO_separated = strsplit(as.character(regular_size_virginica_GO_separated),",")) %>%
  unnest(regular_size_virginica_GO_separated)

#List as a frequency table
regular_size_virginica_GO_separated_split_table <- table(regular_size_virginica_GO_separated_split)
regular_size_virginica_GO_split_table <- sort(table(regular_size_virginica_GO_separated_split), decreasing = TRUE)
regular_size_virginica_GO_separated_split_table_df <- as.data.frame(regular_size_virginica_GO_separated_split_table)

write.csv(file="regular_size_virginica_GO_separated_split_table_df.csv", regular_size_virginica_GO_separated_split_table_df)
#Calculate the frequency of each GO term and rank by frequency (this will then be input into ReVIGO)
#Remove lines at the end of the file in Excel that were picked up in the grep accidentally
#in Revigo be sure to change it so that the blobs are sized by frequency and only the most frequent ones appear on the graph
