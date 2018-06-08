library libajidi requires libgy

function ajidi_3 takes nothing returns nothing
    //call CustomDefeatBJ(GetLocalPlayer(),msgys("失败！"))
endfunction

function ajidi_2 takes nothing returns nothing
    local timer t=CreateTimer()
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,msgys("你失败了，20秒后游戏结束"))
    call TimerStart(t,20,false,function ajidi_3)
    set t=null
endfunction

function ajidi_1 takes nothing returns nothing
    local real maxl=GetUnitState(GetTriggerUnit(),UNIT_STATE_MAX_LIFE)
    local real l=GetUnitState(GetTriggerUnit(),UNIT_STATE_LIFE)
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,msgys("基地被攻击了!!!，血量剩余百分比为： ")+R2S((l/maxl)*100))
endfunction

function ajidi takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function ajidi_1)
    call TriggerRegisterUnitEvent(tr,LoadUnitHandle(udg_hs,0,StringHash("基地")),EVENT_UNIT_ATTACKED)
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function ajidi_2)
    call TriggerRegisterUnitEvent(tr,LoadUnitHandle(udg_hs,0,StringHash("基地")),EVENT_UNIT_DEATH)
    set tr=null
endfunction

endlibrary