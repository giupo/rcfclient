context("getcf")

test_that("getcf fails if no tag is passed", {
  on.exit(options(ticket=NULL))

  with_mock(
    'RCurl::postForm' = function(...) {
      '<cas:serviceResponse xmlns:cas="https://somenamespace">
<cas:authenticationSuccess>
<cas:user>uid</cas:user>
<cas:proxyGrantingTicket>someTicket</cas:proxyGrantingTicket>
<cas:email>mail@mail.com</cas:email>
<cas:first_name>somename</cas:first_name>
<cas:last_name>somedude</cas:last_name>
<cas:username>uid</cas:username>
</cas:authenticationSuccess>
</cas:serviceResponse>'
    }, {
      auth("username", "password")
      expect_error(getcf("nome"))
    })
})

test_that("getcf fails if not authenticated", {
  expect_error(getcf("nome", "tag"), "You have to be authenticated")
})

test_that('getcf returns a list with multiple names', {
  on.exit(options(ticket=NULL))
  with_mock(
    'RCurl::getURL' = function(...) {
      "{'year': 1990,'period': 1,'freq': 4, 'numbers': [0,1,2,3]}"
    }, {
      options(ticket="someticket") # fakes authentication
      x <- getcf(c("NAME0", "NAME1"),"tag")
      expect_is(x, "list")
      expect_equal(names(x), c("NAME0", "NAME1"))
      for(name in names(x)) {
        expect_is(x[[name]], "ts")
        expect_equal(x[[name]], ts(c(0,1,2,3), start=c(1990,1), frequency=4))
      }
    }
  )
})

test_that("getcf returns a ts with a single request", {
  on.exit(options(ticket=NULL))
  with_mock(
    'RCurl::getURL' = function(...) {
      "{'year': 1990,'period': 1,'freq': 4, 'numbers': [0,1,2,3]}"
    }, {
      options(ticket="someticket") # fakes authentication
      x <- getcf("NAME0","tag")
      expect_is(x, "ts")
      expect_equal(x, ts(c(0,1,2,3), start=c(1990,1), frequency=4))
    })
})
