#!/bin/bash
# Pren com entrada un arxiu compost de capçaleres HTTP i contingut
# Trau com a resultat el contingut
cat "$1" | tail -n+`cat "$1" | tr '\r' '_' | grep -a -n ^_$ | head -n1 | cut -f1 -d:` | tail -n+2
