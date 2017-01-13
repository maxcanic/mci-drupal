# Using MCI Drupal boilerplate

## Useful aliases

Alias for `drush` in container from the host

    alias drc='docker-compose exec --user 82 php drush @default.dev'

Now you can use this alias in any project directory to add modules, themes, create sub-themes, control site, clear cache, ask for login etc.

For instance, if you wish to connect to database:

    drc sqlc

The same goes for any `drush` command, all you need is to be somewhere inside project.

On Linux there are some issues with owner/group so you may need to change that and/or permissions so that everything could work.
