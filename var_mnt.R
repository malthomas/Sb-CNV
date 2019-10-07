CN_mnt<- read.csv("/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/CN_mnt.csv")
CN_mnt <- as.tbl(CN_mnt) #convert dataframe to tibble 
var_mnt <- summarise_at(CN_mnt, vars(1:208889), var) #apply the variance function to each column, output new data frame
var_mnt <- t(var_mnt) #transpose dataframe, output matrix
colnames(var_mnt) <- c("Total Variance") #name variable column
write.csv(CN_total, file = '/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/var_mnt.csv') #save dataframe

#In Hyalite 
#library("tidyverse")
#library("stats")
#name <- "/enterhyalitepathtoyourscriptfilehere"
#file(name) #check that R environment can read your hyalite script.R file 
#source(name) #run script 