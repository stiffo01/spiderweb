#!/bin/bash
webfile="index.html"
func1 () {
  if [["$webfile"=='/']]
  then
    webfile="index.html"
  fi
}
func2 () {
webfile=$(grep GET output.txt | cut -d' ' -f2); \
}
while true; do { \
  echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c < $webfile)\r\n\r\n"; \
  cat $webfile; } | nc -l -p 80 -q 1; \
  func2
  func1
done
