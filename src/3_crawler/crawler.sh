#!/bin/bash
# $1 url del lloc a descarregar
# $2 path del directori on descarregar-lo
# $3 referencia temporal amb la que marcar els indicadors a l'eixida
# $4 profunditat del crawling

CURRDIR=`pwd`
web="$1"
DST="$2"
any="$3"
prof="$4"
md5=`echo $web | sed "s<^https*://<<" | sed s/^www.// | md5sum | colrm 4`
TMPDST="/tmp/weeit2/web-storage/$md5$RANDOM"


[ -z "$DST" ] && DST="."

mkdir -p $DST

cd $DST
if [ -f running.lock ]; then
	>&2 echo "Error: Site downloading in progress"
	>&2 echo "Aborting..."
	exit
fi

touch running.lock

echo $TMPDST
mkdir -p $TMPDST/content

domains=`$CURRDIR/accepted-domains.sh "$web"`

wget -e robots=off -P $TMPDST/content -r -nd -l$prof -t 3 --save-headers $web -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0" --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" --wait=4 --random-wait --limit-rate=500k --quota=500m --no-check-certificate --reject '*.js,*.css,*.ico,*.txt,*.gif,*.jpg,*.jpeg,*.png,*.mp3,*.tgz,*.flv,*.avi,*.mpeg,*.iso,*.mp4,*.MP4, *.exe, *.pdf, *.rar, *.webm, *.ogg, *.avi, *.doc, *.docx, *?download=true' --ignore-tags=img,script -D "$domains" -H
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for x in `find $TMPDST/content/ -exec grep -il "Content-Type: application/pdf" {} \;`; do $CURRDIR/catcontent.sh "$x" | pdftotext - -; done > $TMPDST/tot.txt
find $TMPDST/content/ -exec $CURRDIR/catcontentif.sh {} "Content-Type: text/html" \; | tee $TMPDST/htmls.html | $CURRDIR/g-textfromhtml2.sh - >> $TMPDST/tot.txt
IFS=$SAVEIFS

rm $TMPDST/content/ -Rf

cd $CURRDIR

gzip -f $TMPDST/tot.txt $TMPDST/htmls.html 

mv -f $TMPDST/tot.txt.gz $TMPDST/htmls.html.gz $DST
echo "$web" | gzip > "$DST/url.txt.gz"

rmdir $TMPDST
rm $DST/running.lock
