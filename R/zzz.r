.onLoad <- function(libname, pkgname) {
  systemfonts::register_font(
    name = "Headline 360info",
    plain = system.file("extdata", "LibreFranklin-Black.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Subhead 360info",
    plain = system.file("extdata", "LibreFranklin-Bold.ttf",
      package = "themes360info"))
  systemfonts::register_font(
    name = "Body 360info",
    plain = system.file("extdata", "LibreFranklin-Light.ttf",
      package = "themes360info"), 
    italic = system.file("extdata", "LibreFranklin-LightItalic.ttf",
      package = "themes360info"),
    bold = system.file("extdata", "LibreFranklin-Bold.ttf",
      package = "themes360info"),
    bolditalic = system.file("extdata", "LibreFranklin-BoldItalic.ttf",
      package = "themes360info"))
}
