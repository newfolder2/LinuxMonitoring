#!/bin/bash
if [[ "$1" =~ ^[0-9]+$ ]] || [[ $# -eq 0 ]]; then
  echo "Error: incorrect input"
else
  echo "Your text is: $1"
fi