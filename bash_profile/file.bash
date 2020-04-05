
# remove everything but using find
#find . ! -name 'file.txt' -type f -exec rm -f {} +
#find . -type f -not -name '*.gz'-delete
#find . -type f -not -name '*gz' -print0 | xargs -0  -I {} rm -v {}

# remove with extglob
#shopt -s extglob  # to enable extglob
#rm -v !("filename")
#rm -v !("filename1"|"filename2") 
#rm -rf !("tags")
#cp !(b*) new_dir/
#shopt -u extglob  # disable

# copy with rsync
# rsync -aP /folder1/* /folder/2
# rsync -aP --exclude=x /folder1/* /folder2/
# rsync --recursive -P --exclude=x /folder1/* /folder2/

# copy with grep 
#cp -R $(ls | grep -v '^subdir$') subdir/
#ls | grep -v file.txt | xargs rm




#### FZF

# export FZF_DEFAULT_COMMAND='ag -g ""'
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
#If you're running fzf in a large git repository, git ls-tree can boost up the speed of the traversal.
#export FZF_DEFAULT_COMMAND='
  #(git ls-tree -r --name-only HEAD ||
   #find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      #sed s/^..//) 2> /dev/null'

export FZF_DEFAULT_OPTS='--bind ctrl-f:page-down,ctrl-b:page-up'
#export FZF_DEFAULT_OPTS='--bind ctrl-f:page-down,ctrl-b:page-up,up:preview-up,down:preview-down'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

##### Searching File Contents
# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

# same thing but you type in the search
alias greppick="ag --nobreak --nonumbers --noheading . | fzf"

vgp() {
# Try highlight, coderay, rougify in turn, then fall back to cat
  fzf --preview '[[ $(file --mime {}) =~ binary ]] && \
                 echo {} is a binary file || \
                 (highlight -O ansi -l {} || \
                  coderay {} || \
                  rougify {} || \
                  cat {}) 2> /dev/null | head -500'

}


##### Changing Directories

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Another CTRL-T script to select a directory and paste it into line
#__fzf_select_dir ()
#{
        #builtin typeset READLINE_LINE_NEW="$(
                #command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
                        #-prune \
                        #-o -type f -print \
                        #-o -type d -print \
                        #-o -type l -print 2>/dev/null \
                #| command sed 1d \
                #| command cut -b3- \
                #| env fzf -m
        #)"

        #if
                #[[ -n $READLINE_LINE_NEW ]]
        #then
                #builtin bind '"\er": redraw-current-line'
                #builtin bind '"\e^": magic-space'
                #READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                #READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        #else
                #builtin bind '"\er":'
                #builtin bind '"\e^":'
        #fi
#}

#builtin bind -x '"\C-x1": __fzf_select_dir'
#builtin bind '"\C-t": "\C-x1\e^\er"'

