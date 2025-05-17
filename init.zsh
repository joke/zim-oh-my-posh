(( ${+commands[oh-my-posh]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[oh-my-posh]:-"$(${commands[asdf]} which oh-my-posh 2> /dev/null)"}
  [[ -z $command ]] && return 1

  # generating init file
  local initfile=$1/oh-my-posh-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command init zsh >| $initfile
    zcompile -UR $initfile
  fi

  # generating completions
  local compfile=$1/functions/_oh-my-posh
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completions zsh >| $compfile
    print -u2 -PR "* Detected a new version of 'oh-my-posh'. Regenerated completions."
  fi

  source $initfile
} ${0:h}
