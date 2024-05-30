# airline_list 
airline_list <- airlines %>%
  collect() %>%
  split(.$name) %>%
  map(~ .$carrier)

month_list <- as.list(1:12) %>%
  set_names(month.name)

month_list$`All Year` <- 99



