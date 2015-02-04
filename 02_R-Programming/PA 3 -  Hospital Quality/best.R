##
## best.R : returns the hospital name with the lowest outcome rate in the state
##
## Tests:
##
## best("TX", "heart attack")
## best("TX", "heart failure")
## best("MD", "heart attack")
## best("MD", "pneumonia")
## best("BB", "heart attack")

best <- function(state, outcome) {
  
  ## Read outcome data
  
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## check that the state and outcome are valid
  
  if (sum(state == outcomeData$State)==0) stop("invalid state")
  
  validOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% validOutcomes)) stop("invalid outcome")
  
  
  ## lblOtcome will contains the label for the Hospital 30 day death mortality 
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
  
  ## The mortality rate is converted to numeric value
  outcomeData[, lblOutcome] <- suppressWarnings(as.numeric(outcomeData[, lblOutcome]))
  
  ## Hospitals in the state 
  stateHospitals <- outcomeData[outcomeData$State == state, ]
  
  ## Indexes for the hospitals in the state with the minimum outcome value
  minOutcomeIdx <- which(stateHospitals[, lblOutcome] == 
                           min(stateHospitals[, lblOutcome], na.rm=TRUE))
   
  ##Hospitals in the state that has an outcome equal to the mininum value
  hospitalNames <- sort(stateHospitals[minOutcomeIdx, "Hospital.Name"])
  
  result <- sort(hospitalNames)
 
  return(result)
  
}
