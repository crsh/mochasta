
# Changing-State Irrelevant Speech Disrupts Visual-Verbal but not Visual-Spatial Serial Recall

John E. Marsh, Mark J. Hurlstone, Alexandre Marois, Linden J. Ball,
Stuart B. Moore, François Vachon, Sabine J. Schlittmeier, Jan Philipp
Röer, Axel Buchner, Frederik Aust, & Raoul Bell

-----

This repository contains research products associated with the
publication. The `data_raw` directory contains the data in CSV format;
RData-files can be found in `data_processed/`. The analyses herein were
performed with the R package
[**targets**](https://cran.r-project.org/web/packages/targets/index.html)
and can be rerun by executing the file `_make.sh`. *Note that rerunning
the analyses may take several days (see below).* The analyses are run
separately for each study and the results are stored in the directories
`mochasta1/_targets/` and `mochasta2/_targets/`. To run the analysis for
Experiment 1 set the `project` variable in `_make.sh` to `mochasta1`
(and analogously for Experiment 2). The Quarto files in the directories
`mochasta1` and `mochasta2` create reports of the results of the
analyses reported in the paper. The Bayesian meta-analysis reported in
the paper was performed by hand using the online [Bayes factor
calculator](https://users.sussex.ac.uk/~dienes/inference/Bayes.htm) by
Zoltan Dienes; hence, no code is provided for this analysis.

## Preferred citation

    ## @Article{marshhurlstone:2024,
    ##   title = {Changing-State Irrelevant Speech Disrupts Visual-Verbal but not Visual-Spatial Serial Recall},
    ##   author = {John E. Marsh and Mark J. Hurlstone and Alexandre Marois and Linden J. Ball and Stuart B. Moore and François Vachon and Sabine J. Schlittmeier and Jan Philipp Röer and Axel Buchner and Frederik Aust and Raoul Bell},
    ##   year = {2024},
    ##   journal = {Journal of Experimental Psychology: Leaning, Memory and Cognition},
    ## }

## Software requirements

The version of R and all packages required to reproduce the anlysis are
listed in the `DESCRIPTION` file. Additonally, it is required to install
the **mochasta** package from this GitHub repository.

``` r
# Install the mochasta package from GitHub
remotes::install_github("crsh/mochasta")

# Install the mochasta package from a local copy of the repository
devtools::install("path/to/mochasta")
```

## Computational requirements

Running all analyses may take severa on a Desktop computer even when
Bayesian models are fit in parallel on 7 cores (current setting). To
control the number of cores used for parallel processing, change the
**targets** `controller` option in `targets.r` in the folders for each
experiment.

### Experiment 1

``` mermaid
graph LR
  style Legend fill:#FFFFFF00,stroke:#000000;
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Legend
    direction LR
    x7420bd9270f8d27d([""Up to date""]):::uptodate --- x0a52b03877696646([""Outdated""]):::outdated
    x0a52b03877696646([""Outdated""]):::outdated --- xbf4603d6c2c2ad6b([""Stem""]):::none
    xbf4603d6c2c2ad6b([""Stem""]):::none --- x70a5fa6bea6f298d[""Pattern""]:::none
    x70a5fa6bea6f298d[""Pattern""]:::none --- xf0bce276fe2b9d3e>""Function""]:::none
    xf0bce276fe2b9d3e>""Function""]:::none --- x5bffbffeae195fc9{{""Object""}}:::none
  end
  subgraph Graph
    direction LR
    xc540cb9a2aa5f331>"tested_terms"]:::uptodate --> x9bd204461acb81e2>"bf_table"]:::uptodate
    x212d38f8a96a16c1(["mochasta1<br>1.047 seconds"]):::uptodate --> x4082dc70a41d5aa6(["mochasta1_anova<br>0.083 seconds"]):::uptodate
    x212d38f8a96a16c1(["mochasta1<br>1.047 seconds"]):::uptodate --> x12211fe41d4caecd["mochasta1_anova_bf<br>5.133 days<br>16 branches"]:::uptodate
    x60047341e7387653(["mochasta1_anova_models<br>0.001 seconds"]):::uptodate --> x12211fe41d4caecd["mochasta1_anova_bf<br>5.133 days<br>16 branches"]:::uptodate
    xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate --> xa139dbfb46286deb(["mochasta1_simple_effects_bf<br>6.177 seconds"]):::uptodate
    xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate --> x927f26567460a310(["mochasta1_no_order_position_anova<br>0.02 seconds"]):::uptodate
    xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate --> x4f32e94f22b36a35(["mochasta1_simple_effects_spatial<br>0.011 seconds"]):::uptodate
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> xa8760b505faa7e30(["mochasta1_no_order_anova_verbal<br>0.015 seconds"]):::uptodate
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> x56ca37e47dba9819(["mochasta1_no_order_lmm<br>1.56 minutes"]):::uptodate
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> x3208522fc0fb4ba7(["mochasta1_no_order_anova<br>0.043 seconds"]):::uptodate
    x79a78e9c224d4ade>"list_type3_models"]:::uptodate --> xc82181b8c547d330(["mochasta1_no_order_position_anova_models<br>0.001 seconds"]):::uptodate
    x4082dc70a41d5aa6(["mochasta1_anova<br>0.083 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x12211fe41d4caecd["mochasta1_anova_bf<br>5.133 days<br>16 branches"]:::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x3208522fc0fb4ba7(["mochasta1_no_order_anova<br>0.043 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    xa32f19cf709581e9["mochasta1_no_order_anova_bf<br>2.409 days<br>8 branches"]:::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    xcf178e40c42947a4(["mochasta1_no_order_anova_spatial<br>0.927 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    xa8760b505faa7e30(["mochasta1_no_order_anova_verbal<br>0.015 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x927f26567460a310(["mochasta1_no_order_position_anova<br>0.02 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x393fd8e0e0ddb692["mochasta1_no_order_position_anova_bf<br>47.152 seconds<br>4 branches"]:::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    xa139dbfb46286deb(["mochasta1_simple_effects_bf<br>6.177 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x4f32e94f22b36a35(["mochasta1_simple_effects_spatial<br>0.011 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x367d03c6134f6cd1(["mochasta1_simple_effects_verbal<br>0.043 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.593 seconds"]):::outdated
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> xa32f19cf709581e9["mochasta1_no_order_anova_bf<br>2.409 days<br>8 branches"]:::uptodate
    x2e4b03c70c1c11c0(["mochasta1_no_order_anova_models<br>0.027 seconds"]):::uptodate --> xa32f19cf709581e9["mochasta1_no_order_anova_bf<br>2.409 days<br>8 branches"]:::uptodate
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> xcf178e40c42947a4(["mochasta1_no_order_anova_spatial<br>0.927 seconds"]):::uptodate
    x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate --> xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate
    x79a78e9c224d4ade>"list_type3_models"]:::uptodate --> x60047341e7387653(["mochasta1_anova_models<br>0.001 seconds"]):::uptodate
    x212d38f8a96a16c1(["mochasta1<br>1.047 seconds"]):::uptodate --> x5fcfbfc7f9a69741(["mochasta1_no_order<br>0.044 seconds"]):::uptodate
    xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate --> x367d03c6134f6cd1(["mochasta1_simple_effects_verbal<br>0.043 seconds"]):::uptodate
    xaeb50eeab4d65f6f(["mochasta1_no_order_position<br>0.01 seconds"]):::uptodate --> x393fd8e0e0ddb692["mochasta1_no_order_position_anova_bf<br>47.152 seconds<br>4 branches"]:::uptodate
    xc82181b8c547d330(["mochasta1_no_order_position_anova_models<br>0.001 seconds"]):::uptodate --> x393fd8e0e0ddb692["mochasta1_no_order_position_anova_bf<br>47.152 seconds<br>4 branches"]:::uptodate
    x79a78e9c224d4ade>"list_type3_models"]:::uptodate --> x2e4b03c70c1c11c0(["mochasta1_no_order_anova_models<br>0.027 seconds"]):::uptodate
    xd51e323eb90213dd{{"project_packages"}}:::uptodate --> xd51e323eb90213dd{{"project_packages"}}:::uptodate
  end
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef outdated stroke:#000000,color:#000000,fill:#78B7C5;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
  linkStyle 1 stroke-width:0px;
  linkStyle 2 stroke-width:0px;
  linkStyle 3 stroke-width:0px;
  linkStyle 4 stroke-width:0px;
  linkStyle 37 stroke-width:0px;
```

### Experiment 2

``` mermaid
graph LR
  style Legend fill:#FFFFFF00,stroke:#000000;
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Legend
    direction LR
    x7420bd9270f8d27d([""Up to date""]):::uptodate --- xbf4603d6c2c2ad6b([""Stem""]):::none
    xbf4603d6c2c2ad6b([""Stem""]):::none --- x70a5fa6bea6f298d[""Pattern""]:::none
    x70a5fa6bea6f298d[""Pattern""]:::none --- xf0bce276fe2b9d3e>""Function""]:::none
    xf0bce276fe2b9d3e>""Function""]:::none --- x5bffbffeae195fc9{{""Object""}}:::none
  end
  subgraph Graph
    direction LR
    xc540cb9a2aa5f331>"tested_terms"]:::uptodate --> x9bd204461acb81e2>"bf_table"]:::uptodate
    x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate --> x0cd8e6e7e9a2cf8b(["mochasta2_simple_effects_spatial<br>0.017 seconds"]):::uptodate
    x79a78e9c224d4ade>"list_type3_models"]:::uptodate --> xa35c855209637722(["mochasta2_anova_models<br>0.03 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> x6233fe7653e34c6b(["mochasta2_anova<br>0.037 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate
    x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate --> xd40d46bf280c15e2(["mochasta2_simple_effects_verbal<br>0.018 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> x6daf898648b833ac(["mochasta2_lmm<br>1.803 minutes"]):::uptodate
    x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate --> xbe6001c40bc8f114(["mochasta2_simple_effects_bf<br>6.169 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> x42869f79c0bc26c7(["mochasta2_anova_verbal<br>0.015 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> xee4abcec96af0f27["mochasta2_anova_bf<br>2.454 days<br>8 branches"]:::uptodate
    xa35c855209637722(["mochasta2_anova_models<br>0.03 seconds"]):::uptodate --> xee4abcec96af0f27["mochasta2_anova_bf<br>2.454 days<br>8 branches"]:::uptodate
    x79a78e9c224d4ade>"list_type3_models"]:::uptodate --> xf27828e67f2b7969(["mochasta2_no_position_anova_models<br>0.028 seconds"]):::uptodate
    x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate --> x7c00adbaec3ac945["mochasta2_no_position_anova_bf<br>0 seconds<br>4 branches"]:::uptodate
    xf27828e67f2b7969(["mochasta2_no_position_anova_models<br>0.028 seconds"]):::uptodate --> x7c00adbaec3ac945["mochasta2_no_position_anova_bf<br>0 seconds<br>4 branches"]:::uptodate
    x6233fe7653e34c6b(["mochasta2_anova<br>0.037 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    xee4abcec96af0f27["mochasta2_anova_bf<br>2.454 days<br>8 branches"]:::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    xc01e7be638af0e68(["mochasta2_anova_spatial<br>0.032 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    x42869f79c0bc26c7(["mochasta2_anova_verbal<br>0.015 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    xed39ba93949fbe3f(["mochasta2_no_position_anova<br>0.926 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    x7c00adbaec3ac945["mochasta2_no_position_anova_bf<br>0 seconds<br>4 branches"]:::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    xbe6001c40bc8f114(["mochasta2_simple_effects_bf<br>6.169 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    x0cd8e6e7e9a2cf8b(["mochasta2_simple_effects_spatial<br>0.017 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    xd40d46bf280c15e2(["mochasta2_simple_effects_verbal<br>0.018 seconds"]):::uptodate --> xe0fba61fbc506510(["report<br>4.573 seconds"]):::uptodate
    x9d1b703d563379d0(["mochasta2<br>1.112 seconds"]):::uptodate --> xc01e7be638af0e68(["mochasta2_anova_spatial<br>0.032 seconds"]):::uptodate
    x5636acd47df167f9(["mochasta2_no_position<br>0.024 seconds"]):::uptodate --> xed39ba93949fbe3f(["mochasta2_no_position_anova<br>0.926 seconds"]):::uptodate
    xd51e323eb90213dd{{"project_packages"}}:::uptodate --> xd51e323eb90213dd{{"project_packages"}}:::uptodate
  end
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
  linkStyle 1 stroke-width:0px;
  linkStyle 2 stroke-width:0px;
  linkStyle 3 stroke-width:0px;
  linkStyle 29 stroke-width:0px;
```
