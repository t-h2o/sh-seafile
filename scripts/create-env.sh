#!/bin/sh

alias pwgen="docker run \
	--rm \
	--interactive \
	backplane/pwgen \
	--ambiguous \
	--capitalize \
	--secure 20 1"

alias shuf_port="shuf \
	--input-range 10000-60000 \
	--head-count 1"

create_environment_file () {

	MYSQL_ROOT_PASSWORD=$(pwgen)
	MYSQL_LOG_CONSOLE=true

	DB_HOST=db
	DB_ROOT_PASSWD="${MYSQL_ROOT_PASSWORD}"
	TIME_ZONE=$(timedatectl show --property=Timezone | sed 's/Timezone=\(.\+\)/\1/')
	SEAFILE_ADMIN_EMAIL=me@example.com
	SEAFILE_ADMIN_PASSWORD=$(pwgen)
	SEAFILE_SERVER_LETSENCRYPT=false
	SEAFILE_SERVER_HOSTNAME=docs.seafile.com

	PATH_SEAFILE_DATA=./seafile

	SEAFILE_PORT=$(shuf_port)
	cat > .env <<- environment
	MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
	MYSQL_LOG_CONSOLE=${MYSQL_LOG_CONSOLE}

	DB_HOST=${DB_HOST}
	DB_ROOT_PASSWD=${DB_ROOT_PASSWD}
	TIME_ZONE=${TIME_ZONE}
	SEAFILE_ADMIN_EMAIL=${SEAFILE_ADMIN_EMAIL}
	SEAFILE_ADMIN_PASSWORD=${SEAFILE_ADMIN_PASSWORD}
	SEAFILE_SERVER_LETSENCRYPT=${SEAFILE_SERVER_LETSENCRYPT}
	SEAFILE_SERVER_HOSTNAME=${SEAFILE_SERVER_HOSTNAME}

	PATH_SEAFILE_DATA=${PATH_SEAFILE_DATA}

	SEAFILE_PORT=${SEAFILE_PORT}
	environment
}

main () {
	if [ -e "./.env" ]
	then
		printf ".env alredy exist\n"
		exit
	fi

	create_environment_file
}

main
