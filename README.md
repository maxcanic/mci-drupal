# MCI Drupal 8 docker based boilerplate

## Quick usage

First, clone or download this repository to your projects directory

```
cd
cd Sites
git clone git@gitlab.com:MacMladen/mci-boilerplate-d8.git
```

Rename to the project name that will be used in domain and all other further operations (only latin letters, numbers and dashes)

```
mv mci-boilerplate-d8 my-project
```

Change project details in docker configuration files

```
sed -i "s/{{PROJ}}/my-project/g" docker-compose.yml
sed -i "s/{{PROJ}}/my-project/g" docker-compose.local.yml
sed -i "s/{{PROJ}}/my-project/g" frontend/gulpfile.js

# On mac use this
sed -i '' "s/{{PROJ}}/my-project/g" docker-compose.yml
sed -i '' "s/{{PROJ}}/my-project/g" docker-compose.local.yml
sed -i '' "s/{{PROJ}}/my-project/g" frontend/gulpfile.js
```

Now that we have proper structure, start containers.

- `docker-compose.yml` — standard container configuration that is used on production
- `docker-compose.local.yml` — local container configuration that configures local development
- `docker-compose.mac.yml` — local container configuration that enables *Xdebug* on Mac in local development

(if you are on linux, omit the last configuration reference)

```
docker-compose -f docker-compose.yml -f docker-compose.local.yml -f docker-compose.mac.yml up -d
```

Now we have local server environment that uses `vps-proxy` and `dnsmasq` to resolve my-project.dev.loc to browser.

Following services are available:

- http://my-project.dev.loc - Drupal site
- http://my-project.pma.loc - phpMyAdmin
- http://my-project.hog.loc - MailHog

When deployed, they will be on server as

- http://my-project.dev.devbox21.com - Drupal site
- http://my-project.pma.devbox21.com - phpMyAdmin
- http://my-project.hog.devbox21.com - MailHog

You can now perform site building using the following alias, `alias dc='docker-compose exec --user 82 php drush @default.dev'`

```
drc dl drupal-8  --drupal-project-rename=docroot
```

On linux (currently) there is a problem with user/group permissions, so we need to claim back authority to access some directories

```
sudo -u docker mkdir docroot/modules/{contrib,custom,dev,feature}
sudo -u docker mkdir docroot/themes/{contrib,custom}
sudo chmod 775 docroot/{modules,themes}/custom
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

If you need *drupal console* you may use the following alias `alias drd='docker-compose exec --user 82 php drupal --root=/var/www/html/docroot'`

First you have to install drupal console support for the site:

```
docker-compose exec --user 82 php sh

composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader
composer update drupal/console --with-dependencies
exit

alias drd='docker-compose exec --user 82 php drupal --root=/var/www/html/docroot'
drd check
```
