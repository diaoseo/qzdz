library libyg requires libmsg

function bossfh takes nothing returns nothing//副本复活触发
    local integer li=LoadInteger(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("复活boss"))//获取死亡的单位类型
    local trigger t=LoadTriggerHandle(udg_hs,GetHandleId(GetExpiredTimer()),0)
    local integer zb=LoadInteger(udg_hs,11,li)//获取死亡的坐标
    local real x=LoadReal(udg_hs,1,zb)
    local real y=LoadReal(udg_hs,2,zb)
    local real f=LoadReal(udg_hs,3,zb)
    local unit u1=CreateUnit(Player(11),li,x,y,f)//创建单位
    call RemoveUnit(LoadUnitHandle(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("单位")))//移除死亡单位
    call TriggerRegisterUnitEvent(t,u1,EVENT_UNIT_DEATH)//添加事件到触发器
    call FlushChildHashtable(udg_hs,GetHandleId(GetExpiredTimer()))//清除哈希表
    call DestroyTimer(GetExpiredTimer())//清除计时器

    set u1=null
    set t=null
endfunction

function yg takes nothing returns nothing//副本死亡触发
    local timer t=CreateTimer()//新建计时器
    local trigger tr=CreateTrigger()//创建新触发
    local integer li
    if HaveSavedInteger(udg_hs,GetUnitTypeId(GetTriggerUnit()),1000) then
        set li=LoadInteger(udg_hs,GetUnitTypeId(GetTriggerUnit()),1000)
        call CreateItem(LoadInteger(udg_hs,GetUnitTypeId(GetTriggerUnit()),GetRandomInt(1,li)),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))
    endif
    call TriggerAddAction(tr,function yg)//新触发添加动作
    call DestroyTrigger(GetTriggeringTrigger())//删除触发触发
    call SaveInteger(udg_hs,GetHandleId(t),StringHash("复活boss"),GetUnitTypeId(GetTriggerUnit()))//保存死亡的类型
    call SaveUnitHandle(udg_hs,GetHandleId(t),StringHash("单位"),GetTriggerUnit())//保存死亡的单位
    call TimerStart(t,10,false,function bossfh)//启动计时器
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,msg(1)+GetUnitName(GetTriggerUnit())+"已被击杀，10秒后复活")//发消息
    call SaveTriggerHandle(udg_hs,GetHandleId(t),0,tr)//保存触发器
    set t=null
    set tr=null
endfunction

function xgfh takes nothing returns nothing
    local integer li=LoadInteger(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("复活boss"))//获取死亡的单位类型
    local trigger t=LoadTriggerHandle(udg_hs,GetHandleId(GetExpiredTimer()),0)//读取触发器
    local integer zb=LoadInteger(udg_hs,11,li)//获取死亡的坐标
    local real x=LoadReal(udg_hs,1,zb)
    local real y=LoadReal(udg_hs,2,zb)
    local unit u1=CreateUnit(Player(11),li,x+GetRandomReal(-640,640),y+GetRandomReal(-640,640),GetRandomReal(0,360))//创建单位
    call RemoveUnit(LoadUnitHandle(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("单位")))//移除死亡单位
    call TriggerRegisterUnitEvent(t,u1,EVENT_UNIT_DEATH)//添加事件到触发器
    call FlushChildHashtable(udg_hs,GetHandleId(GetExpiredTimer()))//清除哈希表
    call DestroyTimer(GetExpiredTimer())//清除计时器
    set u1=null
    set t=null
endfunction


function xg takes nothing returns nothing//小怪死亡触发
    local timer t=CreateTimer()//新建计时器
    local trigger tr=CreateTrigger()//创建新触发
    call DestroyTrigger(GetTriggeringTrigger())//删除触发触发
    call SaveInteger(udg_hs,GetHandleId(t),StringHash("复活boss"),GetUnitTypeId(GetTriggerUnit()))//保存死亡的类型
    call SaveUnitHandle(udg_hs,GetHandleId(t),StringHash("单位"),GetTriggerUnit())//保存死亡的单位
    call TimerStart(t,10,false,function xgfh)//启动计时器
    call TriggerAddAction(tr,function xg)//新触发添加动作
    call SaveTriggerHandle(udg_hs,GetHandleId(t),0,tr)//保存触发器
    set t=null
    set tr=null
endfunction

/*
function zs_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("转生"))//读取死亡单位
    local player p=LoadPlayerHandle(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("玩家"))//读取所属玩家
    local integer i1=LoadInteger(udg_hs,GetHandleId(p),StringHash("进阶场"))//读取坐标
    local integer i=GetUnitTypeId(u)//读取死亡类型
    local real x=LoadReal(udg_hs,1,i1)
    local real y=LoadReal(udg_hs,2,i1)
    local real f=LoadReal(udg_hs,3,i1)
    local trigger t=LoadTriggerHandle(udg_hs,GetHandleId(GetExpiredTimer()),StringHash("触发"))
    call BJDebugMsg(I2S(i))
    call BJDebugMsg(I2S('UB15'))
    if i<'UB15' then//判断是有下一转
        set u =CreateUnit(Player(11),i+1,x,y,f)//创建下一转
        call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)//注册触发
        //在此处增加隐藏
    else
    endif
    call FlushChildHashtable(udg_hs,GetHandleId(GetExpiredTimer()))//清除哈希表
    call DestroyTimer(GetExpiredTimer())//清除计时器
    call RemoveUnit(u)//移除死亡单位
    set u=null
    set p=null
    set t=null
endfunction


function zs takes nothing returns nothing//转生触发
    local timer t=CreateTimer()
    local integer i =GetUnitTypeId(GetTriggerUnit())//获取触发单位类型
    local trigger tr=GetTriggeringTrigger()//获取触发
    call DestroyTrigger(tr)//删除触发
    call SaveUnitHandle(udg_hs,GetHandleId(t),StringHash("转生"),GetTriggerUnit())//保存死亡单位
    call SavePlayerHandle(udg_hs,GetHandleId(t),StringHash("玩家"),GetOwningPlayer(GetKillingUnit()))//保存玩家
    set tr=CreateTrigger()//新建触发
    call TriggerAddAction(tr,function zs)//添加动作
    call SaveTriggerHandle(udg_hs,GetHandleId(t),StringHash("触发"),tr)//保存触发
    call TimerStart(t,10,false,function zs_1)
    call BJDebugMsg("6666")
    set t=null
    set tr=null
endfunction
*/

endlibrary