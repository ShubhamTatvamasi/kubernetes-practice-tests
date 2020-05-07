#!/bin/bash

exit_status=0
test_number=0

function generate_nonce {
  curl -s "https://katacoda.com/api/embed/nonce"
}

author="https://katacoda.com/embed/mmumshad2/"
fake_scenario="scenario-not-found"
flags="?embed&url&host=kodekloud.com&nonce="

scenario_not_found=$(curl -s \
  "${author}${fake_scenario}${flags}$(generate_nonce)" \
  | html2text | tail -3 | head -1)

while read scenario
do

  let "test_number++"

  test_scenario=$(curl -s "${author}${scenario}${flags}$(generate_nonce)" \
    | html2text | tail -3 | head -1)

  if [ "${scenario_not_found}" != "${test_scenario}" ]; then
      echo -e "\033[0;32mTest Passed ${test_number} : ${scenario}"
  else
      echo -e "\033[0;31mTest failed ${test_number} : ${scenario}"
      exit_status=1
  fi

done < scenarios

exit "${exit_status}"
