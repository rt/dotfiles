
# setup autocomplete in bash into the current shell, bash-completion package should be installed first.
source <(kubectl completion bash) 
alias k=kubectl
complete -F __start_kubectl k
