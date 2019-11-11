:local PingCount 3;
:local dostclient;
:local macregist;
:local ipregist

:foreach capid in=[/caps-man radio find ] do={ 
    :local capname [ /caps-man radio get $capid interface];
    :set dostclient 0;
    :set ipregist 0;
#:put $capname;

    :foreach registid in=[/caps-man registration-table find interface=$capname] do={ 
        :if ($dostclient=0) do={
            :set macregist [/caps-man registration-table get $registid mac-address]; 
            #:put $macregist;
            :if ([ip arp find mac-address=$macregist]!="") do={
                :set ipregist [ip arp get [find mac-address=$macregist] address];
                #:put $ipregist;
                :set dostclient [/ping $ipregist count=$PingCount];
                #:put $dostclient;
            }
        }
    }
    :if (($dostclient=0) && ($ipregist!=0)) do={
        :log warning "Mark Restart no ping wifi cap=$capname";
        /caps-man interface set comment="ResetRunning" [/caps-man interface find name=$capname];
    }
}