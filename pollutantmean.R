pollutantmean <- function(directory="specdata", pollutant="sulfate", id=1:332)
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
  
  if (pollutant %in% colnames(data))
  {
    ans <- CM_control(c(data[[pollutant]]))
    colnames(ans) <- c("Observations", "Mean")
    print(tail(ans, n=1)[2])
    #print(tail(ans, n=1))
  }
  else
  {
    stop(paste("Column", pollutant, "does not exist in the dataset. Breaking execution.", sep=" "))
  }
}


cumulative_mean <- function(prev_step=c(1, 0), data=c())
{
  # calculates mean cumulatively by recursion against obvious recurrence formula for mean
  
  if (length(data) > 0)
  {
    #prev_step[1] = current time tick step
    #prev_step[2] = previous mean
    
    if (!is.na(data[1]))
    {
      new_mean <- ((prev_step[1] - 1) / prev_step[1] * prev_step[2]) + ((1/prev_step[1]) * data[1])
      new_tick <- prev_step[1] + 1
    }
    else
    {
      new_tick <- prev_step[1]
      new_mean <- prev_step[2]
    }
    result <- c(prev_step[1], data[1], new_mean)
    #print(result)
    
    return(cumulative_mean(c(new_tick, new_mean), data[-1]))
  }  
  else
  {
    result <- c(prev_step[1]-1, prev_step[2])
    return(result)
  }
  
}

CM_control <- function(data=c(), mr=floor(sqrt(length(data))))
{
  # Avoids recursion stack overflow in cumulative_mean function by breaking the input into smaller chunks and feeding
  # intermediate results back into cum_mean.
  #
  # This computes the entire mean cumulatively. It would be easily adapted to parallelization by collecting the column means
  # indivdually, and then cum_mean-ing them as last step.
  #
  # This also could be adapted to streaming data.
  #
  # example usage: CM_control(data=10*rcauchy(10000))
  
  oldw <- getOption("warn")
  options(warn = -1)
  
  max_rows <- mr
  length(data) <- prod(dim(matrix(data, nrow=max_rows)))
  data_matrix <- matrix(data, nrow=max_rows)
  
  options(warn = oldw)
  
  #print(data_matrix)
  
  start.time <- Sys.time()
  
  seed <- c(1, 0)
  result_list <- c()
  for (i in 1:ncol(data_matrix))
  {
    #print(c("seed at start of loop: ", c(i, seed)))
    
    seed <- cumulative_mean(seed, data_matrix[,i])
    result_list <- c(result_list, c(seed))
    
    #need to advance the tick
    seed[1] <- seed[1]+1
    
    #print(c("seed at end of loop: ", c(i, seed)))
    next
  }
  
  end.time <- Sys.time()
  time.taken <- end.time - start.time
  #print(paste("ET: ", time.taken))
  
  result_matrix <- matrix(result_list, ncol=2, byrow=TRUE)
  matplot(result_matrix[,1], result_matrix[,2], type="b", pch=0, xlab="Step", ylab="Average")
  return(result_matrix)
  
  #print(matrix(result_list, ncol=2, byrow=TRUE))
}

