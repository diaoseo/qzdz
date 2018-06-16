
library libsywp


function sywp_1 takes nothing returns nothing
    local unit u1=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),StringHash("英雄"))
    local unit u2=GetTriggerUnit()
    local item litem =GetManipulatedItem()
    local integer array li
    local real array r
    set li[0]=GetItemTypeId(litem)
    if li[0]== 'IB2Y' then//一级回复药
        set r[0]=GetUnitState(u1,UNIT_STATE_LIFE)
        if r[0]>0.405 then
            call SetUnitState(u1,UNIT_STATE_LIFE,r[0]+5000)
        endif
    endif
    if li[0]== 'IB2Z' then//二级回复药
        set r[0]=GetUnitState(u1,UNIT_STATE_LIFE)
        if r[0]>0.405 then
            call SetUnitState(u1,UNIT_STATE_LIFE,r[0]+20000)
        endif
    endif
    if li[0]== 'IB30' then//三级回复药
        set r[0]=GetUnitState(u1,UNIT_STATE_LIFE)
        if r[0]>0.405 then
            call SetUnitState(u1,UNIT_STATE_LIFE,r[0]+100000)
        endif
    endif
    if li[0]== 'IB31' then//四级回复药
        set r[0]=GetUnitState(u1,UNIT_STATE_LIFE)
        set r[1]=GetUnitState(u1,UNIT_STATE_MAX_LIFE)
        if r[0]>0.405 then
            call SetUnitState(u1,UNIT_STATE_LIFE,r[0]+r[1]/2)
        endif
    endif
    if li[0]== 'IB41' then//蜘蛛之血
        if u2==u1 then
            set li[0]=0
            set li[1]=GetHandleId(GetOwningPlayer(u1))
            loop
                set li[0]=li[0]+1
                if HaveSavedHandle(udg_hs,li[1],li[0]) then//检测是否绑定有物品
                    set litem=LoadItemHandle(udg_hs,li[1],li[0])//读取绑定的物品
                    set li[9]=GetHandleId(litem)//读取绑定物品的handle
                    set li[11]=LoadInteger(udg_hs,25,GetItemTypeId(litem))//读取升级对应的等级
                    if li[11]>5 and li[11]<=10 then
                        set li[10]=LoadInteger(udg_hs,li[9],GetItemLevel(litem))+30//读取经验和经验+30
                        set li[12]=LoadInteger(udg_hs,GetItemTypeId(litem),2)//读取升级等级对应的强化石
                        set li[13]=(li[11]+4)/5//设置升级所需经验
                        call BJDebugMsg(I2S(li[10])+"   "+I2S(li[13]*100))
                        if li[10]>=li[13]*100 then//判断升级经验是否足够
                            if ModuloInteger(li[11],5)!=0 then//判断是否需要材料
                                call UnitAddItem(u1,CreateItem(li[12],GetUnitX(u1),GetUnitY(u1)))//给予强化石
                            endif
                        else//经验不足
                            call SaveInteger(udg_hs,li[9],GetItemLevel(litem),li[10])//记录经验
                            //此处应显示经验给玩家
                        endif
                    endif
                endif
                exitwhen li[0]==2
            endloop
        endif
    endif

    if li[0]== 'IB40' then//蛇龙之胆
        if u2==u1 then
            set li[0]=0
            set li[1]=GetHandleId(GetOwningPlayer(u1))
            loop
                set li[0]=li[0]+1
                if HaveSavedHandle(udg_hs,li[1],li[0]) then//检测是否绑定有物品
                    set litem=LoadItemHandle(udg_hs,li[1],li[0])//读取绑定的物品
                    set li[9]=GetHandleId(litem)//读取绑定物品的handle
                    set li[11]=LoadInteger(udg_hs,25,GetItemTypeId(litem))//读取升级对应的等级
                    if li[11]>10 and li[11]<=15 then
                        set li[10]=LoadInteger(udg_hs,li[9],GetItemLevel(litem))+30//读取经验和经验+30
                        set li[12]=LoadInteger(udg_hs,GetItemTypeId(litem),2)//读取升级等级对应的强化石
                        set li[13]=(li[11]+4)/5//设置升级所需经验
                        call BJDebugMsg(I2S(li[10])+"   "+I2S(li[13]*100))
                        if li[10]>=li[13]*100 then//判断升级经验是否足够
                            if ModuloInteger(li[11],5)!=0 then//判断是否需要材料
                                call UnitAddItem(u1,CreateItem(li[12],GetUnitX(u1),GetUnitY(u1)))//给予强化石
                            endif
                        else//经验不足
                            call SaveInteger(udg_hs,li[9],GetItemLevel(litem),li[10])//记录经验
                            //此处应显示经验给玩家
                        endif
                    endif
                endif
                exitwhen li[0]==2
            endloop
        endif
    endif
    
    set litem=null
    set u1=null
    set u2=null
endfunction


function sywp takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function sywp_1)
    call TriggerRegisterPlayerUnitEvent(tr,Player(0),EVENT_PLAYER_UNIT_USE_ITEM,null)
    call TriggerRegisterPlayerUnitEvent(tr,Player(1),EVENT_PLAYER_UNIT_USE_ITEM,null)
    call TriggerRegisterPlayerUnitEvent(tr,Player(2),EVENT_PLAYER_UNIT_USE_ITEM,null)
    call TriggerRegisterPlayerUnitEvent(tr,Player(3),EVENT_PLAYER_UNIT_USE_ITEM,null)
    call TriggerRegisterPlayerUnitEvent(tr,Player(4),EVENT_PLAYER_UNIT_USE_ITEM,null)
    call TriggerRegisterPlayerUnitEvent(tr,Player(5),EVENT_PLAYER_UNIT_USE_ITEM,null)
    set tr=null
endfunction

endlibrary
