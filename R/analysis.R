
# =============================================================================
# EXPT. 2: NEAR IDENTICAL REPLICATION =========================================
# =============================================================================

# =============================================================================
# read in and sort data -------------------------------------------------------

# --- read data
near_iden_data <- read.csv("./frequentist/data/between_means.csv")

# --- generate a new ID for the ANOVA
for(i in 1:nrow(near_iden_data)){
  near_iden_data$aov_id[i] <- paste(near_iden_data$id[i],
                                    "_",
                                    near_iden_data$task[i],
                                    sep = "")
}

# --- group by id and pivot from wide to long format
near_iden_data <- near_iden_data %>%
  group_by(aov_id) %>%
  pivot_longer(cols = starts_with("sp"),
               names_to = "position",
               values_to = "pos_total") %>%
  mutate(aov_id = as.factor(aov_id),
         task = as.factor(task),
         sound = as.factor(sound),
         position = as.factor(position)) |>
         ungroup()

# =============================================================================
# ANOVA: 3 (sound condition) x 2 (task modality) x 7 (serial position) --------

# --- ANOVA
first_near_aov <- aov_ez(id = "aov_id", dv = "pos_total",
                         data = near_iden_data,
                         within = c("sound", "position"),
                         between = "task",
                         anova_table = list(correction = "none", es = "pes"))

# --- Bayesian ANOVA
first_near_aov_bf <- generalTestBF(
  pos_total ~ sound*task*position + sound*position*aov_id - sound:position:aov_id
  , data = near_iden_data
  , whichRandom = "aov_id"
  , neverExclude = "aov_id"
  , whichModels = "top"
  , method = "laplace"
  # , multicore = TRUE
)

# --- Mixed model
first_near_lme <- lmer(
  pos_total ~ sound * position * task + (sound + position | aov_id)
  , data = near_iden_data
)


# =============================================================================
# ANOVA: breakdown of changing-state effect by task modality ------------------

# spatial task ----------------------------------------------------------------

# --- get data for spatial task
near_spatial_cse_data <- first_near_data %>%
  filter(task == "spatial") %>%
  filter(!sound == "quiet") %>%
  group_by(sound)

# --- ANOVA
near_spatial_cse_aov <- aov_ez(id = "aov_id", dv = "pos_total",
                               data = near_spatial_cse_data,
                               within = "sound",
                               anova_table = list(correction = "none",
                                                  es = "pes"))


# verbal task -----------------------------------------------------------------

# --- get data for verbal task
near_verbal_cse_data <- first_near_data %>%
  filter(task == "verbal") %>%
  filter(!sound == "quiet") %>%
  group_by(sound)

# --- ANOVA
near_verbal_cse_aov <- aov_ez(id = "aov_id", dv = "pos_total",
                              data = near_verbal_cse_data,
                              within = "sound",
                              anova_table = list(correction = "none",
                                                 es = "pes"))

# --- Bayesian simple effects
near_iden_data |>
  ungroup() |>
  summarize(pos_total = mean(pos_total), .by = c(aov_id, sound, task)) |>
  pivot_wider(names_from = "sound", values_from = "pos_total") |>
  group_by(task) |>
  summarize(bf = ttestBF(steady, changing, paired = TRUE) |> as.vector())


# =============================================================================
# =============================================================================
