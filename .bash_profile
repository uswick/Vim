# .bashrc

# User specific aliases and functions
alias ducks='du -cks * | sort -rn | head -15'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:/home/username/bin:/usr/local/homebrew
export PATH


export PATH=$PATH:/usr/local/texlive/2015/bin/x86_64-darwin/
alias ctags='/usr/local/bin/ctags'

export PATH=$PATH:/Users/uswick/Install/scripts/
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
	            man $1 | grep -iC2 --color=always $2 | less
		        }

alias path='echo -e ${PATH//:/\\n}'
alias ls='ls -FGlAhprt'
alias qfind="find . -name "                 # qfind:    Quickly search for file
alias cmds="cat ~/.cmds"

ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
finds () { /usr/bin/find . -name '*'"$@"'*' ; }  # ffs:      Find file whose name starts with a given string
finde () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string


alias vim="find . -name *.swp -delete;/usr/local/bin/mvim"
export PATH=/Users/uswick/.vim/scripts:$PATH
#export PATH=/Users/uswick/Install/MobyDick/Qemu/qemu-2.3.0/i386-softmmu:$PATH
#export PATH=/Users/uswick/Install/MobyDick/cross-tool/toolchain_32/bin:$PATH
export PATH=/Users/uswick/Install/MobyDick/NewQemu/install/bin:/Users/uswick/Install/MobyDick/NewQemu/install/sbin:$PATH
export PATH=/Users/uswick/Install/MobyDick/cross-tool_x86_64/bin:/Users/uswick/Install/MobyDick/cross-tool_x86_64/sbin:$PATH
#export PATH=/Users/uswick/Install/MobyDick/cross-tool/gdb-7.12/install/bin:$PATH
#export PATH=/Users/uswick/Install/MobyDick/cross-tool/rust/rust-os-gdb/bin:$PATH
export PATH=/Users/uswick/Install/OMPI/openmpi-1.10.3/INSTALL_DIR/bin:$PATH
export PATH=/Users/uswick/Install/MobyDick/cross-tool/gdb-7.12/install/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
