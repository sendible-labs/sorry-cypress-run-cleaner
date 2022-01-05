#!/bin/sh

default_start="2010-01-01"
default_end="2010-12-12"
default_end=$(date -I -d "-2400:00:00") #100 days ago
actual_start=${start_date:=$default_start}
actual_end=${end_date:=$default_end}

echo Deleting tests from $actual_end till $actual_start 

curl $cypress_url -H 'Accept-Encoding: gzip, deflate, br' \
-H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: $cypress_url' \
--data-binary '{"query":"mutation {\n    deleteRunsInDateRange(startDate: \"'$actual_start'T00:00:00.000Z\", endDate: \"'$actual_end'T00:00:00.000Z\") {\n      success\n      message\n      runIds\n      __typename\n    }\n  }\n"}' \
--compressed > /home/output.txt

success=$(jq .data.deleteRunsInDateRange.success /home/output.txt)

if [ "$success" = "true" ]
then
    echo "Deletion successful - $(jq -r .data.deleteRunsInDateRange.message /home/output.txt)"
    exit 0
else
    echo "Deletion unsuccessful"
    exit 1
fi