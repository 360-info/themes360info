#' Register specific Libre Franklin font weights for use in 360info plots. This
#' function runs on package load.
#'
#' @importFrom rlang abort
#' @importFrom cli format_error
#' @importFrom systemfonts system_fonts register_variant
#' @export
register_360fonts <- function() {

  # first check to ensure libre franklin is actually installed
  all_fonts <- systemfonts::system_fonts()
  libre_fonts <- all_fonts[grepl("Libre\\s*Franklin", all_fonts$family), ]
  if (nrow(libre_fonts) < 1)  {
    rlang::abort(
      format_error(c(
        "x" = paste(
          "The font family 360info uses, Libre Franklin, isn't installed. This may",
          "cause errors when rendering plots. To fix this:"),
        "*" = paste(
          "Download the font family from",
          "{.url https://fonts.google.com/specimen/Libre+Franklin}"),
        "*" = switch(Sys.info()["sysname"],
          "Darwin" = paste(
            "{.emph To install fonts on macOS,} go to",
            "{.url",
            "https://support.apple.com/en-au/guide/font-book/fntbk1000/mac}"),
          "Windows" = paste(
            "{.emph To install fonts on Windows,} go to",
            "{.url",
            "https://support.microsoft.com/en-us/office/add-a-font-b7c5f17c-4426-4b53-967f-455339c564c1}"),
          "Install the fonts on your system"),
        "*" = "Then restart R.")),
      .frequency = "once", .frequency_id = "fonts_unavailable")
  }

  # if it is, register our preferred weights so the theme can reference them
  systemfonts::register_variant(
    name = "Headline 360info",
    family = "Libre Franklin",
    weight = "heavy")
  systemfonts::register_variant(
    name = "Subhead 360info",
    family = "Libre Franklin",
    weight = "bold")
  systemfonts::register_variant(
    name = "Body 360info",
    family = "Libre Franklin",
    weight = c("normal", "bold"))

}

#' Returns a CSS `@import` declaration for the 360 fonts. Used by `save_svg` so
#' that people viewing SVG plots on the web can see 360info fonts without
#' having them installed.
#'
#' @importFrom svglite font_face
fontfaces_360fonts <- function() {

  list(
    font_face(
      "Libre Franklin",
      woff = "https://fonts.googleapis.com/css2?family=Libre+Franklin:ital,wght@0,400;0,700;0,900;1,400&display=swap",
      ttf = "LibreFranklin-Regular.ttf",
      local = "Libre Franklin",
      weight = "normal", style = "normal")
    # normal italic here
    # bold here
    # heavy here
  )
  
}