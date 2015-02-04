[local copy of the forked repository from rdpeng/ProgrammingAssignment2]

#' Cache Inverse Matrix
#' 
#' Creates a special matrix object that can cache its inverse. This special
#' matrix is really a list with the following functions:
#' \itemize{
#'    \item set : set the value of the matrix (\code{x})
#'    \item get : get the original matrix (\code{x})
#'    \item setInverse: set the inverse for matrix \code{x}
#'    \item getInverse: get the inverse for matrix \code{x}
#' }
#' 
#' @param m Matrix to be stored in the CacheMatrixObjet
#' 
#' @return An special object that will cache the inverse of a matrix
#' 
#' @examples
#' cacheMatrix <- makeCacheMatrix(x)
#' cacheMatrix$setInverse(inverseMatrix)
#' inverseMatrix <- cacheMatrix$getInverse
#' 
#' @seealso \code{\link{cacheSolve}}
#' 
#' @author Marcos Gestal (c) 2015
makeCacheMatrix <- function( x = matrix() ) {
  
  # Property to cache the inverse matrix
  invMatrix <- NULL
  
  ## Set the original matrix
  set <- function( matrix ) {
    x <<- matrix
    invMatrix <<- NULL
  }
  
  # Get the matrix
  get <- function() x
  
  # Set the inverse of the matrix
  setInverse <- function(inverse) invMatrix <<- inverse
  
  # Get the inverse of the matrix x
  getInverse <- function() invMatrix

# List with the exposed methods
list(set = set, 
     get = get,
     setInverse = setInverse,
     getInverse = getInverse)
}


#' Inverse Matrix Cache Solve
#' 
#' Calculates the inverse matrix of the special "matrix" object (created 
#' with \link{makeCacheMatrix}). First it is checked whether the reverse 
#' matrix is already calculated. If so (and if the matrix has not changed), 
#' it returns the cached inverse matrix. Otherwise, it calculates the 
#' inverse matrix and stores it in the cache using the setInverse method 
#' from the cache matrix object
#' 
#' @param x Cache Matrix from which inverse will be calculated
#' @param ... Further arguments passed to or from other methods
#' 
#' @return Return the inverse of the cacheMatrix \code{x}
#' 
#' @examples
#' inverseMatrix <- cacheSolve(my_cacheMatrix)
#' 
#' @seealso \code{\link{makeCacheMatrix}}
#' 
#' @author Marcos Gestal (c) 2015
cacheSolve <- function(x, ...) {
  
  invMatrix <- x$getInverse()
  
  # check if inverse matrix is already cached
  if(!is.null(invMatrix)) {
    message("Inverse Matrix: getting cached data")
    return(invMatrix)
  }
  
  # compute inverse matrix and store it in cacheMatrix
  data <- x$get()
  invMatrix <- solve(data, ...)
  x$setInverse(invMatrix)
  
  # return inverse matrix
  invMatrix      
}