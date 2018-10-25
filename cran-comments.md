### Update package 2018-10-25 - qsort 0.2.3
* qsets datasets now appear as different objects
* qsort_score function changed accordingly

### Update package 2018-08-12 - qsort 0.2.2
* added Shields and Cicchetti’s (1997) emotion regulation scale to qsets$ccq
* added ORCID number of co-author David N. Sousa in the DESCRIPTION file

### Resubmission 2 addressing reviewer's comments
* DOIs moved inside parentheses
* single quotes added in the Description field
* updated print_cards() function's example as suggested
print_cards(qset = "aqs", desc_col = "description",
   dir.print = tempdir())
* after updating this example R CMD check results in a NOTE
Examples with CPU or elapsed time > 5s
            user system elapsed
print_cards 5.47   0.06    5.58



### Resubmission addressing reviewer's comments
* version numbers of references in the DESCRIPTION file
do not refer to any type of software output,
but only to the most current versions of the referred
psychological instruments
* DOIs for references in the DESCRIPTION file were added;
for one of the references without DOI we added and https link;
* removed the LICENSE file and added License: GPL-3 in the
DESCRIPTION FILE
* replaced \dontrun{} by \donttest{} in the example of the
print_cards() function
* print_cards() function now requires a directory to be specified


### First submission 2018-06-12 - qsort 0.2.1

## Test environments
* local Windows 8.1, R 3.5.0
* ubuntu 14.04 (on travis-ci), R 3.5.0

## R CMD check results
0 errors | 0 warnings | 0 note

## Reverse dependencies
This is a new release, so there are no reverse dependencies.
