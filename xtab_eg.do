// Boschloo and Barnard on real data
clear
* import NHANES
use https://www.stata-press.com/data/r19/nhefs

* drop missing
drop if former_smoker_nh1==.
drop if sex_nhefs==.
* keep first 60 variables
keep in 1/60
tab sex_nhefs former_smoker_nh1, exact
xbtab sex_nhefs former_smoker_nh1