#install.packages("ompr")
#install.packages("ompr.roi")
#install.packages("dplyr")
#install.packages("ROI")
#install.packages("ROI.plugin.glpk")
#install.packages("ROI.plugin.cplex")
rm(list = ls())
library(dplyr)
library(ROI)
library(ROI.plugin.glpk)
library(ompr)
library(ompr.roi)

largest_clean_submatrix <- function(A) {
  m <- nrow(A)
  n <- ncol(A)
  result <- MIPModel() %>%
    add_variable(e[i,j], i = 1:m, j = 1:n, type = "binary") %>%
    add_variable(r[i], i = 1:m, type = "binary") %>%
    add_variable(c[j], j = 1:n, type = "binary") %>%
    set_objective(sum_expr(e[i,j], i = 1:m, j = 1:n), "min") %>%
    add_constraint(e[i, j] >= (1 - A[i,j]), i = 1:m, j = 1:n) %>%
    add_constraint(r[i] + c[j] >= e[i,j], i = 1:m, j = 1:n) %>%
    add_constraint(e[i,j] >= r[i], i = 1:m, j = 1:n) %>%
    add_constraint(e[i,j] >= c[j], i = 1:m, j = 1:n) %>%
    solve_model(with_ROI(solver = "glpk")) 
  r = get_solution(result, r[i])[['value']]
  c = get_solution(result, c[j])[['value']]
  print(result)
  cat("\ninitial size: ", m, "x", n, "\n")
  cat(c("delete rows: ", r,"\n"))
  cat(c("delete columns: ", c,"\n"))
  cat("final size: ", nrow(A[!r,!c]), "x", ncol(A[!r,!c]), "\n")
  return(A[!r,!c])
}

m <- 10
n <- 10
A <- matrix(0, m, n)
A <- apply(A, c(1,2), function(x) sample(c(0,1),1,prob=c(0.05,0.95)))
A
largest_clean_submatrix(A)

#A <- read.table("A.csv", quote="\"", comment.char="")
#A <- as.matrix(A)
#largest_clean_submatrix(A)
