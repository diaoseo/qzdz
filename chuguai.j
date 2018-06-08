library libchuguai

function zzbs takes nothing returns nothing
    local unit u=CreateUnit(Player(11),LoadInteger(udg_hs,13,6),LoadReal(udg_hs,1,77),LoadReal(udg_hs,2,77),LoadReal(udg_hs,3,77))
    call IssueNeutralPointOrderById(Player(11),u,851983,LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77))
    set u=null
endfunction


function cboss takes nothing returns nothing
    local unit u=CreateUnit(Player(11),LoadInteger(udg_hs,13,b/7),LoadReal(udg_hs,1,77),LoadReal(udg_hs,2,77),LoadReal(udg_hs,3,77))//创建进攻boss
    local trigger t
    call IssueNeutralPointOrderById(Player(11),u,851983,LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77))//发布命令
    if b/7==5 and GetPlayerTechCount(Player(11),'RA00',true)==5 then//判断难5
        set t=CreateTrigger()
        call TriggerAddAction(t,function zzbs)
        call TriggerRegisterUnitEvent(t,u,EVENT_UNIT_DEATH)
    endif
    set u=null
    set t=null
endfunction


function chuguai_1 takes nothing returns nothing
    //出怪计时器循环
    if b<35 then
        set b=b+1
        set g=3//出怪数量
        if ModuloInteger(b,7)==0 then
            call cboss() 
        endif
        call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")),"第"+I2S(b+1)+"波敌人来袭")//修改计时器窗口显示标题
    endif
    if b==35 then
        call DestroyTimerDialog(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")))//出怪完毕，删除计时器窗口
        call DestroyTimer(GetExpiredTimer())//删除计时器
    endif
endfunction

function chuguai takes nothing returns nothing
    local trigger tr = CreateTrigger()
    call TriggerRegisterTimerExpireEvent(tr,LoadTimerHandle(udg_hs,0,StringHash("出怪计时器")))
    call TriggerAddAction(tr,function chuguai_1)
    //出怪计时器
    set tr = null
endfunction

endlibrary
