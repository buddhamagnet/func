# DISCUSS - PHOENIX FTW

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### POSTGRES NOTES

* Run ```pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start```
* Or ```/usr/local/Cellar/postgresql/9.6.3/bin/postgres -D /usr/local/var/postgres```
* Run ```psql``` to connect via command line.
