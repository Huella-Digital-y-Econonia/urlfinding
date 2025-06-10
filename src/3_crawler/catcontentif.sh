#!/bin/bash
# Pren com entrada un arxiu compost de capçaleres HTTP i contingut
# Trau com a resultat el contingut si conté el text inclós a $2
# $1 = Arxiu
# $2 = Contingut (generalment capçalera) que ha d'estar a l'arxiu
if grep -iq "$2" "$1"; then
	cat "$1" | tail -n+`cat "$1" | tr '\r' '_' | grep -a -n ^_$ | head -n1 | cut -f1 -d:` | tail -n+2;
fi
