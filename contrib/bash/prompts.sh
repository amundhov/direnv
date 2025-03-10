# Used like:
# PS1='$(_show_context_prompt)$ '

_show_context_prompt() {
  if [[ -n ${DIRENV_CONTEXT} ]]; then
      if [[ -n ${HWT_CONTEXT#${HWT_ENVIRONMENT-}} ]]; then
          # DIRENV_CONTEXT is set and differs from DIRENV_ENVIRONMENT.
          printf '[%s%s]' "${DIRENV_ENVIRONMENT:+${DIRENV_ENVIRONMENT}/}" "${DIRENV_CONTEXT}"
      else
          printf '[%s]' "${DIRENV_ENVIRONMENT}"

      fi
  fi
}

