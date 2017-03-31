#' Returns settings for this package
#'
#' @name settings
#' @usage settings()
#' @param flush boolean, if `TRUE` then reloads data from config file; otherwise return cached values
#' @export
#' @include getWorkDir.r
#' @importFrom rutils ini_parse
#' @return a list of list rapresentation of the rcfclient.ini file

settings <- function(flush=FALSE) {
  if (flush) {
    options(rcfclient=NULL)
  }
  
  settings_ <- getOption("rcfclient", NULL)
  if(is.null(settings_)) {
    settings_ <- ini_parse(configFile())
    options(rcfclient=settings_)
    settings_
  } else {
    settings_
  }
}
