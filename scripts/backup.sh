#!/bin/sh

SEAFILE_SOURCE="seafile"
SEAFILE_DESTINATION="backup"

if [ "$(whoami)" != "root" ]
then
	echo "root only..."
	exit 1
fi

if [ ! -d "${SEAFILE_SOURCE}" ]
then
	echo "\"${SEAFILE_SOURCE}\" do not exist"
	exit 1
fi

if [ ! -d "${SEAFILE_DESTINATION}" ]
then
	echo "\"${SEAFILE_DESTINATION}\" do not exist"
	exit 1
fi

if [ -d "$(date +"${SEAFILE_DESTINATION}/seafile-%F")" ]
then
	echo "\"$(date +"${SEAFILE_DESTINATION}/seafile-%F")\" already exist"
	exit 1
fi

cp -vR ${SEAFILE_SOURCE} $(date +"${SEAFILE_DESTINATION}/seafile-%F")
