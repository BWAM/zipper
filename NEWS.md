# zipper 0.0.7

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
