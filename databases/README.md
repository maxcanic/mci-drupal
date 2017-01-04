# Databases

We dump databases here so that they can be included in `git` pushed to repository and/or used in **dev/stage/prod** on server.

Because `git` remembers everything anyway it is safe to delete database dumps once they are commited.

Please use sensible database name like `project_2016-12-02_1341.sql` with YEAR-MONTH-DAY with leading zeros and time in HOURMINUTES in 24h format (4 digits).

You do not need to compress them as `git` will do that internally to store it.

If database is too big, consider splitting strategy.
