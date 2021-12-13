#' Save a graphic with the 360info logo in the lower right corner.
#'
#' @param plot The ggplot plot to save.
#' @param filename The path to the file to output.
#' @param shape What aspect ratio (width:height) should the graphic be? One of:
#'   - "square" (1:1, the default),
#'   - "phone-landscape" (16:9),
#'   - "phone-portrait", (9:16),
#'   - "photo-landcape" (3:2),
#'   - "photo-portrait" (2:3),
#'   - "sdtv-landscape" (4:3),
#'   - "sdtv-portrait" (3:4)
#' @param retina A scaling factor designed to give you a higher (or lower)
#'   resolution graphic with the same relative size text and other elements.
#' @param ... Other arguments passed on to `ggplot2::ggsave`.
#' @return The original plot, invisibly (so you can use it in pipes)
#' @importFrom svglite svglite
#' @importFrom ggplot2 ggsave
#' @importFrom tools file_ext
#' @importFrom methods hasArg
#' @export
save_360infoplot <- function(plot, filename,
  shape = c("square", "phone-landscape", "phone-portrait", "photo-landcape",
    "photo-portrait", "sdtv-landscape", "sdtv-portrait"),
  retina = 1,
...) {
  
  # calculate height_ratio
  shape <- match.arg(shape)
  height_ratio <- switch(shape,
    "square"          = 1,
    "phone-landscape" = 0.5625,
    "phone-portrait"  = 1.7778,
    "photo-landcape"  = 0.6667,
    "photo-portrait"  = 1.5,
    "sdtv-landscape"  = 0.75,
    "sdtv-portrait"   = 1.3333)
  
  # position the logo
  # TODO - it would be preferable to insert this into the gtable opposite the
  # caption (so that their tops are always aligned!)
  logo_360 <-
    here("360-logo.png") %>%
    readPNG() %>%
    rasterGrob(0.97, 0.03, just = c("right", "bottom"),
      height = unit(1, "cm"),
      interpolate = TRUE)

  # composite the plot and logo
  plot_element_list <- gList(ggplotGrob(gsod_aus_barchart), logo_360)

  # compile ggsave fn args
  # TODO - what if width/height/dpi/scale are overwritten?
  save_args <- list(
    filename = filename,
    plot = plot_element_list,
    # designed for a width = 600px image with appropriate text sizing for
    # theme_360info() at default base_size
    width = 6 * retina,
    height = width * height_ratio,
    dpi = 66.6667 * retina,
    scale = 1.5)

  # (add web fonts to args if we're doing svg)
  is_svg <- (hasArg(device) && device == svglite) || file_ext(filename) == "svg"
  save_args <- c(save_args, list(web_fonts = fontfaces_360fonts())[is_svg])
  
  # write out
  do.call(ggsave, save_args)

  # return the plot invisibly (for piping)
  invisible(plot)
}

# TODO - save_png