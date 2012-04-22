# My settings for bash shell

# set command prompt in blue, showing current directory
PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '

# aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias rm='rm -iv'
alias cp='cp -i'
alias mv='mv -i'
alias cls='/usr/bin/clear'
alias diff='colordiff'
alias gcc='colorgcc'
#alias g++='colorgcc'
#export CC="colorgcc"

# alias for opening file in an existing gvim, instead of launching a new one
alias vv='gvim --remote-silent'
# avoid messages when launching gvim and emacs
alias gvim='gvim 2>/dev/null'
alias emacs='emacs 2>/dev/null'

alias ipython='ipython -noconfirm_exit'
alias gdb="gdbtui"

# vi behaviour for command line 
#set -o vi

# environment vars

# qt
#export PATH=/usr/local/Trolltech/Qt-4.1.1/bin:"${PATH}"

# vmail
#export PATH=/var/lib/gems/1.9.1/bin:"${PATH}"

# vimgolf
#export PATH=/var/lib/gems/1.8/bin:"${PATH}"

# django
#export PYTHONPATH=/home/fran/programming/python/django_projects:"${PYTHONPATH}"
#export PYTHONPATH=/home/fran/projects/m2000:"${PYTHONPATH}"

# java
#export JAVA_HOME=/usr/java/jdk
#export JDK_HOME=$JAVA_HOME
#export PATH=$PATH:$JAVA_HOME/bin

#LANG=en_US.iso-8859-1
LANG=en_US.UTF-8

#export http_proxy="80:192.168.254.254"

# https://bugs.launchpad.net/ubuntu/+source/bash/+bug/80635
# this allows ctrl-s in the console
# it has to do with controlling ctrl-s in vim
stty -ixon

# lilypond
#export LYEDITOR='gvim --remote +:line:normchar file'
export LYEDITOR='emacsclient --no-wait +%(line)s:%(column)s %(file)s'

# cdargs settings
if [ -e /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
  . /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi


findstr() {
    grep -EIRn "$1" ${2:-*} \
		--exclude-dir='.svn' \
		--exclude='*.swp' \
		--exclude='*.vcproj' \
		--exclude='*.dsp' \
		--exclude='cscope.out' \
		--exclude='cscope.files' \
		--exclude='tags'
}

findsym() {
	non_symbol="(^|$|[^a-zA-Z0-9_])"
	pattern="$non_symbol$1$non_symbol"
	findstr "$pattern" "$2"
}

findpy() {
    find . -name "*.py" -print0 | xargs -0 grep -Iin "$1"
}

findcpp() {
    (find . -name "*.cpp" -print0 ; find . -name "*.h" -print0) | xargs -0 grep -Iin "$1"
}

# replacement for rm function, uses trash
del() {
    trash="$HOME"/.trash
    mkdir -p "$trash"

    # possible cases:
    # 1. del dir/[..]/filename
    #   move filename to trash (extract dir)
    # 2. del dir/[..]/dir
    #   move dir to trash (extract dir)
    # 3. del filename
    #   move filename to trash
    # 4. del dir
    #   move dir to trash

    timestamp=`date +%F_%T:%N`
    # iterate through each argument
    # and move files to trash dir, with the timestamp appended to name
    for file in "$@"; do
        local newname
        if [ -d "$file" ]; then
            if [ `basename "$file"` == "$file" ]; then
                # case 4
                newname="$file".$timestamp
            else
                # case 2
                newname=`basename "$file"`.$timestamp
            fi
        elif [ `basename "$file"` == "$file" ]; then
            # case 3
            newname="$file".$timestamp
        else
            # case 1
            newname=`basename "$file"`.$timestamp
        fi

        mv "$file" "$trash"/"$newname"
    done
}

# make function available from scripts
export -f del   

# clear trash
ctrash() {
    trash="$HOME"/.trash

    # TODO: step out of the trash dir if inside

    rm -rf "$trash"
}

# list flash video files
lsflash() {
    find . | xargs file | grep Video
}

# to avoid entering the passphrase on each git commit
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# set window title
function title {
    echo -en "\033]2;$1\007"
}

function mount-iso {
    sudo mount $1 /media/iso -t iso9660 -o loop
}
