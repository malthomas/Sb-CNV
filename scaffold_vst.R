library(tidyverse) 
library(stats) #variance function
library(readr)
setwd("C:/Users/malth/Documents/CNV/Ratios")

# List Sb files
  folder <- "C:/Users/malth/Documents/CNV/Ratios"
  CN_list <-  list.files(path = folder, recursive = TRUE, full.names = FALSE,)
# Read each Sb file in the list
  CN_read <-  lapply(CN_list, read.table, header=T, sep="\t")
  
  

  
##TOTAL DATAFRAME  
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

##MONTANE DATAFRAME  
# Create dataframe
  mnt <- c('Sb1', 'Sb2', 'Sb3', 'Sb4', 'Sb5', 'Sb6', 'Sb8', 'Sb9', 'Sb10', 'Sb11', 'Sb12', 'Sb13', 'Sb14', 'Sb15', 'Sb16', 'Sb18')
  CN_mnt <- select(CN_df, window, one_of(mnt))
  
# Transpose dataframe
  window <- CN_mnt$window #remember row id
  CN_mnt <- as.data.frame(t(CN_mnt[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_mnt) <- window #create column names  
  
  write.csv(CN_mnt, file = 'C:/Users/malth/Documents/CNV/CN_mnt.csv') #save dataframe
  
##COASTAL DATAFRAME 
# Create dataframe
  cst <- c('Sb20', 'Sb21', 'Sb22', 'Sb23', 'Sb24', 'Sb25', 'Sb26', 'Sb27', 'Sb28', 'Sb29', 'Sb34')
  CN_cst <- select(CN_df, window, one_of(cst))
  
# Transpose dataframe
  window <- CN_cst$window #remember row id
  CN_cst <- as.data.frame(t(CN_cst[,-1])) #transpose dataframe, exclude 1st colunmn
  colnames(CN_cst) <- window #create column names  
  
  write.csv(CN_cst, file = 'C:/Users/malth/Documents/CNV/CN_cst.csv') #save dataframe
  
  
  

##CALCULATE VARIANCE  
# total variance
  CN_total <- as.tbl(CN_total) #convert dataframe to tibble 
  var_total <- summarise_at(CN_total, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_total <- t(var_total) #transpose dataframe, output matrix
  colnames(var_total) <- c("Total Variance") #name variable column
  write.csv(var_total, file = 'C:/Users/malth/Documents/CNV/var_total.csv') #save dataframe
  
  
# montane variance
  CN_mnt <- as.tbl(CN_mnt) #convert dataframe to tibble 
  var_mnt <- summarise_at(CN_mnt, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_mnt <- t(var_mnt) #transpose dataframe, output matrix
  colnames(var_mnt) <- c("Total Variance") #name variable column
  write.csv(var_mnt, file = 'C:/Users/malth/Documents/CNV/var_mnt.csv') #save dataframe
  
  
# coastal variance
  CN_cst <- as.tbl(CN_cst) #convert dataframe to tibble 
  var_cst <- summarise_at(CN_cst, vars(1:208889), var) #apply the variance function to each column, output new data frame
  var_cst <- t(var_cst) #transpose dataframe, output matrix
  colnames(var_cst) <- c("Total Variance") #name variable column
  write.csv(var_cst, file = 'C:/Users/malth/Documents/CNV/var_cst.csv') #save dataframe
  

##COMBINE VARIANCE DATAFRAMES
# List variance files
  variances <- "C:/Users/malth/Documents/CNV/Variances"
  var_list <-  list.files(path = variances, recursive = TRUE, full.names = T,)
# Read each variance file in the list
  var_read <-  lapply(var_list, read.csv, header=T, sep=",")
# Make variances dataframe
    var_df <- bind_cols(var_read) %>% #bind columns from Sb files
    select(Window, ends_with("Variance"))%>% #select variables of interest
    as.data.frame()#create dataframe
    
# Calaculate VST
  SbVST <- var_df %>%
          mutate(VST = ((Total-((Cst*11+Mnt*16)/27))/Total) ) %>%
          select(Window, VST)
  write.csv(SbVST, file = 'C:/Users/malth/Documents/CNV/SbVST.csv') #save dataframe


##MANHATTAN PLOT 
#total
library(cn.mops)
library(qqman)
library(tidyverse)
vst <- read.csv("C:/Users/malth/Documents/CNV/SbVST.csv", sep="\t")

vst <- filter(vst, Vst != "NA")
vst$scaffold <- as.numeric(vst$scaffold)
vst$Vst <- as.numeric(vst$Vst)
    
manhattan(vst, chr = "scaffold", bp = "position", p = "Vst", logp=FALSE, ylab="Vst",
          col = c("gray10","gray60"),
          )

#Count windows / scaffold 
vst_n < - vst %>% 
  count(sort = TRUE, scaffold)
  
# Average Vst / scaffold
library(graphics)

vst_avg <- vst %>%
  group_by(scaffold)%>%
  summarise(mean(Vst))

barplot(vst_avg$`mean(Vst)`, ylim = c(0,0.25),xpd = F,
        xlab = "scaffold", ylab = "Average Vst")

# scaffolds 1 - 100
vst <- read.csv("C:/Users/malth/Documents/CNV/SbVST.csv", sep="\t")


vst <- filter(vst, Vst != "NA")
vst$scaffold <- as.numeric(vst$scaffold)
vst$Vst <- as.numeric(vst$Vst)

vst100 <- filter(vst, scaffold <= 100 )
write.csv(vst, file = 'C:/Users/malth/Documents/CNV/vst100.csv') #save dataframe


manhattan(vst100, chr = "scaffold", bp = "position", p = "Vst", logp=FALSE, ylab="Vst",
          col = c("gray10","gray60"), ylim =  c(0, 0.4), cex.axis = 0.9)

# top 1%
vst1 <-filter(vst100, Vst > 0.10238095)
write.csv(vst1, file = 'C:/Users/malth/Documents/CNV/vst1.csv') #save dataframe

