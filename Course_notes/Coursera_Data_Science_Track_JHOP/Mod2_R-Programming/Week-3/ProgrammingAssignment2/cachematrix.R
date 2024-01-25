## R Week 3 Peer Review Assignment - Lexical Scoping ## 


# Part 1 

## The function, which creates a matrix that can cache it's inverse will proceed
## in the following order; it will set an empty object(matrix), cache this 
## object, using an anonymous function it will set the inverse of the object, 
## then get the inverse.

makeCacheMatrix <- function(x = matrix()){
  inv <- NULL # Set as an empty vector
  set <- function(q) { 
    x <<- q # Use scoping operators for cache function
    inv <<- NULL # Cache empty vector
  }
  get <- function() x # Anonymous function within function 
  setInverse <- function(inverse) inv <<- inverse # Set the inverse 
  getInverse <- function() inv # Get the inverse
  list(set = set, get = get, # Form them into a list that can be called
       setInverse = setInverse,
       getInverse = getInverse)
}


# Part 2 

## This function will call the function above and check whether the inverse
## of the matrix has been cached; if it has not, it will proceed to calculate
## the inverse, cache, and subsequently print it.  


cacheSolve <- function(x,...) {
  inv <- x$getInverse() # Call x from the function defined above
  if(!is.null(inv)) { # if it isn't empty, return the inverse value
    message("Returning the cached data")
    return(inv)
  }
  data <- x$get() # call the get function 
  inv <- solve(data, ...)  # Calculate the inverse 
  x$setInverse(inv) # Set the inverse and cache it
  inv # Print the inverse of the matrix 
}

# END 