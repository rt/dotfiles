#! /usr/bin/env bash

# Simple way to get full path from a relative path in a repo
rpath="$1"
repoPath="$(git rev-parse --show-toplevel)"
echo "$repoPath/$rpath"


