
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

source("./R/type3_bf.R")


# Configure plan execution ------------------------------------------------

options(tidyverse.quiet = TRUE)

tar_option_set(
  packages = project_packages
  , controller = crew_controller_local(workers = 7)
  , storage = "main"
  , retrieval = "main"
  , memory = "transient"
  , garbage_collection = TRUE
  , error = "continue"
  , workspace_on_error = TRUE
  , cue = tar_cue(seed = FALSE)
)

tar_option_set(seed = 2)


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
    mochasta2_anova_verbal
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = filter(mochasta2, task == "verbal")
        , within = c("sound", "position")
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta2_anova_spatial
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = filter(mochasta2, task == "spatial")
        , within = c("sound", "position")
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
        , iterations = 8e4
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
  , tar_target(
    mochasta2_no_position_anova
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta2_no_position
        , within = "sound"
        , between = "task"
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex", "dplyr")
  )

  , tar_target(
    mochasta2_no_position_anova_models
    , list_type3_models(
      pos_total ~ sound*task + id
      , random = "id"
    )
    , deployment = "main"
    , packages = c("formula.tools")
  )
  , tar_target(
    mochasta2_no_position_anova_bf
    , {
      lmBF(
        mochasta2_no_position_anova_models[[1]]
        , data = mochasta2_no_position
        , whichRandom = "id"
        # , method = "laplace"
        , iterations = 5e5
      )
    }
    , pattern = map(mochasta2_no_position_anova_models)
    , packages = c("BayesFactor")
    , iteration = "list"
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
        group_by(task) %>%
        do(
          anovaBF(pos_total ~ sound + id, data = ., whichRandom = "id", iterations = 50000, rscaleFixed = 0.5, rscaleRandom = 1) |>
            extractBF()
        ) |>
        select(bf, error)
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
