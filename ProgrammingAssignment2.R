#Make a matrix that can cache its inverse

makeCacheMatrix <- function(x = matrix(
        )) {   #input x will be a matrix
        i <- NULL                             # reset i each time. i will be the inverse matrix

        set <- function(y) {                    
                x <<- y                 
                i <<- NULL
        }
        get <- function() x     # returns the value of first matrix
        setinv <- function(solve) i <<- solve  #called by cachesolve on first run, and cache the value for i
        getinv <- function() i                # return the cached value of i if it exists
        list(set = set, get = get,            #list of the functions which can be used in cacheSolve
             setinv = setinv,
             getinv = getinv)
}

# compute the inverse of the matrix object returned by makeCacheMatrix above
# If the inverse has already been calculated then rtn the cached value and bypass the calculation phase

cacheSolve <- function(x, ...) {
        i <- x$getinv()
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinv(i)
        i
}

#test lines, uncomment to try
     mat <- matrix(rnorm(100),10,10)
mat <- matrix(rnorm(10000),100,100)
     test <- makeCacheMatrix(mat)
     cacheSolve(test)
