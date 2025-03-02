#!/usr/bin/env bash

set -eo pipefail
#SHELL="/usr/bin/env bash"

if [ -n "$1" ] ; then
  echo "Loading $1"
  . $1
else
  . conf.sh
fi

if [ `uname` == 'Darwin' ] ; then
  export SIZE_CMD="stat -f %z"
  #export SIZE_CMD='wc -c < filename'
elif [ `uname` == 'Linux' ] ; then
  export SIZE_CMD="stat -c %s"
else
  echo "Unsupported OS"
  exit
fi

mkdir -p $SOURCE_DIR

for SCRIPT in [0-9]*; do
  echo "Running $SCRIPT"
  ./$SCRIPT
done
