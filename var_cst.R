CN_cst<- read.csv("/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/CN_cst.csv")
CN_cst <- as.tbl(CN_cst) #convert dataframe to tibble 
var_cst <- summarise_at(CN_cst, vars(1:208889), var) #apply the variance function to each column, output new data frame
var_cst <- t(var_cst) #transpose dataframe, output matrix
colnames(var_cst) <- c("Total Variance") #name variable column
write.csv(CN_total, file = '/mnt/lustrefs/store/brancolab/2019fallProjects/sbrevVST/var_cst.csv') #save dataframe

##In Hyalite 
#library("tidyverse")
#library("stats")
#name <- "/enterhyalitepathtoyourscriptfilehere"
#file(name) #check that R environment can read your hyalite script.R file 
#source(name) #run script 