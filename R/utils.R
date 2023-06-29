# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @export
pkgPDF <- function(file) {
  # system(paste0("open ",
  #               system.file(paste0("tutorials/data/",file), package = "LearnPM")
  #               )
  # )
  #
  system(paste0("open data/",file))
}

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

