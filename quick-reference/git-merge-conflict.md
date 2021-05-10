---
title: Merge Conflicts
date: 2019-03-09
---

# Merge Conflicts

Perform three way merge on vim.


```text
:Gdiff on a conflict file it opens three panes (target branch (//2), working copy (filename), merge branch (//3))
from the working copy, diffget //2  or //3

:diffget //2 | diffup      //because highlighting often gets confused
other strategy is move to target or merge branch and :diffput or :dp   (this also does the | diffup for free)

:Gwrite! from either the merge or target branch to use that branch and override
```
