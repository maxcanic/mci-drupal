# MCI Drupal 8 docker based boilerplate

## Prequisites

We need to have

1. `docker` installed and running
2. `docker-compose` installed
3. `docker` user and group set up as UID/GID 82:82
4. `dnsmasq` resolving *.loc*
5. docker **vps-proxy** configured and running
6. `node` and `npm` installed for **frontend**
7. helper tool `dc` available [here](https://gitlab.com/MacMladen/dc/)

## Quick usage

This is mostly how can you do everything manually. `dc` tool will help you with all these tasks, automating them and providing wrapper to many useful operations.

### Prepare directory structure and get files

Most of this will be automated with `dc` tool, once it is finished but this is how it could be done manually and hwo tool operates on its own. This is **work in progress** so it may change in time.

First, clone or download this repository to your projects directory (suggested location is `~/Sites`)

```
cd
cd Sites
git clone git@gitlab.com:MacMladen/mci-boilerplate-d8.git
```

Rename to the project name that will be used in domain and all other further operations (only latin letters, numbers and dashes, like *my-project*).

> We will use **my-project** here as a placeholder, please, replace this in every command with your own project name.

```
mv mci-boilerplate-d8 my-project

cd my-project
```

Change project name in docker configuration files

- `docker-compose.yml` — standard container configuration that is used on production
- `docker-compose.local.yml` — local container configuration that configures local development
- `docker-compose.mac.yml` — local container configuration that enables **Xdebug** on Mac in local development

Main configuration `docker-compose.yml` should not be altered (beside name) because it is optimized for live server. You may freely add ports or other things into `docker-compose.local.yml` which is the proper place for your own alteration.

If changed, it should be added to `.gitignore` so that other users do not pick that up if they should not do that.

```
# On Linux
sed -i "s/{{PROJ}}/my-project/g" docker-compose.yml docker-compose.local.yml frontend/gulpfile.js

# On mac use this
sed -i '' "s/{{PROJ}}/my-project/g" docker-compose.yml docker-compose.local.yml frontend/gulpfile.js
```

### Start containers

Now that we have proper structure, start containers.

```
# On Linux
docker-compose -f docker-compose.yml -f docker-compose.local.yml up -d

# On mac use this
docker-compose -f docker-compose.yml -f docker-compose.local.yml -f docker-compose.mac.yml up -d
```

Now we have local server environment started that uses `vps-proxy` and `dnsmasq` to resolve my-project.dev.loc to browser.

Following services are available:

- http://my-project.dev.loc - Drupal site
- http://my-project.pma.loc - phpMyAdmin
- http://my-project.hog.loc - MailHog

When deployed, they will be on server as

- http://my-project.dev.devbox21.com - Drupal site
- http://my-project.pma.devbox21.com - phpMyAdmin
- http://my-project.hog.devbox21.com - MailHog

### Get Drupal and install site

You can now perform site building using the alias

```
alias drc='docker-compose exec --user 82 php drush @default.dev'

# Only on Linux
sudo chown 82:82 docker-runtime/drush
chown :docker .
chmod 775 .

drc dl drupal-8  --drupal-project-rename=docroot
```

On linux (currently) there is a problem with user/group permissions, so we need to claim back authority to access some directories

```
# On Linux
sudo -u docker mkdir docroot/modules/{contrib,custom,dev,feature}
sudo -u docker mkdir docroot/themes/{contrib,custom}
sudo chmod 775 docroot/{modules,themes}/custom

# On Mac
mkdir docroot/modules/{contrib,custom,dev,feature}
mkdir docroot/themes/{contrib,custom}
```

You can now add modules and themes with

```
drc dl module_filter admin_toolbar adminimal_admin_toolbar adminimal_theme
```

You can also install whole site from CLI

```
drc si --db-url=mysql://drupal:drupal@mariadb/drupal --account-name=admin --account-pass=q
```

...and use other `drush` magic.

### Drupal console

If you need **drupal console** you may use the following alias `alias drd='docker-compose exec --user 82 php drupal --root=/var/www/html/docroot'`

First you have to install drupal console support for the site:

```
docker-compose exec --user 82 php sh

composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader
exit

alias drd='docker-compose exec --user 82 php drupal --root=/var/www/html/docroot'
drd check
```

You can add both aliases to your `~/.bash_aliases` file so that aliases are there after restart.

```
nano ~/.bash_aliases

alias drd='docker-compose exec --user 82 php drupal --root=/var/www/html/docroot'
alias drc='docker-compose exec --user 82 php drush @default.dev'

```

## `docker` and `docker-compose` commands

`docker` controls individual containers by name or ID while `docker-compose` controls a group of containers, usually called _application_ or _stack_.

Usual Docker commands:

- `docker ps -a` — lists all docker containers, running, paused and stopped.
- `docker inspect mcidev_nginx_1` — lists all details about the container by name or ID
- `docker stats --no-stream` — shows resource usage, omit `--no-stream` to have live stats
- `docker-compose up -d` — while in directory structure containing `docker-compose.yml`, creates and starts application.
- `docker-compose pull` — fetch latest version of containers.
- `docker-compose stop` — stops application
- `docker-compose start` — starts application
- `docker-compose restart` — restarts application
- `docker-compose down` — remove containers (instance of contaners images)

## Stopping and removing project

Total removing (no confirmation, no undo, *just kill project*)

```
cd ~/Sites/my-project
docker-compose down
cd ..
sudo rm -rf my-project
```

## FAQ

### I do not have `proxy_net` network?

Create one with this command: `docker network create proxy_net`

### I have web server already running, `netstat -lnp | grep 80` what should I do?

Uncomment **port** in `docker-compose.local.yml` and change values to some that are available

### How do I check if `my-project.dev.loc` is resolving, is it catching any `.loc` subdomain?

`ping -c 1 my-project.dev.loc`

More [FAQ](FAQ.md)

## References

Like to learn more?

- https://docs.docker.com/compose/reference/overview/
- https://docs.docker.com/engine/reference/commandline/
- http://docs.docker4drupal.org/

## Issues, bugs and features

Still want more? Or something is inaccurate?

File an issue [here](https://gitlab.com/MacMladen/mci-boilerplate-d8/issues) and we'll do our best to fix it.
