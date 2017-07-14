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
        data <- read.csv(file=csvFiles[i], skip = 1000, nrows=2000)
        print(nrow(data))
      }
    
    next
    }
  }
  else
  {
    print("No matching files to process.")
  }
}