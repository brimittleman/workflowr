% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/commit_site.R
\name{obtain_files_in_commit}
\alias{obtain_files_in_commit}
\title{Obtain the files updated in a commit}
\usage{
obtain_files_in_commit(repo, commit)
}
\description{
Obtain the files updated in a commit, similar to \code{git status --stat}, by
running a diff between the trees pointed to by the commit and its parent
commit.
}
\details{
This only works for commits that have one parent commit. Thus it will fail
for merge commits (two parents) or the initial root commit (zero parents).
two most recent commits. This uses `diff,git_tree`. See the source code at
\url{https://github.com/ropensci/git2r/blob/89d916f17cb979b3cc21cbb5834755a2cf075f5f/R/diff.r#L314}
and examples at
\url{https://github.com/ropensci/git2r/blob/cb30b1dd5f8b57978101ea7b7dc26ae2c9eed38e/tests/diff.R#L88}.
}
\seealso{
\code{\link{obtain_files_in_commit_root}},
  \code{\link{decide_to_render}}
}

