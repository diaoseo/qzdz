library libchoicelv requires libgy


function choicelv_1 takes nothing returns nothing
    local integer li=LoadInteger(udg_hs,0,H2I(GetClickedButton()))
    call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,msgys(" 选择了难度 "+I2S(li)))//发消息
    call SaveBoolean(udg_hs,0,StringHash("已选择难度"),true)//确认已选择难度
    call SetPlayerTechResearched(Player(11),'RA00',li)//设置难度
    //在这里设置难度
    //以下是启动出怪计时器
    call SaveTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口"),CreateTimerDialog(LoadTimerHandle(udg_hs,0,StringHash("出怪计时器"))))//保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs,0,StringHash("出怪计时器")),jsqjg,true,null)//启动出怪计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")),true)//显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")),"第"+I2S(b+1)+"波")//修改计时器窗口标题
    call DestroyTrigger(GetTriggeringTrigger())//删除触发
endfunction

<?
for x=1,6 do?>
function playcd_<?=tostring(x)?> takes nothing returns nothing//各个玩家的回调函数
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs,0,H2I(an))//获取点击的按钮
    local player p1=Player(<?=x-1?>)//设置循环的玩家
    local real x=LoadReal(udg_hs,4,77)//创建F3的坐标
    local real y=LoadReal(udg_hs,5,77)
    local unit u1
    if li==1 then//第一个按钮
        if LoadBoolean(udg_hs,H2I(p1),StringHash("开启回城")) then//判断已开启回城
            call SaveBoolean(udg_hs,H2I(p1),StringHash("开启回城"),false)//关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs,H2I(p1),StringHash("回城英雄")))//移除回城单位
        else
            call SaveBoolean(udg_hs,H2I(p1),StringHash("开启回城"),true)//开启一键回城
            set u1=CreateUnit(Player(15),'HB01',x,y,90)//创建回城单位
            call SaveUnitHandle(udg_hs,H2I(p1),StringHash("回城英雄"),u1)//记录回城单位
            call SetUnitOwner(u1,p1,true)//改变单位所属
            call SetUnitInvulnerable(u1,true)//设置无敌
            call SetUnitFlyHeight(u1,10000,0)//设置高度
            call SuspendHeroXP(u1,true)//禁止回城英雄获得经验
            if GetLocalPlayer()==p1 then
                call SetUnitFlyHeight(u1,0,0)//异步高度
            endif
            call UnitRemoveAbility(u1,'Amov')//删除移动技能
        endif
    endif

    if li==2 then//第二个按钮
        if GetLocalPlayer()==p1 then//本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET,GetCameraField(CAMERA_FIELD_ZOFFSET)+50,0)//镜头+50
        endif
    endif
    if li==3 then
        if GetLocalPlayer()==p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET,GetCameraField(CAMERA_FIELD_ZOFFSET)-50,0)
        endif
    endif
    if li==4 then//第四个按钮
        set x=LoadReal(udg_hs,GetHandleId(p1),StringHash("音量"))
        if x<100 then
            set x=x+10
            call SaveReal(udg_hs,GetHandleId(p1),StringHash("音量"),x)
        endif
        if GetLocalPlayer()==p1 then//国际惯例
            call SetMusicVolume(PercentToInt(x,127))
        endif 
    endif
    if li==5 then//第五个按钮
        set x=LoadReal(udg_hs,GetHandleId(p1),StringHash("音量"))
        if x>1 then
            set x=x-10
            call SaveReal(udg_hs,GetHandleId(p1),StringHash("音量"),x)
        endif
        if GetLocalPlayer()==p1 then//国际惯例
            call SetMusicVolume(PercentToInt(x,127))
        endif 
    endif
    set an=null
    set p1=null
    set u1=null
endfunction
<?end?>

function choicelv takes nothing returns nothing
    local trigger tr=CreateTrigger()
    local integer li=0
    call TriggerAddAction(tr,function choicelv_1)
    call SaveTriggerHandle(udg_hs,0,StringHash("对话框"),tr)
    <?for x=1,6 do?>
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function playcd_<?=tostring(x)?>)
    call SaveTriggerHandle(udg_hs,0,StringHash(I2S(<?=x?>)+"对话框"),tr)
    <?end?>
    set tr=null
endfunction

endlibrary
