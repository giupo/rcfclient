context("utils")

test_that("getWorkDir returns the correct dir", {
  expect_equal(getWorkDir(), file.path(path.expand("~"), ".rcfclient"))
})

test_that("configFile returns the path to configuration file", {
  expect_equal(configFile(), file.path(getWorkDir(), "rcfclient.ini"))
})

test_that("settings return a list", {
  on.exit(options(rcfclient=NULL))
  expect_is(settings(), "list")
})

test_that("settings without flush reads data from 'cache'",{
  on.exit(options(rcfclient=NULL))
  calls <- 0
  with_mock(
    'rutils::ini_parse' = function(...) {
      calls <<- calls + 1
      list()
    }, {
      settings()
      settings()
      expect_equal(calls, 1)
    })
})
 
test_that("settings with flush reads file again",{
  on.exit(options(rcfclient=NULL))
  calls <- 0
  with_mock(
    'rutils::ini_parse' = function(...) {
      calls <<- calls + 1
      list()
    }, {
      settings()
      settings(TRUE)
      expect_equal(calls, 2)
    })
})


