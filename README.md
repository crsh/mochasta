
# Changing-State Irrelevant Speech Disrupts Visual-Verbal but not Visual-Spatial Serial Recall

John E. Marsh, Mark J. Hurlstone, Alexandre Marois, Linden J. Ball,
Stuart B. Moore, François Vachon, Sabine J. Schlittmeier, Jan Philipp
Röer, Axel Buchner, and Raoul Bell

-----

This repository contains research products associated with the
publication. The `data_raw` directory contains the data in CSV format;
RData-files can be found in `data_processed/`. The analyses were
performed with the R package
[**targets**](https://cran.r-project.org/web/packages/targets/index.html)
and can be rerun by executing the file `_make.sh`. *Note that rerunning
the analyses may take several days (see below).* It is not necessary to
install the **mochasta** package contained in this repository\! The
analyses are run separately for each study and the results are stored in
the directories `mochasta1/_targets/` and `mochasta2/_targets/`. To run
the analysis for Experiment one set the `project` variable in `_make.sh`
to `mochasta1` (and analogously for Experiment 2). The Quarto files in
the directories `mochasta1` and `mochasta2` create reports of the
results of the analyses reported in the paper.

## Software requirements

Packages required to reproduce the anlysis are listed in the
`DESCRIPTION` file.

## Computational requirements

Running all analyses may take severa on a Desktop computer even when
Bayesian models are fit in parallel on 7 cores (current setting). To
control the number of cores used for parallel processing, change the
**targets** `controller` option in `targets.r` in the folders for each
experiment.
