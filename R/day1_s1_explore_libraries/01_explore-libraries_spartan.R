#' Which libraries does R search for packages?

.libPaths()


#' Installed packages

installed.packages()

## use installed.packages() to get all installed packages

## how many packages?

nrow(installed.packages())

# 554


#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on
 
library(dplyr)

inst <- installed.packages() %>% tbl_df()
inst  %>% count(LibPath) # obviously 1
inst %>% count(Priority)
inst %>% count(NeedsCompilation) %>% mutate(prop = n/sum(n))
inst %>% count(License)
inst %>% count(Built)


#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
