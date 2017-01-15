# Terminal 101

101 is common suffix for an introductory class of something. Knowin **terminal** (or **console**, **shell**) is very handy but it is also a far strech from the comfort of GUI.

Terminal is used to connect _"directly"_ to operating system by using **CLI** (command line interface) to issue commands. When you start terminal you are greeted with some a message and the cursor blinks at **prompt** waiting for your command like this
 
    Last login: Sun Jan 15 08:15:08 on ttys000
    ~
    mladen@Buk4 08:41:42 $ 

Usually you see your user name, your system name and prompt which can be customize to show various information like **working directory**, time, git branch and other useful informations.

The program that enables you to issue commands is called **shell** and there are many of them, `bash` (usually standard) being probably the most popular but there are  others like `zsh` being popular lately (installed additionally) or just `sh` being the oldest and most basic of them all (present in Alpine based containers). 

Terminal is **brutal** by nature and you are **fearing** it for a reason: with it you can **wipe** irrevocably something you don't want to or suffer from some side effect you were not aware.

At least you can add this to your aliases to pause you a bit in such action (they are already present in `~/.bashrc`, you just need to uncomment those lines by removing leading `#`)

    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    
To close terminal session you usually just close window in your GUI and it performs `exit` command and closes window for terminal.

When you connect to other computer from you terminal (i.e. `ssh` session) you issue `exit`command to return to your terminal.

## Terminal and keyboard

All systems (mostly) have these keyboard actions
    
    CTRL + C   break - stops last command execution
    CTRL + Z   suspend - pauses last command execution (fg - resumes in foreground, bg in backgorund)  
    CTRL + A   (home) go to beginning
    CTRL + E   (end) go to end
    CTRL + W   delete word to left
    CTRL + U   delete all to left of cursor
    CTRL + K   delete all to right of cursor
    
    CTRL + R   search command history, CTRL + R again for next match
    ENTER ~ .  stops frozen ssh session

### Linux specific (default)

    CTRL + shift + C  copy from terminal to clipboard
    CTRL + shift + V  paste to terminal from clipboard
    
### Mac

Common `CMD + C` for copy and `CMD + V` for paste works as expected. You may consider using [ClipMenu](http://www.clipmenu.com/) which gives you permanent snippets and multiple clipboard options.

### Function keys

On Mac (and some laptops) function keys are usually mapped to some audio, brightness or other forms of computer control. In that case, you can use `ESC ::number::` to achieve keyboard equivalent action (i.e. `ESC 3` is the same as pressing **F3**). 

## Login scripts

Whenever user logs in, `bash` reads some system defaults and executes commands from the initialization scripts (files).

Those files enables us to add some `aliases` (or _shortened commands_) to our terminal session, variables and enable some **expansion** (when you start typing something, press `TAB` and terminal completes that to full command, file name or other argument).

The system behind initialization of terminal is complicated and it largely depends on the system (every Linux/UNIX family has its own standards) so you have to check first which one your system uses and then add your aliases, variables and system extensions where they should be.

### Ubuntu, Debian

They reads system defaults first and then it looks for `~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and reads and executes commands from the first one that exists and is readable.

You will find that `~/.profile` usually just **sources** (includes, executes) `~/.bashrc` which includes most of the additions (expansion, variables and other useful functions) and in the end, it sources `~/.bash_aliases` where you should add aliases you need.

### Mac

Mac starts with `~/.bash_profile` and some installation may add (and source) `~/.bashrc`. I choose to add (and source) `~/.bash_aliases` where I add my aliases.  

## Ownership and permissions

Every file and directory in file system (which starts or **is rooted** at `/`) has **owner**, **group** and **permissions**.

Every user on the system has **user id**, **primary group id** and **secondary group or groups**.

You can easily find your ids and groups you (or any other user belongs to) with `id` command:

    $ id
    uid=0(root) gid=0(root) groups=0(root)
    $ id docker
    uid=82(docker) gid=82(docker) groups=82(docker)

Typical home directory (where your user files and settings are stored, aliased as `~`) looks similarly like this 

    $ ls
    total 992
    drwxr-xr-x+   62 mladen  staff    2108 Jan 15 08:16 ./
    drwxr-xr-x     5 root    admin     170 Jan  7 12:35 ../
    -rw-r--r--     1 mladen  staff     429 Nov  2 14:10 .bash_aliases
    -rw-r--r--     1 mladen  staff  116076 Jan 14 22:44 .bash_history
    -rw-r--r--     1 mladen  staff    2420 Aug 14 10:22 .bash_profile
    drwxr-xr-x   284 mladen  staff    9656 Jan 15 11:28 .bash_sessions/
    -rw-r--r--     1 mladen  staff     463 Nov 21 11:56 .bashrc
    drwxr-xr-x     7 mladen  staff     238 Jul 29 10:54 .composer/
    drwx------     5 mladen  staff     170 Jan  7 07:49 .config/
    drwx------     3 mladen  staff     102 Dec  8 11:31 .docker/
    drwx------     9 mladen  staff     306 Sep  3 07:34 .dropbox/
    drwxr-xr-x     8 mladen  staff     272 Aug 17 21:49 .drush/
    -rw-r--r--     1 mladen  staff    1198 Jan 15 08:16 .gitconfig
    -rw-r--r--@    1 mladen  staff      13 May 31  2016 .gitignore_global
    drwx------+    5 mladen  staff     170 Jan 15 08:18 Desktop/
    drwxr-xr-x+   13 mladen  staff     442 Jan 11 13:04 Documents/
    drwxr-xr-x+   70 mladen  staff    2380 Jan 14 19:37 Downloads/
    drwx------@  122 mladen  staff    4148 Jan 15 08:17 Dropbox/
    drwx------@   64 mladen  staff    2176 Oct 16 20:22 Library/
    drwx------+    6 mladen  staff     204 Jan  3 11:27 Movies/
    drwx------+    4 mladen  staff     136 Jul 25 13:38 Music/
    drwx------+    3 mladen  staff     102 Jul 28 18:58 Pictures/
    drwxr-xr-x+    5 mladen  staff     170 Jun 20  2016 Public/
    drwxr-xr-x    27 mladen  staff     918 Dec 27 16:10 Sites/
    drwxr-xr-x     3 mladen  staff     102 Dec  5 23:03 terminus/
    -rw-r--r--     1 mladen  staff     937 Sep  6 18:56 watchers.xml
    -rw-r--r--     1 mladen  staff  127494 Nov 21 08:19 zones.json

Lets look at each column and what that means

### 1: Permissions `drwxr-xr-x`

First letter is

- `d` for directories
- `-` for files
- `l` for file/directory links
- `s` for socket

Next, there are three groups with three permissions

- first group are **user** permissions
- second group are **group** permissions
- third group are everyone (or **others**) permissions

Each group has

- `r` **read** content for files and directories
- `w` **write** for files and directories
- `x` **execute** for files, **list** for directories

After those there may be a sign like `@` (extended attributes) or `+` for extended properties.

### 2: Number of hardlinks

Files can be **hardlinked** (link behaves just like the file itself) or **softlinked** (link behaves like alias, separate identity, deleting it does not affect file itself)

### 3: Owner

User name or id who owns the file and has permissions from first group.

### 3: Group

Group name or id which owns the file and has permissions from second group. Can be either primary or secondary group.

### 4: Actual size in bytes

Files occupy space on disk in blocks (usually 4k or 4096 bytes) but this reports actual file length in bytes.
 
### 5: File modification time `mtime`

Each file has three (or four) times (all details could be obtained with `stat` command)

- **Access time**
- **Modify time**
- **Change time**

### 6: File or directory name

Names that has spaces must be under quotes like `"name with space""` or **escaped** like `name\ with\ spaces

## Filename expansion

There are few tricks how to make some operation on group of files.



## Basic commands

You can get help on every command and their arguments with `man` or `info` commands

    man chmod
    info less

Here are most commonly used, basic commands

List files in current directory

    # List all visible files
    ls
    # List all visible files with details 
    ls -l
    # list all files including invisible with details
    ls -al
    # Usually available alias for `ls -al` is ll
    ll

If you need some command in shorter form use `alias`

    # Use ll like "list long'
    alias ll='ls -al'

Change working directory

    # Use just cd to go straight to your home directory
    cd
    # Jump directly into subdirectory
    cd Sites/my-awesome-project
    # Go to absolute path
    cd /etc/nginx/conf.d
    
Print working directory

    pwd

Rename or move file or directory

    mv old_name new_name
    mv my-file ../destination_dir/new_dest/

Remove file, files or directory with files

    # Remove a file
    rm some-file
    rm some-file other-file
    # Be very careful!
    rm -rf directory-with-files

Reads from file to screen as plain text, you can navigate to home with `g`, to end `G` search inside with `/`, go **page up**, **page down** and exit with `q`

    less README.txt
    # Just print whole file as text to screen
    cat README.md

Search the file or directory structure for some content

    # Search for text "mac" inside files
    grep "mac" first-file second-file
    # search here and all subdirectories
    grep -R "mac" *

Making and removing directories

    mkdir new-directory
    # Make directory and one inside that one
    mkdir -p new-directory/and-this-one
    # Directory must be empty to be removed
    rmdir remove-me

Changing ownership

    chown user_name:group_name my-files.*
    # Take ownership of directory and everything inside
    chown -R www-data:www-data files

Changing permissions

    # Make directory writable for me
    chmod +w the_directory
    # Make directory writable for owner and group
    chmod ug+w the_directory
    # Make directory and directories inside full accessible for user and readable and listable for group and others
    find -type d -exec chmod 755 {} \;
    # Make all files readable/writable for user and readabole for group and others
    find -type f -exec chmod 644 {} \;
    
Execute a command with administrative permissions
    
    sudo nano /etc/some_service/some_conf

Execute `bash` script

    # Read again all aiiases
    source ~/.bash_aliases
    
## Advanced commands

    find
    xattr
    curl
    wget
    mc
    ssh
    rsync
    sed

## Piping

**Piping** is when output of one command is used as input for next one

    # Check if there is nginx running
    ps aux | grep nginx
