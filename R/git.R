#' @export
extract_commit <- function(path, num) {
  stopifnot(file.exists(path),
            is.numeric(num),
            num == trunc(num),
            num > 0)
  if (!git2r::in_repository(path)) {
    return(list(sha1 = "NA", message = "NA"))
  }
  repo <- git2r::repository(path, discover = TRUE)
  git_log <- capture.output(git2r::reflog(repo))
  total_commits <- length(git_log)
  if (total_commits == 0) {
    return(list(sha1 = "NA", message = "NA"))
  }
  if (num > total_commits) {
    stop(sprintf("Invalid search: %d. This repo only has %d commits.",
                 num, total_commits))
  }
  commit <- git_log[num]
  sha1 <- substr(commit, 2, 8)
  commit_message <- strsplit(commit, split = "commit: ")[[1]][2]
  return(list(sha1 = sha1, message = commit_message))
}

#' Create a default .gitignore file
#'
#' The .gitignore in inst/infrastrucure does not survive builing the R package.
#' The .nojekyll does, so it must be specific to this filename and not a
#' property of hidden files. Hadley does not include .gitignore in
#' .Rbuildignore, which further supports that it is ignored by default.
create_gitignore <- function(path, overwrite = FALSE) {
  lines <- c(".Rproj.user",
             ".Rhistory",
             ".RData",
             ".Ruserdata",
             "analysis/figure",
             "analysis/*html")
  fname <- file.path(path, ".gitignore")
  exists <- file.exists(fname)
  if (exists & !overwrite) {
    warning(sprintf("File %s already exists. Set overwrite = TRUE to replace",
                    fname))
  } else {
    writeLines(lines, con = fname)
  }
  return(invisible(fname))
}
