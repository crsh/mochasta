#!/usr/bin/env Rscript

# Packages to update ------------------------------------------------------

to_update <- c(
    NULL
  )

force <- FALSE

# Run package updates on all machines ------------------------------------

## Set up cluster
methexp_labor_cluster <- methexp::methexp_cluster(
  master = "134.95.17.37"
  , user = "computer"
  , servants = c(paste0("134.95.17.", 62:65)) #, "localhost")
  , cores = 1L
)

### Install project dependencies
if(is.null(to_update)) {
  package_dependencies <- function(
    pkgdir = "."
    , dependencies = NA
    , repos = "https://cloud.r-project.org"
    , type = "source"
  ) {
    pkg <- remotes:::load_pkg_description(pkgdir)
    repos <- c(repos, remotes:::parse_additional_repositories(pkg))
    deps <- remotes:::local_package_deps(pkgdir = pkgdir, dependencies = dependencies)
    if (remotes:::is_bioconductor(pkg)) {
      bioc_repos <- remotes:::bioc_install_repos()
      missing_repos <- setdiff(names(bioc_repos), names(repos))
      if (length(missing_repos) > 0)
        repos[missing_repos] <- bioc_repos[missing_repos]
    }
    list(deps = deps, pkg = pkg)
  }

  to_update <- package_dependencies()

  install_packages <- function(x, ...) {
    if(!"remotes" %in% rownames(installed.packages())) install.packages("remotes")
    library("remotes", quietly = silence_library)
    deps <- remotes:::combine_remote_deps(
      remotes::package_deps(x$deps, repos = "https://cloud.r-project.org", type = "source")
      , remotes:::extra_deps(x$pkg, "remotes")
    )
    remotes:::update.package_deps(
      object = deps
      , dep_deps = NA
      , upgrade = TRUE
      , build = TRUE
      , ...
    )
  }
}

if(force) {
  install_packages <- function(x, ...) install.packages(pkgs = x, ...)
} else {
  install_packages <- function(x, ...) update.packages(pkgs = x, ...)
}

parallel::clusterCall(
  methexp_labor_cluster
  , fun = install_packages
  , x = to_update
  , Ncpus = 1
)
