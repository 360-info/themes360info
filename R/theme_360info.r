#' Add 360info theming to a ggplot.
#'
#' @param base_size Base font size, given in pts.
#' @export
theme_360info <- function(base_family = "Body 360info", base_size = 14) {
  theme_minimal(base_family = base_family, base_size = base_size) +
  theme(
    # plot title
    plot.title = element_text(
      colour = "#36a7e9",
      family = "Headline 360info",
      size = rel(2.3), margin = margin(b = base_size * 0.75)
    ),
    plot.subtitle =
      element_text(family = "Subhead 360info", size = rel(1.15),
        margin = margin(b = base_size * 1.25)),
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
    plot.background = element_rect(fill = "white"),
    plot.margin = unit(rep(1, 4), "cm")
  )
}