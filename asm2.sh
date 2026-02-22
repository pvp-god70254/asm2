#!/bin/bash

if [ ! -d ~/.assemblyModules ]; then
  rm ~/.assemblyModules &>/dev/null
  mkdir ~/.assemblyModules
fi

usage(){

  echo "asm2 Usage:"
  echo "asm2 [options] <assemblyFile>"
  echo -e "\noptions:"
  echo "-o | output of object file"
  echo "-f | output of executable file"
  echo "-m | add assembly script as module"
  echo "-s | dont add modules"
  echo "-j | add 1 custom 1-time module"

}

scriptName="a.out"
inputState=0
mode=0

#mode 1 - add module
#mode 2 - dont add modules

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o)
      output=$2
      shift 2
      ;;
    -f)
      scriptName=$2
      shift 2
      ;;
    -m)
      mode=1
      shift 1
      ;;
    -s)
      mode=2
      shift 1
      ;;
    -j)
      extModules="$extModules $2"
      shift 2
      ;;
    *)
      if [[ $inputState -eq 0 ]]; then
	 inputState=1
	 input=$1
	 shift 1
      else
        usage
	exit 1
	shift 1
      fi
      ;;
  esac
done

modules=$(echo $(find ~/.assemblyModules | grep '\.o'))

if [ -z $input ]; then
  usage
  exit
fi

if [ -z $output ]; then
  output="$input.o"
fi

if [ $mode -eq 1 ]; then
  output="$HOME/.assemblyModules/$output"
  cp "$input" "$output"
  exit
elif [ $mode -eq 2 ]; then
  modules=""
fi

as $input -o $output
if [[ -z $ld ]]; then
  ld -s $output $modules $extModules -o $scriptName
fi
