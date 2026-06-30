#!/usr/bin/env bash

###
# Copyright (C) 2025-2026 Telicent Limited
###

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE user_preferences;
    CREATE USER ${USER_PREFS_DB_USER} WITH PASSWORD '${USER_PREFS_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE user_preferences TO ${USER_PREFS_DB_USER};

    CREATE DATABASE auth;
    CREATE USER ${AUTH_DB_USER} WITH PASSWORD '${AUTH_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE auth TO ${AUTH_DB_USER};
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "user_preferences" <<-EOSQL
    GRANT ALL ON SCHEMA public TO ${USER_PREFS_DB_USER};
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "auth" <<-EOSQL
    GRANT ALL ON SCHEMA public TO ${AUTH_DB_USER};
EOSQL
