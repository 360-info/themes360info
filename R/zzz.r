#' On package startup, register the ttf fils in inst/extdata
#' as "Headline 360info", "Subhead 360info" and "Body 360info"
#' 
#' (Note that the subhead font is no longer used by the theme
#' but is left for backwards-compatibility purposes.)
.onLoad <- function(libname, pkgname) {
  systemfonts::register_font(
    name = "Headline 360info",
    plain = system.file("extdata", "PublicSans-Black.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Subhead 360info",
    plain = system.file("extdata", "PublicSans-Bold.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Body 360info",
    plain = system.file("extdata", "PublicSans-Regular.ttf",
      package = "themes360info"), 
    italic = system.file("extdata", "PublicSans-Italic.ttf",
      package = "themes360info"),
    bold = system.file("extdata", "PublicSans-Bold.ttf",
      package = "themes360info"),
    bolditalic = system.file("extdata", "PublicSans-BoldItalic.ttf",
      package = "themes360info"))
}
