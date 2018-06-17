
library libdeath

function death_1 takes nothing returns nothing
    local unit u1=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetKillingUnit())),StringHash("英雄"))
    local unit u2=GetTriggerUnit()
    local player p1=GetOwningPlayer(u1)
    local integer array li
    local item it
    local unit u3
    local integer bl=GetHeroStr(u1,false)
    local integer bm=GetHeroAgi(u1,false)
    local integer bz=GetHeroInt(u1,false)
    local integer ql=GetHeroStr(u1,true)
    local integer qm=GetHeroAgi(u1,true)
    local integer qz=GetHeroInt(u1,true)
    local integer ll=ql-bl
    local integer lm=qm-bm
    local integer lz=qz-bz
    local group g
    local real x
    local real y
    local real s//伤害

    set s=ql+qm+qz
    set li[0]=GetHandleId(u1)
    set li[1]=GetHandleId(p1)

    if HaveSavedHandle(udg_hs,li[1],1) then//检测是否绑定有物品
        set it=LoadItemHandle(udg_hs,li[1],1)//读取绑定的物品
        set li[9]=GetHandleId(it)//读取绑定物品的handle
        set li[10]=LoadInteger(udg_hs,li[9],GetItemLevel(it))+1//读取经验和经验+1
        set li[11]=LoadInteger(udg_hs,25,GetItemTypeId(it))//读取升级对应的等级
        set li[12]=LoadInteger(udg_hs,GetItemTypeId(it),2)//读取升级等级对应的强化石
        set li[13]=(li[11]+4)/5//设置升级所需经验
        if li[10]>=li[13]*100 then//判断升级经验是否足够
            if ModuloInteger(li[11],5)!=0 then//判断是否需要材料
                call UnitAddItem(u1,CreateItem(li[12],GetUnitX(u1),GetUnitY(u1)))//给予强化石
            endif
        else//经验不足
            call SaveInteger(udg_hs,li[9],GetItemLevel(it),li[10])//记录经验
            //此处应显示经验给玩家
        endif
    endif

    if HaveSavedHandle(udg_hs,li[1],2) then//检测是否绑定有物品
        set it=LoadItemHandle(udg_hs,li[1],2)//读取绑定的物品
        set li[19]=GetHandleId(it)//读取绑定物品的handle
        set li[20]=LoadInteger(udg_hs,li[19],GetItemLevel(it))+1//读取经验和经验+1
        set li[21]=LoadInteger(udg_hs,25,GetItemTypeId(it))//读取升级对应的等级
        set li[22]=LoadInteger(udg_hs,GetItemTypeId(it),2)//读取升级等级对应的强化石
        set li[23]=(li[21]+4)/5//设置升级所需经验
        if li[20]>=li[23]*100 then//判断升级经验是否足够
            if ModuloInteger(li[21],5)!=0 then//判断是否需要材料
                call UnitAddItem(u1,CreateItem(li[22],GetUnitX(u1),GetUnitY(u1)))//给予强化石
            endif
        else//经验不足
            call SaveInteger(udg_hs,li[19],GetItemLevel(it),li[20])//记录经验
        endif
        call BJDebugMsg(I2S(li[20])+"衣服"+I2S(li[23]*100))
    endif

    if HaveSavedHandle(udg_hs,li[1],3) then//检测是否绑定有物品
        set it=LoadItemHandle(udg_hs,li[1],3)//读取绑定的物品
        set li[29]=GetHandleId(it)//读取绑定物品的handle
        set li[30]=LoadInteger(udg_hs,li[29],GetItemLevel(it))+1//读取经验和经验+1
        set li[31]=LoadInteger(udg_hs,25,GetItemTypeId(it))//读取升级对应的等级
        set li[32]=LoadInteger(udg_hs,GetItemTypeId(it),2)//读取升级等级对应的强化石
        set li[33]=li[31]//设置升级所需经验
        if li[30]>=li[33]*100 then//判断升级经验是否足够
            if ModuloInteger(li[31],5)!=0 then//判断是否需要材料
                call UnitAddItem(u1,CreateItem(li[32],GetUnitX(u1),GetUnitY(u1)))//给予强化石
            endif
        else//经验不足
            call SaveInteger(udg_hs,li[29],GetItemLevel(it),li[30])//记录经验
            call BJDebugMsg(I2S(li[30])+"手套"+I2S(li[33]*100))
        endif
    endif

    if GetUnitTypeId(u1)=='HA0G' then//检测是否魔术师凶手
        set g=CreateGroup()
        set x=GetUnitX(u2)
        set y=GetUnitY(u2)
        call GroupEnumUnitsInRange(g,x,y,200,null)
        loop
            set u3=FirstOfGroup(g)
            exitwhen u3==null
                if GetUnitState(u3,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u3,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl",GetUnitX(u3),GetUnitY(u3)))//创建特效
                    call UnitDamageTarget(u1,u3,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u3)
        endloop
        call DestroyGroup(g)
    endif
    if HaveSavedInteger(udg_hs,GetHandleId(u2),666) then//检测是否练功房单位
        set lgf[LoadInteger(udg_hs,GetHandleId(u2),666)+6]=lgf[LoadInteger(udg_hs,GetHandleId(u2),666)+6]-1
        call FlushChildHashtable(udg_hs,GetHandleId(u2))
        call RemoveUnit(u2)
    else
        if HaveSavedInteger(udg_hs,GetHandleId(u2),51) then
            set li[2]=LoadInteger(udg_hs,GetHandleId(u2),51)
            set zx[li[2]]=zx[li[2]]+0.1
            call BJDebugMsg("恭喜傻逼转生到 "+I2S(R2I((zx[li[2]]*10)+0.5 ) )+" 转")//调试时显示
            if HaveSavedInteger(udg_hs,GetHandleId(u2),52) then
                set li[3]=LoadInteger(udg_hs,GetHandleId(u2),52)
                //在此开启最终进阶动作
                call BJDebugMsg(I2S(li[3]))
                call RemoveSavedInteger(udg_hs,GetHandleId(u2),52)
            endif
            call RemoveSavedInteger(udg_hs,GetHandleId(u2),51)
            call RemoveSavedInteger(udg_hs,li[1],51)
        endif
    endif


    set u3=null
    set g=null
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
