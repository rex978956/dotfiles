# 令 gpgsign 在 JetBrains IDEs 能正常運行
export GPG_TTY=$(tty)

ZSH_THEME="bandit-wsl"

DEFAULT_USER="$USER"

BANDIT_PROMPT_ORDER=(
    time
    status 
    custom 
    #context  
    dir 
    git
    screen
    virtualenv
    go
    elixir
    hg
    cmd_exec_time
)

# ============ bandit-wsl ============
if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    export BANDIT_IS_SSH_CLIENT=true
fi

# ========= windows ============
export PATH="$PATH:/mnt/c/Windows/System32"
export PATH="$PATH:/mnt/c/windows"
export PATH="$PATH:/mnt/c/Users/bandit/AppData/Local/Programs/Microsoft VS Code"

alias code='Code.exe'

# ============ x server env for wsl ==============
export DISPLAY=:0
export NO_AT_BRIDGE=1

# ============ translate winpath to wsl path ============
alias cdwsl='function _cdwsl(){ cd "`wslpath $1`";  };_cdwsl'