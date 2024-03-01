
#' Open PDF in tutorial data folder.
#'
#' Opens a pdf file shippped with a given tutorial.
#'
#' @param file The filename of the pdf.
#'
#' @export
pkgPDF <- function(file) {

  system(paste0("open data/",file))
}


#' Install Pmetrics from Github.
#'
#' Installs Pmetrics from the [LAPKB Github repository](https://github.com/LAPKB/Pmetrics).
#'
#' @param ref The branch to install from. Default is "HEAD", which installs the current
#' release. Choose another branch like "dev" for access to beta versions.
#' @param force Re-install even if installed version is the same as repository version.
#' Default is `FALSE`.
#' @param ask Ask before installing. Default is `FALSE`.
#'
#' @export
install_Pmetrics <- function(ref = "HEAD", force = FALSE, ask = FALSE){

  if(!rlang::is_installed("Pmetrics") | force){
    if(ask){
      cat("The Pmetrics package will be dowloaded from Github and installed on your computer.\n")
      cat("OK to proceed?\n\n")
      ans <- readline("1. Yes, install current version.\n2. Yes, install beta version.\n3. No, do not install.\n")
      if(ans == 2){ ref = "dev"}
      if(ans == 3){
        cat("Installation aborted.\n")
        return(invisible(NULL))
      }
    }
    remotes::install_github("LAPKB/Pmetrics", ref = ref, force = force)
    cat(crayon::red("Important:"), "Don't forget to run",crayon::blue("PMbuild()"),
        "after the package is installed.")
  } else {
    cat("Pmetrics v.",as.character(packageVersion("Pmetrics")),"is installed.")
  }

}

#' Launch tutorials in the package
#'
#' Provides a list of current tutorials and asks user which one to launch.
#'
#' @param browser Launch in browser, rather than Rstudio window. Default is `TRUE`.
#'
#' @export
#'
launch <- function(browser = TRUE){
  avail <- learnr::available_tutorials("LearnPM")
  n_tut <- length(avail$name)
  cat(paste0("The following options are available.\n\n"))
  purrr::walk(1:n_tut,\(x){
    cat(paste0(x,". ",crayon::blue(avail$title[x]),"\n"))
  })
  cat(paste0(n_tut+1,". ",crayon::red("None")," - abort.\n"))
  cat("\n")
  ans <- as.numeric(readline("Which option would you like? "))
  if(ans<=n_tut){
    #options(shiny.launch.browser = browser)
    learnr::run_tutorial(avail$name[ans], "LearnPM",
                         # shiny_args = list(launch.browser = TRUE),
                         as_rstudio_job = browser)
  } else {
    return(invisible(NULL))
  }

}

#' Clean text
#'
#' Remove spaces, leading zeros, trailing zeros after decimals and numbers and trailing zeros after decimals
#' @param x the string to process
#' @export
tidyup <- function(x){
  x2 <- stringr::str_replace_all(x, "\\s+", "") %>% #remove spaces
    stringr::str_replace_all("0+(\\d*\\.)","\\1") %>% #remove leading zeros
    stringr::str_replace_all("(\\.0*[1-9]+)0+","\\1") %>% #remove trailing zeros after numbers
    stringr::str_replace_all("(\\d+)\\.0+([^1-9])+","\\1\\2") #remove trailing zeros after decimal
  return(x2)
}

#' Colorize text
#'
#' Color text in tutorials
#' @param x text to color
#' @param color Color to use
#' @export
colorize <- function(x, color) {
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, x)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color,
            x)
  } else x
}
