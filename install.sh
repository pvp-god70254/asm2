#!/bin/bash

cd $(dirname $0)

if [ ! $(id -u) -eq 0 ]; then
  echo "Please run script as root to install"
  exit 1
fi

if [ -z $1 ]; then
  value=0
fi

if [ -z "$(type shc 2>/dev/null)" ] && [ $value -lt 1 ]; then
  echo "shc is missing please use ./install.sh 1 or install shc"
  exit
elif [ $value -gt 0 ]; then
  echo "Installing"
  cp asm2.sh /bin/asm2
  chmod +x /bin/asm2
else
  echo "Compiling And Installing"
  shc -f asm2.sh -o /bin/asm2
  rm asm2.sh.x.c
fi

echo "Installed you can now use asm2"


