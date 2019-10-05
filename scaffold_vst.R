library("tidyverse") 
library("stats") #variance function
setwd("C:/Users/malth/Documents/CNV/Ratios")
folder <- "C:/Users/malth/Documents/CNV/Ratios"


#List Sb files 
  CN_list <-  list.files(path = folder, recursive = TRUE, full.names = FALSE,)
  
#Read each Sb file in the list
  CN_read <-  lapply(CN_list, read.table, header=T, sep="\t")
  
#Combine all Sb files into a single dataframe
  CN_df <-  bind_cols(CN_read) %>% #bind columns from Sb files
            select(Chromosome, Start, starts_with("Sb"))%>% #select variables of interest
            as.data.frame() %>% #create dataframe        
            unite("window", Chromosome:Start, remove = T) #create row id
  
#Transpose dataframe
  window <- CN_df$window #remember row id
  CN_df <- as.data.frame(t(CN_df[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_df) <- window #create column names  
  


# Total variance
  CN_tbl <- as.tbl(CN_df) #convert dataframe to tibble 
  variance_total <- summarise_at(CN_df, vars(1:208889), var) #apply the variance function to each column, output new data frame
  variance_total <- t(variance_total) #transpose dataframe, output matrix
  colnames(variance_total) <- c("Total Variance") #name variable column

    

# Montane samples variance  
  mnt <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18')
  
# Coastal samples variance 
  cst <- c('Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')


write.csv(CN_variance, file = 'C:/Users/malth/Documents/CNV/CN_variance.csv')


##NEXT STEPS
#calculate variance of each column (window) and put the value in a new data table
#repeate for cst and mnt 
#calculate vst for each window
#manhattan plot
#dataframe to hyalite for Mason

          
              
    
            
