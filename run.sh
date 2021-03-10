#!/bin/bash

# wget -O chimera-example-1.0.0.jar https://github.com/cefriel/chimera/releases/download/v2.1/chimera-example-1.0.0.jar

rm result.csv
touch result.csv
echo "testid,result" >> result.csv

for test in `ls -d -v ./rml-test-cases/test-cases/*` ; do
	if [[ $test == *"CSV"* ]] || [[ $test == *"JSON"* ]] || [[ $test == *"XML"* ]] ; then
		TEST_NAME="$(basename "$test")"
		cp rml-test-cases/test-cases/$TEST_NAME/* .

		java -jar chimera-example-1.0.0.jar
		
		mkdir results/$TEST_NAME
		mv out/* results/$TEST_NAME

		echo ""
		echo "$TEST_NAME"

		echo "EXPECTED"
		echo ""
		cat output.nq

		echo "OBTAINED"
		echo ""
		cat results/$TEST_NAME/*.nq

		echo ""
		echo "Result?"
		read answer
  		echo "$(basename "$test"),$answer" >> result.csv
  	else
  		echo "$(basename "$test"),inapplicable" >> result.csv
	fi
done