{smcl}
{* *! version 1.0.0  07jun2025}{...}
{vieweralsosee "[R] tabulate twoway" "mansection R tabulatetwoway"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] fisher" "help fisher"}{...}
{vieweralsosee "[R] tabulate" "help tabulate"}{...}
{viewerjumpto "Syntax" "xbtab##syntax"}{...}
{viewerjumpto "Description" "xbtab##description"}{...}
{viewerjumpto "Options" "xbtab##options"}{...}
{viewerjumpto "Remarks" "xbtab##remarks"}{...}
{viewerjumpto "Examples" "xbtab##examples"}{...}
{viewerjumpto "Stored results" "xbtab##results"}{...}
{viewerjumpto "References" "xbtab##references"}{...}
{title:Title}

{phang}
{bf:xbtab} {hline 2} Extended 2x2 contingency table analysis with exact tests


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:xbtab}
{it:rowvar} {it:colvar}
{ifin}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xbtab} performs 2x2 contingency table analysis and computes three exact statistical tests:
Fisher's exact test, Barnard's exact test, and Boschloo's exact test. The command creates
a cross-tabulation of two categorical variables and returns p-values for testing independence.

{pstd}
This command requires Python integration with SciPy installed, as it uses Python's
{cmd:scipy.stats} module to perform the exact tests.


{marker options}{...}
{title:Options}

{pstd}
{cmd:xbtab} takes no options. The command automatically performs all three exact tests
and displays results.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:xbtab} is designed specifically for 2x2 contingency tables. Both variables must
be binary or have exactly two categories after applying any {cmd:if} or {cmd:in} conditions.

{pstd}
The three exact tests provided are:

{phang2}
{bf:Fisher's exact test}: The classical exact test for 2x2 tables, conditioning on
both marginal totals.

{phang2}
{bf:Barnard's exact test}: An unconditional exact test that conditions only on the
total sample size, generally more powerful than Fisher's test.

{phang2}
{bf:Boschloo's exact test}: A hybrid approach that combines aspects of Fisher's and
Barnard's tests, often providing the most powerful exact test.

{pstd}
All tests use two-sided alternatives and test the null hypothesis of independence
between the row and column variables.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse highschool}{p_end}

{pstd}Basic 2x2 contingency table analysis{p_end}
{phang2}{cmd:. xbtab race sex}{p_end}

{pstd}Analysis with conditions{p_end}
{phang2}{cmd:. xbtab treatment outcome if group == 1}{p_end}

{pstd}Using binary variables{p_end}
{phang2}{cmd:. generate success = (score > 70)}{p_end}
{phang2}{cmd:. generate treated = (group == "treatment")}{p_end}
{phang2}{cmd:. xbtab success treated}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:xbtab} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(fisher_pvalue)}}p-value from Fisher's exact test{p_end}
{synopt:{cmd:r(barnard_pvalue)}}p-value from Barnard's exact test{p_end}
{synopt:{cmd:r(boschloo_pvalue)}}p-value from Boschloo's exact test{p_end}


{marker references}{...}
{title:References}

{phang}
Barnard, G. A. 1947. Significance tests for 2×2 tables. {it:Biometrika} 34: 123-138.

{phang}
Boschloo, R. D. 1970. Raised conditional level of significance for the 2×2-table 
when testing the equality of two probabilities. {it:Statistica Neerlandica} 24: 1-9.

{phang}
Fisher, R. A. 1922. On the interpretation of χ² from contingency tables, and the 
calculation of P. {it:Journal of the Royal Statistical Society} 85: 87-94.


{title:Author}

{pstd}
Alun Hughes{break}
University College London{break}
Department of Population Science & Experimental Medicine{break}
London, UK{break}
{browse "mailto:alun.hughes@ucl.ac.uk"}


{title:Also see}

{psee}
Manual: {bf:[R] tabulate twoway}

{psee}
Online: {helpb tabulate}, {helpb fisher}, {helpb tabi}