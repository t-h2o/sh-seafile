#!/bin/sh

PATH_NGINX_TEMPLATE="nginx.seafile.conf"
PATH_NGINX_CONFIG_D="/etc/nginx/conf.d"

ENVIRONMENT_FILE=".env"

# export in the program the environment variable saved in the file
# $1: path of environment file
export_env () {
	while IFS= read -r line
	do
		if expr "${line}" : "\w\+=" > /dev/null
		then
			export "${line?}"
		fi
	done < "${1}"
}

place_nginx_config () {
	envsubst \
	'${SEAFILE_PORT},${SEAFILE_SERVER_HOSTNAME}' \
	< "${PATH_NGINX_TEMPLATE}" \
	> "${PATH_NGINX_CONFIG_D}"/nginx.seafile.conf
}

checks () {
	check_value=0

	if [ ! -d "${PATH_NGINX_CONFIG_D}" ]
	then
		echo "Error: the \"${PATH_NGINX_CONFIG_D}\" directory do not exist"
		check_value=1
	fi

	if [ ! -e "${ENVIRONMENT_FILE}" ]
	then
		echo "Error: the \"${ENVIRONMENT_FILE}\" environment file do not exist"
		check_value=1
	fi

	if [ "${check_value}" -ne 0 ]
	then
		exit 1
	fi
}

main () {
	checks
	export_env "${ENVIRONMENT_FILE}"
	place_nginx_config
}

main
