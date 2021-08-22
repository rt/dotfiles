#! /usr/bin/env bash

# TODO:  Not implemented yet
# Return a list of all files in project with the relative paths of the current file
# Use `git ls-files ../../` So need to add the correct amount of `../` for current file to top of repo
rpath="$1"

repoPath="$(git rev-parse --show-toplevel)"


