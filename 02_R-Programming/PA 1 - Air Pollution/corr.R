corr <- function(directory, threshold = 0) {
# Computes the correlation value between the pollutants (nitrate and sulfate)
# considering only those observations with more than 'threshold" complete 
# observations

# Args: 
#   directory: a character vector of length 1 indicating
#              the location of the CSV files
#   threshold: a numeric vector of length 1 indicating the
#              number of completely observed observations (on all
#              variables) required to compute the correlation between
#              nitrate and sulfate; the default is 0
#  
# Returns:
#   A numeric vector of correlations

  completes <- complete(directory, 1:332)
  completes <- subset(completes, nobs > threshold )
  
  ## Initialize variables
  correlations <- vector()
  
  ## Loop over the passed id's
  for(i in completes$id ) {
    
    ## Pad the i to create a filename
    filename <- sprintf("%03d.csv", i)
    filepath <- paste(directory, filename, sep="/")
    
    ## Load the data
    data <- read.csv(filepath)
    
    ## Calculate and store the count of complete cases
    completeCases <- data[complete.cases(data),]
    
    ## Calculate correlation value
      correlations <- c(correlations, cor(completeCases$nitrate, completeCases$sulfate) )
  }
  
  ## Return a numeric vector of correlations
  correlations
}