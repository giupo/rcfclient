#' Returns working and settings dir location
#'
#' @name getWorkDir
#' @usage getWorkDir()
#' @return path to working dir location
#' @export

getWorkDir <- function() {
  file.path(path.expand("~"), ".rcfclient")
}


#' Returns path to rcfclient.ini
#'
#' @name configFile
#' @usage configFile()
#' @return path to config file ($HOME/.rcfclient/rcfclient.ini)
#' @export

configFile <- function() {
  file.path(getWorkDir(), "rcfclient.ini")
}
