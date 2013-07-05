export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
source ~/.zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### PATH
typeset -U path
path=(\
    /bin(N-/) \
    /opt/bin(N-/) \
    /usr/bin(N-/) \
    /usr/local/bin(N-/) \
    $HOME/bin(N-/) \
    $HOME/.gem/ruby/1.9.1/bin(N-/) \
)

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=( \
    {,/usr,/usr/local}/sbin(N-/))

typeset -xT PYTHONPATH python_path
typeset -U python_path
python_path=( \
    ./lib)

