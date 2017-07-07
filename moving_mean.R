#need to figure out how to feed a vector to it sequentially w/ results

cumulative_mean <- function(prev_step=c(1, 0), new_data=0)
{
  #prev_step[1] = current time tick step
  #prev_step[2] = previous mean
  
  new_mean <- ((prev_step[1] - 1) / prev_step[1] * prev_step[2]) + ((1/prev_step[1]) * new_data)
  new_tick <- prev_step[1] + 1
  
  result <- c(new_tick, new_mean)
  result
}


cm_control <- function(vector_data=0)
{
  #temp hardcoding the argument
  data = c(3, 7, 4, 2)
  
  r1 <- cumulative_mean(new_data=data[1])
  r2 <- cumulative_mean(r1, data[2])
  r3 <- cumulative_mean(r2, data[3])
  r4 <- cumulative_mean(r3, data[4])
  
  print(r1)
  print(r2)
  print(r3)
  print(r4)
  
}