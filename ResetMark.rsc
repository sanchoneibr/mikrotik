:local dis [/caps-man interface find comment="DisableRunning"];

:if ($dis!="")  do={

    log warning "Restart no runnig wifi"; 

    /caps-man interface disable [/caps-man interface find comment="DisableRunning"]; 

    /caps-man interface enable [/caps-man interface find comment="DisableRunning"]; 

    /caps-man interface  set comment="" [/caps-man interface find comment="DisableRunning"];

}

 

:local disnoping [/caps-man interface find comment="ResetRunning"]; 

:if ($disnoping!="")  do={

    :log warning "Restart no ping wifi";

    /caps-man interface disable [/caps-man interface find comment="ResetRunning"];

    /caps-man interface enable [/caps-man interface find comment="ResetRunning"];

    /caps-man interface  set comment="" [/caps-man interface find comment="ResetRunning"]; 

}