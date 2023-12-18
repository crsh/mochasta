---
title: "Analysis of Experiment 2"
author: "Frederik Aust"
date: "2023-12-16"

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
mochasta2_anova <- tar_read(mochasta2_anova)

mochasta2_anova
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
               Effect            df    MSE          F  pes p.value
1                task        1, 126 198.30    9.81 ** .072    .002
2               sound  1.93, 243.45   9.20  18.42 *** .128   <.001
3          task:sound  1.93, 243.45   9.20  10.01 *** .074   <.001
4            position  2.54, 319.72  10.71 148.91 *** .542   <.001
5       task:position  2.54, 319.72  10.71     3.31 * .026    .027
6      sound:position 8.57, 1079.96   2.90     2.21 * .017    .021
7 task:sound:position 8.57, 1079.96   2.90     1.87 + .015    .055
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1

Sphericity correction method: GG 
```
:::

```{.r .cell-code}
mochasta2_anova$Anova
```

::: {.cell-output .cell-output-stdout}
```

Type III Repeated Measures MANOVA Tests: Pillai test statistic
                    Df test stat approx F num Df den Df    Pr(>F)    
(Intercept)          1   0.77685   438.65      1    126 < 2.2e-16 ***
task                 1   0.07225     9.81      1    126 0.0021557 ** 
sound                1   0.20577    16.19      2    125 5.581e-07 ***
task:sound           1   0.12381     8.83      2    125 0.0002584 ***
position             1   0.79185    76.72      6    121 < 2.2e-16 ***
task:position        1   0.07769     1.70      6    121 0.1269626    
sound:position       1   0.20374     2.45     12    115 0.0069797 ** 
task:sound:position  1   0.14937     1.68     12    115 0.0794474 .  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta2_anova_bf) |>
  bf_table()
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 7 × 3
  term                       bf  error
  <chr>                   <dbl>  <dbl>
1 sound               2.76e+  5 0.0553
2 task                1.56e+  1 0.0437
3 position            6.88e+120 0.0493
4 sound:task          2.82e+  2 0.0446
5 position:sound      6.16e-  2 0.0939
6 position:task       2.41e+  0 0.0997
7 position:sound:task 8.46e-  2 0.105 
```
:::
:::



# Simple effects of state changes per task modalitiy


::: {.cell}

```{.r .cell-code}
tar_read(mochasta2_simple_effects_spatial)
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
  Effect    df  MSE    F  pes p.value
1  sound 1, 63 1.14 0.73 .011    .397
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta2_simple_effects_verbal)
```

::: {.cell-output .cell-output-stdout}
```
Anova Table (Type 3 tests)

Response: pos_total
  Effect    df  MSE         F  pes p.value
1  sound 1, 63 1.14 34.22 *** .352   <.001
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1
```
:::

```{.r .cell-code}
tar_read(mochasta2_simple_effects_bf)
```

::: {.cell-output .cell-output-stdout}
```
# A tibble: 2 × 2
  task           bf
  <fct>       <dbl>
1 spatial     0.194
2 verbal  73914.   
```
:::
:::
