#!/bin/bash
#to run the script use: sudo bash spiderweb.sh | tee output.txt
webfile="index.html"
#func1 will search the output.txt file for what file is requested in the browser, if the browser is / (empty)
#then it will replace the epmty / with index.html.
func1 () {
  if [[ "$webfile" == "null" ]]
  then
    echo "#do something"  
  fi
  webfile=$(head -1 output.txt | cut -d' ' -f2)
  if [[ "$webfile" == '/' ]]
  then
    webfile="index.html"
  else
    webfile=$(echo "$webfile" | tr -d "/")
    echo "$webfile"
  fi
}
while true; do { \
  echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c < webfile=$(func1))\r\n\r\n"; \
  cat $webfile; } | nc -l -p 80 -q 1; \
done
