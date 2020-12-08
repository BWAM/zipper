#' Get Zip File Content Information
#'
#' @param .zip_path a file path to a zip file.
#' @return a data frame containing information about the zip file.
#' @export

get_zip_content <- function(.zip_path) {
  # unzip will extract zip content info
  zip_content <- utils::unzip(zipfile = .zip_path,
                              # Provides data frame of info
                              list = TRUE,
                              # prevents the unzip files from saving to disk
                              junkpaths = TRUE)

  # Add a column that contains the name of the zip file
  # Makes it clear where the data came from
  zip_content$zip_file <- sub(".*\\/", "", .zip_path)

  return(zip_content)
}

#' Read a Single File From a Zip File
#' Provides some flexibility regarding the file type to be imported.
#' @param .file the name of a single file contained within a zip file.
#' @param .col_names argument passed to vroom::vroom. "Either TRUE, FALSE or a
#'   character vector of column names. If TRUE, the first row of the input will
#'   be used as the column names, and will not be included in the data frame. If
#'   FALSE, column names will be generated automatically: X1, X2, X3 etc. If
#'   col_names is a character vector, the values will be used as the names of
#'   the columns, and the first row of the input will be read into the first row
#'   of the output data frame. Missing (NA) column names will generate a
#'   warning, and be filled in with dummy names X1, X2 etc. Duplicate column
#' names will generate a warning and be made unique with a numeric prefix."
#' @param .col_types argument passed to vroom::vroom. "One of NULL, a cols()
#'   specification, or a string. See vignette("readr") for more details. If
#'   NULL, all column types will be imputed from the first 1000 rows on the
#'   input. This is convenient (and fast), but not robust. If the imputation
#'   fails, you'll need to supply the correct types yourself. If a column
#'   specification created by cols(), it must contain one column specification
#'   for each column. If you only want to read a subset of the columns, use
#'   cols_only(). Alternatively, you can use a compact string representation
#'   where each character represents one column: c = character, i = integer, n =
#'   number, d = double, l = logical, f = factor, D = date, T = date time, t =
#'   time, ? = guess, or _/- to skip the column.
#' @inheritParams get_zip_content
#' @return A single object extracted from a zip file.

read_zip_element <- function(.file, .zip_path, .col_names = TRUE,
                             .col_types = NULL) {
  # Identify the file extension
  file_extension <- substring(.file,
                              regexpr("\\.([[:alnum:]]+)$",
                                      .file) + 1L)

  # Apply the proper import based on the file extension
  if (file_extension %in% c("txt", "csv")) {
    vroom::vroom(unz(description = .zip_path,
                     filename = .file),
                 col_names = .col_names,
                 col_types = .col_types,
                 progress = FALSE)
    # read.csv(unz(description = .zip_path,
    #              filename = .file),
    #          stringsAsFactors = FALSE)
  } else if (file_extension %in% "htm") {
    # NOT READING CORRECTLY
    read_htm(.zip_path = .zip_path,
             .file = .file)
  } else {
    # Provide error message if not one of the file types referenced above
    stop(paste("read_zip_element does not know how to read files of type",
               file_extension))
  }
}


#' Read and Clean HTM Strings
#'
#' @inheritParams get_zip_content
#' @inheritParams read_zip_element
#'
#' @return a clean htm string.

read_htm <- function(.zip_path, .file) {
  init_string <- paste(
    readLines(
      con = unzip(zipfile = .zip_path,
                  files = .file,
                  junkpaths = TRUE,
                  exdir = tempdir()),
      encoding = "UTF-8",
      skipNul = FALSE,
      warn = FALSE
    ),
    collapse = "\n"
  )

  gsub("\\", "/", init_string, fixed = TRUE)
}


#' Read in Files Contained in a Zip File
#'
#' @inheritParams get_zip_content
#' @inheritParams read_zip_element
#' @return A list of objects imported from a zip file.
#' @export

read_zip <- function(.zip_path, .col_names = TRUE,
                     .col_types = NULL) {
  # validator function call to extract file names contained in zip
  name_vec <- get_zip_content(.zip_path = .zip_path)$Name
  # Extract the contents of the zip file into a list
  zip_list <- lapply(X = name_vec,
                     FUN = function(file_i) {
                       # Internal validator function
                       read_zip_element(.file = file_i,
                                        .zip_path = .zip_path,
                                        .col_names = .col_names,
                                        .col_types = .col_types)
                     })
  # Name the elements of the list with the file names
  names(zip_list) <- name_vec

  # Return the list of files
  return(zip_list)
}
