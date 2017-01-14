# Docker persistent storage

In this directory, we **mount** directories in local file system which are mounted inside containers.

That enables us to destroy and rebuild containers while keeping data (persistent storage).

When entering **mariadb** container, `./databases` are mounted to `/var/lib/mysql/databases` and that full path must be used when **sourcing** SQL files directly in mysql.

**metro** directory should hold _metro_ material theme that can be used for **phpMyAdmin**. Latest version can be obtained at [phpMyAdmin themes](https://www.phpmyadmin.net/themes/)

**drush** directory holds pure `drush` commands like [registry_rebuild](https://www.drupal.org/project/registry_rebuild) for Drupal 7.
