#' this functions returns a JWT token needed to
#' interact with FA web services
#'
#' @name auth
#' @usage auth()
#' @usage auth(username, password)
#' @param username self-explained (it's defaulted to `rutils::whoami()`)
#' @param password self-explained (it's defaulted to `rutils::flypwd()`)
#' @return an alpha-numerical strings (aka token, aka ticket) to pass on each HTTP
#'         request to the webservices
#' @importFrom rutils whoami flypwd
#' @importFrom XML xmlParse xmlToList
#' @importFrom RCurl postForm
#' @include settings.r
#' @export

auth <- function(username=whoami(), password=flypwd()) {
  base_url <- settings()$API$base_url
  baseurl <- paste0(.base_url, "/authjwt/login")
  res <- postForm(baseurl, username=username, password=password,
                  .opts = list(ssl.verifypeer = FALSE))
  parsed <- xmlParse(res)
  list <- xmlToList(parsed)
  if("authenticationSuccess" %in%  names(list)) {
    options(ticket=list$authenticationSuccess$proxyGrantingTicket)
  } else {
    stop("Auth failed")
  }
}

