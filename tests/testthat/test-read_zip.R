test_that("The defualt will be silent", {
    testthat::expect_silent(
      read_zip(.zip_path = here::here("inst",
                                     "example_zips",
                                     "R2005136.zip")
      )
      )
})


test_that("Snapshoot remains the same", {

  testthat::expect_snapshot(
    read_zip(.zip_path = here::here("inst",
                                   "example_zips",
                                   "R2005136.zip")
    )
    )
})
