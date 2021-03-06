context("ebirdhotspotlist")

test_that("ebirdhotspotlist works correctly", {
  skip_on_cran()
  
  out <- ebirdhotspotlist("CA-NS-YA")
  out2 <- ebirdhotspotlist(lat = 30, lng = -90, dist = 10)
  out3 <- ebirdhotspotlist(lat = 30, lng = -90, dist = 5)
  out4 <- ebirdhotspotlist("CA-NS-YA", back = 7)
  
  expect_is(out, "data.frame")
  expect_is(out, "tbl_df")
  expect_is(out2, "data.frame")
  expect_is(out2, "tbl_df")
  expect_gt(NCOL(out), 8)
  expect_gt(nrow(out2), nrow(out3))
  expect_gt(nrow(out), nrow(out4))
  
  expect_is(out$locId, "character")
  expect_is(out$numSpeciesAllTime, "integer")
  
  expect_warning(ebirdhotspotlist(lat = 0, lng = 0, dist = 1000))
  expect_warning(ebirdhotspotlist(lat = 0, lng = 0, dist = 10, back = 31))
  
  expect_warning(
    ebirdhotspotlist(),
    "As a complete lat/long pair was not provided"
  )
})

test_that("ebirdhotspotlist fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdhotspotlist(c("CA-NS-HL","CA-NS-YA")))
  expect_error(ebirdhotspotlist(""))
  expect_error(ebirdhotspotlist("foobar"))
  expect_error(ebirdhotspotlist("CA-NS-HA"))
  expect_error(ebirdhotspotlist(lat = 40))
  expect_error(ebirdhotspotlist(lat = -91, lng = 0))
  expect_error(ebirdhotspotlist(lat = 0, lng = 181))
  expect_error(ebirdhotspotlist(lat = 51.5, lng = 0, dist = -1))
})

test_that_without_key("ebirdhotspotinfo doesn't work with dummy API key", {

  expect_error(ebirdhotspotlist("CA-NS-YA")) # Doesn't work without API key
  expect_error(ebirdhotspotlist("CA-NS-YA", key = "foobar"))
})
