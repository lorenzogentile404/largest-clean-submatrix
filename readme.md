# Largest clean submatrix

Given a binary matrix *A* with *m* rows and *n* columns, find the largest submatrix containing non zero elements.
The algorithm is a MIP model implemented in R and based on [this](https://mathematica.stackexchange.com/questions/108299/given-a-large-binary-matrix-find-the-largest-submatrix-containing-non-zero-elem).
In the context of data cleaning, it may be used to remove from a dataset the NA values by deleting rows and columns, in a way that the minimum amount of useful data is wasted.

```
> m <- 10
> n <- 10
> A <- matrix(0, m, n)
> A <- apply(A, c(1,2), function(x) sample(c(0,1),1,prob=c(0.05,0.95)))
> A
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
 [1,]    1    1    1    1    1    1    1    1    1     1
 [2,]    1    1    1    1    1    1    1    1    1     1
 [3,]    1    1    1    1    1    1    1    1    1     1
 [4,]    1    1    0    1    1    1    1    1    1     1
 [5,]    1    1    1    1    0    1    1    1    1     1
 [6,]    1    1    1    1    1    1    1    1    0     1
 [7,]    1    1    1    0    1    1    1    1    1     1
 [8,]    1    1    1    1    1    1    1    1    1     1
 [9,]    1    1    1    1    1    0    1    1    1     0
[10,]    1    1    1    1    1    1    1    1    1     1
> largest_clean_submatrix(A)
Status: optimal
Objective value: 44
initial size:  10 x 10 
deleted rows:  0 0 0 0 0 1 0 0 1 0 
deleted columns:  0 0 1 1 1 0 0 0 0 0 
final size:  8 x 7 
     [,1] [,2] [,3] [,4] [,5] [,6] [,7]
[1,]    1    1    1    1    1    1    1
[2,]    1    1    1    1    1    1    1
[3,]    1    1    1    1    1    1    1
[4,]    1    1    1    1    1    1    1
[5,]    1    1    1    1    1    1    1
[6,]    1    1    1    1    1    1    1
[7,]    1    1    1    1    1    1    1
[8,]    1    1    1    1    1    1    1
```
