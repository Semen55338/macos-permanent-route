#!/bin/sh

router="10.8.0.1"

for ip in $(grep -Ev '^$|^#' ip.list)
do
route add -host $ip $router 
done