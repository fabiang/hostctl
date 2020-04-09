#!/bin/bash

set -e

if [ "$1" = 'hostctl' ]; then
  exec hostctl -p $PROJECT_NAME "${@:2}"
fi

exec "$@"
