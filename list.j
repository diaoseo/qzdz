library liblist requires libhg

function list_2 takes nothing returns nothing
    local player p1=LoadPlayerHandle(udg_hs,0,H2I(GetExpiredTimer()))
    call SaveBoolean(udg_hs,H2I(p1),StringHash("双击"),false)
    set p1=null
endfunction

function list_1 takes nothing returns nothing
    local unit u1=GetTriggerUnit()
    local integer li=GetUnitTypeId(u1)
    local player p1=GetOwningPlayer(u1)
    local boolean bool=LoadBoolean(udg_hs,H2I(p1),StringHash("双击"))
    local timer t1
    local dialog dhk=LoadDialogHandle(udg_hs,H2I(p1),StringHash("作弊对话框"))//读取对话框
    if li == 'HB00' then
        if bool then
            call SaveBoolean(udg_hs,H2I(p1),StringHash("双击"),false)//保存正在双击
            if GetLocalPlayer()==p1 then//异步
                call ClearSelection()
            endif
            call DialogDisplay(p1,dhk,true)//显示对话框
        else
            set t1=CreateTimer()//启动计时器
            call TimerStart(t1,0.5,false,function list_2)//设置计时器回调函数
            call SavePlayerHandle(udg_hs,0,H2I(t1),p1)//保存handle
            call SaveBoolean(udg_hs,H2I(p1),StringHash("双击"),true)///确认已单击
            if GetLocalPlayer()==p1 then//异步
                //call ClearSelection()//清空玩家选择，往后可能取消这个选项，作为宠物使用，条件也需要修改
            endif
        endif
    endif
    if li=='HB01' then
        call hg(LoadUnitHandle(udg_hs,H2I(p1),StringHash("英雄")))//回城函数
    endif
    set u1=null
    set p1=null
    set t1=null
endfunction

function list takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call SaveTriggerHandle(udg_hs,0,StringHash("菜单触发"),tr)
    call TriggerAddAction(tr,function list_1)
    set tr=null
endfunction

endlibrary
