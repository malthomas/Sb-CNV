setwd("C:/Users/malth/CNV/Ratios")
folder <- "C:/Users/malth/CNV/Ratios"

#Create Data Frame 
CN <- list.files(path = folder, recursive = TRUE, full.names = FALSE,)

CN_read <- lapply(CN, function(x) {read.table(file = x, header = T, sep ="\t")})

CN_df <- do.call("cbind", lapply(CN_read, as.data.frame))

CN_clean <- data.frame(CN_df$Chromosome, CN_df$Start, CN_df$Sb1, CN_df$Sb2, CN_df$Sb3, CN_df$Sb4, CN_df$Sb5, CN_df$Sb6, CN_df$Sb8, CN_df$Sb9, CN_df$Sb10, CN_df$Sb11, CN_df$Sb12, CN_df$Sb13, CN_df$Sb14, CN_df$Sb15, CN_df$Sb16, CN_df$Sb18, CN_df$Sb20, CN_df$Sb21, CN_df$Sb22, CN_df$Sb23, CN_df$Sb24, CN_df$Sb25, CN_df$Sb26, CN_df$Sb27, CN_df$Sb28, CN_df$Sb29, CN_df$Sb34)

write.csv(CN_clean, file = 'C:/Users/malth/CNV/CN_clean.csv')

# Caclulate Variance
library(tidyverse)
library(readr)
CN_var <- read_csv("C:/Users/malth/CNV/CN_var.csv")

mnt <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18')
cst <- c('Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')
total <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18', 'Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')

CN_mnt <- CN_var %>%
            select('Chromosome' , 'Start', mnt) %>%
            mutate(case_when())
          
              
    
            
