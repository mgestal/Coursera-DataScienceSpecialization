rankall <- function(outcome, num = "best") {
  
  
  ## Check that state and outcome are valid
  ## Read outcome data
  
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## check that the outcome are valid
    
  validOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% validOutcomes)) stop("invalid outcome")
  
  ## lblOutcome will contains the label for the Hospital 30 day death mortality 
  ## rates from the outcome specified as parameter
  
  if (outcome=="heart attack") {
    lblOutcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }
  
  if (outcome=="heart failure") {
    lblOutcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }
  
  if (outcome=="pneumonia") {
    lblOutcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  
  states <- sort(unique(outcomeData$State))
  
  hospital <- rep(" ", length(states))
  
  for (i in 1:length(states)) {
  
    outcomeValues = outcomeData[outcomeData$State == states[i], c("Hospital.Name", lblOutcome)]
    outcomeValues[, lblOutcome] <- suppressWarnings( as.numeric(outcomeValues[, lblOutcome]) )
                       
    rankedOutcome <- rank(outcomeValues[, lblOutcome], na.last = TRUE)  

    rankedIdx <- NA
  
    if (num == "best") rankedIdx <- 1;
    if (num == "worst") rankedIdx <- length(rankedOutcome)      
    if (is.numeric(num)) { if (num <= length(rankedOutcome)) rankedIdx <- num }
    
    if (is.na(rankedIdx))
      hospital[i] <- NA
    else 
      hospital[i] <- outcomeValues$Hospital.Name[order(outcomeValues[, lblOutcome], 
                                                       outcomeValues$Hospital.Name)[rankedIdx]]   
  }

  return(data.frame(hospital=hospital, state=states))
  
}
  