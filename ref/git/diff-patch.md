# patch

```bash
# specify by sha (if only one is specified, HEAD is assumed)
git diff from-commit to-commit > patch.diff

# apply the patch

# optional: look at changes first
git apply --stat fix_empty_poster.patch

# optional: test
git apply --check fix_empty_poster.patch

# note it just applies the total diff to the working tree (no commit logs, etc.)
git apply patch.diff
```


*new files won't appear so create a separate patch with staged new files*

```bash
git diff -p --staged > new_files.diff
```
	
another reason to always create a branch is you can make a patch and not worry about commits, just the branch (current) against master

	git format-patch master --stdout > fix_empty_poster.patch

	//using this allows you to sign off
	git am --signoff < fix_empty_poster.patch



### diff

	git diff HEAD file			//commit vs working tree
	git diff file						//index vs working tree
	git diff --cached file	//index vs commit 



**basic (non-git) diff/path**

```bash
diff -Naur sources-orig/ sources-fixed/ > myfixes.patch
patch -p1 < ../myfixes.patch
```

**git diff/apply (most cases do this)**

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

**git format-patch (probably don't do such complicated ones)**

Diff with all individual commits between your branch an a specified source branch.

```bash
git format-patch <source-branch>                   # Will give all commit diffs in separate files
git format-patch --stdout > 12345_fix_issues.patch # Create single file for all commits
```

Apply

```bash
git am --3way <patch file> # --3way option tells git am to automatically skip patches that are currently applied to your branch
```
