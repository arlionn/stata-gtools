*! version 0.3.3 12Nov2017 Mauricio Caceres Bravo, mauricio.caceres.bravo@gmail.com
*! Calculate the top groups by count of a varlist (jointly).

cap program drop gtop
program gtop, rclass
    local 00 `0'
    gtoplevelsof `0'
    local 0 `00'
    syntax [anything], [LOCal(str) MATrix(str) *]
    tempname gmat
    matrix `gmat' = r(toplevels)
    if ( "`local'"  != "" ) c_local `local' `"`r(levels)'"'
    if ( "`matrix'" != "" ) matrix  `matrix' = `gmat'
    return local levels    `"`r(levels)'"'
    return scalar N         = `r(N)'
    return scalar J         = `r(J)'
    return scalar minJ      = `r(minJ)'
    return scalar maxJ      = `r(maxJ)'
    return matrix toplevels = `gmat'
end
