#!/bin/bash

# $1 url del lloc a descarregar
web=`echo $1 | tr -d '\r<'`;
ini=`echo $web | sed "s<^https*://<<" | sed s/^www.// | colrm 3 | tr '[:upper:]' '[:lower:]' `
safe_web=$ini/`echo $web | sed "s<^https*://<<" | sed 's</$<<;s/\//$/g' | tr '[:upper:]' '[:lower:]' `
echo $safe_web/
