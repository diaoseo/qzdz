
library libdeath

function death_1 takes nothing returns nothing
    local unit u1=GetKillingUnit()
    local unit u2=GetTriggerUnit()
    local player p1=GetOwningPlayer(u1)
    local integer array li
    local item it
    set li[0]=GetHandleId(u1)
    set li[1]=GetHandleId(p1)

    if HaveSavedHandle(udg_hs,li[1],1) then//检测是否绑定有物品
        set it=LoadItemHandle(udg_hs,li[1],1)//读取绑定的物品
        set li[9]=GetHandleId(it)//读取绑定物品的handle
        set li[10]=LoadInteger(udg_hs,li[9],GetItemLevel(it))+1//读取经验和经验+1
        set li[11]=LoadInteger(udg_hs,25,GetItemTypeId(it))//读取升级对应的等级
        set li[12]=LoadInteger(udg_hs,GetItemTypeId(it),2)//读取升级等级对应的强化石
        set li[13]=(li[11]+5)/5//设置升级所需经验
        if li[10]==li[13]*100 then//判断升级经验是否足够
            if ModuloInteger(li[11],5)!=5 then//判断是否需要材料
                call UnitAddItem(u1,CreateItem(li[12],GetUnitX(u1),GetUnitY(u1)))//给予强化石
            endif
        else//经验不足
            call SaveInteger(udg_hs,li[9],GetItemLevel(it),li[10])//记录经验
            call BJDebugMsg(I2S(li[10]))
        endif
    endif

    if HaveSavedHandle(udg_hs,li[1],2) then//检测是否绑定有物品
        set it=LoadItemHandle(udg_hs,li[1],2)//读取绑定的物品
        set li[19]=GetHandleId(it)//读取绑定物品的handle
        set li[20]=LoadInteger(udg_hs,li[19],GetItemLevel(it))+1//读取经验和经验+1
        set li[21]=LoadInteger(udg_hs,25,GetItemTypeId(it))//读取升级对应的等级
        set li[22]=LoadInteger(udg_hs,GetItemTypeId(it),2)//读取升级等级对应的强化石
        set li[23]=(li[21]+5)/5//设置升级所需经验
        if li[20]==li[23]*100 then//判断升级经验是否足够
            if ModuloInteger(li[21],5)!=5 then//判断是否需要材料
                call UnitAddItem(u1,CreateItem(li[22],GetUnitX(u1),GetUnitY(u1)))//给予强化石
            endif
        else//经验不足
            call SaveInteger(udg_hs,li[19],GetItemLevel(it),li[20])//记录经验
        endif
    endif

    set it=null
    set p1=null
    set u2=null
    set u1=null
endfunction

function death takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function death_1)
    call TriggerRegisterPlayerUnitEvent(tr,Player(11),EVENT_PLAYER_UNIT_DEATH,null)
    set tr=null
endfunction

endlibrary
