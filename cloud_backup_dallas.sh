#!/bin/bash

stateid=
NORMAL="*is operating normally*"

CLOUD_BACKUP_CURL=`curl --silent https://status.rackspace.com/ | grep -A 36 -m 2 "<DIV CLASS='field field-group field-group-name'>Cloud Backup</DIV>" | sed -e "s/<DIV CLASS='field field-service field-service-name'>//g" -e "s/<\/DIV>//g"  -e "s/<DIV CLASS='field field-group field-group-name'>//g" -e "/<DIV CLASS='field field-group field-group-status'>/d" -e "/DIV ID=/d" -e "/<IMG CLASS/d" -e "/<DIV CLASS='row row-service'>/d" -e "/toggleGroup/d" -e "s/<DIV CLASS='field field-group field-group-message'>//g" -e "s/<DIV CLASS='field field-group field-group-updated'>//g" -e "/<DIV CLASS='field field-service field-service-status'>/d" -e "s/<DIV CLASS='field field-service field-service-message'>//g" -e "s/<DIV CLASS='field field-service field-service-updated'>//g"`

CLOUD_BACKUP=`echo $CLOUD_BACKUP_CURL | cut -f18-25 -d " "`

if [[ ${CLOUD_BACKUP} == ${NORMAL} ]];
 then
   echo ${CLOUD_BACKUP}
   stateid=0
elif [[ "${CLOUD_BACKUP}" != ${NORMAL} ]];
 then
   echo ${CLOUD_BACKUP}
   stateid=3
 fi
exit $stateid
