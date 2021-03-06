#' @title Downloads and installs Inno Setup
#' 
#' @description Downloads and installs Inno Setup's \href{http://www.jrsoftware.org/isdl.php#stable}{stable release}
#' 
#' @details
#' Inno Setup is a free installer for Windows programs. First introduced in 1997, it currently rivals many commercial installers in feature set and stability.
#' 
#' See \href{http://www.jrsoftware.org/isinfo.php#features}{Features} for more information.
#' 
#' @return TRUE/FALSE - was the installation successful or not.
#' 
#' @author Tal Galili and Jonathan M. Hill
#' 
#' @param quick_start_pack logical (default is FALSE) - The Inno Setup QuickStart Pack includes Inno Setup and Inno Script Studio script editor. See \href{http://www.jrsoftware.org/is3rdparty.php}{Third-Party Files} page for more information.
#' @param encryption_module logical (default is TRUE) - Inno Setup's Encryption Module
#' 
#' @param ... extra parameters to pass to \link{install.URL}
#' 
#' @examples
#' 
#' \dontrun{
#' install.inno()
#' install.inno(quick_start_pack = TRUE)
#' }
#' 
#' @export

install.inno <- function(
  quick_start_pack = FALSE, encryption_module = TRUE,
  ...) {
  
  page_with_download_url = 'http://www.jrsoftware.org/download.php/' 
  exe_filename = 'is.exe'
  
  if (quick_start_pack) {
    exe_filename = 'ispack.exe'
  }
  
  URL <- paste0(page_with_download_url, exe_filename)
  
  install.URL(URL, ...)
  
  if (encryption_module) {
    # Find the Inno Setup folder
    progs <- c(list.dirs("C:/Program Files", T, F),
               list.dirs("C:/Program Files (x86)", T, F))

    inno <- progs[grep("Inno Setup", progs)]

    # Create a temp file and add the encryption module
    temp <- tempfile()
    utils::download.file("http://www.jrsoftware.org/download.php/iscrypt.dll", temp, mode = 'wb')
    file.copy(temp, file.path(inno, "ISCrypt.dll"))
  }
}
