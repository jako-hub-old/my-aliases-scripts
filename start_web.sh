#!/bin/bash

APP_NAME=''
DIR_APP=''
VALID_APPS=("admin" "landing_cli" "landing_tri" "client" "trikollaborator")
BASE_PATH="/var/www/html/triko"
declare -A APP_ROUTES=(
	[admin]="${BASE_PATH}/triko-app-admin"
	[landing_cli]="${BASE_PATH}/triko-app-landing-clients"
	[landing_tri]="${BASE_PATH}/triko-app-landing-collaborators"
	[trikollaborator]="${BASE_PATH}/triko-app-collaborators"
	[client]="${BASE_PATH}/triko-app-clients"
)
echo "Opening a web app with react"

get_list_of_apps() {
	local STR=$(printf "|%s" "${VALID_APPS[@]}")
	STR=${STR:1}
	echo $STR;
}

print_usage() {
	STR_VALID_APPS=$(get_list_of_apps)
	echo "Usage: start_web -a [${STR_VALID_APPS}]"
}

while getopts ':a:' opt; do
	case $opt in
		a) 
			APP_NAME=$OPTARG
			>&2
			break;;
		''|*)
			echo "Invalid option" >&2
			exit 1
			break;;
	esac
done

if [ "$APP_NAME" = '' ]; then
	echo "You must select a valida application -a"
	print_usage
	exit 1
fi


match=$(echo "${VALID_APPS[@]:0}" | grep -o $APP_NAME)  

if [[ ! -z $match ]]; then
	VALID_APP=true
else
	VALID_APP=false
fi

if [ "$VALID_APP" = "false" ]; then
	echo "Not a valid app"
	print_usage
	exit 1
fi
APP_DIR="${APP_ROUTES[$APP_NAME]}"
cd $APP_DIR
yarn start