# Using MCI Drupal boilerplate

[Quick star guide](quickstart.md) will walk you directly with steps needed to get the copy of boilerplate, adjust it for new project and get it started.

Here are some steps you may need in everyday operation or solving some problems that may arise.

## Useful aliases

Alias for `drush` in container from the host

    alias drc='docker-compose exec --user 82 php drush @default.dev'

You can add it to your `.bash_profile` (Mac) or `.bash_aliases` (Ubuntu) depending on platform terminal loading scripts.

    nano ~/.bash_profile

Now you can use this alias in any project directory to add modules, themes, create sub-themes, control site, clear cache, ask for login etc.

For instance, if you wish to connect to database:

    drc sqlc

The same goes for any `drush` command, all you need is to be somewhere inside project.

## Linux specifics

On Linux there are some issues with owner/group so you may need to change that and/or permissions so that everything could work.

