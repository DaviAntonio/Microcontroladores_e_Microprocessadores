#!/bin/bash
CFILE=$1
msp430-gcc -mmcu=msp430g2553 -Wall -pedantic -g3 $CFILE -o $CFILE.elf
