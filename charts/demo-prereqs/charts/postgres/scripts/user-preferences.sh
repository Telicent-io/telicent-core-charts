#!/usr/bin/env bash

###
# Copyright (C) 2025-2026 Telicent Limited
###

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE user_preferences;
    CREATE DATABASE auth;
EOSQL
