#!/usr/bin/env bash

if [ -z "$SOURCE_DIR" ] ; then
  SOURCE_DIR=data/sources
fi

if [ -z "$INPUT" ] ; then
  INPUT=$SOURCE_DIR/input.o5m
fi

echo "Skipping 3_pre_process_cleanup.sh"
