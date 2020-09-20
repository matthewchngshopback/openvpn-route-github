#!/bin/sh

BASEDIR=$(dirname "$0")
WORKDIR="/tmp/openvpn-route-github"

jqURL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
jq=$WORKDIR/bin/jq # update to local jq binary path if exists to skip downloading

ghmetaUrl="https://api.github.com/meta"
ghmetaJson=$WORKDIR/api.github.com/meta.json
ghmetaKeys="web git pages" # Specify keys in https://api.github.com/meta with IPs to route

# 
output=${1-$WORKDIR/openvpn-server/out.conf}

# Setup directories
mkdir -p $WORKDIR/bin $WORKDIR/api.github.com $WORKDIR/openvpn-server

# Download jq if not exists
if [ -f $jq ]; then
    printf "Using jq version %s\n" $($jq --version)
else
    echo "jq not found. Downloading from ${jqURL}"
    wget -q $jqURL -O $jq --show-progress
    chmod +x $jq
fi

# Fetch https://api.github.com/meta

cp $BASEDIR/api.github.com/meta.json $ghmetaJson # Set up default
echo "Fetching latest Github IPs from $ghmetaUrl"
tmpghmetaJson=$(mktemp $ghmetaJson.tmp.XXXXXX)
wget -q -t 1 $ghmetaUrl -O $tmpghmetaJson

if [ $? -ne 0 ]; then
    echo "Fetching latest Github IPs failed. Proceeding with latest cached result in $ghmetaJson"
    rm $tmpghmetaJson
else
    mv $tmpghmetaJson $ghmetaJson
fi

tmpoutfile=$(mktemp $output.tmp.XXXXXX)
routecmdformat='push "route %s"'

for k in $ghmetaKeys; do
    echo "# github $k" >> $tmpoutfile
    cat $ghmetaJson | $jq -r ".$k[]" | xargs -n 1 $BASEDIR/cidr2mask.sh | xargs -d "\n" printf "$routecmdformat\n" >> $tmpoutfile
done

mv $tmpoutfile $output