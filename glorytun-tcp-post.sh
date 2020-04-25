#!/bin/sh
. "$(readlink -f "$1")"

INTF=gt-${DEV}
[ -z "$LOCALIP" ] && LOCALIP="10.255.255.1"
[ -z "$BROADCASTIP" ] && BROADCASTIP="10.255.255.3"
[ "$(ip addr show dev $INTF | grep -o 'inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*')" != "$LOCALIP" ] && {
	ip link set dev ${INTF} up 2>&1 >/dev/null
	ip addr add ${LOCALIP}/30 brd ${BROADCASTIP} dev ${INTF} 2>&1 >/dev/null
}
