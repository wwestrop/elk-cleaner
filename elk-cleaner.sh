#!/bin/sh

ELASTICSEARCH_HOST="http://{hostname}:9200/"
SECONDS_IN_DAY=86400


echo "Starting elk-cleaner"
echo "===================================="

while [ : ]
do
    echo "Time now is $(date)"

    for i in 10 9 8 7 6 5
    do
        SECONDS_TO_SUBTRACT=$(( $SECONDS_IN_DAY * $i ))

        # Backdate the date this number of days from today (expressed in seconds)
        DATE=$(date -I -d@"$(( `date +%s`-$SECONDS_TO_SUBTRACT))" | sed -e 's/-/./g')
        INDEX="logstash-$DATE"

        echo "Deleting index from $i days ago ($INDEX)"
        echo "curl --silent -X \"DELETE\" ${ELASTICSEARCH_HOST}${INDEX}"
        curl --silent -X "DELETE" ${ELASTICSEARCH_HOST}${INDEX}

        echo ""
        echo "Done"
        echo ""
    done

    echo "===================================="
    echo "Will run again tomorrow, around this time"

    sleep 1d
done

