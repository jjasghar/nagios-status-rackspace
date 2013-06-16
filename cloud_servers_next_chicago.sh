#!/bin/bash

stateid=
NORMAL="*is operating normally*"

CLOUD_SERVERS_NEXT=`curl --silent https://status.rackspace.com/ | grep -A 36 -m 2 "<DIV CLASS='field field-group field-group-name'>Cloud Servers (Next Generation)</DIV>" | sed -e "s/<DIV CLASS='field field-service field-service-name'>//g" -e "s/<\/DIV>//g"  -e "s/<DIV CLASS='field field-group field-group-name'>//g" -e "/<DIV CLASS='field field-group field-group-status'>/d" -e "/DIV ID=/d" -e "/<IMG CLASS/d" -e "/<DIV CLASS='row row-service'>/d" -e "/toggleGroup/d" -e "s/<DIV CLASS='field field-group field-group-message'>//g" -e "s/<DIV CLASS='field field-group field-group-updated'>//g" -e "/<DIV CLASS='field field-service field-service-status'>/d" -e "s/<DIV CLASS='field field-service field-service-message'>//g" -e "s/<DIV CLASS='field field-service field-service-updated'>//g"`

CHICAGO_SERVERS_NEXT=`echo $CLOUD_SERVERS_NEXT | cut -f12-19 -d " "`

if [[ ${CHICAGO_SERVERS_NEXT} == ${NORMAL} ]];
 then
   echo ${CHICAGO_SERVERS_NEXT}
   stateid=0
elif [[ "${CHICAGO_SERVERS_NEXT}" != ${NORMAL} ]];
 then
   echo ${CHICAGO_SERVERS_NEXT}
   stateid=2
 fi
exit $stateid
