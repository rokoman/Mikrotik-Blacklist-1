# Mikrotik-Blacklist
This is a blocklist for Mikrotik router to block all connections from known spam/criminal/etc. networks.

Every couple days I pull lists from:
- Spamhaus (DROP & EDROP)
- dShield  
- blacklist.de (all.txt)
- Feodo
- dan.me.uk/torlist/ (TOR exit nodes)

and reformat it to allow automatic import to MT routers. This is automated process so if you see errors in the final list open an issue please.

## How to run this on MT
Run following to your MT device:

Download script:
`/system script add name="pwlgrzs-blacklist-dl" source={/tool fetch url="https://raw.githubusercontent.com/jstrahle/Mikrotik-Blacklist/master/blacklist.rsc" mode=https}`

Update script:
`/system script add name="pwlgrzs-blacklist-replace" source {/ip firewall address-list remove [find where list="pwlgrzs-blacklist"]; /import file-name=blacklist.rsc}`

Download schedule:
`/system scheduler add interval=3h name="dl-mt-blacklist" start-date=Jan/01/2000 start-time=00:05:00 on-event=pwlgrzs-blacklist-dl`

Update schedule:
`/system scheduler add interval=3h name="ins-mt-blacklist" start-date=Jan/01/2000 start-time=00:10:00 on-event=pwlgrzs-blacklist-replace`

You'll also need firewall rule:
`/ip firewall raw add chain=prerouting action=drop src-address-list=pwlgrzs-blacklist in-interface=IFNAME`  
*Note: Replace IFNAME in-interface name with one you have configured*

You can also import install.rsc file, it will do all of above for you.  
Upload to MT and run `/import file-name=install.rsc` in terminal. You still need to manually add firewall rule.

## TODO
 - Add more sources.
