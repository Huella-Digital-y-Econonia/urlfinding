#!/bin/bash

# Dominis acceptables separats per comes
# llevar www
# posar tant .com com .org .eu i tots els dominis de la UE + UK
# wget -D -H

orig="$1"

domini=`echo "$1" | sed "s<^http://<<; s<^https://<<; s</.*$<<;"`

no_tld=`echo $domini | sed "s<[.][^.]*$<<; s<^www[.]<<;"`
orig_tld=`echo $domini | sed -n "s<^.*[.]\([^.]*\)$<\1<p"`

no_tld_no_hyphens=`echo $no_tld | sed "s<-<<g;"`

echo -n "$no_tld.com,$no_tld.$orig_tld,$no_tld.org,$no_tld.de,$no_tld.be,$no_tld.hr,$no_tld.dk,$no_tld.es,$no_tld.fr,$no_tld.ie,$no_tld.lv,$no_tld.lu,$no_tld.nl,$no_tld.se,$no_tld.bg,$no_tld.sk,$no_tld.ee,$no_tld.gr,$no_tld.mt,$no_tld.pl,$no_tld.cz,$no_tld.at,$no_tld.cy,$no_tld.si,$no_tld.fi,$no_tld.hu,$no_tld.it,$no_tld.lt,$no_tld.pt,$no_tld.ro,$no_tld.uk,$no_tld.ue"

if [ "$no_tld" != "$no_tld_no_hyphens" ]; then
	no_tld=$(echo $domini | sed "s<[.][^.]*$<<; s<^www[.]<<; s<-<<g;")
	echo -n ",$no_tld.com,$no_tld.$orig_tld,$no_tld.org,$no_tld.de,$no_tld.be,$no_tld.hr,$no_tld.dk,$no_tld.es,$no_tld.fr,$no_tld.ie,$no_tld.lv,$no_tld.lu,$no_tld.nl,$no_tld.se,$no_tld.bg,$no_tld.sk,$no_tld.ee,$no_tld.gr,$no_tld.mt,$no_tld.pl,$no_tld.cz,$no_tld.at,$no_tld.cy,$no_tld.si,$no_tld.fi,$no_tld.hu,$no_tld.it,$no_tld.lt,$no_tld.pt,$no_tld.ro,$no_tld.uk,$no_tld.ue"
fi;

echo " "

