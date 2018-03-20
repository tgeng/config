if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="${ZSH_CACHE_DIR}/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

  z_() {
    local dir
    local candidates
    candidates=$(fasd -Rdl "$1")
    if [[ -n $candidates ]]; then
      if [[ $(wc -l <<< $candidates) = 1 ]]; then
        cd $candidates
      else
        dir="$(echo $candidates | fzy)" && cd "${dir}" || return 1
      fi
    fi
  }

  alias zz=z_

  f_() {
    local file
    local candidates
    candidates=$(fasd -Rfl "$2")
    if [[ -n $candidates ]]; then
      if [[ $(wc -l <<< $candidates) = 1 ]]; then
        vim $candidates
      else
        file="$(echo $candidates | fzy)" && $1 "${file}" || return 1
      fi
    fi
  }

  _cdt() {
    if [[ -n $1 ]]; then
      cd $1 2> /dev/null || cd $(dirname $1)
    else
      f_ _cdt
    fi
  }
  alias v='f_ vim'
  alias gv='f_ gvim'
  alias cdt='_cdt'
fi