# $FreeBSD: releng/10.1/etc/root/dot.cshrc 243893 2012-12-05 13:56:39Z eadler $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
# 

alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv	EDITOR	    vim
setenv	PAGER	    more
setenv	BLOCKSIZE   K

if ( $?prompt ) then
	# An interactive shell -- set some stuff up
	set prompt = "%N@%m:%~ %# "
	set promptchars = "%#"

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif

# ================================
#  surman
# ================================

# Comentarios:
#   en batch scripts se usa # blablala
#   en shell interactiva se usa : blablabla
#
# root@lnx:~# : asdsad esto es un cometario
# root@lnx:~# : joder lo q ma costao encontrarlo

# prompt
# set prompt = "%n@%m:%~ %# "

# Home, End y Delete
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[7~" beginning-of-line # Home rxvt
bindkey "\e[2~" overwrite-mode    # Ins
bindkey "\e[3~" delete-char       # Delete
bindkey "\e[4~" end-of-line       # End
bindkey "\e[8~" end-of-line       # End rxvt

# reverse search Ctrl+r
bindkey "^R" i-search-back

# Ctrl+izq/dcha para moverte entre palabras
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

## enviroment

#setenv PKG_SITES 'http://pkgbeta.freebsd.org/freebsd:10:x86:64/latest'

## enviroment
setenv EDITOR vim
setenv PAGER less
#setenv PAGER most

# colors
set autolist set color set colorcat
setenv CLICOLOR "true"
setenv LSCOLORS "exfxcxdxbxegedabagacad"

## system prompt
set prompt = "%{\033[0;1;37m%}%n%{\033[0;1;31m%}@%{\033[0;1;37m%}%m%{\033[0;1;33m%}:%{\033[0;1;32m%}%b%/%{\033[0;1;0m%} %# "
## jail prompt
# set prompt = "%{\033[0;1;37m%}(%{\033[0;1;31m%}jail %m%{\033[0;1;37m%})%{\033[0;1;33m%}:%{\033[0;1;32m%}%b%/%{\033[0;1;0m%} %# "
alias	psjail	ps -o pid,jid -awux

setenv HOSTNAME `hostname -s`

## titulo xterm
alias settitle printf '"\033]2;\!*\a\033]1;\!*\a\033]0;\!*\a"'
if ( "$TERM" == "xterm" ) then
    set PROMPT_COMMAND = 'printf "%{\033[0;1;37m%}%n%{\033[0;1;31m%} @ %{\033[0;1;37m%}%m%{\033[0;1;33m%}:%{\033[0;1;32m%}%~%{\033[0;1;0m%} %# "'
    settitle $user@$HOSTNAME : $cwd
endif

##[--------------- start csh auto-screen snippet ----------------]
#
# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
setenv STARTED_SCREEN
setenv DISPLAY
alias settitle printf '"\033]2;\!*\a\033]1;\!*\a\033]0;\!*\a"'
if ( "$TERM" != screen && $?prompt == 1 && "${STARTED_SCREEN}X" == X \
		    && "${SSH_TTY}X" != X && "${DISPLAY}X" == X ) then
  echo "Auto-starting screen."
  # Set the window title to HOSTNAME
  settitle $user@$HOSTNAME : $cwd
  # If no session is running, set DISPLAY environment variable
  screen -ls | egrep -q "^No Sockets found"
  if ( $? == 0 ) then
    setenv | grep -q DISPLAY || setenv DISPLAY 0
    @ DISPLAY = $DISPLAY + 1
    setenv DISPLAY $DISPLAY
    echo "No running screen found. DISPLAY set to $DISPLAY."
  endif
  sleep 3
  setenv STARTED_SCREEN 1
  screen -D -RR && exit 0
  # normally, execution of this rc script ends here...
  echo "Screen failed! Continuing with normal bash startup."
endif
if  ( "$STARTED_SCREEN"X == X && "${prompt}"X != X ) then
    echo "Available screens:"
    screen -ls
endif
##[------------------ end csh of auto-screen snippet ------------------]
