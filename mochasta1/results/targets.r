
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
)


# Define plan -------------------------------------------------------------

list(
  # EXPERIMENT 1
  tar_target(
    mochasta1
    , {
      load("data/mochasta1.Rdata")
      mochasta1
    }
    , deployment = "main"
  )
  , tar_target(
    mochasta1_no_order
    , {
      mochasta1 |>
      summarize(pos_total = mean(pos_total), .by = c(id, sound, task, position))
    }
    , deployment = "main"
    , packages = c("dplyr")
  )
  , tar_target(
    mochasta1_no_order_position
    , {
      mochasta1_no_order |>
        filter(!sound == "quiet") |>
        summarize(pos_total = mean(pos_total), .by = c(id, sound, task))
    }
    , deployment = "main"
    , packages = c("dplyr")
  )

  # ANOVA: 3 (sound condition) x 2 (task modality) x
  # 7 (serial position) x 2 (task order)
  , tar_target(
    mochasta1_anova
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta1
        , within = c("task", "sound", "position")
        , between = "order"
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta1_anova_models
    , list_type3_models(
      pos_total ~ order*sound*task*position + sound*task*position*id -
        sound:task:position:id
      , random = "id"
    )
    , deployment = "main"
    , packages = c("formula.tools")
  )
  , tar_target(
    mochasta1_anova_bf
    , {
      lmBF(
        mochasta1_anova_models[[1]]
        , data = mochasta1
        , whichRandom = "id"
        # , method = "laplace"
        # , iterations = 5e4
      )
    }
    , pattern = map(mochasta1_anova_models)
    , packages = c("BayesFactor")
    , iteration = "list"
  )

  # ANOVA: 3 (sound condition) x 2 (task modality) x 7 (serial position)
  , tar_target(
    mochasta1_no_order_anova
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta1_no_order
        , within = c("task", "sound", "position")
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta1_no_order_anova_verbal
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = filter(mochasta1_no_order, task == "verbal")
        , within = c("sound", "position")
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta1_no_order_anova_spatial
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = filter(mochasta1_no_order, task == "spatial")
        , within = c("sound", "position")
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta1_no_order_lmm
    , {
      lmer(
        pos_total ~ sound * position * task + (sound + position | id)
        , data = mochasta1_no_order
      )
    }
    , deployment = "main"
    , packages = c("lme4")
  )
  , tar_target(
    mochasta1_no_order_anova_models
    , list_type3_models(
      pos_total ~ sound*task*position*id - sound:task:position:id
      , random = "id"
    )
    , deployment = "main"
    , packages = c("formula.tools")
  )
  , tar_target(
    mochasta1_no_order_anova_bf
    , {
      lmBF(
        mochasta1_no_order_anova_models[[1]]
        , data = mochasta1_no_order
        , whichRandom = "id"
        # , method = "laplace"
        # , iterations = 5e4
      )
    }
    , pattern = map(mochasta1_no_order_anova_models)
    , packages = c("BayesFactor")
    , iteration = "list"
  )

  # ANOVA: 2 (sound condition: steady, changing) x 2 (task modality)
  , tar_target(
    mochasta1_no_order_position_anova
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta1_no_order_position
        , within = c("task", "sound")
        , anova_table = list(correction = "GG", es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex")
  )
  , tar_target(
    mochasta1_no_order_position_anova_models
    , list_type3_models(
      pos_total ~ sound*task*id - sound:task:id
      , random = "id"
    )
    , deployment = "main"
    , packages = c("formula.tools")
  )
  , tar_target(
    mochasta1_no_order_position_anova_bf
    , {
      lmBF(
        mochasta1_no_order_position_anova_models[[1]]
        , data = mochasta1_no_order_position
        , whichRandom = "id"
        # , method = "laplace"
        # , iterations = 5e4
      )
    }
    , pattern = map(mochasta1_no_order_position_anova_models)
    , packages = c("BayesFactor")
    , iteration = "list"
  )

  # ANOVA: breakdown of changing-state effect by task modality
  , tar_target(
    mochasta1_simple_effects_spatial
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta1_no_order_position |>
          filter(task == "spatial")
        , within = "sound"
        , anova_table = list(es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex", "dplyr")
  )
  , tar_target(
    mochasta1_simple_effects_verbal
    , {
      aov_ez(
        id = "id"
        , dv = "pos_total"
        , data = mochasta1_no_order_position |>
          filter(task == "verbal")
        , within = "sound"
        , anova_table = list(es = "pes")
      )
    }
    , deployment = "main"
    , packages = c("afex", "dplyr")
  )
  , tar_target(
    mochasta1_simple_effects_bf
    , {
      mochasta1_no_order_position |>
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
    , path = "mochasta1/results/analysis1.qmd"
    , deployment = "main"
    , quiet = TRUE
  )
)
