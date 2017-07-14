#! /bin/sh
/usr/local/cassandra1.sh
sh nodetool status
./cqlsh -f /usr/local/TOD-script.cql
./cqlsh
#tail -f /tmp/server-log.txt
#waitpid()
