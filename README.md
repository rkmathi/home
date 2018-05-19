# home

```sh
$ ./install.sh -c # for Linux with CUI
$ ./install.sh -g # for Linux with GUI
$ ./install.sh -m # for macOS
$ ./install.sh -w # for Windows
```


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rkmathi/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/home/rkmathi/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rkmathi/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/rkmathi/opt/google-cloud-sdk/completion.zsh.inc'; fi
