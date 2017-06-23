#data getter
#this will dl the zip from coursera site
#put zip in passed directory (create if needed)
#unzip downloaded files to passed subdir (create if needed, clear dir if arg passed)
#message to console after each step

#download zip
zipData.Url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
zipData.Folder <- "C:\\Users\\sheri\\Downloads\\classzip\\"
zipDataFiles.Folder <- "temp"
zipData.File <- "specdata.zip"


# one way or the other, we start with a clean directory
if(!dir.exists(zipData.Folder))
{
  dir.create(zipData.Folder)
  dir.create(paste(zipData.Folder, zipDataFiles.Folder))
} else
{
  file.remove(dir(path=zipData.Folder, pattern="*.*"))
}


#download the zip data file
zipData.FolderFile <- paste(zipData.Folder, zipData.File)
download.file(zipData.Url, zipData.FolderFile)


#unzip the zip data file into the data files subdir
unzip(zipData.FolderFile, exdir=paste(zipData.Folder, zipDataFiles.Folder))



# clean up by deleting everything we created
unlink(zipData.Folder, recursive=FALSE)
#delete all files in data file folder

#delte the data file folder

#delete all files in the zip folder

#delete the zip folder