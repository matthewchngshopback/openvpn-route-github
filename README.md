# OpenVPN route Github

Use this with OpenVPN server's `--client-connect` option to automatically
download Github IPs and push routes to client on every client connection.

When users start to find their connection to Github failing, they can simply
reconnect to get the latest routes and carry on.

This script will attempt to fetch Github IPs from https://api.github.com/meta
and generate the relevant config output.

Add the following to the OpenVPN's configuration

```
script-security 2
client-connect <path/to/this/project/build-config.sh>
```

# build-config.sh [output [format]] 

Running this will create default working directory in
`/tmp/openvpn-route-github`. It will also download `jq` into this directory
on first run.

**This script requires `wget` to download `jq` and fetch from Github's
public API.**

## Fault tolerance

If the script fails to fetch Github IPs from https://api.github.com/meta within
1 second, the script will log a message and proceed to use the IPs from the
last successful fetch.

Client's connection will be delayed for at most 1 second if Github's API is
slow to respond or if there are network connectivity issues in your server's
setup.

There is a fallback JSON that is provided in this project which was fetched on
2020-09-20.

## Sample server config output
```
# github web
push "route 192.30.252.0 255.255.252.0"
push "route 185.199.108.0 255.255.252.0"
push "route 140.82.112.0 255.255.240.0"
push "route 13.114.40.48 255.255.255.255"
push "route 52.192.72.89 255.255.255.255"
push "route 52.69.186.44 255.255.255.255"
push "route 15.164.81.167 255.255.255.255"
push "route 52.78.231.108 255.255.255.255"
push "route 13.234.176.102 255.255.255.255"
push "route 13.234.210.38 255.255.255.255"
push "route 13.229.188.59 255.255.255.255"
push "route 13.250.177.223 255.255.255.255"
push "route 52.74.223.119 255.255.255.255"
push "route 13.236.229.21 255.255.255.255"
push "route 13.237.44.5 255.255.255.255"
push "route 52.64.108.95 255.255.255.255"
push "route 18.228.52.138 255.255.255.255"
push "route 18.228.67.229 255.255.255.255"
push "route 18.231.5.6 255.255.255.255"
# github git
push "route 192.30.252.0 255.255.252.0"
push "route 185.199.108.0 255.255.252.0"
push "route 140.82.112.0 255.255.240.0"
push "route 13.114.40.48 255.255.255.255"
push "route 52.192.72.89 255.255.255.255"
push "route 52.69.186.44 255.255.255.255"
push "route 15.164.81.167 255.255.255.255"
push "route 52.78.231.108 255.255.255.255"
push "route 13.234.176.102 255.255.255.255"
push "route 13.234.210.38 255.255.255.255"
push "route 13.229.188.59 255.255.255.255"
push "route 13.250.177.223 255.255.255.255"
push "route 52.74.223.119 255.255.255.255"
push "route 13.236.229.21 255.255.255.255"
push "route 13.237.44.5 255.255.255.255"
push "route 52.64.108.95 255.255.255.255"
push "route 18.228.52.138 255.255.255.255"
push "route 18.228.67.229 255.255.255.255"
push "route 18.231.5.6 255.255.255.255"
push "route 18.181.13.223 255.255.255.255"
push "route 54.238.117.237 255.255.255.255"
push "route 54.168.17.15 255.255.255.255"
push "route 3.34.26.58 255.255.255.255"
push "route 13.125.114.27 255.255.255.255"
push "route 3.7.2.84 255.255.255.255"
push "route 3.6.106.81 255.255.255.255"
push "route 18.140.96.234 255.255.255.255"
push "route 18.141.90.153 255.255.255.255"
push "route 18.138.202.180 255.255.255.255"
push "route 52.63.152.235 255.255.255.255"
push "route 3.105.147.174 255.255.255.255"
push "route 3.106.158.203 255.255.255.255"
push "route 54.233.131.104 255.255.255.255"
push "route 18.231.104.233 255.255.255.255"
push "route 18.228.167.86 255.255.255.255"
# github pages
push "route 192.30.252.153 255.255.255.255"
push "route 192.30.252.154 255.255.255.255"
push "route 185.199.108.153 255.255.255.255"
push "route 185.199.109.153 255.255.255.255"
push "route 185.199.110.153 255.255.255.255"
push "route 185.199.111.153 255.255.255.255"

```

# build-client-config.sh [output]
This is just a convenience wrapper to run
`build-config.sh /some/output/file.conf "route %s"` which will generate output
for use in OpenVPN client configuration.

`build-config.sh` usage is described above.

If `output` isn't specified, it defaults to 
`/tmp/openvpn-route-github/openvpn-client/out.conf`.

Running this will create a default output directory at
`/tmp/openvpn-route-github/openvpn-client`.

Please note that Github IP addresses can change over time so the generated
routes will decay. When routes stop working, simply re-generate the routes,
update your `ovpn` config, reconnect and get back to work.

## Sample client config output
```
####
# Auto generated at Wed Oct 21 04:08:39 UTC 2020
# Please append contents into client ovpn and reconnect
##

# github web
route 192.30.252.0 255.255.252.0
route 185.199.108.0 255.255.252.0
route 140.82.112.0 255.255.240.0
route 13.114.40.48 255.255.255.255
route 52.192.72.89 255.255.255.255
route 52.69.186.44 255.255.255.255
route 15.164.81.167 255.255.255.255
route 52.78.231.108 255.255.255.255
route 13.234.176.102 255.255.255.255
route 13.234.210.38 255.255.255.255
route 13.229.188.59 255.255.255.255
route 13.250.177.223 255.255.255.255
route 52.74.223.119 255.255.255.255
route 13.236.229.21 255.255.255.255
route 13.237.44.5 255.255.255.255
route 52.64.108.95 255.255.255.255
route 18.228.52.138 255.255.255.255
route 18.228.67.229 255.255.255.255
route 18.231.5.6 255.255.255.255
# github git
route 192.30.252.0 255.255.252.0
route 185.199.108.0 255.255.252.0
route 140.82.112.0 255.255.240.0
route 13.114.40.48 255.255.255.255
route 52.192.72.89 255.255.255.255
route 52.69.186.44 255.255.255.255
route 15.164.81.167 255.255.255.255
route 52.78.231.108 255.255.255.255
route 13.234.176.102 255.255.255.255
route 13.234.210.38 255.255.255.255
route 13.229.188.59 255.255.255.255
route 13.250.177.223 255.255.255.255
route 52.74.223.119 255.255.255.255
route 13.236.229.21 255.255.255.255
route 13.237.44.5 255.255.255.255
route 52.64.108.95 255.255.255.255
route 18.228.52.138 255.255.255.255
route 18.228.67.229 255.255.255.255
route 18.231.5.6 255.255.255.255
route 18.181.13.223 255.255.255.255
route 54.238.117.237 255.255.255.255
route 54.168.17.15 255.255.255.255
route 3.34.26.58 255.255.255.255
route 13.125.114.27 255.255.255.255
route 3.7.2.84 255.255.255.255
route 3.6.106.81 255.255.255.255
route 18.140.96.234 255.255.255.255
route 18.141.90.153 255.255.255.255
route 18.138.202.180 255.255.255.255
route 52.63.152.235 255.255.255.255
route 3.105.147.174 255.255.255.255
route 3.106.158.203 255.255.255.255
route 54.233.131.104 255.255.255.255
route 18.231.104.233 255.255.255.255
route 18.228.167.86 255.255.255.255
# github pages
route 192.30.252.153 255.255.255.255
route 192.30.252.154 255.255.255.255
route 185.199.108.153 255.255.255.255
route 185.199.109.153 255.255.255.255
route 185.199.110.153 255.255.255.255
route 185.199.111.153 255.255.255.255
```

# OpenVPN documentation 
Documentation on the `script-security` and `client-connect` options

>–script-security level  
>This directive offers policy-level control over OpenVPN’s usage of external
>programs and scripts. Lower level values are more restrictive, higher values
>are more permissive. Settings for level:0 — Strictly no calling of external
>programs.  
>1 — (Default) Only call built-in executables such as ifconfig, ip, route, or
>    netsh.  
>2 — Allow calling of built-in executables and user-defined scripts.  
>3 — Allow passwords to be passed to scripts via environmental variables
>    (potentially unsafe).  
>
>OpenVPN releases before v2.3 also supported a method flag which indicated how
>OpenVPN should call external commands and scripts. This could be either execve
>or system. As of OpenVPN 2.3, this flag is no longer accepted. In most *nix
>environments the execve() approach has been used without any issues.Some
>directives such as –up allow options to be passed to the external script. In
>these cases make sure the script name does not contain any spaces or the
>configuration parser will choke because it can’t determine where the script
>name ends and script options start.To run scripts in Windows in earlier OpenVPN
>versions you needed to either add a full path to the script interpreter which
>can parse the script or use the system flag to run these scripts. As of OpenVPN
>2.3 it is now a strict requirement to have full path to the script interpreter
>when running non-executables files. This is not needed for executable files,
>such as .exe, .com, .bat or .cmd files. For example, if you have a Visual Basic
>script, you must use this syntax now:  
>
>  ```--up 'C:\\Windows\\System32\\wscript.exe C:\\Program\ Files\\OpenVPN\\config\\my-up-script.vbs'```
>
>Please note the single quote marks and the escaping of the backslashes (\) and
>the space character.
>
>The reason the support for the system flag was removed is due to the security
>implications with shell expansions when executing scripts via the system() call.

>–client-connect cmd  
>Run command cmd on client connection.cmd consists of a path to script (or 
>executable program), optionally followed by arguments. The path and arguments
>may be single- or double-quoted and/or escaped using a backslash, and should be
>separated by one or more spaces.  
>The command is passed the common name and IP address of the just-authenticated
>client as environmental variables (see environmental variable section below).
>The command is also passed the pathname of a freshly created temporary file as
>the last argument (after any arguments specified in cmd ), to be used by the
>command to pass dynamically generated config file directives back to OpenVPN.  
>
>If the script wants to generate a dynamic config file to be applied on the
>server when the client connects, it should write it to the file named by the
>last argument.
>
>See the –client-config-dir option below for options which can be legally used
>in a dynamically generated config file.
>
>Note that the return value of script is significant. If script returns a
>non-zero error status, it will cause the client to be disconnected.


References
- https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/
- https://unix.stackexchange.com/questions/528070/push-routes-dynamically-for-openvpn


