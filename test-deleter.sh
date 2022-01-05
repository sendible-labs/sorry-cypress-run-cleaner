#!/bin/sh

start_date="2010-01-01"
end_date=$(date -I --date="100 day ago")

echo Deleting tests from $end_date to $start_date 

curl $cypress_url -H 'Accept-Encoding: gzip, deflate, br' \
-H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: $cypress_url' \
--data-binary '{"query":"mutation {\n    deleteRunsInDateRange(startDate: \"'$start_date'T00:00:00.000Z\", endDate: \"'$end_date'T00:00:00.000Z\") {\n      success\n      message\n      runIds\n      __typename\n    }\n  }\n"}' \
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