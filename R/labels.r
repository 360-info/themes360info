#' Add a 360info-themed textbox to the plot.
#'
#' @param box_style A string for one of the pre-defined 360info styles. Affects
#'   the fill and text colour of the box. One of "light", "dark", "blue",
#'   "glass_light" or "glass_dark".
#' @param ... Other arguments passed on to `ggtext::geom_textbox` or
#'   `ggplot2::geom_label`.
#' @importFrom rlang warn
#' @importFrom cli format_warning
#' @importFrom ggplot2 unit geom_label
#' @export
geom_label360 <- function(
  box_style = c("light", "dark", "blue", "glass_light", "glass_dark"),
  ...) {

  # determine colours from selected pre-fill style
  box_style <- match.arg(box_style)
  all_styles <- data.frame(
    style = c("light", "dark", "blue", "glass_light", "glass_dark"),
    fill = c("white", "black", "#36a7e9", NA, NA),
    colour = c("black", "white", "white", "black", "white"))
  selected_style <- all_styles[all_styles$style == box_style, ]

  # return either a geom_textbox (if available) or a geom_label (if not)
  if (requireNamespace("ggtext", quietly = TRUE)) {

    ggtext::geom_textbox(
      fill = selected_style$fill, colour = selected_style$colour,
      family = "Body 360info",
      size = 5,
      box.r = unit(0, "cm"), box.padding = unit(0.5,  "cm"),
      box.colour = NA,
    ...)

  } else {

    # throw a warning (once) if ggtext isn't installed...
    warn(
      format_warning(c(
        "i" = paste(
          "The {.pkg ggtext} package isn't installed. This means that textbox",
          "features like {.emph formatting text} and line wrapping aren't",
          "available."),
        ">" = paste(
          "Get it by running the command: {.code install.packages('ggtext')},",
          "then try again to enable these features."))),
      .frequency = "once", .frequency_id = "ggtext_unavailable")
    
    # ... then proceed with a regular textbox
    geom_label(
      fill = selected_style$fill, colour = selected_style$colour,
      family = "Body 360info",
      size = 5,
      label.r = unit(0, "cm"), label.padding = unit(0.5,  "cm"),
      label.colour = NA,
      ...)

  }

  
}

# TODO - annotate_360, using geom = `ggtext:geom_textbox`?