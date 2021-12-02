# themes360info
Helpers for creating graphics with ggplot2 that align with 360info style guides

# Installation

First, [download the Libre Franklin fonts](https://fonts.google.com/specimen/Libre+Franklin) and install them.

Then install the development version with:

```r
remotes::install_github("360-info/themes360info")
```

# Examples

```r
library(ggplot2)
library(themes360info)

p1 <- ggplot(mtcars) +
  aes(mpg, disp) +
  geom_point() +
  theme_360info() +
  labs(
    x = "Em-peg", y = "Disp",
    title = "BIG TITLE",
    subtitle = "SMALL THINGS HAPPEN SOMETIMES",
    caption = "Source: stuff")
ggsave("test1.png", p1)
```

![test1](https://user-images.githubusercontent.com/6520659/143531686-ca66dbf7-2d24-46b8-9b86-23d9863ffbdc.png)

```r
# not working yet!
p2 <- p1 +
  textbox_360info("blue",
    x = Inf, y = Inf, hjust = "inward", vjust = "inward", halign = 1,
    label = "**THIS IS A PATTERN**<br>As one measure gets bigger, the other gets smaller."
  )
ggsave("test2.png", p2)
```
