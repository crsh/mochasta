#' List Type 3 Models
#'
#' This function generates a list of submodels for a given model formula to
#' perform Type-3 mode comparisons, i.e. dropping individual terms from the
#' full model.
#'
#' @param x A formula object representing the ful model.
#' @param dv A character string to identify the dependent variable. Not used
#'   in the function, kept for compatibility.
#' @param random A character string to identify random terms in the model.
#' @return A vecotr of all model formulas required for Type-3 model
#'   compariosons. The full model is always the last vector element.
#' @examples
#' \dontrun{
#' list_type3_models(y ~ x1 + x2 + id, dv = "y", random = "id")
#' }
#' @export

list_type3_models  <- function(x, dv, random) {
  dv <- formula.tools::lhs(x)

  terms <- attr(terms.formula(x), "term.labels")

  fixed_terms <- terms[!grepl(random, terms)]
  random_terms <- terms[!terms %in% fixed_terms] |>
    paste(collapse = " + ")

  submodels <- sapply(
    fixed_terms
    , \(y) paste(fixed_terms[fixed_terms != y], collapse = " + ") |>
      paste(as.character(dv), "~", x = _) |>
      c(x = _, random_terms) |>
      paste(collapse = " + ") |>
      formula()
  ) |>
    c(full = x)

  submodels
}

#' Tested Terms
#'
#' This function extracts the terms that were tested in a BayesFactor object.
#'
#' @param x A BayesFactor object.
#' @return A list of terms that were tested.
#' @export

tested_terms <- function(x) {
  lapply(
    x@numerator
    , \(y) {
      BayesFactor:::whichOmitted(
        y
        , x@denominator
      )
    }
  ) |>
  unlist(use.names = FALSE)
}

#' Bayes Factor Table
#'
#' This function generates a table of Bayes Factors for a given list of
#' BayesFactor objects.
#'
#' @param x A list of BayesFactor objects.
#' @return A tibble with the tested term, the Bayes Factor, and the error.
#' @export

bf_table <- function(x) {
  x <-  do.call(c, args = x)
  
  x <- x[-length(x)] / x[length(x)]

  BayesFactor::extractBF(x, logbf = TRUE) |>
    tibble::tibble() |>
    dplyr::mutate(
      term = tested_terms(x)
      , bf = exp(-bf)
    ) |>
    dplyr::select(term, bf, error)
}
