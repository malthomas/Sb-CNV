library("tidyverse") 
library("stats") #variance function
setwd("C:/Users/malth/Documents/CNV/Ratios")
folder <- "C:/Users/malth/Documents/CNV/Ratios"

# List Sb files 
  CN_list <-  list.files(path = folder, recursive = TRUE, full.names = FALSE,)
  
# Read each Sb file in the list
  CN_read <-  lapply(CN_list, read.table, header=T, sep="\t")
  

  
##TOTAL VARIANCE  
# Create dataframe
  CN_df <- bind_cols(CN_read) %>% #bind columns from Sb files
            select(Chromosome, Start, starts_with("Sb"))%>% #select variables of interest
            as.data.frame() %>% #create dataframe        
            unite("window", Chromosome:Start, remove = T) #create row id
    
# Transpose dataframe
  window <- CN_df$window #remember row id
  CN_total <- as.data.frame(t(CN_df[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_total) <- window #create column names  
  write.csv(CN_total, file = 'C:/Users/malth/Documents/CNV/CN_total.csv') #save dataframe
  
# Calculate variance
  CN_total <- as.tbl(CN_total) #convert dataframe to tibble 
  var_total <- summarise_at(CN_total, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_total <- t(var_total) #transpose dataframe, output matrix
  colnames(var_total) <- c("Total Variance") #name variable column

    

##MONTANE VARIANCE  
# Create dataframe
  mnt <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18')
  CN_mnt <- select(CN_df, window, one_of(mnt))
  
# Transpose dataframe
  window <- CN_mnt$window #remember row id
  CN_mnt <- as.data.frame(t(CN_mnt[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_mnt) <- window #create column names  
  write.csv(CN_mnt, file = 'C:/Users/malth/Documents/CNV/CN_mnt.csv') #save dataframe
  
# Calculate variance
  CN_mnt <- as.tbl(CN_mnt) #convert dataframe to tibble 
  var_mnt <- summarise_at(CN_mnt, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_mnt <- t(var_mnt) #transpose dataframe, output matrix
  colnames(var_mnt) <- c("Total Variance") #name variable column
  
  
  
##COASTAL VARIANCE 
# Create dataframe
  cst <- c('Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')
  CN_cst <- select(CN_df, window, one_of(cst))
  
# Transpose dataframe
  window <- CN_cst$window #remember row id
  CN_cst <- as.data.frame(t(CN_cst[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_cst) <- window #create column names  
  write.csv(CN_cst, file = 'C:/Users/malth/Documents/CNV/CN_cst.csv') #save dataframe
  
# Calculate variance
  CN_cst <- as.tbl(CN_cst) #convert dataframe to tibble 
  var_cst <- summarise_at(CN_cst, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_cst <- t(var_cst) #transpose dataframe, output matrix
  colnames(var_cst) <- c("Total Variance") #name variable column
  

##CALCULATE VST
#Combine variance dataframes
  


##MANHATTAN PLOT

          
              
    
            
