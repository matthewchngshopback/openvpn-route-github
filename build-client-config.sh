#!/bin/sh
set -e

BASEDIR=$(dirname "$0")
OUTPUTDIR="/tmp/openvpn-route-github/openvpn-client"

# Default args
output=${1-$OUTPUTDIR/out.conf}

mkdir -p $OUTPUTDIR

$BASEDIR/build-config.sh $output "route %s"

echo "\
####
# Auto generated at $(date -u)
# Please append contents into client ovpn and reconnect
##

$(cat $output)" > $output

echo "Configuration has been generated at"
echo $output
echo "Append the contents into your client ovpn and reconnect"