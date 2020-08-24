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
#' @inheritParams get_zip_content
#' @return A single object extracted from a zip file.

read_zip_element <- function(.file, .zip_path) {
  # Identify the file extension
  file_extension <- substring(.file,
                              regexpr("\\.([[:alnum:]]+)$",
                                      .file) + 1L)

  # Apply the proper import based on the file extension
  if (file_extension %in% c("txt", "csv")) {
    read.csv(unz(description = .zip_path,
                 filename = .file),
             stringsAsFactors = FALSE)
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
                  junkpaths = TRUE),
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
#'
#' @return A list of objects imported from a zip file.
#' @export

read_zip <- function(.zip_path) {
  # validator function call to extract file names contained in zip
  name_vec <- get_zip_content(.zip_path = .zip_path)$Name
  # Extract the contents of the zip file into a list
  zip_list <- lapply(X = name_vec,
                     FUN = function(file_i) {
                       # Internal validator function
                       read_zip_element(.file = file_i,
                                        .zip_path = .zip_path)
                     })
  # Name the elements of the list with the file names
  names(zip_list) <- name_vec

  # Return the list of files
  return(zip_list)
}
