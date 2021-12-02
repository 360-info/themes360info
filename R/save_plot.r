#' Register specific Libre Franklin font weights for use in 360info plots. This
#' function runs on package load.
#'
#' @param plot The ggplot plot to save.
#' @param filename The path to the file to output.
#' @param height_factor How tall to render the graphic, relative to the width?
#'   Common values are: 1 (square, the default), 9/16 (16:9 landscape), 16/9 (16:9 portrait), 3/4 (4:3 landscape), 4/3 (4:3 portrait)
#' @param scaling A scaling factor that affects the size of all text and lines.
#'   By default, this is tuned to give the same font scaling as `save_png` (but
#'   you may wish to increase it if you're making a particularly tall or short
#'   graphic).
#' @param ... Other arguments passed on to `svglite::svglite`.
#' @return The original plot, invisibly (so you can use it in pipes)
#' @importFrom svglite svglite
#' @export
save_svg <- function(plot, filename, height_factor = 1, scaling = 1.4, ...) {

  svglite(filename,
    width = 6,
    height = 6 * height_factor,
    scaling = scaling,
    web_fonts = fontfaces_360fonts(),
    ...
    )

  # TODO - print plot now, with logo

  dev.off()

  # return the plot invisibly
  invisible(plot)
}

# TODO - save_png