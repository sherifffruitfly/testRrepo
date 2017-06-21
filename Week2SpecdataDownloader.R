#data getter
#this will dl the zip from coursera site
#put zip in passed directory (create if needed)
#unzip downloaded files to passed subdir (create if needed, clear dir if arg passed)
#message to console after each step

#download zip
zipdataurl <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
zipdatadesty <- "C:\\Users\\sheri\\Downloads\\specdata.zip"

#> URL      <- "http://rfunction.com/code/1202/120222.R"
#> destfile <- "downloaded/120222.R"
#> download.file(URL, destfile)

download.file(zipdataurl, zipdatadesty)