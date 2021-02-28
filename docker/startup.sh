#! /bin/sh

# ./docker/wait-for-services.sh
./docker/prepare-db.sh
# mkdir ./tmp/pids
pid = ./tmp/pids/server.pid

if test -f "$pid"; then
  echo "$pid exists."
  rm -f $pid
fi

bundle exec puma -C config/puma.rb
