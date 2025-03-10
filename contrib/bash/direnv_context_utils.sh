declare -a _direnv_contexts
_direnv_context_list() {
  local absolute_base_path
  shopt -s nullglob
  absolute_base_path="${DIRENV_DIR#-}/.env"
  _direnv_contexts=(${absolute_base_path}${1:+.$1}!(rc*))
  # Strip off to only leave env name
  _direnv_contexts=(${_direnv_contexts[@]#${absolute_base_path}.})
}

_direnv_comp_contexts() {
    if [[ "$COMP_CWORD" -ge 2 ]]; then
        # Already completed the context.
        COMPREPLY=()
    else
        _direnv_context_list "$2"
        COMPREPLY=("${_direnv_contexts[@]}")
    fi
}

_direnv_set_context() {
  local context_file
  DIRENV_CONTEXT="$1"
  context_file="${DIRENV_DIR#-}/.envrc.context"
  echo "${DIRENV_CONTEXT}" > "${context_file}"
}

_direnv_context_bash_setup() {
  bind -x '"\C-x": ""'
#   bind -x '"\C-x": "_cycle_context ; printf ''\\r%s'' "${PS1@P}""'
  complete -F _direnv_comp_contexts _direnv_set_context
}
