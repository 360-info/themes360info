#' On package startup, register the ttf fils in inst/extdata
#' as "Headline 360info", "Subhead 360info" and "Body 360info"
#' 
#' (Note that the subhead font is no longer used by the theme
#' but is left for backwards-compatibility purposes.)
#' @param libname a character string giving the library directory where the package defining the namespace was found.
#' @param pkgname	a character string giving the name of the package.
.onLoad <- function(libname, pkgname) {
  systemfonts::register_font(
    name = "Headline 360info",
    plain = system.file("extdata", "RobotoCondensed-ExtraBold.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Subhead 360info",
    plain = system.file("extdata", "RobotoCondensed-Bold.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Body 360info",
    plain = system.file("extdata", "RobotoCondensed-Light.ttf",
      package = "themes360info"), 
    italic = system.file("extdata", "RobotoCondensed-LightItalic.ttf",
      package = "themes360info"),
    bold = system.file("extdata", "RobotoCondensed-Bold.ttf",
      package = "themes360info"),
    bolditalic = system.file("extdata", "RobotoCondensed-BoldItalic.ttf",
      package = "themes360info"))
}
