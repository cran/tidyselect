% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{language}
\alias{language}
\alias{select_helpers}
\title{Selection language}
\description{
\subsection{Overview of selection features:}{

tidyselect implements a DSL for selecting variables. It provides helpers
for selecting variables:
\itemize{
\item \code{var1:var10}: variables lying between \code{var1} on the left and \code{var10} on the right.
}
\itemize{
\item \code{\link[=starts_with]{starts_with("a")}}: names that start with \code{"a"}.
\item \code{\link[=ends_with]{ends_with("z")}}: names that end with \code{"z"}.
\item \code{\link[=contains]{contains("b")}}: names that contain \code{"b"}.
\item \code{\link[=matches]{matches("x.y")}}: names that match regular expression \code{x.y}.
\item \code{\link[=num_range]{num_range(x, 1:4)}}: names following the pattern, \code{x1}, \code{x2}, ..., \code{x4}.
\item \code{\link[=all_of]{all_of(vars)}}/\code{\link[=any_of]{any_of(vars)}}:
matches names stored in the character vector \code{vars}. \code{all_of(vars)} will
error if the variables aren't present; \code{any_of(var)} will match just the
variables that exist.
\item \code{\link[=everything]{everything()}}: all variables.
\item \code{\link[=last_col]{last_col()}}: furthest column on the right.
\item \code{\link[=where]{where(is.numeric)}}: all variables where
\code{is.numeric()} returns \code{TRUE}.
}

As well as operators for combining those selections:
\itemize{
\item \code{!selection}: only variables that don't match \code{selection}.
\item \code{selection1 & selection2}: only variables included in both \code{selection1} and \code{selection2}.
\item \code{selection1 | selection2}: all variables that match either \code{selection1} or \code{selection2}.
}

When writing code inside packages you can substitute \code{"var"} for \code{var} to avoid \verb{R CMD check} notes.
}
}
\section{Simple examples}{


Here we show the usage for the basic selection operators. See the
specific help pages to learn about helpers like \code{\link[=starts_with]{starts_with()}}.

The selection language can be used in functions like
\code{dplyr::select()} or \code{tidyr::pivot_longer()}. Let's first attach
the tidyverse:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(tidyverse)

# For better printing
iris <- as_tibble(iris)
}\if{html}{\out{</div>}}

Select variables by name:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{starwars \%>\% select(height)
#> # A tibble: 87 x 1
#>   height
#>    <int>
#> 1    172
#> 2    167
#> 3     96
#> 4    202
#> # i 83 more rows

iris \%>\% pivot_longer(Sepal.Length)
#> # A tibble: 150 x 6
#>   Sepal.Width Petal.Length Petal.Width Species name         value
#>         <dbl>        <dbl>       <dbl> <fct>   <chr>        <dbl>
#> 1         3.5          1.4         0.2 setosa  Sepal.Length   5.1
#> 2         3            1.4         0.2 setosa  Sepal.Length   4.9
#> 3         3.2          1.3         0.2 setosa  Sepal.Length   4.7
#> 4         3.1          1.5         0.2 setosa  Sepal.Length   4.6
#> # i 146 more rows
}\if{html}{\out{</div>}}

Select multiple variables by separating them with commas. Note how
the order of columns is determined by the order of inputs:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{starwars \%>\% select(homeworld, height, mass)
#> # A tibble: 87 x 3
#>   homeworld height  mass
#>   <chr>      <int> <dbl>
#> 1 Tatooine     172    77
#> 2 Tatooine     167    75
#> 3 Naboo         96    32
#> 4 Tatooine     202   136
#> # i 83 more rows
}\if{html}{\out{</div>}}

Functions like \code{tidyr::pivot_longer()} don't take variables with
dots. In this case use \code{c()} to select multiple variables:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{iris \%>\% pivot_longer(c(Sepal.Length, Petal.Length))
#> # A tibble: 300 x 5
#>   Sepal.Width Petal.Width Species name         value
#>         <dbl>       <dbl> <fct>   <chr>        <dbl>
#> 1         3.5         0.2 setosa  Sepal.Length   5.1
#> 2         3.5         0.2 setosa  Petal.Length   1.4
#> 3         3           0.2 setosa  Sepal.Length   4.9
#> 4         3           0.2 setosa  Petal.Length   1.4
#> # i 296 more rows
}\if{html}{\out{</div>}}
\subsection{Operators:}{

The \code{:} operator selects a range of consecutive variables:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{starwars \%>\% select(name:mass)
#> # A tibble: 87 x 3
#>   name           height  mass
#>   <chr>           <int> <dbl>
#> 1 Luke Skywalker    172    77
#> 2 C-3PO             167    75
#> 3 R2-D2              96    32
#> 4 Darth Vader       202   136
#> # i 83 more rows
}\if{html}{\out{</div>}}

The \code{!} operator negates a selection:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{starwars \%>\% select(!(name:mass))
#> # A tibble: 87 x 11
#>   hair_color skin_color  eye_color birth_year sex   gender    homeworld species
#>   <chr>      <chr>       <chr>          <dbl> <chr> <chr>     <chr>     <chr>  
#> 1 blond      fair        blue            19   male  masculine Tatooine  Human  
#> 2 <NA>       gold        yellow         112   none  masculine Tatooine  Droid  
#> 3 <NA>       white, blue red             33   none  masculine Naboo     Droid  
#> 4 none       white       yellow          41.9 male  masculine Tatooine  Human  
#> # i 83 more rows
#> # i 3 more variables: films <list>, vehicles <list>, starships <list>

iris \%>\% select(!c(Sepal.Length, Petal.Length))
#> # A tibble: 150 x 3
#>   Sepal.Width Petal.Width Species
#>         <dbl>       <dbl> <fct>  
#> 1         3.5         0.2 setosa 
#> 2         3           0.2 setosa 
#> 3         3.2         0.2 setosa 
#> 4         3.1         0.2 setosa 
#> # i 146 more rows

iris \%>\% select(!ends_with("Width"))
#> # A tibble: 150 x 3
#>   Sepal.Length Petal.Length Species
#>          <dbl>        <dbl> <fct>  
#> 1          5.1          1.4 setosa 
#> 2          4.9          1.4 setosa 
#> 3          4.7          1.3 setosa 
#> 4          4.6          1.5 setosa 
#> # i 146 more rows
}\if{html}{\out{</div>}}

\code{&} and \code{|} take the intersection or the union of two selections:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{iris \%>\% select(starts_with("Petal") & ends_with("Width"))
#> # A tibble: 150 x 1
#>   Petal.Width
#>         <dbl>
#> 1         0.2
#> 2         0.2
#> 3         0.2
#> 4         0.2
#> # i 146 more rows

iris \%>\% select(starts_with("Petal") | ends_with("Width"))
#> # A tibble: 150 x 3
#>   Petal.Length Petal.Width Sepal.Width
#>          <dbl>       <dbl>       <dbl>
#> 1          1.4         0.2         3.5
#> 2          1.4         0.2         3  
#> 3          1.3         0.2         3.2
#> 4          1.5         0.2         3.1
#> # i 146 more rows
}\if{html}{\out{</div>}}

To take the difference between two selections, combine the \code{&} and
\code{!} operators:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{iris \%>\% select(starts_with("Petal") & !ends_with("Width"))
#> # A tibble: 150 x 1
#>   Petal.Length
#>          <dbl>
#> 1          1.4
#> 2          1.4
#> 3          1.3
#> 4          1.5
#> # i 146 more rows
}\if{html}{\out{</div>}}
}
}

\section{Details}{

The order of selected columns is determined by the inputs.
\itemize{
\item \code{all_of(c("foo", "bar"))} selects \code{"foo"} first.
\item \code{c(starts_with("c"), starts_with("d"))} selects all columns
starting with \code{"c"} first, then all columns starting with \code{"d"}.
}
}

