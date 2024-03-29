# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
#ZSH_THEME="bullet-train"
#ZSH_THEME="robbyrussell"

export TERM="xterm-256color"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git wd colored-man-pages sudo)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#alias ffrm TODO

function set_cpu_gov()
{
    gov=$1
    # To get available governors (this differs from system to system): run "cpufreq-info"
    #
    # I only have performance and powersave, usually these are also available:
    # * performance     Run the CPU at the maximum frequency.
    # * powersave     Run the CPU at the minimum frequency.
    # * userspace     Run the CPU at user specified frequencies.
    # * ondemand     Scales the frequency dynamically according to current load. Jumps to the highest frequency and then possibly back off as the idle time increases.
    # * conservative     Scales the frequency dynamically according to current load. Scales the frequency more gradually than ondemand.
    # * schedutil     Scheduler-driven CPU frequency selection [1], [2].
    for i in {0..7};
    do
        sudo cpufreq-set -c $i -g $gov;
    done
}

BULLETTRAIN_PROMPT_ORDER=(
    dir
    git
)

#set_cpu_gov performance

function firefox_noproxy
{
    export http_proxy=""
    export https_proxy=""
    firefox&
}

function proxy_off
{
    export http_proxy=""
    export https_proxy=""
    export ftp_proxy=""
    export HTTP_PROXY=""
    export HTTPS_PROXY=""
    export FTP_PROXY=""
}

function proxy_on
{
    export http_proxy="http://gotpr002vip.got.volvocars.net:83"
    export https_proxy="https://gotpr002vip.got.volvocars.net:83"
    export HTTP_PROXY="http://gotpr002vip.got.volvocars.net:83"
    export HTTPS_PROXY="https://gotpr002vip.got.volvocars.net:83"
}

function disable_touchpad
{
    if [ `hostname` = "GOT120FRM0YF2" ]; then
        xinput list  | grep DualPoint | grep -Eo '=[0-9]{1,4}' | grep -Eo '[0-9]{1,4}' | cat | xargs -I % xinput disable %
    fi
}

function start_dlt_viewer
{
    adb forward tcp:3490 tcp:3490
    /usr/bin/dlt-viewer&
}

disable_touchpad

function busy
{
    source ~/sources/scripts/luxafor-python/venv/bin/activate
    ~/sources/scripts/luxafor-python/luxafor-linux.py color -l 255 -r 255 -g 0 -b 0
    deactivate
}

function free
{
    source ~/sources/scripts/luxafor-python/venv/bin/activate
    ~/sources/scripts/luxafor-python/luxafor-linux.py color -l 255 -r 0 -g 255 -b 0
    deactivate
}

function pw_vccdocker5
{
    /home/pwerner/sources/vcc/ihu5/tools/volvo/docker_build/run.sh --multiuser $@
}

function pw_ihu5_build_1_aosp
{
    pw_vccdocker5 "cd /home/pwerner/sources/vcc/ihu5/android; source build/envsetup.sh; lunch msmnile_gvmq; make -j7 | tee ~/sources/vcc/ihu5/build_aosp.log"
}

function pw_ihu5_build_2_nonhlos
{
    pw_vccdocker5 "cd /home/pwerner/sources/vcc/ihu5/nonhlos; source vendor/volvocars/setenv_qcomBSP.sh; compileBSP.sh | tee ~/sources/vcc/ihu5/build_nonhlos.log"
}

function pw_ihu5_build_3_qnx
{
    pw_vccdocker5 "env; cd /home/pwerner/sources/vcc/ihu5/qnx/apps/qnx_ap; source vendor/volvocars/setenv_QNX-ihu5.sh; make clean; make | tee ~/sources/vcc/ihu5/build_qnx.log"
}

function pw_ihu5_build_4_sign_images
{
    pw_vccdocker5 "cd /home/pwerner/sources/vcc/ihu5/nonhlos; source vendor/volvocars/setenv_qcomBSP.sh; signImages.sh | tee ~/sources/vcc/ihu5/build_signing.log"
}

function pw_ihu5_build_5_flash
{
    pw_vccdocker5 "cd /home/pwerner/sources/vcc/ihu5/nonhlos/common/build/; python fastboot_complete.py --st=ufs --pf=8155_la; fastboot reboot"
}

function pw_ihu5_build_6_flash
{
    pw_vccdocker5 "cd /home/pwerner/sources/vcc/ihu5/nonhlos/common/build/; echo `pwd`"
}

function pw_ihu5_build_clean
{
    cd ~/sources/vcc/ihu5/
    repo forall -vc "git clean -xdf; git reset --hard"
    repo sync -j7
}

function pw_ihu5_build_all
{
    set -ex
    pw_ihu5_build_1_aosp
    pw_ihu5_build_2_nonhlos
    pw_ihu5_build_3_qnx
    pw_ihu5_build_4_sign_images
    pw_ihu5_build_5_flash
}

function pw_ihu5_flash
{
    pw_vccdocker5 "cd ~/sources/vcc/ihu5/nonhlos/common/build/; python fastboot_complete.py --st=ufs --pf=8155_la; fastboot reboot"
}

if [[ $HOST == 'shrimphorse' ]]
then
    alias VIP='sudo minicom -D /dev/ttyVIP -C ~/logs/minicom/VIP-log.txt'
    alias MP='sudo minicom -D /dev/ttyMP -C ~/logs/minicom/MP-log.txt'
    alias ff='find . -type f -iname'
    alias pw_vccdocker4='~/sources/vcc/ihu4/vendor/volvocars/tools/docker_build/run.sh --multiuser'
    alias pw_vccdocker4_local='~/sources/vcc/ihu4/vendor/volvocars/tools/docker_build/run.sh --multiuser --local'
    export no_proxy="*.volvocars.net"
    export PYTHONPATH=$PYTHONPATH:/home/pwerner/sources/vcc/ihu4/test:/home/pwerner/sources/vcc/ihu4/vendor
    export PATH=$PATH:~/apps/Discord/
fi

if [[ $HOST == 'nexus' ]]
then

    # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
    export COCOS_CONSOLE_ROOT="/home/phiwer/dev/cocos2d-x-3.16/tools/cocos2d-console/bin"
    export PATH=$COCOS_CONSOLE_ROOT:$PATH

    # Add environment variable COCOS_X_ROOT for cocos2d-x
    export COCOS_X_ROOT="/home/phiwer/dev"
    export PATH=$COCOS_X_ROOT:$PATH

    # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
    export COCOS_TEMPLATES_ROOT="/home/phiwer/dev/cocos2d-x-3.16/templates"
    export PATH=$COCOS_TEMPLATES_ROOT:$PATH

    # Add environment variable NDK_ROOT for cocos2d-x
    export NDK_ROOT="/home/phiwer/Android/Sdk/ndk-bundle"
    export PATH=$NDK_ROOT:$PATH

    # Add environment variable ANDROID_SDK_ROOT for cocos2d-x
    export ANDROID_SDK_ROOT="/home/phiwer/Android/Sdk"
    export PATH=$ANDROID_SDK_ROOT:$PATH
    export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

    # Add environment variable ANT_ROOT to cocos2d-x
    export ANT_ROOT="/usr/bin/"
    export PATH=$ANT_ROOT:$PATH
fi

source ~/.aliases

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/home/phiwer/sources/external/cocos2d-x/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/home/phiwer/sources/external"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/home/phiwer/sources/external/cocos2d-x/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

export PATH=$PATH:$HOME/.dotnet/tools
