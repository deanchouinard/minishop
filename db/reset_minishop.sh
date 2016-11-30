#!/usr/bin/env bash

# ALTER database minishop_test OWNER TO postgres;

function drop_and_create() {
  echo "Dropping and creating database $1..."
  if psql -U postgres -c "drop database $1" template1 ; then
    psql -U postgres -c "create database $1" template1

    echo "Loading schema for database $1..."
    psql -f db/1_create_tables.sql $1 postgres
  else
    echo "Unable to get exclusive acccess to $1"
    exit 1
  fi
}

for db_name in minishop_test minishop_dev ; do
  drop_and_create $db_name
done

echo "Loading seed data..."
mix run priv/repo/seeds.exs

