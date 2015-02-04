pollutantmean <- function(directory, pollutant, id = 1:332) {
# Computes the mean of the pollutant across the monitors list
# in the 'id' vector
#
# Args: 
#     directory: character vector of length 1 indicating
#                the location of the CSV files  
#     pollutant: is a character vector of length 1 indicating
#                the name of the pollutant for which we will calculate 
#                the mean; either "sulfate" or "nitrate".
#     id: integer vector indicating the monitor ID numbers to be used
# 
#  Returns:
#    The mean of the pollutant across all monitors list in the 
#    'id' vector (ignoring NA values)

  
  ## Initialize a vector to hold the measures
  measures <- vector()
  
  ## Loop over the passed id's
  for(f in id) {
    
    ## Pad the f to create a filename
    filename <- sprintf("%03d.csv", f)
    file <- paste(directory, filename, sep="/")
    
    ## Load the data
    data <- read.csv(file)
    
    ## Select desidered column, discarding NAs values
    d <- data[,pollutant]
    d <- d[!is.na(d)]

    measures <- c(measures, d)
  }
  
  ## Return the mean
  round(mean(measures), 3)
  
}