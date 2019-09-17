setwd("C:/Users/malth/CNV/Ratios")
folder <- "C:/Users/malth/CNV/Ratios"

CN <- list.files(path = folder, recursive = TRUE, full.names = FALSE,)
CN                                                     

CN_read <- lapply(CN, function(x) {read.table(file = x, header = T, sep ="\t")})
CN_df <- do.call("cbind", lapply(CN_read, as.data.frame))

CN_clean <- data.frame(CN_df$Chromosome, CN_df$Start, CN_df$Sb1, CN_df$Sb2, CN_df$Sb3, CN_df$Sb4, CN_df$Sb5, CN_df$Sb6, CN_df$Sb8, CN_df$Sb9, CN_df$Sb10, CN_df$Sb11, CN_df$Sb12, CN_df$Sb13, CN_df$Sb14, CN_df$Sb15, CN_df$Sb16, CN_df$Sb18, CN_df$Sb20, CN_df$Sb21, CN_df$Sb22, CN_df$Sb23, CN_df$Sb24, CN_df$Sb25, CN_df$Sb26, CN_df$Sb27, CN_df$Sb28, CN_df$Sb29, CN_df$Sb34)
CN_clean
