
<!-- README.md is generated from README.Rmd. Please edit that file -->

# themes360info

Helpers for creating graphics with ggplot2 that align with 360info style
guides

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

# Installation

First, download and install either the [Libre Franklin
fonts](https://fonts.google.com/specimen/Libre+Franklin) or the [ITC
Franklin Gothic
fonts](https://www.myfonts.com/fonts/itc/franklin-gothic/) and install
them.

Then install the package with:

``` r
remotes::install_github("360-info/themes360info")
```

## Use

To create plots in our style:

-   Add `themes360info::theme_360` to your ggplot2 plot;
-   Add our fonts to other elements, like annotations or additional
    theme customisations (see the [“Working with fonts”
    article](articles/articles/working-with-fonts.html));
-   Save the plot, adding a footer with the 360 logo, using
    `themes360info::save_plot`

## Issues

Please feel free to [get in
touch](https://github.com/360-info/themes360info/issues/new) if you have
problems with the package or would like to suggest new features.

## Next features

-   360 colour paletter helpers
-   Annotation textboxes with `ggtext`:

``` r
# not working yet!
# p2 <- p1 +
#   textbox_360("blue",
#     x = Inf, y = Inf, hjust = "inward", vjust = "inward", halign = 1,
#     label = "**THIS IS A PATTERN**<br>As one measure gets bigger, the other gets smaller."
#   )
# ggsave("test2.png", p2)
```
