# Installing docker

There are few ways for each platform to install and use `docker` but we cannot cover all cases here, we'll just focus on the main and preferred one for each platform at the time of writing.

## Minimal hardware requirements

**All platforms** should have 4GB at least and that is hardly usable in real world: OS needs at least one, docker will grab another one, PHPStorm will grab one also and any browser is rarely short of one, that is four and we haven't even started yet!

However for some comfort starts with 8GB and 16GB is what would be recommended for full stack development.

You will need also modern 64-bit processor with EPT and memory management functions which is nearly any 64-bit processor, you can check with **cpu-id** on Windows or by `cat /proc/cpuinfo`

Your OS should also be 64-bit, updated and latest version.

## Mac OS X

* Mac OS X 10.11 (El Capitan) or newer (it will work on Mac OS X 10.10.3 Yosemite but limited)
* Intel i3, i5, i7 or Xeon processor (machines from 2010 or newer)
* At least 4GB of RAM
* VirtualBox prior to version 4.3.30 **must not** be installed (it is incompatible with Docker for Mac). If you have it, just uninstall it.

**Macs** should use native [Docker for Mac](https://docs.docker.com/docker-for-mac/).

The install includes: Docker Engine, Docker CLI client, Docker Compose, and Docker Machine.

After download, copy to `/Applications` and start just like any other Mac Applications. Docker demon will start and all tools will be available in terminal. Check instructions on [Docker for Mac](https://docs.docker.com/docker-for-mac/) page.

You can limit the memory available to `docker` or CPU, include shared directories, restart or stop docker demon.

In case you need to use `docker` on Macs older than 2010, you can use older `docker toolbox`, details are [here](https://www.docker.com/products/docker-toolbox).

Once docker is running, you can set [local proxy](local_proxy.md), [resolving](resolving.md) and start [new project](quickstart.md)

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

    lsb_release -a


### Docker user and group

Change `docker` group to id 82 (www-data from container)

    sudo groupmod -g 82 docker

Adding new docker user (needed for Linux)

    sudo useradd -g 82 -u 82 -r -s /usr/sbin/nologin docker

### Docker composer

    sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

## Windows

**Windows** can also use native solution **Docker for Windows** under Windows 10, otherwise also ahve to use `docker toolbox`, details are [here](https://docs.docker.com/engine/installation/windows/)

* **Windows** — any 64-bit x86 compatible processor with EPT instruction set and 64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). with Hypervisor enabled.
