#!/bin/bash
INPUT_FILE=`dirname $0`/../docker-compose.yml
ENV_FILE=`dirname $0`/../.env
TEMP_COMPOSE_FILE=`dirname $0`/../docker-compose.temp.yml
TEMP_ENV=`dirname $0`/../temp.env
NAME=gtd

prepare() {
  cp $INPUT_FILE $TEMP_COMPOSE_FILE
  tr -d '\r' <$ENV_FILE >$TEMP_ENV
  while read -r line; do
    OLD_IFS="$IFS"
    IFS="="
    pair=($line)
    IFS="$OLD_IFS"
    sed -i -e "s/\${${pair[0]}}/${pair[1]}/g" $TEMP_COMPOSE_FILE
  done < $TEMP_ENV
}

deploy() {
  docker stack deploy -c $TEMP_COMPOSE_FILE $NAME
}

prepare
deploy

rm -f $TEMP_ENV
rm -f $TEMP_COMPOSE_FILE
