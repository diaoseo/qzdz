

library libkj

function kj_1 takes nothing returns nothing
    local integer li=GetPlayerTechCount(GetOwningPlayer(GetTriggerUnit()),GetResearched(),true)//获取科技等级
    local integer li1=0
    loop
        exitwhen li1==7
        call SetPlayerTechResearched(Player(li1),GetResearched(),li)//同步科技等级
        set li1=li1+1
    endloop
endfunction

function kj takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function kj_1)
    call SaveTriggerHandle(udg_hs,0,StringHash("科技"),tr)
    set tr=null
endfunction

endlibrary
