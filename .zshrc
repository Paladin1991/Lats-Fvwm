#====================================================================
# Name = Ztools
# Created by = Diego Cesare <diegocesare300491@gmail.com>
# Inspired by = Oh My Zsh
# Functions = Make the use of the terminal with zsh 
# more friendly and aesthetically 
# more beautiful and functional.
# Dependencies = fzf, pacman-contrib
# Optional facilities = zsh-syntax-highlighting, zsh-autosuggestions  
#=================================================================ns===

# use to install packages
# the packages will be displayed on the screen
# showing the package information focused on the right side
# will also be displayed if the package is installed
# you can use the keyboard to navigate through the options and also search for a specific package

function install(){
  pacman -Sl | awk '{print $2" "$4}' \
  | column -t | fzf --reverse --preview 'pacman -Si {1}' \
  | xargs -ro sudo pacman -S 
}

# this function installs packages from the AUR repository in the same way as the previous function

function yinstall(){
  yay -Sl | awk '{print $2" "$4}' \
  | column -t | fzf --reverse --preview 'yay -Si {1}' \
  | xargs -ro yay -S 
}

# use to delete packages,
# Attention! the packages will be removed
# along with your dependencies
# and configuration files.

function delete(){
  pacman -Sl | awk '{print $2" "$4}' \
  | column -t | grep instalado | fzf --reverse --preview 'pacman -Si {1}' \
  | awk '{print $1}' | xargs -ro sudo pacman -Rscn
 
}

# Source plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Sourse prompt themes
source ~/.config/zsh/themes.zsh
# Use aliases
source ~/.config/zsh/alias.zsh

# Set prompt
#===========
unsetopt ALL_EXPORT
setopt PROMPT_SUBST

# Select pronpt style
PS1='$(simple)'

# Set/unset ZSH options
#======================
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY

# Setopt HASH_CMDS
#=================
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
#=========================
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
#==============================================
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

#zmodload -ap zsh/mapfile mapfile
#================================
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Set variables
#==============
PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
HISTFILE=$HOME/.zhistory
HISTSIZE=3000
SAVEHIST=3000
#HOSTNAME="$(hostname)"
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

# Load simple
#============
autoload simple zsh/terminfo
if [[ "$terminfo[simple]" -ge 8 ]]; then
   simple
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done

# Completion Styles
#==================
autoload -U compinit
compinit

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-simple ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# list of completers to use
#==========================
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
#==========================================================================
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
#===========================================
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
#========================
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
#===============================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
#==============================================
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
#=============================================================================
zstyle ':completion:*:processes' command 'ps -au$USER'

# add simple to processes for kill completion
#============================================
zstyle ':completion:*:*:kill:*:processes' list-simple '=(#b) #([0-9]#)*=0=01;31'

# NEW completion:
#================
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts \
| grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

# Filename suffixes to ignore during completion (except after rm command)
#=========================================================================
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
#===========================================================
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort

# SSH Completion
#===============
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show
