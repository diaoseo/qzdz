library libchoicelv requires libgy


function choicelv_1 takes nothing returns nothing
    local integer li=LoadInteger(udg_hs,0,H2I(GetClickedButton()))
    call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,msgys(" 选择了难度 "+I2S(li)))//发消息
    call SaveBoolean(udg_hs,0,1013,true)//确认已选择难度
    call SetPlayerTechResearched(Player(11),'RA00',li)//设置难度
    //在这里设置难度
    call MultiboardSetTitleText(multi,"当前难度 "+I2S(li))//标题
    call MultiboardDisplay(multi,true)//显示多面板
    //以下是启动出怪计时器
    call SaveTimerDialogHandle(udg_hs,0,1014,CreateTimerDialog(LoadTimerHandle(udg_hs,0,1015)))//保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs,0,1015),jsqjg,true,null)//启动出怪计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs,0,1014),true)//显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs,0,1014),"第"+I2S(b+1)+"波")//修改计时器窗口标题
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
    local integer xx
    local integer yy
    if li==1 then//第一个按钮
        if LoadBoolean(udg_hs,H2I(p1),1016) then//判断已开启回城
            call SaveBoolean(udg_hs,H2I(p1),1016,false)//关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs,H2I(p1),1017))//移除回城单位
        else
            call SaveBoolean(udg_hs,H2I(p1),1016,true)//开启一键回城
            set u1=CreateUnit(Player(15),'HB01',x,y,90)//创建回城单位
            call SaveUnitHandle(udg_hs,H2I(p1),1017,u1)//记录回城单位
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
        set x=LoadReal(udg_hs,GetHandleId(p1),1018)
        if x<100 then
            set x=x+10
            call SaveReal(udg_hs,GetHandleId(p1),1018,x)
        endif
        if GetLocalPlayer()==p1 then//国际惯例
            call SetMusicVolume(PercentToInt(x,127))
        endif 
    endif
    if li==5 then//第五个按钮
        set x=LoadReal(udg_hs,GetHandleId(p1),1018)
        if x>1 then
            set x=x-10
            call SaveReal(udg_hs,GetHandleId(p1),1018,x)
        endif
        if GetLocalPlayer()==p1 then//国际惯例
            call SetMusicVolume(PercentToInt(x,127))
        endif 
    endif

    if li==6 then//第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90荣誉系数 = "+R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90翅膀系数 = "+R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90转生系数 = "+R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90英雄系数 = "+R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90法强系数 = "+R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90斗者系数 = "+R2S(dx[xx]))
        if HaveSavedHandle(udg_hs,GetHandleId(p1),1) then
            call DisplayTimedTextToPlayer(p1,0,0,30,"|cff97ffff武器经验 = "+I2S(LoadInteger(udg_hs,GetHandleId(LoadItemHandle(udg_hs,GetHandleId(p1),1)),GetItemLevel(LoadItemHandle(udg_hs,GetHandleId(p1),1))))+" / "+I2S(((LoadInteger(udg_hs,25,GetItemTypeId(LoadItemHandle(udg_hs,GetHandleId(p1),1)))+4)/5)*100))
        endif
        if HaveSavedHandle(udg_hs,GetHandleId(p1),2) then
            call DisplayTimedTextToPlayer(p1,0,0,30,"|cff97ffff衣服经验 = "+I2S(LoadInteger(udg_hs,GetHandleId(LoadItemHandle(udg_hs,GetHandleId(p1),2)),GetItemLevel(LoadItemHandle(udg_hs,GetHandleId(p1),2))))+" / "+I2S(((LoadInteger(udg_hs,25,GetItemTypeId(LoadItemHandle(udg_hs,GetHandleId(p1),2)))+4)/5)*100))
        endif
        if HaveSavedHandle(udg_hs,GetHandleId(p1),3) then
            call DisplayTimedTextToPlayer(p1,0,0,30,"|cff97ffff护手经验 = "+I2S(LoadInteger(udg_hs,GetHandleId(LoadItemHandle(udg_hs,GetHandleId(p1),3)),GetItemLevel(LoadItemHandle(udg_hs,GetHandleId(p1),3))))+" / "+I2S(LoadInteger(udg_hs,25,GetItemTypeId(LoadItemHandle(udg_hs,GetHandleId(p1),3)))*100))
        endif
        call DisplayTimedTextToPlayer(p1,0,0,30,"|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif

    if li==7 then
        call DialogDisplay(p1,LoadDialogHandle(udg_hs,GetHandleId (p1),322),true)//显示选择翅膀对话框
    endif

    if li==8 then
        call DialogDisplay(p1,LoadDialogHandle(udg_hs,GetHandleId (p1),324),true)//显示选择称号对话框
    endif

    if li==9 then
        call DialogDisplay(p1,LoadDialogHandle(udg_hs,GetHandleId (p1),323),true)//显示选择称号对话框
    endif


    if li>10 and li<19 then
        set xx=li-10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs,GetHandleId(p1),1002)
            loop
                exitwhen yy==8
                set yy=yy+1
                call UnitRemoveAbility(u1,'AA3@'+yy)
            endloop
            call UnitAddAbility(u1,'AA3@'+xx)
            call BJDebugMsg(GetObjectName('AA3@'+xx))
        endif
    endif

    if li>24 and li<28 then
        set xx=li-24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs,GetHandleId(p1),1002)
            loop
                exitwhen yy==3
                set yy=yy+1
                call UnitRemoveAbility(u1,'AE0/'+yy)
            endloop
            call UnitAddAbility(u1,'AE0/'+xx)
            call BJDebugMsg(GetObjectName('AE0/'+xx))
        endif
    endif

    if li>30 and li<41 then
        set xx=li-30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs,GetHandleId(p1),1002)
            loop
                exitwhen yy==10
                set yy=yy+1
                call UnitRemoveAbility(u1,'AA4@'+yy)
            endloop
            call UnitAddAbility(u1,'AA4@'+xx)
            call BJDebugMsg(GetObjectName('AA3@'+xx))
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
