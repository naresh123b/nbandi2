#! /bin/sh
/naresh/apache-cassandra-3.9/bin/cassandra -R > /tmp/server-log.txt &
sleep 1
while ! grep -m1 'state jump to NORMAL' < /tmp/server-log.txt; do
    sleep 1
done
echo Continue
