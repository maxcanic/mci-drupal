# MCI Drupal 8 docker based boilerplate

This project is the base which can be easily used to start a new project.

The main idea is to use [docker](http://docker.com/) container technology and tools, [Docker4Drupal](http://docker4drupal.org/) project as a base for Drupal 7 and 8 development and set of predefined structures and tools to streamline development, frontend build, testing and deployment.

## Quick start guide for MCI Drupal 8 docker based boilerplate

If you wish to start as quickly as possible and feel that you can follow along, follow this [Quick start guide](docs/quickstart.md)

For more detailed information, read these documents:

1. [Docker 101](docs/docker.md)
2. [Installing Docker](docs/install_docker.md)
3. [Resolving local domains](docs/resolving.md)
4. [Proxy containers to local domains](docs/local_proxy.md)
5. [Frontend tools](docs/frontend.md)
6. [Quick start](docs/quickstart.md)
7. [Using](docs/using.md)
8. [`dc` helper tool](https://gitlab.com/MacMladen/dc/)
9. [Terminal 101](docs/terminal101.md)
10. [Local install commands sequence](docs/local-docker.sh)
11. [Server install commands sequence](docs/server-docker.sh)

## Why `docker`

There are many problems with local setup for development, some of them are

1. Setting everything right
2. Upgrading OS may break some hand made tuning
3. Difference with stage/production like PHP version, services like `solr`
4. Using some specific setup for a project
5. Differences with developers' computers like different platforms, OS-es, versions
6. ...and many more potential pitfalls

Docker is a lightweight virtualization comparing to full virtualization like Virtual Box, VMWare, Parallels or similar.

There are some differences between implementation on **Linux** and on **Docker for Mac** or **Docker for Windows**.

## Requirements for `docker`

Most of the systems today are capable of running `docker` on Linux, however on Mac and Windows there are additional requirements:

* **All platforms** — 2GB at least, however for some comfort 8GB on system is recommended
* **Linux** — any 64-bit x86 compatible processor with EPT instruction set and kernel newer than 3.10
* **Mac** — 4GB of memory, Mac OS X 10.10.3 (Yosemite) or newer, Intel i3, i5, i7 or Xeon processor (machines newer than 2010)
* **Windows** — any 64-bit x86 compatible processor with EPT instruction set and 64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). with Hypervisor enabled

**Linux** based workstation should be updated to latest stable OS version for optimal development experience. Installation details can be found in [Installing Docker](install_docker.md) document and on [docker site](http://docker.com/). You should also consider using Linux kernel 4.4 or newer and adjust kernel boot arguments. You can find particular information [here](https://docs.docker.com/engine/installation/linux/)

**Macs** use native **Docker for Mac**. In case you wish to use `docker` on Macs older than 2010, you can use older `docker toolbox`, details are [here](https://docs.docker.com/engine/installation/mac/)

**Windows** can also use native solution **Docker for Windows** under Windows 10, otherwise also ahve to use `docker toolbox`, details are [here](https://docs.docker.com/engine/installation/windows/)

## Docker4Drupal

[Docker4Drupal](http://docker4drupal.org/) project is just one of many existing Drupal stacks. It was chosen due to small size and easy usage scenario. There are many options that could be set in configuration files on per project basis.

# Other components

### Proxy

**Docker4Drupal** project uses ports to communicate with browser. In order to make it more simple and use domain names, we chose to use [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) container that dynamically scans docker network and proxies container so they are accessible by configuration/variable assigned name.

### Resolver

Resolving can be done most easily in `/etc/hosts` file but that requires editing every time we have new project so we developed **dnsmasq** based recipe that works on Linux and Mac (looking into Windows solution).

### Frontend tools

Front end build system is based on `node` and `npm` which set up local working build with `gulp` as task runner and **Sass** as main CSS preprocessor. **Sass** is developed in `/frontend` where are all the tools, libraries and unoptimized resources which are then compiled and optimized directly in theme according to `gulpfile.js` settings.

### `dc` tool

`dc` is **bash** based tool that just simplifies commands and procedures for managing projects.

## Files structure

* **assets** — this directory is intended to hold *all original** files given by the client. They should not be altered and, if needed, should be divided into subdirectories named by date they were given.
* **databases** — Here are all database dumps and this directory is mounted into `mariadb` container so all files are accessible to be sourced into database.
* **docker-runtime** — all docker persistent data is held here. That enables us to rebuild containers without loosing:
  - `/databases` database files,
  - `/metro` add theme to **phpMyAdmin** and to
  - `/drush` keep useful `drush` commands.
  - ...possibly something more in future
* **docroot** — this is for the **root** of the website, where all Drupal files are held. Linux users should take care of permissions and everyone should know that `nginx` container is **very** (production) restrictive so nothing except `index.php` will get executed.
* **docs** — all usable documentation is here
* **frontned** — is holding everything frontend related so that `docroot` only holds Drupal theme and nothing else (Sass or build files). Usually there are following directories:
  - **scss** — holding main **style.scss** and all components in their files in subdirectories
  - **images** — for **source** images that are needed in CSS (i.e. for backgrounds) that will be optimized and copied to theme.
  - **media** — for **source** media files that are used statically like slider images.
  - **js** — for **source** JS files, mostly those that we write, usually configuration and initialization.
  - **vendor** — for **source** vendor libraries whose components will be used and copied to theme.
  - **fonts** — for **source** font files that are going to be minimised, inlined and included in theme.
* **styleguide** — for more complex theme building with HTML/CSS/JS web components, **patternlab** and Style Guide Driven Development®.
* `docker-compose.yml` — standard container configuration that is used on production
* `docker-compose.local.yml` — local container configuration that configures local development
* `docker-compose.mac.yml` — local container configuration that enables **Xdebug** on Mac in local development

## Contributing

The best way to contribute is to use **pull request** mechanism.

Those who are not comfortable with PR workflow may use [issues](https://gitlab.com/MacMladen/mci-boilerplate-d8/issues) queue.

## Contact

The best way to contact is to use [issues](https://gitlab.com/MacMladen/mci-boilerplate-d8/issues) queue.
