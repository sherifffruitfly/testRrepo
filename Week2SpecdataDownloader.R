testfun1 <- function(x){x^2}
testfun2 <- function(x, y){testfun1(x) * y}
currmean <- 0
currnum <- 0
runningmean <- function(k, x_k, M_k1){
  if(1==1)
  {
    
  }
}

#
# am i gonna do this running average file by file, or datapoint by datapoint?
# ie point by point i can do the recursion k, xk, Mk-1
# but file by file it makes sense to do weighted average of averages file by file - WeightedAverage(M1, k1, M2, k2)


#data getter
#this will dl the zip from coursera site
#put zip in passed directory (create if needed)
#unzip downloaded files to passed subdir (create if needed, clear dir if arg passed)
#message to console after each step

#download zip
zipData.Url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
zipData.Folder <- "C:\\classzip"
zipDataFiles.Folder <- "\\temp"
zipData.File <- "specdata.zip"
zipData.PathFile <- paste(zipData.Folder, "\\", zipData.File, sep="")
zipData.TempFolder <- paste(zipData.Folder, zipDataFiles.Folder, sep="")

# # one way or the other, we start with a clean directory
# if(dir.exists(zipData.Folder))
# {
#   print(paste("data directories already exist - wiping files for a clean start: ", zipData.Folder))
#   #file.remove(dir(path=zipData.Folder, pattern="*.*"))
#   unlink(zipData.Folder, recursive=TRUE)
# }
# 
# print(paste("creating zipdata.folder: ", zipData.Folder))
# dir.create(zipData.Folder)
# 
# print(paste("creating zipdatafiles.folder subdir: ", zipDataFiles.Folder))
# dir.create(paste(zipData.Folder, zipDataFiles.Folder, sep=""))
# 
# 
# 
# #download the zip data file
# zipData.FolderFile <- paste(zipData.Folder, "\\", zipData.File)
# print(paste("downloading data: ", zipData.FolderFile, sep=""))
# download.file(zipData.Url, zipData.FolderFile)
# 
# 
# #unzip the zip data file into the data files subdir
# cat(paste("unzipping: \n",  zipData.Folder, zipDataFiles.Folder, sep=""))
# unzip(zipData.FolderFile, exdir=paste(zipData.Folder, zipDataFiles.Folder))

#delete all files from temp\ directory
unlink(paste(zipData.TempFolder, "\\*", sep=""))

#unzip the data files into temp\ directory
unzip(zipData.PathFile, exdir=zipData.TempFolder)






#COMMENT THIS OUT UNTIL ALL DONE AND NEEDED
# clean up by deleting everything we created
#unlink(zipData.Folder, recursive=TRUE)
