#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for dashd"

  set -- dashd "$@"
  	
  if [[ ! -s "$DASH_DATA/dash.conf" ]]; then
		cat <<-EOF > "$DASH_DATA/dash.conf"
		daemon=0
    server=1
		printtoconsole=1
		EOF
		chown dash:dash "$DASH_DATA/dash.conf"
	fi


fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "dashd" ]; then
  mkdir -p "$DASH_DATA"
  chmod 700 "$DASH_DATA"
  chown -R dash "$DASH_DATA"

  echo "$0: setting data directory to $DASH_DATA"

  set -- "$@" -datadir="$DASH_DATA"
fi

if [ "$1" = "dashd" ] || [ "$1" = "dash-cli" ] || [ "$1" = "dash-tx" ]; then
  echo
  exec gosu dash "$@"
fi

echo
exec "$@"
