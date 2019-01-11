
# Enable aliases to be sudo’ed
alias sudo='sudo '

# Easier navigation: .., ..., ...., ....., -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"
# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"
# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
# Always use color output for `ls`
alias ls="command ls ${colorflag}"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

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

vgp() {
# Try highlight, coderay, rougify in turn, then fall back to cat
  fzf --preview '[[ $(file --mime {}) =~ binary ]] && \
                 echo {} is a binary file || \
                 (highlight -O ansi -l {} || \
                  coderay {} || \
                  rougify {} || \
                  cat {}) 2> /dev/null | head -500'

}

# same thing but you type in the search
alias greppick="ag --nobreak --nonumbers --noheading . | fzf"
alias greppick2="grep --line-buffered --color=never -r \"\" * | fzf"

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

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@";
} 

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
