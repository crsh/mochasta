---
title: "Analysis of Experiment 1"
author: "Frederik Aust"
date: "2023-12-13"

toc: true
number-sections: true
reference-location: margin

highlight-style: github
theme: lumen

execute:
  keep-md: true

format:
  html:
    code-fold: true
    standalone: true
    embed-resources: true
    self-contained: true
    link-external-icon: true
    citations-hover: true
    footnotes-hover: true
---





# Full ANOVA

ANOVA: 3 (sound condition) x 2 (task modality) x 7 (serial position) x 2 (task order)


::: {.cell}

```{.r .cell-code}
mochasta1_anova <- tar_read(mochasta1_anova)

mochasta1_anova
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
                      Effect           df    MSE          F  pes p.value
1                      order        1, 62 226.50       0.79 .013    .379
2                       task        1, 62  52.80       1.36 .022    .247
3                 order:task        1, 62  52.80       0.24 .004    .627
4                      sound 1.97, 122.20   8.19  11.35 *** .155   <.001
5                order:sound 1.97, 122.20   8.19       0.14 .002    .869
6                   position 2.53, 156.55  15.14 186.33 *** .750   <.001
7             order:position 2.53, 156.55  15.14     3.16 * .048    .034
8                 task:sound 1.94, 120.51  12.06    5.62 ** .083    .005
9           order:task:sound 1.94, 120.51  12.06       0.33 .005    .716
10             task:position 4.13, 255.77   5.34  30.54 *** .330   <.001
11       order:task:position 4.13, 255.77   5.34       1.18 .019    .321
12            sound:position 8.67, 537.72   2.95   3.46 *** .053   <.001
13      order:sound:position 8.67, 537.72   2.95       0.62 .010    .771
14       task:sound:position 8.09, 501.82   3.54       1.05 .017    .399
15 order:task:sound:position 8.09, 501.82   3.54       0.64 .010    .749
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1

Sphericity correction method: GG 
```
:::

```{.r .cell-code}
mochasta1_anova$Anova
```

::: {.cell-output .cell-output-stdout}
```

Type III Repeated Measures MANOVA Tests: Pillai test statistic
                          Df test stat approx F num Df den Df    Pr(>F)    
(Intercept)                1   0.88282   467.11      1     62 < 2.2e-16 ***
order                      1   0.01253     0.79      1     62 0.3785798    
task                       1   0.02153     1.36      1     62 0.2473103    
order:task                 1   0.00383     0.24      1     62 0.6269872    
sound                      1   0.25455    10.41      2     61 0.0001285 ***
order:sound                1   0.00401     0.12      2     61 0.8845924    
position                   1   0.86248    59.58      6     57 < 2.2e-16 ***
order:position             1   0.23168     2.86      6     57 0.0165017 *  
task:sound                 1   0.14320     5.10      2     61 0.0089697 ** 
order:task:sound           1   0.00894     0.28      2     61 0.7604788    
task:position              1   0.58503    13.39      6     57 2.098e-09 ***
order:task:position        1   0.09300     0.97      6     57 0.4511479    
sound:position             1   0.44183     3.36     12     51 0.0011782 ** 
order:sound:position       1   0.08952     0.42     12     51 0.9495430    
task:sound:position        1   0.26599     1.54     12     51 0.1406047    
order:task:sound:position  1   0.12429     0.60     12     51 0.8292719    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta1_anova_bf) |>
  bf_table()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 15 × 3
   term                             bf  error
   <chr>                         <dbl>  <dbl>
 1 order                     4.44e-  1 0.0548
 2 sound                     2.91e+  2 0.0640
 3 task                      3.61e-  1 0.0515
 4 position                  1.33e+143 1.00  
 5 order:sound               3.24e-  2 0.0909
 6 order:task                2.58e-  1 0.0851
 7 sound:task                5.34e+  0 0.0611
 8 order:position            2.20e+  0 0.0713
 9 position:sound            5.89e+  0 0.0541
10 position:task             3.85e+ 26 0.0674
11 order:sound:task          8.81e-  2 0.0724
12 order:position:sound      4.72e-  4 0.0532
13 order:position:task       2.74e-  2 0.0692
14 position:sound:task       4.66e-  3 0.0511
15 order:position:sound:task 4.32e-  3 0.0525
```
:::
:::



# ANOVA collapsing accross order

ANOVA: 3 (sound condition) x 2 (task modality) x 7 (serial position)


::: {.cell}

```{.r .cell-code}
mochasta1_no_order_anova <- tar_read(mochasta1_no_order_anova)

mochasta1_no_order_anova
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
               Effect           df   MSE          F  pes p.value
1                task        1, 63 52.16       1.38 .021    .244
2               sound 1.97, 124.12  8.08  11.51 *** .154   <.001
3            position 2.52, 158.52 15.72 180.16 *** .741   <.001
4          task:sound 1.94, 122.28 11.94    5.68 ** .083    .005
5       task:position 4.12, 259.80  5.36  30.45 *** .326   <.001
6      sound:position 8.63, 543.99  2.95   3.48 *** .052   <.001
7 task:sound:position 8.14, 513.04  3.50       1.05 .016    .394
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1

Sphericity correction method: GG 
```
:::

```{.r .cell-code}
mochasta1_no_order_anova$Anova
```

::: {.cell-output .cell-output-stdout}
```

Type III Repeated Measures MANOVA Tests: Pillai test statistic
                    Df test stat approx F num Df den Df    Pr(>F)    
(Intercept)          1   0.88151   468.70      1     63 < 2.2e-16 ***
task                 1   0.02145     1.38      1     63 0.2443992    
sound                1   0.25415    10.56      2     62 0.0001128 ***
position             1   0.86150    60.13      6     58 < 2.2e-16 ***
task:sound           1   0.14243     5.15      2     62 0.0085395 ** 
task:position        1   0.57955    13.32      6     58 2.006e-09 ***
sound:position       1   0.44181     3.43     12     52 0.0009565 ***
task:sound:position  1   0.26284     1.55     12     52 0.1382181    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta1_no_order_anova_bf) |>
  bf_table()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 7 × 3
  term                       bf  error
  <chr>                   <dbl>  <dbl>
1 sound               3.52e+  2 0.0395
2 task                3.74e-  1 0.0343
3 position            7.24e+103 0.0367
4 sound:task          6.39e+  0 0.0339
5 position:sound      5.52e+  0 0.0387
6 position:task       3.40e+ 26 0.0312
7 position:sound:task 4.21e-  3 0.0858
```
:::
:::


# ANOVA collapsing across order and position

ANOVA: 2 (sound condition: steady, changing) x 2 (task modality)


::: {.cell}

```{.r .cell-code}
mochasta1_no_order_position_anova <- tar_read(mochasta1_no_order_position_anova)

mochasta1_no_order_position_anova
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
      Effect    df  MSE         F  pes p.value
1       task 1, 63 5.61      0.08 .001    .772
2      sound 1, 63 1.26 13.40 *** .175   <.001
3 task:sound 1, 63 1.40    5.45 * .080    .023
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1
```
:::

```{.r .cell-code}
mochasta1_no_order_position_anova$Anova
```

::: {.cell-output .cell-output-stdout}
```

Type III Repeated Measures MANOVA Tests: Pillai test statistic
            Df test stat approx F num Df den Df    Pr(>F)    
(Intercept)  1   0.87971   460.74      1     63 < 2.2e-16 ***
task         1   0.00134     0.08      1     63 0.7724921    
sound        1   0.17535    13.40      1     63 0.0005174 ***
task:sound   1   0.07955     5.45      1     63 0.0228278 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta1_no_order_position_anova_bf) |>
  bf_table()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 3 × 3
  term           bf  error
  <chr>       <dbl>  <dbl>
1 sound      15.7   0.0374
2 task        0.261 0.0590
3 sound:task  3.40  0.0419
```
:::
:::



# Simple effects of state changes per task modalitiy


::: {.cell}

```{.r .cell-code}
tar_read(mochasta1_simple_effects_spatial)
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
  Effect    df  MSE    F  pes p.value
1  sound 1, 63 1.41 0.65 .010    .422
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta1_simple_effects_verbal)
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
  Effect    df  MSE         F  pes p.value
1  sound 1, 63 1.26 18.82 *** .230   <.001
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta1_simple_effects_bf)
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 2 × 2
  task         bf
  <fct>     <dbl>
1 spatial   0.187
2 verbal  383.   
```
:::
:::
