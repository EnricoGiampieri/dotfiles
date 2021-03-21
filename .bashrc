# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$('/home/enrico/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/enrico/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/enrico/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/enrico/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ==============================================================================
# FUNZIONI ED ALIAS PERSONALI
# ==============================================================================

# this should have a failsafe to normal if the program is not present
# >>> powerline-shell initialize >>>
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
# <<< powerline-shell initialize <<<


alias vipython='ipython --TerminalInteractiveShell.editing_mode=vi --profile=datascience'
#neofetch

export PATH="/home/enrico/scripts:$PATH"

alias tx=tmuxinator

function fdl {
    cd $(find . -not -path '*/\.*' -type d | fzf --preview 'tree -C {} | head -200')
}

function cdl {
    cd $1 && pwd && ls -lhgvF
}

function goto {
    cd $(cat ~/recenti.txt | fzf)
}

function switch {
    # cambio attività su timewarrior
    timew stop && timew start $1
}

function track {
    # fa partire una attività su timewarrior con un watch integrato
    # quando interrompo il watch arresta l'attività
    timew start $1 && watch -n 1 timew && timew stop
}

alias youtube-mp3="youtube-dl --extract-audio --audio-quality 0 --audio-format mp3"

function task_next {
    while true; do clear && timew summary && task next limit:3; sleep 2; done
}

function task_burndown {
    while true; do clear && task burndown.daily; sleep 2; done
}

function choose {
    # this script take a two columns csv in input
    # let the user pick an element from the first column
    # and return the equivalent content from the second column
    cat $1 | grep $(cat $1 | cut -d',' -f1 | fzf) | cut -d',' -f2
}

function choose_single {
    # uno snipper generico per selezionare una entry da una lista semplice, da
    # migliorare usando i jsonlines!
    # fzf | awk -F ";" '{print $2}' | tr -d '\n' | xclip -selection clipboard
    fzf --tac | jq -r '.[2]' | xclip -r -selection clipboard
}

function choose_multi {
    # uno snipper generico per selezionare una entry da una lista semplice, da
    # migliorare usando i jsonlines!
    # fzf | awk -F ";" '{print $2}' | tr -d '\n' | xclip -selection clipboard
    fzf --tac -m | jq -r '.[2]' |  xclip -selection clipboard
}

function get_pass {
    # elenca le password disponibili e le copia sulla clipboard di sistema
    # come funziona:
    # * elenca i file delle password
    # * rimuove l'estensione `.gpg`
    # * fa scegliere quale password con fzf
    # * chiede a pass di ottenere quella chiave
    # * rimuove il new line alla file dell'output
    # * lo mette dentro la clipboard
    # si puà cambiare fzf con dmenu per avere un'interfaccia grafica
    ls ~/.password-store/ | sed 's/\.gpg$//' | fzf | xargs pass | xclip -r -selection clipboard
}


# =============================================================================
# CONFIGURAZIONE DI UN GIT BARE REPOSITORY PER I DOT FILES
# https://www.atlassian.com/git/tutorials/dotfiles
# =============================================================================

# per inizializzare il repository usare:
# git init --bare $HOME/.cfg
# config config --local status.showUntrackedFiles no
# config remote add origin <git-repo-url>

# repository bare per i vari dot files
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ESPORTARE IN UN NUOVO SISTEMA
# per prima cosa impostare l'alias per `config`
# inserirlo nel gitignore evita problemi di ricorsione quando si fa il clone
# echo ".cfg" >> .gitignore
# clonare il repository dalla fonte remota
# git clone --bare <git-repo-url> $HOME/.cfg
# fare il checkout dei file
# config checkout
# può dare errore perché alcuni file potrebbero già esistere (come ad esempio il bashrc)
# nel qual caso basta rinominarli prima di fare il checkout
# per terminare settare di nuovo questa flag per evitare di vedere gli untracked
# config config --local status.showUntrackedFiles no



# =============================================================================
# CONFIGURAZIONE PER APRIRE NEOVIM COME SE STESSO NEL TERMINALE
# non funziona con programmi come vipe o vidir perché fanno escaping in modo strano
# il risultato è che il programma sembra sospeso: bisogna fare il wipe del buffer
# o rimane sempre li
# =============================================================================
# contenuto dello script nvr_shield, da mettere nel path
    ## versione che splitta il terminale, per tornare al terminale
    ## lo chiudo semplicemente
    #nvr -cc split --remote-wait +'set bufhidden=wipe' $@
    ## versione che rimpiazza il terminale, per mantenere lo split devo fare lo
    ## switch invece di chiuderlo
    ## nvr --remote-wait +'set bufhidden=wipe' $@

export VISUAL='nvim5alpha'
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL=nvr_shield
fi
alias nvim=$VISUAL
export EDITOR=$VISUAL
alias vi=$VISUAL

# =============================================================================
# fine configurazione
# =============================================================================

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_ALT_C_COMMAND='bfs -type d'

export LEDGER_FILE=~/2021.ledger
alias bat="batcat"
alias tw="timew"

# estrae tutti i caratteri unicode interessanti da un file di riferimento
alias uni="cat ~/scripts/unicode.jmt | fzf -m |  jq -r '.[2]' | tr -d '\n' | xclip -r -selection clipboard"
# configura il lancio di broot come source per permettere di fare cd
source /home/enrico/.config/broot/launcher/bash/br

