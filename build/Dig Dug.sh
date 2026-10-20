#!/bin/sh
printf '\033c\033]0;%s\a' Dig Dug
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Dig Dug.x86_64" "$@"
