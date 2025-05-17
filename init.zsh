(( ${+commands[oh-my-posh]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[oh-my-posh]:-"$(${commands[asdf]} which oh-my-posh 2> /dev/null)"}
  [[ -z $command ]] && return 1

  # generating init file
  local initfile=$1/oh-my-posh-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command init zsh >| $initfile
    zcompile -UR $initfile
  fi

  source $initfile
} ${0:h}
