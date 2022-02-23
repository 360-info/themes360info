#' Register specific Libre Franklin font weights for use in 360info plots. This
#' function runs on package load.
#'
#' @param pref The preferred font to use: either `itc` for ITC Franklin Gothic,
#'   or `libre` for Libre Franklin. If the preferred font is unavailable, the
#'   other will be used as a fallback. By default, this argument is read from
#'   the option "themes360info.franklin.pref", with `itc` used if it is unset.
#' @param reset_fonts If TRUE, reset the font register before registering
#'   fonts. You may wish to use this if the wrong font was loaded, but it will
#'   also clear any other custom fonts you've loaded with the `systemfonts`
#'   package.
#' @importFrom rlang abort inform warn .data
#' @importFrom dplyr arrange filter slice desc
#' @importFrom cli format_error format_message format_warning cli_bullets
#' @importFrom systemfonts clear_registry register_variant system_fonts
#' @export
register_360fonts <- function(
  pref = getOption("themes360info.franklin.pref", "itc"),
  reset_fonts = FALSE) {

  # first check to ensure libre or itc franklin is actually installed
  all_fonts <- systemfonts::system_fonts()
  franklin_fonts <-
    all_fonts[grepl("Libre|ITC\\s*Franklin", all_fonts$family), ]
  libre_fonts <- all_fonts[grepl("Libre\\s*Franklin", all_fonts$family), ]
  # prevent conflict with adobe fonts (which are condensed)
  itc_fonts <- all_fonts[grepl("ITC\\s*Franklin", all_fonts$name), ]

  # diagnostic messages
  specify_diff_font <- paste(
    "Specify a different font to use with 360info themes by calling",
    "{.pkg register_360fonts()} or by setting",
    "{.pkg options(\"themes360info.franklin.pref\")} to either",
    "{.pkg \"itc\"} or {.pkg \"libre\"} (or {.pkg \"none\"} to disable",
    "automatic font loading).")
  no_fonts_found <- paste(
    "Neither ITC Franklin Gothic nor Libre Franklin was found. 360info themes",
    "may fall back to other fonts or not render properly at all."
  )

  switch(pref,
    "itc" = {
      # use itc, falling back to libre or aborting if neither are found
      if (nrow(itc_fonts) > 1) {
        family <- itc_fonts
        options("themes360info.franklin.loaded" = "itc")
        rlang::inform(cli::format_message(c(
            "v" = "Using preferred font, ITC Franklin Gothic.",
            "i" = specify_diff_font)))
      } else if (nrow(libre_fonts) > 1) {
        family <- libre_fonts
        options("themes360info.franklin.loaded" = "libre")
        rlang::warn(cli::format_warning(c(
          "!" = paste(
            "Preferred font, ITC Franklin Gothic, not found.",
            "Using Libre Franklin as a fallback."),
          "i" = specify_diff_font)))
      } else {
        options("themes360info.franklin.loaded" = "none")
        rlang::abort(cli::format_error(c("x" = no_fonts_found)))
      }
    },
    "libre" = {
      # use libre, falling back to itc or aborting if neither are found
      if (nrow(libre_fonts) > 1) {
        family <- libre_fonts
        options("themes360info.franklin.loaded" = "libre")
        rlang::inform(cli::format_message(c(
            "v" = "Using preferred font, Libre Franklin.",
            "i" = specify_diff_font)))
      } else if (nrow(itc_fonts) > 1) {
        family <- itc_fonts
        options("themes360info.franklin.loaded" = "itc")
        rlang::warn(cli::format_warning(c(
          "!" = paste(
            "Preferred font, Libre Franklin, not found.",
            "Using ITC Franklin Gothic as a fallback."),
          "i" = specify_diff_font)))
      } else {
        options("themes360info.franklin.loaded" = "none")
        rlang::abort(cli::format_error(c("x" = no_fonts_found)))
      }
    },
    {
      # abort if a bad font specification is given (neither itc nor libre)
      options("themes360info.franklin.loaded" = "none")
      rlang::abort(cli::format_error(c(
        "x" = paste0(
          "The preferred font option for Franklin Gothic should be either ",
          "`itc` or `libre`, not `", pref, "`."))))
    })

  if (reset_fonts) {
    systemfonts::clear_registry()
  }

  # locate preferred weights as precisely as we can
  # TODO - eliminate pipes here (they mess up package docs in .onLoad)
  headline <-
    family %>%
    filter(!.data$italic) %>%
    arrange(desc(.data$weight)) %>%
    slice(1)
  subhead <-
    family %>%
    filter(!.data$italic, .data$weight < "ultrabold") %>%
    arrange(desc(.data$weight)) %>%
    slice(1)
  body <-
    family %>%
    filter(!.data$italic, .data$weight == "normal") %>%
    arrange(desc(.data$weight)) %>%
    slice(1)

  # register variants of the selected font
  systemfonts::register_variant(
    name = "Headline 360info",
    family = headline$family,
    weight = headline$weight)
  systemfonts::register_variant(
    name = "Subhead 360info",
    family = subhead$family,
    weight = subhead$weight)
  systemfonts::register_variant(
    name = "Body 360info",
    family = body$family,
    weight = c(body$weight, subhead$weight))

  # TODO - switch font face declaration state?

  return()

}

#' Returns a CSS `@import` declaration for the 360 fonts. Used by `save_plot`
#' when saving SVG files so that other users viewing them on the web can see
#' 360info fonts without having them installed.
#'
#' @importFrom svglite font_face
#' @importFrom rlang warn
#' @importFrom cli format_warning cli_bullets
fontfaces_360fonts <- function() {
  
  loaded_font_name <- getOption("themes360info.franklin.loaded")
  if (loaded_font_name != "libre") {
    warn(format_warning(cli_bullets(c(
      "i" = paste0("The currently loaded 360info font, ", loaded_font_name,
        "can't be embedded in this SVG. Users may see a fallback font instead.")
    ))))
  }
  loaded_font_spec <- switch(loaded_font_name,
    "libre" = list("https://fonts.googleapis.com/css2?family=Libre+Franklin:ital,wght@0,400;0,700;0,900;1,400&display=swap"),
    list())

  return(loaded_font_spec)
}