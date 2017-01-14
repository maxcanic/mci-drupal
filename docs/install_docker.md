# Installing docker

There are few ways for each platform to install and use `docker` but we cannot cover all cases here, we'll just focus on the main and preferred one for each platform at the time of writing.

## Minimal hardware requirements

**All platforms** should have 4GB at least and that is hardly usable in real world: OS needs at least one, docker will grab another one, PHPStorm will grab one also and any browser is rarely short of one, that is four and we haven't even started yet!

However for some comfort starts with 8GB and 16GB is what would be recommended for full stack development.

You will need also modern 64-bit processor with EPT and memory management functions which is nearly any 64-bit processor, you can check with **cpu-id** on Windows or by `cat /proc/cpuinfo`

Your OS should also be 64-bit, updated and latest version.

Once docker is running, you can set [local proxy](local_proxy.md), [resolving](resolving.md) and start [new project](quickstart.md)

Check documentation for your platform

- [Linux](#linux)
- [mMc](#mac)
- [Windows](#windows)

## Linux

* Any 64-bit x86 compatible processor with EPT instruction set
* At least 4GB of RAM
* Kernel 3.10 or newer. You should also consider using Linux kernel 4.4 or newer.
* Some effort is needed to handle owner/group differences between host and containers

**Linux** based workstation should be updated to latest stable OS version for optimal development experience.

Adjust kernel boot arguments. You can find particular information [here](https://docs.docker.com/engine/installation/linux/)

    sudo nano /etc/default/grub
    # GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
    sudo update-grub

    # Check your Linux version details
    lsb_release -a
    
You need to **restart** your system to apply the changes.

### Docker user and group

Change `docker` group to gid 82 (www-data from container)

    sudo groupmod -g 82 docker

Adding new docker user with uid 82 

    sudo useradd -g 82 -u 82 -r -s /usr/sbin/nologin docker

### Docker composer

Linux installation does not have `docker-compose` by default so we need to install that manually

    sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

## Mac OS X

* Mac OS X 10.11 (El Capitan) or newer (it will work on Mac OS X 10.10.3 Yosemite but limited)
* Intel i3, i5, i7 or Xeon processor (machines from 2010 or newer)
* At least 4GB of RAM
* VirtualBox prior to version 4.3.30 **must not** be installed (it is incompatible with Docker for Mac). If you have it, just uninstall it.

**Macs** should use native [Docker for Mac](https://docs.docker.com/docker-for-mac/).

The install includes: Docker Engine, Docker CLI client, Docker Compose, and Docker Machine.

After download, copy to `/Applications` and start just like any other Mac Applications. Docker demon will start and all tools will be available in terminal. Check instructions on [Docker for Mac](https://docs.docker.com/docker-for-mac/) page.

You can limit the memory available to `docker` or CPU, include shared directories, restart or stop docker demon.

Mac access docker machines through hypervisor so we need loopback interface to reach **Xdebug**

    sudo ifconfig lo0 alias 10.254.254.254

You can install **launchd agent** to start loopback on machine restart (took from this [gist](https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93))

    sudo curl -o /Library/LaunchDaemons/com.ralphschindler.docker_10254_alias.plist https://gist.githubusercontent.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93/raw/com.ralphschindler.docker_10254_alias.plist

In case you need to use `docker` on Macs older than 2010, you can use older `docker toolbox`, details are [here](https://www.docker.com/products/docker-toolbox).

## Windows

* **Windows** — any 64-bit x86 compatible processor with EPT instruction set and 64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). with Hypervisor enabled.

**Windows** can also use native solution **Docker for Windows** under Windows 10, otherwise also ahve to use `docker toolbox`, details are [here](https://docs.docker.com/engine/installation/windows/)

