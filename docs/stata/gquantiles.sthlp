{smcl}
{* *! version 0.2.1 08Nov2017}{...}
{viewerdialog gquantiles "dialog gquantiles"}{...}
{vieweralsosee "[R] gquantiles" "mansection R gquantiles"}{...}
{viewerjumpto "Syntax" "gquantiles##syntax"}{...}
{viewerjumpto "Description" "gquantiles##description"}{...}
{viewerjumpto "Options" "gquantiles##options"}{...}
{viewerjumpto "Stored results" "gegen##results"}{...}
{title:Title}

{p2colset 5 19 23 2}{...}
{p2col :{cmd:gquantiles} {hline 2}}Efficiently compute percentiles (quantiles), categories, and frequencies.{p_end}
{p2colreset}{...}

{pstd}
{it:Note for Windows users}: It may be necessary to run
{opt gtools, dependencies} at the start of your Stata session.

{marker syntax}{...}
{title:Syntax}

{phang}
gquantiles can function as a fast alternative to {cmd:xtile}, {cmd:pctile},
and {cmd:_pctile}, though ultimately it offers more functionality that those
Stata commands.

{phang}
Create variable containing percentiles (equivalent to {cmd:pctile})

{p 8 15 2}
{cmd:gquantiles}
{newvar} {cmd:=} {it:{help exp}}
{ifin}
{cmd:,}
pctile
[{opth nquantiles(int)}
{opth genp(newvarname)}
{opt altdef}]

{phang}
Create variable containing quantile categories (equivalent to {cmd:xtile})

{p 8 15 2}
{cmd:gquantiles}
{newvar} {cmd:=} {it:{help exp}}
{ifin}
{cmd:,}
xtile
[{opth nquantiles(int)}
{opth cutpoints(varname)}
{opt altdef}]

{p 8 15 2}
{cmd:fasterxtile}
{newvar} {cmd:=} {it:{help exp}}
{ifin}
{cmd:,}
[{opth nquantiles(int)}
{opth cutpoints(varname)}
{opt altdef}]

{phang}
Compute percentiles and store them in r() (equivalent to {cmd:_pctile})

{p 8 15 2}
{cmd:gquantiles}
{it:{help exp}}
{ifin}
{cmd:,}
_pctile
[{opth nquantiles(int)}
{opth percentiles(numlist)}
{opt altdef}]

{pstd}
The full syntax, however, is

{p 8 15 2}
{cmd:gquantiles}
[{newvar} {cmd:=}] {it:{help exp}}
{ifin}
{cmd:,}
{c -(}{cmd:pctile}{c |}{cmd:xtile}{c |}{cmd:_pctile}{c )-}
{it:{help gquantiles##quantiles_method:quantiles_method}}
[{it:{help gquantiles##gquantiles_options:gquantiles_options}}]

{synoptset 22 tabbed}{...}
{marker quantiles_method}{...}
{synopthdr}
{synoptline}
{syntab :Quantiles method}

{synopt :{opt n:quantiles(#)}}number of quantiles; default is {cmd:nquantiles(2)}
{p_end}
{synopt :{opth p:ercentiles(numlist)}}calculate percentiles corresponding to the specified percentages
{p_end}
{synopt :{opth c:utpoints(varname)}}use values of {it:varname} as cutpoints
{p_end}
{synopt :{opth cutoffs(numlist)}}use values of {it:numlist} as cutpoints
{p_end}
{synopt :{opth cutquantiles(numlist)}}calculate percentiles corresponding to the values of {it:varname}
{p_end}

{synoptset 18 tabbed}{...}
{marker gquantiles_options}{...}
{synopthdr}
{synoptline}
{syntab :Options}

{synopt :{opth g:enp(newvar:newvarp)}}generate {it:newvarp} variable containing percentages
{p_end}
{synopt :{opt alt:def}}use alternative formula for calculating percentiles
{p_end}

{syntab:Extras}
{synopt :{opt _pctile}} Do the computation in the style of {cmd:_pctile}
{p_end}
{synopt :{cmd:pctile}[{cmd:(}{newvar}{cmd:)}]} Store percentiles in {it:newvar}. If {it:newvar} is not specified, then this indicates to do the computations in the style of {cmd:pctile}.
{p_end}
{synopt :{cmd:xtile}[{cmd:(}{newvar}{cmd:)}]} Store quantile categories in {it:newvar}. If {it:newvar} is not specified, then this indicates to do the computations in the style of {cmd:xtile}.
{p_end}
{synopt :{cmd:binfreq}[{cmd:(}{newvar}{cmd:)}]} Store the frequency counts of the source variable in the quantile categories in {it:newvar}. If {it:newvar} is not specified, this is stored in {hi:r(quantiles_bincount)} or {hi:r(cutoffs_bincount)}
{p_end}
{synopt :{cmd:binpct}[{cmd:(}{newvar}{cmd:)}]} Same as {it:binfreq} but it computes percentages. If {it:newvar} is not specified, this is stored in {hi:r(quantiles_binpct)} or {hi:r(cutoffs_binpct)}
{p_end}

{syntab:Switches}
{synopt :{opt method(#)}} Algorithm to use to compute quantiles.
{p_end}
{synopt :{opt dedup}} Drop duplicate values of variables specified via {opth cutpoints} or {opth cutquantiles}
{p_end}
{synopt :{opt cutifin}} Exclude values outside {ifin} of variables specified via {opth cutpoints} or {opth cutquantiles}
{p_end}
{synopt :{opt returnlimit(#)}} Maximum return values that can be set via {opt _pctile}
{p_end}
{synopt :{opt strict}} Exit with error if the number of quantiles requested via {opt nquantiles(#)} is greater than the number of non-missing observations plus one.
{p_end}
{synopt :{opt minmax}} Additionally store the min and max in {hi:r(min)} and {hi:r(max)}
{p_end}
{synopt :{opt replace}} Replace targets, should they exist.
{p_end}

{syntab:Gtools}
{synopt :{opt v:erbose}}Print info during function execution.
{p_end}
{synopt :{opt bench:mark}}Benchmark various steps of the plugin.
{p_end}
{synopt :{opth hashlib(str)}}(Windows only) Custom path to {it:spookyhash.dll}.
{p_end}

{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}

{pstd}
{cmd:gquantiles} replaces {cmd:xtile}, {cmd:pctile}, and {cmd:_pctile}.
While weights are not yet supported, gquantiles offers several additional
options above the three built-in Stata commands. gquantiles is also faster
than the user-written fastxtile, so an alias, fasterxtile, is also provided.

{pstd}
Weights are currently not supported. But {cmd:gquantiles} can compute an 
arbitrary number of quantiles, can deal with arbitrary cutoffs, can compute
frequency counts of the categories, can compute {cmd:pctile} and {cmd:xtile}
at the same time, and so on.

{pstd}
{opt gquantiles} is part of the {manhelp gtools R:gtools} project.

{marker options}{...}
{title:Options}

{dlgtab:Quantiles method}

{phang}
{opt n:quantiles(#)} specifies the number of quantiles.
It computes percentiles corresponding to percentages 100*k/m
for k=1, 2, ..., m-1, where m={it:#}.  For example, {cmd:nquantiles(10)}
requests that the 10th, 20th, ..., 90th percentiles be computed.  The default
is {cmd:nquantiles(2)}; that is, the median is computed.

{phang}
{opth p:ercentiles(numlist)} requests
percentiles corresponding to the specified percentages.  For example,
{cmd:percentiles(10(20)90)} requests that the 10th, 30th, 50th, 70th, and 90th
percentiles be computed. With {opt _pctile} these are placed into {cmd:r(r1)},
{cmd:r(r2)}, {cmd:r(r3)}, {cmd:r(r4)}, and {cmd:r(r5)} up to 1,001. With
{opt xtile} these are the quantiles that define the categories and with
{opt pctile} these are the quantiles to compute.

{phang}
{opth c:utpoints(varname)} requests that the values of {it:varname}
be used to define the categories, rather than quantiles. This is natural
to use with {opt xtile}. With {opt pctile} and {opt _pctile} this is
redindant unless you also request {cmd:binfreq}[{cmd:(}{newvar}{cmd:)}].
By default, all values of {it:varname} are used, regardless of any {opt if}
or {opt in} restriction. You can specify {opt cutifin} to obey the
restrictions and {opt dedup} to exclude duplicates.

{phang}
{opth cutoffs(numlist)} Use values of {it:numlist} as cutpoints.

{phang}
{opth cutquantiles(numlist)} Calculate percentiles corresponding to the values of
{it:varname}. This is an alternative to {opth percentiles()}.

{dlgtab:Standard Options}

{phang}{opth genp(newvar)}
specifies a new variable to be generated
containing the percentages corresponding to the percentiles.

{phang}{opt altdef} uses an alternative formula for calculating percentiles.
The default method is to invert the empirical distribution function by using
averages, where the function is flat (the default is the same method used by
{cmd:summarize}; see {manhelp summarize R}).
The alternative formula uses an interpolation method.  See
{mansection D pctileMethodsandformulas:{it:Methods and formulas}} in
{bf:[D] pctile}.

{dlgtab:Extras}

{phang}
{opt _pctile} Do the computation in the style of {cmd:_pctile}. It
stores return values in r(1), r(2), and so on, as wll as a matrix called
{hi:r(quantiles_used)} or {hi:r(cutoffs_used)} in case quantiles or cutoffs
are requested. This can be combined with other options listed in this section.

{phang}
{cmd:pctile}[{cmd:(}{newvar}{cmd:)}] Store percentiles in {it:newvar}. If
{it:newvar} is not specified, then this indicates to do the computations in
the style of {cmd:pctile}.  This can be combined with other options listed in
this section.

{phang}
{cmd:xtile}[{cmd:(}{newvar}{cmd:)}] Store quantile categories in
{it:newvar}. If {it:newvar} is not specified, then this indicates to do the
computations in the style of {cmd:xtile}. This can be combined with other
options listed in this section.

{phang}
{cmd:binfreq}[{cmd:(}{newvar}{cmd:)}] Store the frequency counts of the
source variable in the quantile categories in {it:newvar}. If {it:newvar}
is not specified, this is stored in {hi:r(quantiles_bincount)} or
{hi:r(cutoffs_bincount)}. This can be combined with other
options listed in this section.

{phang}
{cmd:binpct}[{cmd:(}{newvar}{cmd:)}] Same as {it:binfreq} but it
computes percentages. If {it:newvar} is not specified, this is stored in
{hi:r(quantiles_binpct)} or {hi:r(cutoffs_binpct)}. This can be combined with
other options listed in this section.

{dlgtab:Switches}

{phang}
{opt method(#)} Algorithm to use to compute quantiles.  If you have many
duplicates or are computing many quantiles, you should specify {opt
method(1)}. If you have few duplicates or are computing few quantiles you
should specify {opt method(2)}. By default, {cmd:gquantiles} tries to guess
which method will run faster.

{phang}
{opt dedup} Drop duplicate values of variables specified via {opth
cutpoints()} or {opth cutquantiles()}. For instance, if the user asks for
quantiles 1, 90, 10, 10, and 1, then quantiles 1, 1, 10, 10, and 90 are
used. With this option only 1, 10, and 90 would be used.

{phang}
{opt cutifin} Exclude values outside {ifin} of variables specified via 
{opth cutpoints()} or {opth cutquantiles()}. The restriction that all
values are used is artificial (the option was originally written to
allow {cmd:xtile} to use {cmd:pctile} internally).

{phang}
{opt returnlimit(#)} Maximum return values that can be set via {opt _pctile}.
Since {cmd:gquantiles} can compute a large number of quantiles very quickly,
the function allows the user to request an arbitrary number. But setting
1,000s of return values is computationally infeasible. Consider {opt pctile}
in this case.

{phang}
{opt strict} Exit with error if the number of quantiles requested via 
{opt nquantiles(#)} is greater than the number of non-missing observations
plus one. This restriction for {opt pctile} is automatic, but for {opt xtile}
it is artificial. It exists because it uses {opt pctile} internally, but
{cmd:gquantiles} does not have this issue.

{phang}
{opt minmax} Additionally store the min and max in {hi:r(min)} and {hi:r(max)}

{phang}
{opt replace} Replace targets, should they exist.

{dlgtab:Gtools}

{phang}
{opt verbose} prints some useful debugging info to the console.

{phang}
{opt benchmark} prints how long in seconds various parts of the program
take to execute.

{phang}
{opth hashlib(str)} On earlier versions of gtools Windows users had a problem
because Stata was unable to find {it:spookyhash.dll}, which is bundled with
gtools and required for the plugin to run correctly. The best thing a Windows
user can do is run {opt gtools, dependencies} at the start of their Stata
session, but if Stata cannot find the plugin the user can specify a path
manually here.

{marker example}{...}
{title:Examples}

{pstd}
See the
{browse "http://gtools.readthedocs.io/en/latest/usage/gquantiles/index.html#examples":online documentation}
for examples.

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:gquantiles} stores the following in {cmd:r()}:

{synoptset 22 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)           }}Number of observations                     {p_end}
{synopt:{cmd:r(min)         }}Min (only w minmax was requested)          {p_end}
{synopt:{cmd:r(max)         }}Max (only w minmax was requested)          {p_end}
{synopt:{cmd:r(nqused)      }}Number of quantiles/cutoffs                {p_end}
{synopt:{cmd:r(method_ratio)}}Rule used to decide between methods 1 and 2{p_end}

{synopt:{cmd:r(nquantiles)     }}Number of quantiles (only w nquantiles())  {p_end}
{synopt:{cmd:r(ncutpoints)     }}Number of cutpoints (only w cutpoints())   {p_end}
{synopt:{cmd:r(nquantiles_used)}}Number of quantiles (only w quantiles())   {p_end}
{synopt:{cmd:r(nquantpoints)   }}Number of quantiles (only w cutquantiles()){p_end}
{synopt:{cmd:r(ncutoffs_used)  }}Number of cutoffs (only w cutoffs())       {p_end}

{synopt:{cmd:r(r#)}}The #th quantile requested (only w _pctile){p_end}
{p2colreset}{...}

{synoptset 22 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(quantiles)}}Quantiles used (only w percentiles() or quantiles()){p_end}
{synopt:{cmd:r(cutoffs)  }}Cutoffs used (only w option cutoffs())              {p_end}
{p2colreset}{...}

{synoptset 22 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(quantiles_used)   }}With _pctile or with quantiles()               {p_end}
{synopt:{cmd:r(quantiles_binfreq)}}With option binfreq and any quantiles requested{p_end}
{synopt:{cmd:r(quantiles_binpct) }}With option binpct and any quantiles requested {p_end}

{synopt:{cmd:r(cutoffs_used)   }}With _pctile or with cutoffs()               {p_end}
{synopt:{cmd:r(cutoffs_binfreq)}}With option binfreq and any cutoffs requested{p_end}
{synopt:{cmd:r(cutoffs_binpct) }}With option binpct and any cutoffs requested {p_end}
{p2colreset}{...}


{marker author}{...}
{title:Author}

{pstd}Mauricio Caceres{p_end}
{pstd}{browse "mailto:mauricio.caceres.bravo@gmail.com":mauricio.caceres.bravo@gmail.com }{p_end}
{pstd}{browse "https://mcaceresb.github.io":mcaceresb.github.io}{p_end}

{title:Website}

{pstd}{cmd:gquantiles} is maintained as part of {manhelp gtools R:gtools} at {browse "https://github.com/mcaceresb/stata-gtools":github.com/mcaceresb/stata-gtools}{p_end}

{marker acknowledgment}{...}
{title:Acknowledgment}

{pstd}
This help file was based on StataCorp's own help file for {it:pctile}
{p_end}

{pstd}
This project was largely inspired by Sergio Correia's {it:ftools}:
{browse "https://github.com/sergiocorreia/ftools"}.
{p_end}

{pstd}
The OSX version of gtools was implemented with invaluable help from @fbelotti;
see {browse "https://github.com/mcaceresb/stata-gtools/issues/11"}.
{p_end}

{title:Also see}

{p 4 13 2}
help for 
{help pctile}, 
{help gtools};
{help fastxtile} (if installed),
{help ftools} (if installed)

