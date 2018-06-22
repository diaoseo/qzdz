
library libbgj


function bgj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetAttacker())),1002)
    local integer bl=GetHeroStr(u,false)
    local integer bm=GetHeroAgi(u,false)
    local integer bz=GetHeroInt(u,false)
    local integer ql=GetHeroStr(u,true)
    local integer qm=GetHeroAgi(u,true)
    local integer qz=GetHeroInt(u,true)
    local integer ll=ql-bl
    local integer lm=qm-bm
    local integer lz=qz-bz
    local group g=CreateGroup()
    local unit u1=GetTriggerUnit()
    local unit u2
    local real x=GetUnitX(u1)
    local real y=GetUnitY(u1)
    local real s//伤害
    local integer id=GetPlayerId(GetOwningPlayer(u))
    local integer ids=GetHandleId(GetOwningPlayer(u))
    local boolean bo
    //伤害系数在这里设置
    if IsUnitType(GetAttacker(),UNIT_TYPE_HERO) and GetRandomInt(1,100)>95 then
        set s= (ll+lm+lz)*0.4+(bl+bm+bz)*0.2
        set s=s*((vx[id]+zx[id]+cx[id]+yx[id]+fx[id])*100/GetHeroLevel(u) +dx[id])
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect(LoadStr(udg_hs,GetUnitTypeId(u),3),GetUnitX(u2),GetUnitY(u2)))
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetUnitTypeId(u)=='HA0D' and GetRandomInt(1,5)==1 then//黑贞德攻击几率加敏捷
        call SetHeroInt(u,bm+2,true)
    endif

    if HaveSavedBoolean(udg_hs,ids,'A00D') and IsUnitType(GetAttacker(),UNIT_TYPE_HERO)  then//冰冻天赋
        set u2=CreateUnit(GetOwningPlayer(u),'n000',GetUnitX(u),GetUnitY(u),0)
        call UnitAddAbility(u2,'A01X')//添加技能
        call UnitApplyTimedLife(u2,'BHwe',1)//设置生命周期
        call IssueNeutralTargetOrderById(GetOwningPlayer(u),u2,852075,u1)//放减速
    endif


    if HaveSavedBoolean(udg_hs,ids,'A00C') and IsUnitType(GetAttacker(),UNIT_TYPE_HERO)  then//火焰天赋
        set s= (ll+lm+lz)*0.4+(bl+bm+bz)*0.2
        set s=s*((vx[id]+zx[id]+cx[id]+yx[id]+fx[id])*100/GetHeroLevel(u) +dx[id])
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl",GetUnitX(u1),GetUnitY(u1)))
        call UnitDamageTarget(u,u1,s*0.1, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )
    endif


    if HaveSavedBoolean(udg_hs,ids,'A00E') and IsUnitType(GetAttacker(),UNIT_TYPE_HERO)  then//麻痹天赋
        set u2=CreateUnit(GetOwningPlayer(u),'n000',GetUnitX(u),GetUnitY(u),0)
        call UnitAddAbility(u2,'A01Y')//添加技能
        call UnitApplyTimedLife(u2,'BHwe',1)//设置生命周期
        call IssueNeutralTargetOrderById(GetOwningPlayer(u),u2,852190,u1)//放诅咒
    endif

    if HaveSavedBoolean(udg_hs,ids,210) and IsUnitType(GetAttacker(),UNIT_TYPE_HERO)  then
        set bo =LoadBoolean(udg_hs,ids,210)
        if bo then
            if GetRandomInt(1,10)==1 then
                call SetUnitState(u,UNIT_STATE_LIFE,GetUnitState(u,UNIT_STATE_LIFE)+GetUnitState(u,UNIT_STATE_MAX_LIFE)*0.1)
            endif
        else
            if GetRandomInt(1,10)==1 then
                set s= (ll+lm+lz)*0.4+(bl+bm+bz)*0.2
                set s=s*((vx[id]+zx[id]+cx[id]+yx[id]+fx[id])*100/GetHeroLevel(u) +dx[id])
                //可创建特效call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl",GetUnitX(u1),GetUnitY(u1)))
                call UnitDamageTarget(u,u1,s*8, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )
            endif
        endif
    endif



    if HaveSavedBoolean(udg_hs,ids,'A005') and IsUnitType(GetAttacker(),UNIT_TYPE_HERO) and GetRandomInt(1,10)==1 then//火焰天赋
        set s= (ll+lm+lz)*0.4+(bl+bm+bz)*0.2
        set s=s*((vx[id]+zx[id]+cx[id]+yx[id]+fx[id])*100/GetHeroLevel(u) +dx[id])
        set g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl",GetUnitX(u2),GetUnitY(u2)))//创建特效
                    call UnitDamageTarget(u,u2,s*0.5, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    set g=null
    set u=null
    set u1=null
    set u2=null
endfunction


function bgj takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function bgj_1)
    call TriggerRegisterPlayerUnitEvent(tr,Player(11),EVENT_PLAYER_UNIT_ATTACKED,null)
    set tr=null
endfunction

endlibrary
