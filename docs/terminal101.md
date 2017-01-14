# Terminal 101

101 is common suffix for an introductory class of something. Knowin **terminal** (or **console**, **shell**) is very handy but it is also a far strech from the comfort of GUI.

Terminal is **brutal** by nature and you are **fearing** it for a reason: with it you can **wipe** irrevocably something you don't want to or suffer from some side effect you were not aware.

At least you can add this to your aliases to pause you a bit in such actions:

    alias rm='rm -i'

## Terminal and keyboard

    CTRL + shift + C  copy from terminal to clipboard
    CTRL + shift + V  paste to terminal from clipboard
    
    CTRL + C   break - stops last command execution
    CTRL + Z   suspend - pauses last command execution (fg - resumes in foreground, bg in backgorund)  
    CTRL + A   (home) go to beginning
    CTRL + E   (end) go to end
    CTRL + W   delete word to left
    CTRL + U   delete left of cursor
    CTRL + K   delete right of cursor
    
    CTRL + R   search command history, CTRL + R again for next match
    ENTER ~ .  stops frozen ssh session

## Login scripts

    .bashrc
    .bash_profile
    .profile

## Basic commands

    ls
    alias
    ll
    cd
    rm
    less
    cat
    mkdir
    rmdir
    chown
    chmod
    sudo
    source
    
## Advanced commands

    find
    xattr

## Piping
