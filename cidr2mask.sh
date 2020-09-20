#!/bin/sh

# https://forums.gentoo.org/viewtopic-p-6772228.html?sid=746da3ca7c7088c86f5e4b20ff8914b0#6772228
cidr2mask ()
{
   # Number of args to shift, 255..255, first non-255 byte, zeroes
   set -- $(( 5 - ($1 / 8) )) 255 255 255 255 $(( (255 << (8 - ($1 % 8))) & 255 )) 0 0 0
   [ $1 -gt 1 ] && shift $1 || shift
   echo ${1-0}.${2-0}.${3-0}.${4-0}
}

# Parse and validate arguments
[ -z "$1" ] && exit 0
[ "${1%/*}" = "$1" ] && mask="$2" || mask="${1#*/}"
[ -z "$mask" ] && echo "No netmask." && exit 0

# Check and convert mask
ip=${1%/*}

# Convert CIDR to netmask and vice versa
printf "%s %s\n" $ip $(cidr2mask $mask)