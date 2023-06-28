# themes360info 0.0.3

* Move to using Public Sans as the only supported theme font
  - Public Sans is now distributed with the package
  - Package options are now ignored
  - You can continue to use "Headline 360info" and "Body 360info" as the font families in graphics
  - "Subhead 360info" is also left in for backwards compatibility purposes, but the theme itself no longer uses it (we now use the Body font for subheads, allowing us to bold key phrases)
* Remove dplyr, magrittr and methods as dependencies
* Plot headers are now black, rather than 360 blue

# 0.0.2

* Change the error when installed fonts aren't found to a warning, so that the
  package can still be used for assessment purposes without the installed fonts.
* The option for expressing a font preference is now
  `themes360info.franklin.pref` (previously `themes360info.franklin`)

# 0.0.1

* First release!
