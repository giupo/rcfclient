.onLoad <- function(libname = find.package("rcfclient"), pkgname = "rcfclient") {
  # nocov start
  if(!file.exists(configFile())) { 
    packageStartupMessage("Creating stub config file for 'rcfclient'")
    if(!file.exists(dirname(configFile()))) {
      dir.create(dirname(configFile()))
    }

    ini_lines <- c("[API]", "base_url=https://osi2-phys-102.utenze.bankit.it:8000/grafo")
    writeLines(ini_lines, con=configFile())
  }
  # nocov end
}
