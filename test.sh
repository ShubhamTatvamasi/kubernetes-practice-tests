#!/bin/bash

exit_status=0
test_number=0

scenario_not_found=$(curl -s \
https://katacoda.com/embed/mmumshad2/scenario-not-found \
| html2text | tail -n3)

while read url
do

  let "test_number++"
  test_url=$(curl -s ${url} | html2text | tail -n3)

  if [ "${scenario_not_found}" != "${test_url}" ]; then
      echo -e "\033[0;32mTest Passed ${test_number} : ${url##*2/}"
  else
      echo -e "\033[0;31mTest failed ${test_number} : ${url##*2/}"
      exit_status=1
  fi

done < urls

exit "${exit_status}"
