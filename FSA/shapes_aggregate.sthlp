{smcl}
{it:v. 2.3.0}


{title:github}

{p 4 4 2}
{bf:shapes_aggregate} is a program for returning outputs compatible with the SHAPES output structure
{space 1}as well as import dependencies from 
{browse "http://www.github.com/WFP-VAM/RAMResourceScripts":GitHub} website


{title:Syntax}

{p 8 8 2} {bf:shapes_aggregate} [ {it:if} ] [ {it:in} ] [, {it:options} ]


{title:Description}

{p 4 4 2}


{title:Options}

{p 4 4 2}
The {bf:shapes_aggregate} command also takes several options for calculating median 
and for putting together by a list of grouping variables. All this is handled through varlists.
Note that variables can be included only in one of the three varlists included. 
If Household weights are missing, they're assumed 1.


{p 4 4 2}{bf:{bf:shapes_aggregate} options:}

{col 5}{it:option}{col 18}{it:Description}
{space 4}{hline}
{col 5}grouping({it:varlist}){col 18} requires at least 1 variable. Blocks process if a variable has 50 or more options and if one class has less than 30 observations.
{col 5}mean({it:varlist}){col 18} calculates the average for this list of variables
{col 5}median({it:varlist}){col 18} calculates median
{space 4}{hline}

