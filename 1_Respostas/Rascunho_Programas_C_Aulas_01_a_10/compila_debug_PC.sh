#!/bin/bash
CFILE=$1
gcc -Wall -pedantic -g3 $CFILE -o $CFILE.bin
