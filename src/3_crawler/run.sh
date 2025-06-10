#!/bin/bash

# urls és una llista de les websites

mkdir -p logs

echo "URL,Seconds,Date" > logs/times.txt

MAX_CONEXIONES=4

process_url() {
  url="$1"
  name=$(echo "$url" | sed 's|https\?://||; s|^www\.||; s|/$||; s|[^a-zA-Z0-9]|_|g')

  echo "[$(date)] Downloading $url" | tee -a "logs/$name.log"
  start_time=$(date +%s)

  ./crawler.sh "$url" "nas/$name" "" 1 >> "logs/$name.log" 2>> "logs/$name.err"

  end_time=$(date +%s)
  duration=$((end_time - start_time))

  echo "[$(date)] Duration: $duration s" | tee -a "logs/$name.log"

  echo "$url,$duration,$(date '+%Y-%m-%d %H:%M:%S')" >> logs/times.txt
}

export -f process_url 

cat urls.txt | xargs -P "$MAX_CONEXIONES" -I {} bash -c 'process_url "$@"' _ {}


