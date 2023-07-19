#!/bin/sh

REMOTE_BORG="ssh://user@ip:22/tmp/remote"

init_repo () {
	borg init --encryption repokey "${REMOTE_BORG}"
}

create_a_backup () {
	borg create \
		--stats \
		--progress \
		--compression lz4 \
		"${REMOTE_BORG}"::seafile_"$(date +"%Y-%m-%d")"
}

list_backup () {
	borg list "${REMOTE_BORG}"
}

list_backup
