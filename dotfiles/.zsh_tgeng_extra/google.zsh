if [[ -e /usr/local/google/home ]]; then
  function sj() {
    if [[ $PWD =~ '(.*)/javatests(.*)' ]]; then
      cd "${match[1]}/java${match[2]}"
    else
      cd "${PWD/\/google3\/java//google3/javatests}"
    fi
  }

  function bb() {
    if [[ $PWD =~ '(.*)/blaze-bin(.*)' ]]; then
      cd "${match[1]}${match[2]}"
    else
      cd "${PWD/\/google3//google3/blaze-bin}"
    fi
  }

  alias gme='g fix5 && g multi export'
  alias gl='g log5'
  alias gr='g rb5'
  alias gms='g multi sync'
  alias gcm='g commit --amend --no-edit'
  alias gcam='g commit -a --amend --no-edit'
  alias gca='g commit -a'
  alias gfix='g fix5'
  alias grc='g rebase --continue'
  alias gra='g rebase --abort'
  alias gco='g co'
  alias ga='noglob g add'
  alias fixjs=/google/src/components/head/google3/third_party/java_src/jscomp/java/com/google/javascript/jscomp/lint/fixjs.sh
  function gg() {
    zz ${1}/google3
  }
  function depotp() {
    pwd | sed 's|/usr/local/google/home/tgeng/git/[^/]\+/google3/\(.\+\)|\1|' | sed 's|/google/src/cloud/tgeng/[^/]\+/google3/\(.\+\)|\1|' | sed 's|^/.*||'
  }
  function sc() {
    local current
    current=$(depotp)
    g4d $1 && cd $current
  }
  function sg() {
    local current
    current=$(depotp)
    gg $1 && cd $current
  }
  function p() {
    echo -n '//'`depotp` | xclip -selection clipboard
  }

  function cdg() {
    bd google3
    if [ $1 ]; then
      cdt $1
    fi
  }

  source /etc/bash_completion.d/g4d
fi
