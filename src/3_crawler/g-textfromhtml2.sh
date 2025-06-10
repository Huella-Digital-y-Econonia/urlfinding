#!/bin/bash

# Torna el text contingu al HTML 

cat $1  | tr '\n' ' ' | tr '<' '\n' | sed -n "s/[^>]*>\(.*\)$/\1/p"  | php -r 'while(($line=fgets(STDIN)) !== FALSE) echo html_entity_decode($line, ENT_QUOTES|ENT_HTML401);' |  grep -v ^[\ ]*$ | grep -v { | grep -v =

