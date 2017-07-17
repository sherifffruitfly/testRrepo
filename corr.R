corr <- function(directory="specdata", threshold=0)
{
  source("C:\\cdjProgramming\\coursera\\r\\_scratch\\firstgithubproject\\complete.R")
  #source("c:\\cdjProgramming\\testRrepo\\complete.R")
  
  result <- tryCatch(
    {
      fullpath <- paste("C:\\", directory, sep="")
      setwd(fullpath)
    }
    , warning = function(w) 
    {
      #warning-handler-code
    }
    , error = function(e) 
    {
      stop(paste("Error setting working directory ", fullpath, " :\n\n", e))
    }
    , finally <-  
    {
      #cleanup-code
    }
  )
  
  filePattern <- "\\.csv$"
  csvFiles <- list.files(pattern=filePattern)
  
  if (length(csvFiles) > 0)
  {
    data <- c()
    ans <- numeric()
    for (i in 1:length(csvFiles))
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
          #print("before reading file")
          data <- read.csv(file=csvFiles[i], skip = 0000, nrows=10000)
          
          #print(paste("before: ", nrow(data)))
          data <- na.omit(data)
          #print(paste("after: ", nrow(data)))
          if (nrow(data) > threshold)
          {
            correl <- cor(data$sulfate, data$nitrate)
            #print(correl)
            ans <- c(ans, correl)
          }
          else
          {
            #print("blocked")
          }
        }
        , warning <- function(w)
        {
          print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " WARNING"))
        }
        , error = function(e)
        {
          print(paste("file ", i, " - ", csvFiles[i], " ", nrow(data), " rows", " ERROR: ", e))
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
  
  #names(ans)<-c("Correlation")
  return(ans)
  
}