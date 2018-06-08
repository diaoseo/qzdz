library libgetitem requires libmsg


function getitem_2 takes nothing returns nothing//宠物获得物品
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),StringHash("英雄"))//读取英雄
    local item litem=GetManipulatedItem()//获取被操作物品
    local integer ti = GetItemTypeId(litem)//获取被操作物品类型
    local integer lv=GetItemLevel(litem)//物品等级
    if GetItemType(litem)==ITEM_TYPE_POWERUP then//判断能量提升
        call UnitAddItem(u,litem)//转移物品
    endif
    set litem=null
endfunction

function getitem_1 takes nothing returns nothing//英雄获得物品
    local item litem=GetManipulatedItem()//获取被操作物品
    local integer ti = GetItemTypeId(litem)//获取被操作物品类型
    local integer ti1=LoadInteger(udg_hs,10,ti)//读取坐标
    local real x = LoadReal(udg_hs,4,ti1)//坐标X
    local real y = LoadReal(udg_hs,5,ti1)//坐标Y
    local real face = LoadReal(udg_hs,6,ti1)//坐标面向角度
    local unit u1 = GetTriggerUnit()//触发单位
    local integer lv=GetItemLevel(litem)//物品等级
    local integer array li

    if GetItemType(litem)==ITEM_TYPE_POWERUP then//判断能量提升
        if lv==1 then//判断等级开启传送
            call SetUnitPosition(u1,x,y)//传送
            call SetUnitFacing(u1,face)//设置面向角度
            if GetOwningPlayer(GetTriggerUnit())==GetLocalPlayer() then//异步
                call SetCameraPosition(x,y)
                call ClearSelection()
                call SelectUnit(GetTriggerUnit(),true)
            endif
            call RemoveItem(litem)//能量提升直排
            set u1=null
            set litem=null
            return//退出
        endif
        if lv==2 then//判断等级强化
            set li[0]=0//初始化循环
            set li[1]=LoadInteger(udg_hs,22,ti)//读取强化书等级
            set li[2]=LoadInteger(udg_hs,ti,100)//读取强化书对应武器类型
            set li[3]=LoadInteger(udg_hs,ti,101)//读取强化书对应衣服类型
            loop//遍历物品栏
                exitwhen li[0]==5
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[2] or GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[3] then//判断有无对应武器或衣服
                    set li[4]=GetItemTypeId(UnitItemInSlot(u1,li[0]))//读取对应装备
                    call RemoveItem(UnitItemInSlot(u1,li[0]))//删除旧装备
                    set litem=CreateItem(LoadInteger(udg_hs,21,li[4]),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))
                    call UnitAddItem(u1,litem)//创建新装备
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备已升级成"+GetItemName(litem))
                    set litem=null
                    set u1=null
                    call RemoveItem(GetManipulatedItem())//能量提升直排
                    return//退出
                endif
                set li[0]=li[0]+1
            endloop
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备强化失败，请检查你的装备")
            call RemoveItem(GetManipulatedItem())//能量提升直排
            set litem=null
            set u1=null
            return
        endif
        call RemoveItem(GetManipulatedItem())//能量提升直排
    endif

    if GetItemType(litem)==ITEM_TYPE_PERMANENT then//判断永久物品
        if lv>0 and lv<4 then//一级武器，二级衣服，三级圣兽物品
            set li[0]=0
            loop
                exitwhen li[0]==5
                if GetItemLevel(UnitItemInSlot(u1,li[0]))==lv and UnitItemInSlot(u1,li[0])!=litem then//只能携带一件同类装备
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"你身上已有同类物品")
                    call UnitRemoveItem(u1,litem)
                    set litem=null
                    set u1=null
                    return
                endif
                set li[0]=li[0]+1
           endloop
        endif
    endif


    set litem=null
    set u1=null
endfunction

function getitem takes nothing returns nothing
    local trigger tr =CreateTrigger()
    call TriggerAddAction(tr,function getitem_1)
    call SaveTriggerHandle(udg_hs,0,StringHash("获得物品触发"),tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function getitem_2)
    call SaveTriggerHandle(udg_hs,0,StringHash("宠物获得物品触发"),tr)
    set tr=null    
endfunction

endlibrary
