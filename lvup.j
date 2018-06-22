
library liblvup


function lvup1 takes nothing returns nothing
    if GetHeroLevel(GetTriggerUnit())==200 or GetHeroLevel(GetTriggerUnit())==500 or GetHeroLevel(GetTriggerUnit())==800 or GetHeroLevel(GetTriggerUnit())==1000 then
        set jn[20*GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+20]=jn[20*GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+20]+1
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,20,"你获得斗魂技能 :"+GetObjectName(jn[jn[20*GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+20]]))
        call SetPlayerAbilityAvailable(GetTriggerPlayer(),jn[jn[20*GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+20]],true)//获得一个天赋点
        call SaveBoolean(udg_hs,GetHandleId(GetTriggerPlayer()),jn[20*GetPlayerId(GetTriggerPlayer())+jn[20*GetPlayerId(GetOwningPlayer(GetTriggerUnit()))+20]],true)//开启该技能
        call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,false)//禁用下一页
        call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,true)//启用下一页
    endif

    if GetUnitTypeId(GetTriggerUnit())=='HA05' and ( GetHeroLevel(GetTriggerUnit())==300 or GetHeroLevel(GetTriggerUnit())==600 or GetHeroLevel(GetTriggerUnit())==900) then
        call IncUnitAbilityLevel(GetTriggerUnit(),'A00T')
    endif

    if GetUnitTypeId(GetTriggerUnit())=='HA08' and ( GetHeroLevel(GetTriggerUnit())==300 or GetHeroLevel(GetTriggerUnit())==600 or GetHeroLevel(GetTriggerUnit())==900) then
        call IncUnitAbilityLevel(GetTriggerUnit(),'A00Z')
    endif



endfunction

function lvup takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function lvup1)
    call SaveTriggerHandle(udg_hs,0,300,tr)
    set tr=null
endfunction

endlibrary
