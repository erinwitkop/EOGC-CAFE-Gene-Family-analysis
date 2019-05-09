# Script to Compare regular_size_shared to regular_size_virginica_con and regular_size_virginica_exp

library(tidyr)

# Load in the data

regular_size_virginica_exp <- read.table("./CAFE_Annotation_Analysis_Tracks/Gene_family_IDs/regular_size_virginica_exp.txt")
regular_size_virginica_con <- read.table("./CAFE_Annotation_Analysis_Tracks/Gene_family_IDs/regular_size_virginica_con.txt")
regular_size_shared_con <- read.table("./CAFE_Annotation_Analysis_Tracks/Gene_family_IDs/regular_size_shared_con.txt")
regular_size_shared_exp <- read.table("./CAFE_Annotation_Analysis_Tracks/Gene_family_IDs/regular_size_shared_exp.txt")

#Find if shared_con and regular_size_virginica_con overlap

common_con <- intersect(regular_size_shared_con$V1, regular_size_virginica_con$V1)
#Nothing in common

common_exp <- intersect(regular_size_shared_exp$V1, regular_size_virginica_exp$V1)
# nothing in common 