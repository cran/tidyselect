#' Select all variables or the last variable
#'
#' @description
#'
#' These functions are [selection helpers][language].
#'
#' * [everything()] selects all variable. It is also useful in
#'   combination with other tidyselect operators.
#'
#' * [last_col()] selects the last variable.
#'
#' @inheritParams starts_with
#'
#' @section Examples:
#'
#' ```{r, child = "man/rmd/setup.Rmd"}
#' ```
#'
#' Selection helpers can be used in functions like `dplyr::select()`
#' or `tidyr::pivot_longer()`. Let's first attach the tidyverse:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' library(tidyverse)
#'
#' # For better printing
#' iris <- as_tibble(iris)
#' mtcars <- as_tibble(mtcars)
#' ```
#'
#' Use `everything()` to select all variables:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(everything())
#'
#' mtcars %>% pivot_longer(everything())
#' ```
#'
#' Use `last_col()` to select the last variable:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' iris %>% select(last_col())
#'
#' mtcars %>% pivot_longer(last_col())
#' ```
#'
#' Supply an offset `n` to select a variable located `n` positions
#' from the end:
#'
#' ```{r, comment = "#>", collapse = TRUE}
#' mtcars %>% select(1:last_col(5))
#' ```
#'
#' @seealso `r rd_helpers_seealso()`
#' @export
everything <- function(vars = NULL) {
  vars <- vars %||% peek_vars(fn = "everything")
  seq_along(vars)
}

#' @rdname everything
#' @export
#' @param offset Set it to `n` to select the nth var from the end.
last_col <- function(offset = 0L, vars = NULL) {
  if (!is_integerish(offset, n = 1)) {
    not <- obj_type_friendly(offset)
    cli::cli_abort("{.arg offset} must be a single integer, not {not}.")
  }

  vars <- vars %||% peek_vars(fn = "last_col")
  n <- length(vars)

  if (offset && n <= offset) {
    cli::cli_abort("{.arg offset} ({offset}) must be smaller than the number of columns ({n}).")
  } else if (n == 0) {
    cli::cli_abort("Can't select last column when input is empty.")
  } else {
    n - as.integer(offset)
  }
}
