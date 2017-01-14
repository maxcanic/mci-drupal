# Frontend installation

Frontend workflow is described in [README.md](../frontned/README.md) document in `../frontned`.

Here is described only installation of the main tools, `node` and `npm`. 

## `node` and `npm` installation

First check if you have older `node` installation

    node -v
    npm -v

If you have it and it is old, update or remove it first. (latest version now is `node` - 7.4.0, `npm` - 4.0.5)

Check documentation for your platform

- [Linux](#linux)
- [mMc](#mac)
- [Windows](#windows)

### Linux 

This depends on platform, you should check [original documentation](https://nodejs.org/en/download/package-manager/)

#### Debian, Ubuntu and derivates

    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs

If there were no errors, jsut check versions again in terminal to be sure they are operational.

    node -v
    npm -v

### Mac

We need `brew` in case you do not already have it

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Then we need `node`

    brew install node

You can check versions with

    node -v
    npm -v

You can update as any `brew` package

    brew upgrade

### Windows


