# #' Add a 360info-themed textbox geom to the plot.
# #'
# #' @param text_colour A string for the text colour
# #' @param ... Other arguments passed on to `ggtext::geom_textbox` or
# #'   `ggplot2::geom_label`.
# #' @importFrom rlang warn
# #' @importFrom cli format_warning
# #' @importFrom ggplot2 unit geom_label
# #' @export
# geom_textbox360 <- function(
#   text_colour = c("dark", "light", "blue"),
#   box_colour = c(NA_character_, names(colours_360())),
#   size = 7, ...) {

#   text_colour <- match.arg(text_colour)
#   box_colour <- match.arg(box_colour)

#   text_colour <- switch(text_colour,
#     "dark" = colours_360("black"),
#     "light" = colours_360("white"),
#     "blue" = colours_360("lightblue"))
#   if (!is.na(box_colour)) {
#     box_colour <- colours_360(box_colour)
#   }

#   ggtext::geom_textbox(
#     fill = box_colour, colour = text_colour,
#     family = "Body 360info",
#     size = 7,
#     box.r = unit(0, "cm"), box.padding = unit(0.5,  "cm"),
#     box.colour = NA,
#     ...)
# }

# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_light <- function(...) {
#   geom_textbox360(text_colour = "dark", box_colour = "lightgrey", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_dark <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "darkgrey", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_lightblue <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "lightblue", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_darkblue <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "darkblue", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_teal <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "teal", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_green <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "green", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_lightgrey <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "lightgrey", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_darkgrey <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = "darkgrey", ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_glasslight <- function(...) {
#   geom_textbox360(text_colour = "dark", box_colour = NA_character_, ...)
# }
# #' @rdname geom_textbox360
# #' @export
# geom_textbox360_glassdark <- function(...) {
#   geom_textbox360(text_colour = "light", box_colour = NA_character_, ...)
# }

#' Add a 360info-themed textbox annotation to the plot.
#'
#' @param text_colour The colour of the text: "dark", "light" or "blue".
#' @param box_colour The box fill colour: NA (the default) for no fill, or one
#'   of the colour names in `colours_360`.
#' @param ... Other arguments passed on to `ggtext::geom_textbox` or
#'   `ggplot2::geom_label`.
#' @param size The size of the text (passed to `ggplot2::annotate`)
#' @importFrom rlang warn
#' @importFrom cli format_warning
#' @importFrom ggplot2 unit geom_label
#' @importFrom ggtext GeomRichText
#' @export
annotate_360 <- function(
  text_colour = c("dark", "light", "blue"),
  box_colour = c(NA_character_, names(colours_360())),
  size = 7, ...) {

  text_colour <- match.arg(text_colour)
  box_colour <- match.arg(box_colour)

  text_colour <- switch(text_colour,
    "dark" = colours_360("black"),
    "light" = colours_360("white"),
    "blue" = colours_360("lightblue"))
  if (!is.na(box_colour)) {
    box_colour <- colours_360(box_colour)
  }

  annotate(geom = GeomRichText, colour = text_colour, fill = box_colour,
    label.colour = NA, family = "Body 360info", size = size,
    label.r = unit(0, "cm"), label.padding = unit(0.25, "cm"),
    ...)
}

#' @rdname annotate_360
#' @export
annotate_360_light <- function(...) {
  annotate_360(text_colour = "dark", box_colour = "lightgrey", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_dark <- function(...) {
  annotate_360(text_colour = "light", box_colour = "darkgrey", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_lightblue <- function(...) {
  annotate_360(text_colour = "light", box_colour = "lightblue", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_darkblue <- function(...) {
  annotate_360(text_colour = "light", box_colour = "darkblue", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_teal <- function(...) {
  annotate_360(text_colour = "light", box_colour = "teal", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_green <- function(...) {
  annotate_360(text_colour = "light", box_colour = "green", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_lightgrey <- function(...) {
  annotate_360(text_colour = "light", box_colour = "lightgrey", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_darkgrey <- function(...) {
  annotate_360(text_colour = "light", box_colour = "darkgrey", ...)
}
#' @rdname annotate_360
#' @export
annotate_360_glasslight <- function(...) {
  annotate_360(text_colour = "dark", box_colour = NA_character_, ...)
}
#' @rdname annotate_360
#' @export
annotate_360_glassdark <- function(...) {
  annotate_360(text_colour = "light", box_colour = NA_character_, ...)
}

