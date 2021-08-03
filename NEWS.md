# zipper 0.0.8

-   `read_zip()` added `…` argument to provide users with more flexibility to specify how files should be imported. The additional arguments are passed on to `read.csv` or `read.table`.

# zipper 0.0.7

-   `read_zip()` now guesses if an imported data frame did not have any headers by looking for the presence of blank column names. When no headers are present:

    -   The imported column names are appended to the data frame as a new row.

    -   During the append, all column types are converted to character. `type.convert()` is used to make an educated guess at the column type.

    -   The column names are replaced with dummy names. The dummy names have the prefix "X" followed by a number assigned sequentially based on the number of columns present.

# zipper 0.0.6

-   `read_zip()` will now check if .txt files are CSV or TSV, and subsequently read the file in using the correct delimiter.

# zipper 0.0.5

-   add the ability to ingest HTML files.

# zipper 0.0.4

-   `read.csv()` defaults are now:

    -   `na.strings = c("", "NA", "N/A", "na", "n/a")`

    -   `strip.white = TRUE`

    -   `stringsAsFactors = FALSE`

# zipper 0.0.3

-   Dropped the use of `vroom` to import CSVs and TXTs in favor of `read.csv()`.

# zipper 0.0.2

-   Added the ability to pass `col_names` and `col_types` to `vroom::vroom()`via `read_zip_element()` and `read_zip()`.

# zipper 0.0.1

# zipper 0.0.0.9000

-   Added a `NEWS.md` file to track changes to the package.

-   Moved functions out of the validator package to make them more accessible to other BWAM packages.
