test_that("The defualt will be silent", {
    testthat::expect_silent(
      read_zip(.zip_path = here::here("inst",
                                     "example_zips",
                                     "R2005136.zip")
      )
      )

  testthat::expect_silent(
    read_zip(.zip_path = here::here("inst",
                                    "example_zips",
                                    "R2006316-K.zip")
    )
  )

  test <- read_zip(.zip_path = here::here("inst",
                                          "example_zips",
                                          "R2006316-K.zip")
  )
  # Test that CSV are imported correctly ------------------------------------

  csv_zip <- read_zip(.zip_path = here::here("inst",
                                             "example_zips",
                                             "R2003501.zip")
  )
  # Test expected list elements
  testthat::expect_equal(
    length(csv_zip),
    4
  )
  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(csv_zip$Batch_v3.txt),
    c(186, 8)
  )

  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(csv_zip$Sample_v3.txt),
    c(55, 29)
  )

  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(csv_zip$TestResultQC_v3.txt),
    c(312, 66)
  )

# Test that TSV are imported correctly ------------------------------------

  tab_zip <- read_zip(.zip_path = here::here("inst",
                                  "example_zips",
                                  "R2101209_tsv.zip")
  )
  # Test expected list elements
  testthat::expect_equal(
   length(tab_zip),
   4
  )
  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(tab_zip$`R2101209/Batch_v3.txt`),
    c(143, 8)
  )

  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(tab_zip$`R2101209/Sample_v3.txt`),
    c(45, 29)
  )

  # Test that expected table dimensions are present.
  testthat::expect_equal(
    dim(tab_zip$`R2101209/TestResultQC_v3.txt`),
    c(143, 66)
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
