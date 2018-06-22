
library libsywp


function sywp_1 takes nothing returns nothing
    local unit u1=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),1002)
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
    if li[0]== 'IB39' then//暗淡的斗者意志
        set li[0]=GetPlayerId(GetOwningPlayer(u1))
        set kx[li[0]]=kx[li[0]]+100
        if ModuloInteger(kx[li[0]],1500)<=100 and dx[li[0]]-1<vx[li[0]]  then//1.5K的经验升级E技能，DX不能大于VX-1
            set dx[li[0]]=dx[li[0]]+0.1
        endif
    endif
    if li[0]== 'IB3A' then//绚丽的斗者意志
        set li[0]=GetPlayerId(GetOwningPlayer(u1))
        set kx[li[0]]=kx[li[0]]+500
        if ModuloInteger(kx[li[0]],1500)<=500 and dx[li[0]]-1<vx[li[0]]  then//1.5K的经验升级E技能，DX不能大于VX-1
            set dx[li[0]]=dx[li[0]]+0.1
        endif
    endif
    //开箱子，神器改成可以使用，可分解，宝器改为可分解
    if li[0]=='IB32' or li[0]=='IB33' or li[0]=='IB34' or li[0]=='IB35' or li[0]=='IB36' then
        set li[1]=li[0]-'IB31'
        set li[2]=GetRandomInt(1,20)
        if li[1]<4 then
            if li[2]<=12+li[1]*2 then
                set litem=CreateItem(GetRandomInt('IB2O','IB2W'),GetUnitX(u2),GetUnitY(u2))
                call UnitAddItem(u2,litem)
                call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
            endif
        else
            if li[1]==4 then
                if li[2]<=14 then
                    set litem=CreateItem(GetRandomInt('IB2O','IB2W'),GetUnitX(u2),GetUnitY(u2))
                    call UnitAddItem(u2,litem)
                    call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                else
                    if li[2]<=17 then
                        set li[3]='IBB0'
                        set li[4]='IBB3'
                        set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                        call UnitAddItem(u2,litem)
                        call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                    else
                        if li[2]<=19 then
                            set li[3]='IBB1'
                            set li[4]='IBB4'
                            set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                            call UnitAddItem(u2,litem)
                            call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                        else
                            set li[3]='IBB2'
                            set li[4]='IBB5'
                            set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                            call UnitAddItem(u2,litem)
                            call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                        endif
                    endif
                endif
            else
                if li[2]<=11 then
                    set litem=CreateItem(GetRandomInt('IB2O','IB2W'),GetUnitX(u2),GetUnitY(u2))
                    call UnitAddItem(u2,litem)
                    call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                else
                    if li[2]<=15 then
                        set li[3]='IBB0'
                        set li[4]='IBB3'
                        set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                        call UnitAddItem(u2,litem)
                        call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                    else
                        if li[2]<=18 then
                            set li[3]='IBB1'
                            set li[4]='IBB4'
                            set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                            call UnitAddItem(u2,litem)
                            call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                        else
                            set li[3]='IBB2'
                            set li[4]='IBB5'
                            set litem=CreateItem(li[GetRandomInt(3,4)],GetUnitX(u2),GetUnitY(u2))
                            call UnitAddItem(u2,litem)
                            call DisplayTextToPlayer(GetLocalPlayer(),0,0,"恭喜 "+GetPlayerName(GetOwningPlayer(u2))+" 在宝箱中获得 "+GetItemName(litem))
                        endif
                    endif
                endif
            endif
        endif
    endif
    if li[0]=='IBB0' or li[0]=='IBB1' or li[0]=='IBB2' then
        call UnitAddAbility(u1,li[0]+134024960)//添加技能
        call SetPlayerTechResearched(GetOwningPlayer(u1),li[0]+149815040,1)//添加科技
        call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,GetPlayerName(GetOwningPlayer(u1))+" 解锁了神器 "+GetObjectName(li[0]))
    endif
    if li[0]=='IBB3' or li[0]=='IBB4' or li[0]=='IBB5' then
        call UnitAddAbility(u1,li[0]+134024707)//添加技能
        call SetPlayerTechResearched(GetOwningPlayer(u1),li[0]+149815293,1)//添加科技
        call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,GetPlayerName(GetOwningPlayer(u1))+" 解锁了神器 "+GetObjectName(li[0]))
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
