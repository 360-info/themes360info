#' The 360info brand colours.
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> Strings of colours to request.
#'  Includes helpers `blues`, `greens` and `greys`, which each give two
#'  different colours. If no colours are specified, the entire palette is
#'  returned.
#' @return A named vector of colour values.
#' @importFrom stringr str_which str_split
#' @importFrom purrr is_empty reduce
#' @importFrom rlang list2
#' @export
#' @examples
#' colours_360("black", "blues")
#' colours_360(c("lightblue", "darkgrey"))
#' colours_360()
colours_360 <- function(...) {

  pal_360 <- c(
    "lightblue" = "#36a7e9",
    "darkblue" = "#2d3494",
    "green" = "#96ca4f",
    "teal" = "#47bfaf",
    "lightgrey" = "#e1e4e6",
    "darkgrey" = "#6b767f",
    "black" = "black",
    "white" = "white")

  # return the whole palette if no colours are selected
  colours <- list2(...)
  if (is_empty(colours)) {
    return(pal_360)
  }
  
  # extract the dots into a vector
  colours <- reduce(colours, c)

  # locate the helper colours
  blues_which <- str_which(colours, "blues")
  greens_which <- str_which(colours, "greens")
  greys_which <- str_which(colours, "greys")

  # convert the requested colours to a list and extract the helper colours
  colour_list <- str_split(colours, "blues|greens|greys")

  # splice the helper colour shortcuts back in
  if (!is_empty(blues_which)) {
    colour_list[blues_which] <- rep(
      list(c("lightblue", "darkblue")),
      length(blues_which))
  }
  if (!is_empty(greens_which)) {
    colour_list[greens_which] <- rep(
      list(c("green", "teal")),
      length(greens_which))
  }
  if (!is_empty(greys_which)) {
    colour_list[greys_which] <- rep(
      list(c("lightgrey", "darkgrey")),
      length(greys_which))
  }
  
  # reduce back down to a vector
  colours <- reduce(colour_list, c)

  return(pal_360[colours])
}
