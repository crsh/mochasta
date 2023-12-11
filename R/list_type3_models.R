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

# list_type3_models(RT ~ shape * color * ID, random = "ID")

