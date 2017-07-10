cumulative_mean <- function(prev_step=c(1, 0), new_data=c())
{
  # easy sample data argument: new_data=sample(0:100,100,replace=T)
   
  if (length(new_data) == 0)
  {
    return("done!")
  }
  else
  {
    #prev_step[1] = current time tick step
    #prev_step[2] = previous mean

    if (!is.na(new_data[1]))
    {
      new_mean <- ((prev_step[1] - 1) / prev_step[1] * prev_step[2]) + ((1/prev_step[1]) * new_data[1])
      new_tick <- prev_step[1] + 1
    }
    else
    {
      new_tick <- prev_step[1]
      new_mean <- prev_step[2]
    }
    result <- c(prev_step[1], new_data[1], new_mean)
    print(result)
    
    return(cumulative_mean(c(new_tick, new_mean), new_data[-1]))
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
  
  print(data_matrix)
  
  #1) pass column by column to cumulative_mean
    #SO HOW DO I DO THIS???
  #2) after each, harvest the mean and # of data points
  #3) after all columns done, perform cumulative mean on that set of sub-means - VOILA!
}