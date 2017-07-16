pollutantmean <- function(directory="C:\\specdata", pollutant="sulfate", id=1:332)
{
  #let's see if this works
  source('C:/cdjProgramming/testRrepo/moving_mean.R')
  
  # 1) get all csv files in DIRECTORY
  # 2) if 0, then quit with msg

  # this can be set more finely based on filename if desired, say a TRUST_DATA_ENTRY flag
  setwd(directory)
  filePattern <- "\\.csv$"
  csvFiles <- list.files(pattern=filePattern)
  
  if (length(csvFiles) > 0)
  {
    data <- c()
    for (i in 1:length(csvFiles))
    {
        result <- tryCatch(
          {
            data <- read.csv(file=csvFiles[i], skip = 0000, nrows=10000)
            print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ", CM_control(data[,2])))
          }
          , warning <- function(w)
          {
            x <- 1
            print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " WARNING"))
            #warning-handler-code
          }
          , error = function(e)
          {
            x <- 1
            print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ERROR"))
            #WHEN I BREAK THE READ INTO CHUNKS THIS MEANS I HIT EOF
          }
          , finally <- 
          {
            #print("finally")
            #cleanup-code
          }
    )
    next
  }
    }
    else
    {
      print("No matching files to process.")
    }
}



