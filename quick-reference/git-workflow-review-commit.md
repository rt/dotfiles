# git-workflow-commit

Single commit.

**Working files**

Do work and want to look at what's in the commit

- :Git difftool               // quickfix list of edited working files (stages and unstaged don't come up)
- ]q                          // next
- :GitGutterUndoHunk          // similar to piecemeal (piecemeal allows you to see what is in staged and working)
- :Git                        // stage what you want, diff if curious, and commit
- :Git push


**Merge branch into master**

git merge --no-commit --squash feature

All files are staged (you can unstage but if you have other unstaged files ... probably should try to stay clean)

- :Git                        // Unstage
- Do working files workflow
