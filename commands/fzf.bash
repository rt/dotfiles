
##### Completion (this was done in .bashrc when you do the install, which does some completion)
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# export FZF_DEFAULT_COMMAND='ag -g ""'
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!*.swp"'

#If you're running fzf in a large git repository, git ls-tree can boost up the speed of the traversal.
# export FZF_DEFAULT_COMMAND='
#   (git ls-tree -r --name-only HEAD ||
#    find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
#       sed s/^..//) 2> /dev/null'

export FZF_CTRL_T_COMMAND='fd . $(git rev-parse --show-toplevel) --hidden --follow --exclude ".git" --exclude node_modules'
export FZF_ALT_C_COMMAND='fd . $(git rev-parse --show-toplevel) -t d --hidden --follow --exclude ".git" --exclude node_modules'

export FZF_DEFAULT_OPTS='--bind ctrl-f:page-down,ctrl-b:page-up'
#export FZF_DEFAULT_OPTS='--bind ctrl-f:page-down,ctrl-b:page-up,up:preview-up,down:preview-down'

