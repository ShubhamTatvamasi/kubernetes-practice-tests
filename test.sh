#!/bin/bash

exit_status=0
testNumber=0

scenario_not_found=$(curl -s \
https://katacoda.com/embed/mmumshad2/scenario-not-found/ \
| html2text | tail -n3)

while read url
do

  let "testNumber++"
  testUrl=$(curl -s ${url} | html2text | tail -n3)

  if [ "${scenario_not_found}" != "${testUrl}" ]; then
      echo -e "\033[0;32mTest Passed ${testNumber} : ${url##*2/} "
  else
      echo -e "\033[0;31mTest failed ${testNumber} : ${url##*2/} "
      exit_status=1
  fi

done < urls

exit "${exit_status}"
