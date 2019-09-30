library("tidyverse")
library("stringr")
library("data.table")
setwd("C:/Users/malth/Documents/CNV/Ratios")
folder <- "C:/Users/malth/Documents/CNV/Ratios"


#List Sb files 
  CN_list <-  list.files(path = folder, recursive = TRUE, full.names = FALSE,)
#Read each Sb file in the list
  CN_read <-  lapply(CN_list, read.table, header=T, sep="\t", stringsAsFactors = F)
#Combine all Sb files into a single dataframe
  CN_df <-  bind_cols(CN_read) %>% #bind dataframe by columns
            select(Chromosome, Start, starts_with("Sb")) %>% #select variables of interest
            unite("window", Chromosome:Start, remove = T) #create row identifiers
# Make it pretty
  total <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18','Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')
  CN_clean <- CN_df %>%
              data.frame(row.names = 'window') %>%
              select(total) %>%
              t()
# Total variance
  CN_total <- CN_clean %>%
              transmute_all(funs(var))

# Montane samples variance  
  mnt <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18')
  
# Coastal samples variance 
  cst <- c('Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')


write.csv(CN_variance, file = 'C:/Users/malth/Docuemnts/CNV/CN_variance.csv')


##NEXT STEPS
#calculate variance of each column (window) and put the value in a new data table
#repeate for cst and mnt 
#calculate vst for each window
#manhattan plot

          
              
    
            
