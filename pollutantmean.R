pollutantmean <- function(directory="C:\\specdata", pollutant="sulfate", id=1:332)
{
  source('C:/cdjProgramming/testRrepo/moving_mean.R')

  # this can be set more finely based on filename if desired, say a TRUST_DATA_ENTRY flag
  setwd(directory)
  filePattern <- "\\.csv$"
  csvFiles <- list.files(pattern=filePattern)
  
  if (length(csvFiles) > 0)
  {
    data <- c()
    ans <- NA
    for (i in 1:length(csvFiles))
    {
        result <- tryCatch(
        {
          data <- read.csv(file=csvFiles[i], skip = 0000, nrows=10000)
          ans <- CM_control(c(data[[pollutant]]))
          #print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ", CM_control(data[,2])))
        }
        , warning <- function(w)
        {
          print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " WARNING"))
        }
        , error = function(e)
        {
          print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ERROR"))
          #WHEN I BREAK THE READ INTO CHUNKS THIS MEANS I HIT EOF
        }
        , finally <- 
        {
          #print("finally")
          #cleanup-code
        }
        
        #print("1")
        #print(paste(i, "ans", sep=" "))
    )

    print(paste(i, tail(ans, n=1), sep=" "))

    next
  }
    }
    else
    {
      print("No matching files to process.")
    }
}



