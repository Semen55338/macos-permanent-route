#!/bin/sh

router="10.8.0.1"

curl -z tmp/subnet.lst https://antifilter.download/list/subnet.lst --output tmp/subnet.lst
curl -z tmp/ipsum.lst https://antifilter.download/list/ipsum.lst --output tmp/ipsum.lst

old=$(cat tmp/md5);
new=$(cat tmp/*.lst | md5sum | head -c 32);

if [ "$old" != "$new" ]
then
cat tmp/ipsum.lst > tmp/ip.list
cat tmp/subnet.lst >> tmp/ip.list
for ip in $(grep -Ev '^$|^#' tmp/ip.list)
do
route add $ip $router 1>/dev/null 
done

echo $new > tmp/md5
fi