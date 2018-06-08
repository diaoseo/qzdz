library libfuhuo requires libgy

function fuhuo_2 takes nothing returns nothing
    //复活计时器
    local timer ti1=GetExpiredTimer()
    local unit lu1=LoadUnitHandle(udg_hs,H2I(ti1),StringHash("复活的英雄"))
    local real x=LoadReal(udg_hs,4,77)
    local real y=LoadReal(udg_hs,5,77)+128

    call ReviveHero(lu1,x,y,true)//复活
    call DestroyTimer(GetExpiredTimer())//删除到期的计时器
        if GetOwningPlayer(lu1)==GetLocalPlayer() then//异步
            call SetCameraPosition(x,y)//设置镜头
            call ClearSelection()//清除选择
            call SelectUnit(lu1,true)//选择英雄
        endif
    set ti1=null
    set lu1=null
endfunction

function fuhuo_1 takes nothing returns nothing
    //复活触发
    local timer lti
    set lti=CreateTimer()
    call TimerStart(lti,5,false,function fuhuo_2)
    call SaveUnitHandle(udg_hs,H2I(lti),StringHash("复活的英雄"),GetTriggerUnit())
    set lti=null
endfunction

function fuhuo takes nothing returns nothing
    local trigger tr
    set tr=CreateTrigger()
    //创建英雄死亡触发
    call SaveTriggerHandle(udg_hs,0,StringHash("复活英雄"),tr)
    call TriggerAddAction(tr,function fuhuo_1)
    set tr=null
endfunction

endlibrary
