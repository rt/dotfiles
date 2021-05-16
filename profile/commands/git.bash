alias g="git"
alias g.branch.toggle="git checkout @{-1}"
alias g.checkout.sha.all="fcoc"
alias g.checkout.branch="fbr_local"
alias g.checkout.all="fbr_all"
alias g.commit.get_sha="fcs"
alias g.show="fshow"
alias g.stash.inspect="fstash"
alias g.churn="git_churn"
alias g.churn.month="git_churn --since='1 month ago' ."
alias g.churn.year="git_churn --since='1 year ago' ."
alias g.linecount="git_line_count"

#alias gLog="git log | grep rtsunoda -B 1 -A 3 | head -n 50"
alias gLog="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gLog2="git --no-pager log --oneline --all --decorate --graph -40 --pretty=format:'%h %ad | %s%d [%an]'"

##### Completion

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# bash completion for git
#source ~/bin/git-completion.bash
 

# add another remote
# git remote set-url --add --push origin https://gitlab.pebblefields.com/root/skeleton-client-webapp.git

# by date
# git checkout 'master@{2018-09-01 01:00:00}'

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

git_line_count() {
	if [ -z "$1" ]; then
    git ls-files | xargs cat | wc -l
  else
    git ls-files | grep "\.$1$" | xargs cat | wc -l
  fi
}

# Show churn for whole repo:
#   $ git_churn
#
# Show churn for specific directories, or move to directory and use '.':
#   $ git_churn ./app ./lib
#
# Show churn for a time range:
#   $ git_churn . --since='1 month ago'
#
# (These are all standard arguments to `git log`.)
git_churn() {
  set -e
  git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort | awk 'BEGIN {print "count\tfile"} {print $1 "\t" $2}' | sort -g
}


##### Git (FZF)
# checkout git branch
fbr_local() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# checkout git branch (including remote branches)
fbr_all() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}


# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}
