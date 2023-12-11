
# Libraries ---------------------------------------------------------------

library("targets")
library("tarchetypes")
library("crew")

## Packages for project

project_packages <- c(
  "dplyr"
  , "tidyr"
  , "afex"
  , "emmeans"
  , "BayesFactor"
  , "lme4"
)

# Make custom functions available -----------------------------------------

source("./R/list_type3_models.R")

 # roxygen2::roxygenise()
# devtools::install(pkg = ".", upgrade = "never")


# Configure plan execution ------------------------------------------------

options(tidyverse.quiet = TRUE)

tar_option_set(
  packages = project_packages
  , controller = crew_controller_local(workers = 4)
  , storage = "main"
  , retrieval = "main"
  , memory = "transient"
  , garbage_collection = TRUE
  , error = "continue"
  , workspace_on_error = TRUE
)

## Remote parallelized execution
# library("future")

# Sys.setenv(
#   PATH = paste0(
#     Sys.getenv("PATH")
#     , ":/usr/lib/rstudio-server/bin/postback"
#   )
# )

# methexp_labor_cluster <- methexp::methexp_cluster(
#   master = "134.95.17.37"
#   , user = "computer"
#   , servants = c(paste0("134.95.17.", 62:64), "localhost")
#   , cores = 1L
# )

# future::plan(future::cluster, workers = methexp_labor_cluster)


# Define plan -------------------------------------------------------------

list(
  # EXPERIMENT 2
  tar_target(
    mochasta2
    , {
      load("data/mochasta2.Rdata")
      mochasta2
    }
    , deployment = "main"
  )
  , tar_target(
    mochasta2_no_position
    , {
      mochasta2 |>
        filter(!sound == "quiet") |>
        summarize(pos_total = mean(pos_total), .by = c(id, sound, task))
    }
    , deployment = "main"
    , packages = c("dplyr")
  )

  # ANOVA: 3 (sound condition) x 2 (task modality) x 7 (serial position)
  , tar_target(
    mochasta2_anova
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta2
        , within = c("sound", "position")
        , between = "task"
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta2_anova_models
    , list_type3_models(
      pos_total ~ sound*task*position + sound*position*id -
        sound:position:id
      , random = "id"
    )
    , deployment = "main"
    , packages = c("formula.tools")
  )
  , tar_target(
    mochasta2_anova_bf
    , {
      lmBF(
        mochasta2_anova_models[[1]]
        , data = mochasta2
        , whichRandom = "id"
        # , method = "laplace"
        , iterations = 1e5
      )
    }
    , pattern = map(mochasta2_anova_models)
    , packages = c("BayesFactor")
    , iteration = "list"
  )
  , tar_target(
    mochasta2_lmm
    , {
      lmer(
        pos_total ~ sound * position * task + (sound + position | id)
        , data = mochasta2
      )
    }
    , deployment = "main"
    , packages = c("lme4")
  )

  # ANOVA: breakdown of changing-state effect by task modality
  , tar_target(
    mochasta2_simple_effects_spatial
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta2_no_position |>
          filter(task == "spatial")
        , within = "sound"
        , anova_table = list(es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex", "dplyr")
  )
  , tar_target(
    mochasta2_simple_effects_verbal
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta2_no_position |>
          filter(task == "verbal")
        , within = "sound"
        , anova_table = list(es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex", "dplyr")
  )
  , tar_target(
    mochasta2_simple_effects_bf
    , {
      mochasta2_no_position |>
        pivot_wider(names_from = "sound", values_from = "pos_total") |>
        group_by(task) |>
        summarize(
          bf = ttestBF(steady, changing, paired = TRUE) |>
            as.vector()
        )
    }
    , deployment = "main"
    , packages = c("tidyr", "dplyr", "BayesFactor")
  )

  # Render report
  , tar_quarto(
    report
    , path = "mochasta2/results/analysis2.qmd"
    , deployment = "main"
    , quiet = TRUE
  )
)
