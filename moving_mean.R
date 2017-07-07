cumulative_mean <- function(prev_step=c(1, 0), new_data=c())
{
  options(expressions=100000)
  
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
