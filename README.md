# Getting and Cleaning Data Project

## CondeBook.md

This markdown file contains more information about the raw source data and all the attributes.


## run_analysis.R
This is the script used to tidy the data set.
It contains 5 distinct steps.

1. Column bind all test and train data. Rowbind both data sets to the full sample
2. Calculate mean and standard deviation values for all variables
3. Reading in activities and placing decripte activities instead of levels.
4. Label the data set with approriate label names
5. Redo step 1 and 2,Calculate mean and standard deviation values for all variables