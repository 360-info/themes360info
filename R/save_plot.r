# Function takes as input a ggplot2 object and returns a list containing the
# title, subtitle, and caption of the object. Can handle regular ggplot2 plots
# and patchwork plots with labels added using patchwork::plot_annotation()
#' Take a ggplot2 object and return a list containing its title, subtitle, and
#' caption. Recognises Patchwork plots.
#' Based on https://github.com/grattan/grattantheme (under MIT licence)
#' @importFrom rlang warn
#' @importFrom cli format_warning
#' @param p ggplot2 object
#' @return The plot caption
extract_caption <- function(p) {

  if (isFALSE(inherits(p, "gg"))) {
    stop("Plot is not a ggplot2 object.")
  }

  if (isTRUE(inherits(p, "patchwork"))) {
    caption <- p$patches$annotation$caption

    # Warn user if labels added with +labs() to a Patchwork plot
    if (isTRUE(is.null(c(caption)))) {
      if (isFALSE(is.null(c(p$labels$caption)))) {
      warn(format_warning(c("!" =
        "Add a caption to a Patchwork plot using",
        " `patchwork::plot_annotation()`, not `labs()`.")))
      }
    }
  } else {
    caption <- p$labels$caption
  }

  return(caption)
}

#' Replace a ggplot2's labels (title, subtitle, and/or caption) with a
#' given string. Works for regular ggplot2 plots and patchwork plots.
#' Based on https://github.com/grattan/grattantheme (under MIT licence)
#'
#' @param p ggplot2 object
#' @param caption The caption to use in place of the plot's existing caption
#'
replace_caption <- function(p, caption) {

  if (isFALSE(inherits(p, "gg"))) {
    stop("Plot is not a ggplot2 object.")
  }

  # patchwork plots
  if (isTRUE(inherits(p, "patchwork"))) {
    # first, remove existing labels
    # p$patches$annotation <- subset(p$patches$annotation,
    #   !names(p$patches$annotation) %in% c("caption"))

    # then, replace with supplied labels
    p$patches$annotation$caption <- caption

  } else {
    # non-patchwork plots

    # first, remove existing labels
    # p$labels <- subset(p$labels,
    #   !names(p$labels) %in% c("caption"))

    # Then, replace with supplied labels
    p$labels$caption <- caption
  }
  return(p)
}

#' Get a sized and positioned rasterGrob of the 360info logo.
#'
#' @importFrom magick image_read_svg
#' @importFrom grid rasterGrob
#' @importFrom rlang inform
#' @importFrom cli format_message
#' @importFrom scales percent
#' @param width The base physical plot width, as a `ggplot2::unit`
#' @param footer_width_prop The proportion of the plot's width that
#'   will be taken up by the footer's height.
#' @return A sized and positioned `grid::rasterGrob` object displaying the logo
get_360logo <- function(width, footer_width_prop) {
  logo <- system.file("extdata", "360-logo.svg", package = "themes360info")

  # inform(format_message(c(
  #   "Logo diagnostic messages:",
  #   "i" = paste("Logo proportion of square: ", footer_width_prop),
  #   "i" = paste("Square width: ", width),
  #   "i" = paste("Logo height: ", width * footer_width_prop))))

  # bring the logo in using the magick package
  # (it antialiases much better than PNG!)
  grid::rasterGrob(
    image_read_svg(logo),
    1, 1, just = c("right", "top"),
    # height = width * 0.075,
    height = width * footer_width_prop * 0.6,
    interpolate = TRUE)
}

#' Save a graphic with the 360info logo in the lower right corner.
#'
#' @param plot The ggplot plot to save.
#' @param filename The path to the file to output.
#' @param shape What aspect ratio (width:height) should the graphic be?
#' Either a number specifying the ratio of the height to the width directly, or #' one of:
#'   - "phone-portrait", (9:16),
#'   - "photo-portrait" (2:3),
#'   - "sdtv-portrait" (3:4)
#'   - "square" (1:1, the default),
#'   - "sdtv-landscape" (4:3),
#'   - "photo-landcape" (3:2),
#'   - "phone-landscape" (16:9),
#' @param retina A scaling factor designed to give you a higher (or lower)
#'   resolution graphic with the same relative size text and other elements.
#' @param ... Other arguments (currently ignored).
#' @return The original plot, invisibly (so you can use it in pipes)
#' @import ggplot2
#' @importFrom ggtext GeomRichText
#' @importFrom grid gpar gList grid.lines rasterGrob
#' @importFrom patchwork wrap_elements wrap_plots
#' @importFrom svglite svglite
#' @importFrom tools file_ext
#' @importFrom rlang inform abort
#' @importFrom cli format_message format_error cli_bullets
#' @importFrom scales percent
#' @export
save_360plot <- function(plot, filename, shape = "square", retina = 2, ...) {

  # starting properties
  # we work on the basis of 6" * 66.67 dpi * 1.5 scale = 600px
  width <- unit(6, "in")
  dpi <- 66.6667 * retina
  scale <- 1.5
  
  # set height ratio based on shape keyword if it isn't specified directly
  if (is.character(shape)) {
    height_ratio <- switch(shape,
      "square"          = 1,
      "phone-landscape" = 0.5625,
      "phone-portrait"  = 1.7778,
      "photo-landcape"  = 0.6667,
      "photo-portrait"  = 1.5,
      "sdtv-landscape"  = 0.75,
      "sdtv-portrait"   = 1.3333,
      abort(format_error(cli_bullets(c(
        "x" = "Allowed keywords for the {.arg shape} argument are:",
        "*" = "{.arg phone-portrait} (9:16)",
        "*" = "{.arg photo-portrait} (2:3)",
        "*" = "{.arg sdtv-portrait} (3:4)",
        "*" = "{.arg square} (1:1)",
        "*" = "{.arg sdtv-landscape} (4:3)",
        "*" = "{.arg photo-landscape} (3:2)",
        "*" = "{.arg phone-landscape} (16:9)")))))
  } else if (is.numeric(shape)) {
    height_ratio <- shape
  } else {
    abort(format_error(cli_bullets(c(
      "x" = paste(
        "The {.arg shape} argument should either be a keyword, or a number",
        "specifying the ratio of the height to the width directly.")))))
  }

  # calculate the footer height
  # (footer is designed to be fixed for a given width)
  # NOTE - this proportion clearly isn't scaling properly. i've made it
  # conservative to ensure the footer is always visible, but on taller graphics
  # it leads to white space below the footer
  footer_prop_square <- 1 / 8
  footer_prop <- footer_prop_square / height_ratio
  panel_prop <- 1 - footer_prop - 0.001
  
  # get the logo (define height to scale alongside plot width)
  logo_360 <- get_360logo(width, footer_prop_square)

  # remove the existing plot (or patchwork) caption
  # TODO - removing existing caption isn't working!
  caption <- extract_caption(plot)
  modified_plot <- replace_caption(plot, NULL)

  # prepare the footer panel using the logo and caption
  footer_panel <-
    ggplot() +
    scale_x_continuous(limits = c(0, 1), expand = expansion(0)) +
    scale_y_continuous(limits = c(0, 1), expand = expansion(0)) +
    # caption
    annotate(
      geom = GeomRichText, x = 0, y = 1, label = caption,
      hjust = "left", vjust = "top",
      label.padding = unit(0, "in"),
      label.r = unit(0, "in"),
      label.colour = NA, fill = NA, colour = "#6b767f",
      size = 6, family = "Body 360info") +
    # logo (using sizing and position from grob above)
    annotation_custom(logo_360) +
    theme_void()

  # footer top border (G)
  # grey_line <- grid.lines(y = c(0.5, 0.5), draw = FALSE,
  #   gp = gpar(col = themes360info::pal_360[["grey"]], lwd = 2))
  grey_line <- grid.lines(y = c(0.5, 0.5), draw = FALSE,
    gp = gpar(col = "grey", lwd = 2))

  # composite the plot, line and footer
  patch <- wrap_plots(
    modified_plot,
    wrap_elements(plot = grey_line),
    wrap_elements(plot = footer_panel),
    ncol = 1,
    heights = c(panel_prop, 0.001, footer_prop))

  # compile ggsave fn args
  # TODO - what if width/height/dpi/scale are overwritten?
  save_args <- list(
    filename = filename,
    plot = patch,
    # designed for a width = 600px image with appropriate text sizing for
    # theme_360info() at default base_size
    width = width,
    height = width * height_ratio,
    dpi = dpi,
    scale = scale)

  # (add web fonts to args if we're doing svg)
  if (file_ext(filename) == "svg") {
    save_args$web_fonts <- fontfaces_360fonts()
  }

  # write out
  do.call(ggsave, save_args)

  # return the original plot invisibly (for piping)
  invisible(plot)
}
