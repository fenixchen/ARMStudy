#!/bin/bash

DEF_IMAGE_FILE=display.bin

QEMU_GDB='-S -s'

QEMU_GDB_ARG=''
IMAGE_FILE=''

for arg in $*; do
  if [ "$arg" = '-debug' ]; then
    QEMU_GDB_ARG=$QEMU_GDB;
  else
    if [ "$IMAGE_FILE" = '' ]; then
      IMAGE_FILE=$arg
    fi
  fi
done

if [ "$IMAGE_FILE" = '' ]; then
  IMAGE_FILE=$DEF_IMAGE_FILE
fi


QEMUBIN=qemu-system-arm

$QEMUBIN -M versatilepb -nographic -m 128 -kernel $IMAGE_FILE $QEMU_GDB_ARG
