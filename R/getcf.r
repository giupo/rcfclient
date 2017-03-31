#' Downloads FA timeseries data from webservice
#'
#' The webservice endpoint is configured in the `configFile()`
#'
#' @name getcf
#' @usage getcf(ids, tag)
#' @param ids character array of timeseries names
#' @param tag version tag applied to the dataset (ask the FA Unit)
#' @return a named list of TimeSeries or, in case of a single object, the object itself.
#' @export
#' @examples \dontrun{
#'   serie <- getcf("NOMESERIE", "rel15") # single series request
#'   lista <- getcf(c("NOMESERIE1", "NOMESERIE2", "NOMESERIE3", ...), "rel14") # named list of series
#' }
#' @note this function requires authentication via `auth`
#' @importFrom RCurl getURL
#' @include settings.r

getcf <- function(ids, tag) {
  if(is.null(getOption("ticket", NULL))) {
    stop("You have to be authenticated to use the webservice. @see auth() function")
  }
  stopifnot(length(tag) == 1)
  endpoint <- settings()$API$base_url
  endpoint <- paste0(endpoint, "/series/api/", tag, "/")
  ticket <- getOption("ticket")
  httpheader <- c(Authorization=ticket)
  ret <- list()
  for(name in ids) {
    url <- paste0(endpoint, name)
    res <- getURL(url, .opts=list(httpheader=httpheader, ssl.verifypeer=FALSE))
    ret[[name]] <- from_json(res)
  }

  if(length(ret) == 1) {
    ret[[1]]
  } else {
    ret
  }
}
