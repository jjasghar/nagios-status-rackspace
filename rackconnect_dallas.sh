#!/bin/bash

stateid=
NORMAL="*is operating normally*"

RACKCONNECT_CURL=`curl --silent https://status.rackspace.com/ | grep -A 36 -m 2 "<DIV CLASS='field field-group field-group-name'>RackConnect</DIV>" | sed -e "s/<DIV CLASS='field field-service field-service-name'>//g" -e "s/<\/DIV>//g"  -e "s/<DIV CLASS='field field-group field-group-name'>//g" -e "/<DIV CLASS='field field-group field-group-status'>/d" -e "/DIV ID=/d" -e "/<IMG CLASS/d" -e "/<DIV CLASS='row row-service'>/d" -e "/toggleGroup/d" -e "s/<DIV CLASS='field field-group field-group-message'>//g" -e "s/<DIV CLASS='field field-group field-group-updated'>//g" -e "/<DIV CLASS='field field-service field-service-status'>/d" -e "s/<DIV CLASS='field field-service field-service-message'>//g" -e "s/<DIV CLASS='field field-service field-service-updated'>//g"`

RACKCONNECT=`echo $RACKCONNECT_CURL | cut -f17-24 -d " "`

if [[ ${RACKCONNECT} == ${NORMAL} ]];
 then
   echo ${RACKCONNECT}
   stateid=0
elif [[ "${RACKCONNECT}" != ${NORMAL} ]];
 then
   echo ${RACKCONNECT}
   stateid=3
 fi
exit $stateid
