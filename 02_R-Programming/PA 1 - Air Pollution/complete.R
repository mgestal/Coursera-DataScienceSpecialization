complete <- function(directory, id = 1:332) {
# Computes the number of complete cases for the monitor ID specificated
#  
# Args: 
#   directory: is a character vector of length 1 indicating
#              the location of the CSV files
#   id: is an integer vector indicating the monitor ID numbers
#        to be used
#
# Returns
#   A data frame of the form:
#       id nobs
#       1  117
#       2  1041
#       ...
#      where 'id' is the monitor ID number and 'nobs' is the
#      number of complete cases

  
  ## Initialize a vector to hold the measures
  counts <- vector()
  ids <- vector()
  
  ## Loop over the passed id's
  for(f in id) {
    
    ## Pad the f to create a filename
    filename <- sprintf("%03d.csv", f)
    file <- paste(directory, filename, sep="/")
    
    ## Load the data
    data <- read.csv(file)
    
    ids <- c(ids, f)
    
    ## Select number of complete cases
    completeCases <- data[complete.cases(data),]
    counts <- c(counts, nrow(completeCases))
  }

  data.frame(id=ids, nobs=counts)

}