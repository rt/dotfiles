# Merge Conflicts

Perform three way merge on vim.

```text
:Git
dv      on unstaged conflict file it opens three panes 
        (target branch (//2), working copy (filename), merge branch (//3))
        from the working copy, diffget //2  or //3

:diffget //2 | diffup      //because highlighting often gets confused

edit middle pane by removing arrows and taking/editing what you need

other strategy is move to target or merge branch and :diffput or :dp   (this also does the | diffup for free)

:Gwrite! from either the merge or target branch to use that branch and override
```
