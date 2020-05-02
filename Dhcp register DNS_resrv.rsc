# взял https://onformix.blogspot.com/2017/01/autoreg-dns-mikrotik.html
:local topdomain;
:set topdomain "cosysoft.loc";
:local ttl;
:set ttl "3d 00:10:00";
:local hostname;
:local hostip;
:local free;
/ip dns static;
:foreach a in=[find] do={
  :if ([get $a ttl] = $ttl) do={
    :put ("Removing: " . [get $a name] . " : " . [get $a address]);
    remove $a;
  }
}
/ip dhcp-server lease ;
:foreach i in=[find] do={
  /ip dhcp-server lease ;
  :if ([:len [get $i host-name]] > 0) do={
    :set free "true";
    :set hostname ([get $i host-name] . "." . $topdomain);
    :set hostip [get $i address];
    /ip dns static ;
    :foreach di in [find] do={
      :if ([get $di name] = $hostname) do={
        :set free "false";
        :put ("Not adding already existing entry: " . $hostname);
      }
    }
    :if ($free = true) do={
      :put ("Adding: " . $hostname . " : " . $hostip ) ;
      /ip dns static add name=$hostname address=$hostip ttl=$ttl;
    }
  }
}