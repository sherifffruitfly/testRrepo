complete <- function(directory="C:\\specdata", id=1:332)
{
  # this can be set more finely based on filename if desired, say a TRUST_DATA_ENTRY flag
  setwd(paste("C:\\", directory, sep=""))
  filePattern <- "\\.csv$"
  csvFiles <- list.files(pattern=filePattern)
  
  if (length(csvFiles) > 0)
  {
    data <- c()
    ans <- NA
    for (i in id)
    {
      if (i %% 1 != 0 || i < 1)
      {
        print(paste("skipping ", i, sep=" "))
        next  # we only attempt to process positive integers
      }
      
      #print(i)
      #print(csvFiles[i])
      result <- tryCatch(
        {
          data <- rbind(data, read.csv(file=csvFiles[i], skip = 0000, nrows=10000))
          #print(nrow(data))
          #ans <- CM_control(c(data[[pollutant]]))
          #print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ", CM_control(data[,2])))
        }
        , warning <- function(w)
        {
          print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " WARNING"))
        }
        , error = function(e)
        {
          #print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ERROR"))
          #WHEN I BREAK THE READ INTO CHUNKS THIS MEANS I HIT EOF (OR NO FILE)
        }
        , finally <- 
        {
          #print("finally")
          #cleanup-code
        }
        
        #print("1")
        #print(paste(i, "ans", sep=" "))
      )
      next
    }
  }
  else
  {
    print("No matching files to process.")
  }
  
  
  
  # return dataframe like:
  # id  nobs
  # 1   234
  # 2   9053
  # 3   342
  #
  # here nobs indicates the total # of COMPLETE observations - neither sulfate nor nitrate are NA
}