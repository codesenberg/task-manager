#!/usr/bin/env bash

function start_db {
  docker run --name task_manager_pg_db\
    -e POSTGRES_PASSWORD=password\
    -p 5432:5432 -v "$(pwd)"/db/development-db:/var/lib/postgresql/data\
    -d postgres
}

function stop_db {
  docker stop task_manager_pg_db &&
  docker rm task_manager_pg_db
}

function connect {
  docker exec -it task_manager_pg_db psql -U postgres task_manager_development
}

cmd="$1"

case $cmd in
  "start")
  start_db
  ;;
  "stop")
  stop_db
  ;;
  "connect")
  connect
  ;;
esac
