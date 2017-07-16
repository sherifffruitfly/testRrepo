pollutantmean <- function(directory="C:\\specdata", pollutant="sulfate", id=1:332)
{
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
      #print(paste("file ", i, " - ", csvFiles[i]))
      if (i == 1)
      {
        result <- tryCatch(
          {
            data <- read.csv(file=csvFiles[i], skip = 000, nrows=2000)
            print(nrow(data))
          }
          , warning <- function(w)
          {
            x <- 1
            print("warning")
            #warning-handler-code
          }
          , error = function(e)
          {
            x <- 1
            print("error")
            #error-handler-code
          }
          , finally <- 
          {
            print("finally")
            #cleanup-code
          }
        )
      }
      
    next
  }
    }
    else
    {
      print("No matching files to process.")
    }
}



