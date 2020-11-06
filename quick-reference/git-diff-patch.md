**basic diff/path**

```bash
diff -Naur sources-orig/ sources-fixed/ > myfixes.patch
patch -p1 < ../myfixes.patch
```

**git diff/apply**

Better, and becaues you are always in a repo, use this over diff/patch.
a" and "b" prefixes from the diff header. Specifying this option allows patch to be run using patch -p0

```bash
git diff
git diff --no-prefix # use this if you want to use patch to apply (probably not)
git diff --relative  # tell git to generate relative to current directory (for a certain part only)
```

```bash
git apply <filename>
git apply -p <filename> # if this came from diff or cvs diff (usually no)
```

git apply has two key differences from patch. First, it will not apply a patch
if you have other uncommitted changes in your code. The other significant
difference is that by default, git apply will not apply a patch that does not
apply cleanly.

**git format-patch**

Diff with all individual commits between your branch an a specified source branch.

```bash
git format-patch <source-branch>                   # Will give all commit diffs in separate files
git format-patch --stdout > 12345_fix_issues.patch # Create single file for all commits
```

Apply

```bash
git am --3way <patch file> # --3way option tells git am to automatically skip patches that are currently applied to your branch
```
