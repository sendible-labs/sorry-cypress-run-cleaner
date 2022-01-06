#!/bin/sh

default_start="2010-01-01"
default_end=$(date -I -d "-100days") #100 days ago

if [ -z "$sorry_cypress_api_url" ]
then
    echo -e "Error: Missing Sorry Cypress API url Environment Variable"
    exit 1
fi

if [ -z "$run_days_to_keep" ]
then
    required_end=$(date -I -d "-100days")
else
    required_end=$(date -I -d "-$run_days_to_keep"days)
fi

actual_start=${start_date:=$default_start}
actual_end=${required_end:-$default_end}

echo Deleting tests from $actual_start till $actual_end for $sorry_cypress_api_url

curl $sorry_cypress_api_url -H 'Accept-Encoding: gzip, deflate, br' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H 'Connection: keep-alive' \
-H 'DNT: 1' -H 'Origin: $sorry_cypress_api_url' \
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
