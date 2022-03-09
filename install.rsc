/system script 
add name="pwlgrzs-blacklist-dl" source={/tool fetch url="https://raw.githubusercontent.com/jstrahle/Mikrotik-Blacklist/master/blacklist.rsc" mode=https}
add name="pwlgrzs-blacklist-replace" source {/ip firewall address-list remove [find where list="pwlgrzs-blacklist"]; /import file-name=blacklist.rsc}
/system scheduler 
add interval=3h name="dl-mt-blacklist" start-date=Jan/01/2000 start-time=00:05:00 on-event=pwlgrzs-blacklist-dl
add interval=3h name="ins-mt-blacklist" start-date=Jan/01/2000 start-time=00:10:00 on-event=pwlgrzs-blacklist-replace
