##
## rankhospital.R : Return hospital name in that state with the given rank
##

rankhospital <- function(state, outcome, num = "best") {
  
  ## Check that state and outcome are valid
  ## Read outcome data
  
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## check that the state and outcome are valid
  
  if (sum(state == outcomeData$State)==0) stop("invalid state")
  
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
  
  ## Hospitals with outcome in the state (discarding the hospitals with NAs in outcome) 
  stateHospitals <- outcomeData[outcomeData$State == state, c("Hospital.Name", lblOutcome)]
  stateHospitals[, lblOutcome] <- suppressWarnings( as.numeric(stateHospitals[, lblOutcome]) )
  stateHospitals <- stateHospitals[!is.na(stateHospitals[ , lblOutcome]), ]
  
  if (num == "best") num = 1;
  if (num == "worst") num = nrow(stateHospitals)
  
  if (num > nrow(stateHospitals)) return(NA)  # argument num is out of range
  
  # Sequence of hospitals in the state, ordered by outcome rate
  bestHospitalsSequence <- order(stateHospitals[, lblOutcome])  
  
  # Outcome rate of the hospital in position num
  hospitalRate <- stateHospitals[bestHospitalsSequence[num], lblOutcome]
  hospitalsInRateIdx <- stateHospitals[, lblOutcome]==hospitalRate
  
  # Return the first hospital (in alphabetical order) with the same rate
  return ( sort(stateHospitals[ hospitalsInRateIdx , "Hospital.Name"][1]) )
  
  # Another otion
  # return(stateHospitals$Hospital.Name[order(stateHospitals[, lblOutcome], stateHospitals$Hospital.Name)[num]])

  
}

