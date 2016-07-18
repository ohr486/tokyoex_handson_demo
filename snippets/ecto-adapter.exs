### Production Ecto Adapter Examples
#
# Untested but provided for convenience.

### MySQL
# mix phoenix.new --database mysql PROJECT_PATH

# dev
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "tokyoex_handson_demo_dev",
  hostname: "localhost",
  pool_size: 10

# test
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "tokyoex_handson_demo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# prod
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "username", # change me
  password: "password", # change me
  database: "tokyoex_handson_demo_prod",
  pool_size: 20

### PostgreSQL
# mix phoenix.new --database postgres PROJECT_PATH

# dev
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tokyoex_handson_demo_dev",
  hostname: "localhost",
  pool_size: 10

# test
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tokyoex_handson_demo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# prod
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "username", # change me
  password: "password", # change me
  database: "tokyoex_handson_demo_prod",
  pool_size: 20

### SQLite
# mix phoenix.new --database sqlite PROJECT_PATH

# dev
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Sqlite.Ecto,
  database: "db/tokyoex_handson_demo_dev.sqlite",
  pool_size: 10

# test
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Sqlite.Ecto,
  database: "db/tokyoex_handson_demo_test.sqlite",
  pool: Ecto.Adapters.SQL.Sandbox

# prod
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Sqlite.Ecto,
  database: "db/tokyoex_handson_demo_prod.sqlite",
  pool_size: 20

### MongoDB
# mix phoenix.new --database mongodb PROJECT_PATH

# dev
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Mongo.Ecto,
  database: "tokyoex_handson_demo_dev",
  pool_size: 10

# test
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
config :mongodb_new, MongodbNew.Repo,
  adapter: Mongo.Ecto,
  database: "tokyoex_handson_demo_test",
  pool_size: 1

# prod
config :tokyoex_handson_demo, TokyoexHandsonDemo.Repo,
  adapter: Mongo.Ecto,
  database: "tokyoex_handson_demo_prod",
  pool_size: 20

