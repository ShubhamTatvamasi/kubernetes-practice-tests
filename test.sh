#!/bin/bash

exit_status=0
test_number=0

scenario_not_found=$(curl -s \
  "https://katacoda.com/embed/mmumshad2/scenario-not-found/?embed&url&host=kodekloud.com" \
  | html2text | tail -3 | head -1)

while read url
do

  let "test_number++"
  test_url=$(curl -s ${url} | html2text | tail -3 | head -1)
  test_name=$(echo ${url##*d2/} | rev | cut -c 31- | rev)

  if [ "${scenario_not_found}" != "${test_url}" ]; then
      echo -e "\033[0;32mTest Passed ${test_number} : ${test_name}"
  else
      echo -e "\033[0;31mTest failed ${test_number} : ${test_name}"
      exit_status=1
  fi

done < urls

exit "${exit_status}"
