#' Add 360info theming to a ggplot.
#'
#' @param base_family Name of the font family to use by default.
#' @param base_size Base font size, given in pts.
#' @importFrom ggplot2 element_text element_rect margin theme_minimal rel theme
#'   unit
#' @export
theme_360 <- function(base_family = "Body 360info", base_size = 16) {
  theme_minimal(base_family = base_family, base_size = base_size) +
  theme(
    # plot title
    plot.title = element_text(
      colour = "#36a7e9",
      family = "Headline 360info",
      size = rel(1.8), margin = margin(b = base_size * 0.5)
    ),
    plot.subtitle =
      element_text(family = "Subhead 360info", size = rel(0.9),
        margin = margin(b = base_size * 1.15)),
    plot.caption =
      element_text(hjust = 0, margin = margin(20, 0, 0, 0), size = rel(0.8),
        colour = "#6b767f"),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    # axes
    axis.title = element_text(face = "bold"),
    # panel grid
    # panel.grid = element_line(alpha("#6b767f", 0.5), size = rel(0.75)),
    # panel.grid.minor = element_line(size = rel(0.375)),
    # legends
    legend.title = element_text(face = "bold"),
    # plot frame and background
    plot.background = element_rect(fill = "white", colour = NA),
    plot.margin = unit(rep(0, 4), "in")
  )
}