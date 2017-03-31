context("Authentication")

test_that("auth calls the api only if FLUSH is True", {
  on.exit(options(ticket=NULL))
  apicalls <- 0
  with_mock(
    'RCurl::postForm' = function(...) {
      apicalls <<- apicalls + 1
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
      ticket <- auth(username="pippo", password="pluto")
      ticket <- auth(username="pippo", password="pluto")
      expect_equal(apicalls, 1)

      ticket <- auth(username="pippo", password="pluto", flush=TRUE)
      expect_equal(apicalls, 2)
    })
})

test_that("a falied authentication raises an error,", {
  with_mock(
    'RCurl::postForm' = function(...) {
      '<cas:serviceResponse xmlns:cas="https://somenamespace"></cas:serviceResponse>'
    }, {
      expect_error(auth(username="pippo", password="pluto"), "Auth failed")
    })
})
