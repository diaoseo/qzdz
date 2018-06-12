library libskill requires libcf




function skill_1 takes nothing returns nothing
    local unit u=GetTriggerUnit()
    local integer bl=GetHeroStr(u,false)
    local integer bm=GetHeroAgi(u,false)
    local integer bz=GetHeroInt(u,false)
    local integer ql=GetHeroStr(u,true)
    local integer qm=GetHeroAgi(u,true)
    local integer qz=GetHeroInt(u,true)
    local player p1=GetOwningPlayer(u)
    local integer ll=ql-bl
    local integer lm=qm-bm
    local integer lz=qz-bz
    local integer array li
    local group g
    local unit u1
    local unit u2
    local unit u3
    local real x
    local real y
    local real array f
    local real s//伤害
    set s=ql+qm+qz
    if GetSpellAbilityId()=='A00I' then//骑士之志
        set g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",GetUnitX(u2),GetUnitY(u2)))//创建特效
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A00K' then//雷神领域
        set u1=GetSpellTargetUnit()
        set g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        set u3=CreateUnit(p1,'n000',GetUnitX(u),GetUnitY(u),0)//创建马甲
        call UnitAddAbility(u3,'A01J')//添加技能
        call UnitApplyTimedLife(u3,'BHwe',1)//设置生命周期
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call IssueNeutralTargetOrderById(p1,u3,852095,u2)//扔锤子
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A00M' then//野蛮冲撞
        set x=GetUnitX(GetSpellTargetUnit())
        set y=GetUnitY(GetSpellTargetUnit())
        call libcf_cf(u,x,y,0.4,0.02,false,false)
        set g=CreateGroup()
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",GetUnitX(u2),GetUnitY(u2)))//创建特效
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif
    //无影手技能在此
    //破甲阵的触发就省下了

    if GetSpellAbilityId()=='A00V' then//绝对陷阱
        set u1=GetSpellTargetUnit()
        set g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        set u3=CreateUnit(p1,'n000',GetUnitX(u),GetUnitY(u),0)//创建马甲
        call UnitAddAbility(u3,'A01P')//添加技能
        call UnitApplyTimedLife(u3,'BHwe',1)//设置生命周期
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call IssueNeutralTargetOrderById(p1,u3,852106,u2)//扔网
                    if IsUnitType(u2,UNIT_TYPE_HERO) then
                        call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                    else
                        if GetRandomInt(1,100)<8 then
                            call SetUnitOwner(u2,p1,true)
                            call UnitApplyTimedLife(u2,'BHwe',120)
                        else
                            call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                        endif
                    endif
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A00Y' then//斗者怒吼
        set g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        set u3=CreateUnit(p1,'n000',GetUnitX(u),GetUnitY(u),0)//创建马甲
        call UnitAddAbility(u3,'A01Q')//添加技能
        call UnitApplyTimedLife(u3,'BHwe',1)//设置生命周期
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and false==IsUnitOwnedByPlayer(u2,Player(11)) then//选队友
                    call IssueNeutralTargetOrderById(p1,u3,852101,u2)//放嗜血术
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A010' then//削铁如泥
        set g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",GetUnitX(u2),GetUnitY(u2)))//创建特效
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A011' then
        set f[0]=GetUnitFacing(u)
        set f[1]=GetUnitX(u)
        set f[2]=GetUnitY(u)
        set li[0]=-4
        loop
            set x=GetUnitX(u) + 600*Cos((f[0]+15*li[0])*3.14159/180)
            set y=GetUnitY(u) + 600*Sin((f[0]+15*li[0])*3.14159/180)
            set u1=CreateUnit(p1,'n003',f[1],f[2],f[0]+15*li[0])
            call AddSpecialEffectTarget("Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl",u1,"sprite")
            call UnitApplyTimedLife(u1,'BHwe',0.5)
            call libcf_cf(u1,x,y,0.5,0.025,false,false)
            exitwhen li[0]==4
            set li[0]=li[0]+1
        endloop
    endif

    set g=null
    set u=null
    set u1=null
    set u2=null
    set u3=null
    set p1=null
endfunction



function skill_jzxj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),StringHash("英雄"))
    local integer bl=GetHeroStr(u,false)
    local integer bm=GetHeroAgi(u,false)
    local integer bz=GetHeroInt(u,false)
    local integer ql=GetHeroStr(u,true)
    local integer qm=GetHeroAgi(u,true)
    local integer qz=GetHeroInt(u,true)
    local player p1=GetOwningPlayer(u)
    local integer ll=ql-bl
    local integer lm=qm-bm
    local integer lz=qz-bz
    local group g=CreateGroup()
    local unit u2
    local real x=GetUnitX(GetTriggerUnit())
    local real y=GetUnitY(GetTriggerUnit())
    local real s//伤害
    set s=ql+qm+qz
    call GroupEnumUnitsInRange(g,x,y,600,null)
    loop
        set u2=FirstOfGroup(g)
        exitwhen u2==null
            if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",GetUnitX(u2),GetUnitY(u2)))
                call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )
            endif
            call GroupRemoveUnit(g,u2)
    endloop
    call DestroyGroup(g)
    call DestroyTrigger(GetTriggeringTrigger())
    set g=null
    set u=null
    set u2=null
    set p1=null
endfunction

function skill_jzxj takes nothing returns nothing//召唤出的单位注册死亡事件
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function skill_jzxj_1)
    call TriggerRegisterUnitEvent(tr,GetSummonedUnit(),EVENT_UNIT_DEATH)
    set tr=null
endfunction

function skill takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr,function skill_1)
    call SaveTriggerHandle(udg_hs,0,99,tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function skill_jzxj)
    call SaveTriggerHandle(udg_hs,0,101,tr)
    set tr=null
endfunction

endlibrary
