cumulative_mean <- function(prev_step=c(1, 0), data=c())
{
  # easy sample data argument: cumulative_mean(new_data=sample(0:100,100,replace=T))

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
  print(paste("ET: ", time.taken))
  
  return(seed)
    
  #print(matrix(result_list, ncol=2, byrow=TRUE))
}