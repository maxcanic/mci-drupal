# Docker persistent storage

In this directory, we **mount** directories in local file system which are mounted inside containers.

That enables us to destroy and rebuild containers while keeping data.

When entering **mariadb** container, `./databases` are mounted to `/var/lib/mysql/databases` and that path must be used if **sourcing** SQL files directly in mysql.

*metro* is material theme that can be used inside **phpMyAdmin** container.

*drush* holds pure `drush` commands like `registry_rebuild`.
