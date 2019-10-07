CN_total<- read.csv("/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/CN_total.csv") 
CN_total <- as.tbl(CN_total) #convert dataframe to tibble 
var_total <- summarise_at(CN_total, vars(1:208889), var) #apply the variance function to each column, output new data frame
var_total <- t(var_total) #transpose dataframe, output matrix
colnames(var_total) <- c("Total Variance") #name variable column
write.csv(CN_total, file = '/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/var_total.csv') #save dataframe

#In Hyalite 
#library("tidyverse")
#library("stats")
#name <- "/enterhyalitepathtoyourscriptfilehere"
#file(name) #check that R environment can read your hyalite script.R file 
#source(name) #run script 