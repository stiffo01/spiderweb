#!/bin/bash

#to run the script use: sudo bash spiderweb.sh | tee output.txt
#func1 will search the output.txt file for what file is requested in the browser, if the browser is / (empty)
#then it will replace the epmty / with index.html.

func1 () { 
  webfile=$(grep "GET" output.txt | tail -n1 | cut -d' ' -f2)
  #this looks at the first line in output.txt and then sends this information to cut, cut will cut field 2 with the separator " " and print it to the variable $webfile
  if [[ "$webfile" == '/' || -z $webfile ]]
  then
    echo "index.html"
  else
    echo "$webfile" | tr -d "/"
    #this will remove the / from the filename. It is from the beginning /index.html like this, We want only the text
  fi
}
while true 
do  
  weblink=$(func1)
  {
  echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c < $weblink)"\r\n\r\n
  cat $weblink; } | nc -l -p 80 -q 1
done
