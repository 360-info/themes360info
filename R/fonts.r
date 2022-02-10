#' Register specific fonts for use in 360info plots. This
#' function runs on package load unless it's been disabled in options().
#'
#' @param pref The preferred font to use: either `itc` for ITC Franklin Gothic,
#'   or `libre` for Libre Franklin. If the preferred font is unavailable, the
#'   other will be used as a fallback. By default, this argument is read from
#'   the option "themes360info.franklin", with `itc` used if it is unset.
#' @param reset_fonts If TRUE, reset the font register before registering
#'   fonts. You may wish to use this if the wrong font was loaded, but it will
#'   also clear any other custom fonts you've loaded with the `systemfonts`
#'   package.
#' @importFrom rlang abort inform warn
#' @importFrom dplyr arrange filter slice
#' @importFrom cli format_error format_message format_warning
#' @importFrom systemfonts clear_registry register_variant system_fonts
#' @export
register_360fonts <- function(
  pref = getOption("themes360info.franklin", "itc"),
  reset_fonts = FALSE) {

  # TODO - register typekit fonts with systemfonts::register_font
  # (but how to know which to use?)
  try(
    { load_adobe_fonts() },
    )

  # first check to ensure libre or itc franklin is actually installed
  all_fonts <- systemfonts::system_fonts()
  franklin_fonts <-
    all_fonts[grepl("Libre|ITC\\s*Franklin", all_fonts$family), ]
  libre_fonts <- all_fonts[grepl("Libre\\s*Franklin", all_fonts$family), ]
  itc_fonts <- all_fonts[grepl("ITC\\s*Franklin", all_fonts$family), ]

  # diagnostic messages
  specify_diff_font <- paste(
    "Specify a different font to use with 360info themes by calling",
    "{.pkg register_360fonts()} or by setting",
    "{.pkg options(\"themes360info.franklin\")} to either",
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
        rlang::inform(cli::format_message(c(
            "v" = "Using preferred font, ITC Franklin Gothic.",
            "i" = specify_diff_font)))
      } else if (nrow(libre_fonts) > 1) {
        family <- libre_fonts
        rlang::warn(cli::format_warning(c(
          "!" = paste(
            "Preferred font, ITC Franklin Gothic, not found.",
            "Using Libre Franklin as a fallback."),
          "i" = specify_diff_font)))
      } else {
        rlang::abort(cli::format_error(c("x" = no_fonts_found)))
      }
    },
    "libre" = {
      # use libre, falling back to itc or aborting if neither are found
      if (nrow(libre_fonts) > 1) {
        family <- libre_fonts
        rlang::inform(cli::format_message(c(
            "v" = "Using preferred font, Libre Franklin.",
            "i" = specify_diff_font)))
      } else if (nrow(itc) > 1) {
        family <- itc_fonts
        rlang::warn(cli::format_warning(c(
          "!" = paste(
            "Preferred font, Libre Franklin, not found.",
            "Using ITC Franklin Gothic as a fallback."),
          "i" = specify_diff_font)))
      } else {
        rlang::abort(cli::format_error(c("x" = no_fonts_found)))
      }
    },
    {
      # abort if a bad font specification is given (neither itc nor libre)
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
    dplyr::filter(!italic) %>%
    dplyr::arrange(desc(weight)) %>%
    dplyr::slice(1)
  subhead <-
    family %>%
    dplyr::filter(!italic, weight < "ultrabold") %>%
    dplyr::arrange(desc(weight)) %>%
    dplyr::slice(1)
  body <-
    family %>%
    dplyr::filter(!italic, weight == "normal") %>%
    dplyr::arrange(desc(weight)) %>%
    dplyr::slice(1)

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
fontfaces_360fonts <- function() {
  # TODO - libre vs itc?
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

#' Find the paths of ITC Franklin fonts synced from Adobe Fonts. Throws an error
#' if the fonts can't be found.
load_adobe_fonts <- function() {

  # ~/Library/Application Support/Adobe/CoreSync/plugins/livetype/.r/.[number].otf
  # C:\Users\<your user name>\AppData\Roaming\Adobe\CoreSync\plugins\livetype\r
  typekit_dir <- normalizePath(switch(Sys.info()["sysname"],
    "Darwin" =
      "~/Library/Application Support/Adobe/CoreSync/plugins/livetype/.r",
    "Windows" =
      "~\\..\\AppData\\Roaming\\Adobe\\CoreSync\\plugins\\livetype\\r",
    "Unix" = rlang::warn(cli::format_warning(c(
      "x" = "Adobe Fonts unavailable on Linux.")))
  ))

  # does the directory exist?
  if (!dir.exists(typekit_dir)) {
    rlang::warn(cli::format_warning(c("x" = "Adobe Fonts not found.")))
  }

  # these unique identifiers are used by typekit
  # (on macOS, the files have a leading period to make them hidden!)
  franklin_fonts <- c(
    plain = "39285.otf",
    bold = "39287.otf",
    italic = "39286.otf",
    bolditalic = "39288.otf")

  franklin_paths <-
    switch(Sys.info()["sysname"],
      "Darwin" = file.path(typekit_dir, paste0(".", franklin_fonts)),
      "Windows" = file.path(typekit_dir, franklin_fonts))
  names(franklin_paths) <- names(franklin_fonts)

  # confirm the fonts are available
  if (!all(file.exists(franklin_paths))) {
    rlang::warn(cli::format_warning(c(
      "x" = paste(
        "One or more of the ITC Franklin Gothic LT Pro Condensed fonts",
        "is unsynced."),
      "i" = paste(
        "Activate them from",
        "{.url https://fonts.adobe.com/fonts/itc-franklin-gothic}",
        "using your Adobe Fonts subscription."
      ))))

    stop(paste(
      "One or more of the ITC Franklin Gothic LT Pro Condensed fonts is missing.",
      "Activate them from https://fonts.adobe.com/fonts/itc-franklin-gothic",
      "using your Adobe Fonts subscription."
      ))
  }

  # register the font
  register_font(
    "Franklin 360",
      plain = file.path(typekit_dir, ".39285.otf"),
      bold = file.path(typekit_dir, ".39287.otf"),
      italic = file.path(typekit_dir, ".39286.otf"),
      bolditalic = file.path(typekit_dir, ".39288.otf"))
  rlang::inform(cli::format_message(c(
    "v" = "Using your synced Adobe Fonts typefaces.",
    "i" = "Use them in your plots with the {.emph \"Franklin 360\"} font family.")))
  return()
}