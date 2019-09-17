pkg <- c("stringr", "reshape2",  "dplyr", "ggplot2",  "magrittr")

new.pkg <- pkg[!(pkg %in% installed.packages())]

if (length(new.pkg)) {
  install.packages(new.pkg)
}

library(stringr)
library(reshape2)
suppressPackageStartupMessages(library(dplyr))
library(ggplot2)

setwd("C:/Users/malth/CNV/Ratios")
folder <- "C:/Users/malth/CNV/Ratios"
CN <- list.files(path = folder, recursive = TRUE, full.names = FALSE,)
CN                                                     

CN_read <- lapply(CN, function(x) {read.table(file = x, header = T, sep ="\t")})
CN_df <- do.call("cbind", lapply(CN_read, as.data.frame))
