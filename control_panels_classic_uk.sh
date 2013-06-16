#!/bin/bash

stateid=
NORMAL="*is operating normally*"

CONTROL_PANELS_CURL=`curl --silent https://status.rackspace.com/ | grep -A 43 -m 2 "<DIV CLASS='field field-group field-group-name'>Control Panels</DIV>" | sed -e "s/<DIV CLASS='field field-service field-service-name'>//g" -e "s/<\/DIV>//g"  -e "s/<DIV CLASS='field field-group field-group-name'>//g" -e "/<DIV CLASS='field field-group field-group-status'>/d" -e "/DIV ID=/d" -e "/<IMG CLASS/d" -e "/<DIV CLASS='row row-service'>/d" -e "/toggleGroup/d" -e "s/<DIV CLASS='field field-group field-group-message'>//g" -e "s/<DIV CLASS='field field-group field-group-updated'>//g" -e "/<DIV CLASS='field field-service field-service-status'>/d" -e "s/<DIV CLASS='field field-service field-service-message'>//g" -e "s/<DIV CLASS='field field-service field-service-updated'>//g"`

CONTROL_PANELS=`echo $CONTROL_PANELS_CURL | cut -f10-21 -d " "`

if [[ ${CONTROL_PANELS} == ${NORMAL} ]];
 then
   echo ${CONTROL_PANELS}
   stateid=0
elif [[ "${CONTROL_PANELS}" != ${NORMAL} ]];
 then
   echo ${CONTROL_PANELS}
   stateid=2
 fi
exit $stateid
