#' this functions returns a JWT token needed to
#' interact with FA web services
#'
#' @name auth
#' @usage auth(username, password, flush)
#' @param username self-explained (it's defaulted to `rutils::whoami()`)
#' @param password self-explained (it's defaulted to `rutils::flypwd()`)
#' @param flush boolean: removes auth token from cache (defaults to `FALSE`: cache as long as you can)
#' @return an alpha-numerical strings (aka token, aka ticket) to pass on each HTTP
#'         request to the webservices
#' @importFrom rutils whoami flypwd
#' @importFrom XML xmlParse xmlToList
#' @importFrom RCurl postForm
#' @include settings.r
#' @export

auth <- function(username=whoami(), password=flypwd(), flush=FALSE) {
  if (flush) {
    options(ticket=NULL)
  }

  ticket <- getOption("ticket", NULL)
  invisible(if(is.null(ticket)) {
    base_url <- settings()$API$base_url
    loginurl <- paste0(base_url, "/authjwt/login")

    res <- postForm(
      loginurl, username=username, password=password,
      .opts = list(ssl.verifypeer = FALSE))

    parsed <- xmlParse(res)
    lista <- xmlToList(parsed)
    if("authenticationSuccess" %in%  names(lista)) {
      ticket <- lista$authenticationSuccess$proxyGrantingTicket
      options(ticket=ticket)
      ticket
    } else {
      stop("Auth failed")
    }
  } else {
    ticket
  })
}

