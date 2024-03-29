% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/labels.r
\name{annotate_360}
\alias{annotate_360}
\alias{annotate_360_light}
\alias{annotate_360_dark}
\alias{annotate_360_lightblue}
\alias{annotate_360_darkblue}
\alias{annotate_360_teal}
\alias{annotate_360_green}
\alias{annotate_360_lightgrey}
\alias{annotate_360_darkgrey}
\alias{annotate_360_glasslight}
\alias{annotate_360_glassdark}
\title{Add a 360info-themed textbox annotation to the plot.}
\usage{
annotate_360(
  text_colour = c("dark", "light", "blue"),
  box_colour = c(NA_character_, names(colours_360())),
  size = 7,
  ...
)

annotate_360_light(...)

annotate_360_dark(...)

annotate_360_lightblue(...)

annotate_360_darkblue(...)

annotate_360_teal(...)

annotate_360_green(...)

annotate_360_lightgrey(...)

annotate_360_darkgrey(...)

annotate_360_glasslight(...)

annotate_360_glassdark(...)
}
\arguments{
\item{text_colour}{The colour of the text: "dark", "light" or "blue".}

\item{box_colour}{The box fill colour: NA (the default) for no fill, or one
of the colour names in \code{colours_360}.}

\item{size}{The size of the text (passed to \code{ggplot2::annotate})}

\item{...}{Other arguments passed on to \code{ggtext::geom_textbox} or
\code{ggplot2::geom_label}.}
}
\description{
Add a 360info-themed textbox annotation to the plot.
}
