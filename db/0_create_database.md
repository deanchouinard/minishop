## Manual Instructions to Create Minishop Database

    $ psql template1 postgres

    template1> create database minishop_dev;
    \q

    $ psql -f 1_create_tables.sql minshop_dev postgres

    $ mix run priv/repo/seeds.exs

The create extension command was in the dump, but not sure you
need it if it already exists in the database.

    CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
