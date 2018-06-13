
library libskill requires libcf



function timer_smjq takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer i0=GetHandleId(t)
    local integer i1=LoadInteger(udg_hs,i0,0)
    local integer i2=0
    loop
        set i2=i2+1
        call DestroyLightning(LoadLightningHandle(udg_hs,i0,i2))
        exitwhen i2==i1
    endloop
    call FlushChildHashtable(udg_hs,i0)
    call DestroyTimer(t)
    set t=null
endfunction



function timerhyy takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer i1=GetHandleId(t)
    local integer i2=LoadInteger(udg_hs,i1,1)
    local unit u1=LoadUnitHandle(udg_hs,i1,0)
    local real s=LoadReal(udg_hs,i1,2)
    local unit u2
    local integer i3=LoadInteger(udg_hs,i1,3)
    local group g
    local unit u3=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(u1)),StringHash("英雄"))
    if i3==i2 then
        call FlushChildHashtable(udg_hs,i1)
        call DestroyTimer(GetExpiredTimer())
    else
        set g=CreateGroup()
        call GroupEnumUnitsInRange(g,GetUnitX(u1),GetUnitY(u1),600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call UnitDamageTarget(u3,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)

    set i3=i3+1
    call SaveInteger(udg_hs,i1,3,i3)
    endif
    set u3=null
    set g=null
    set u2=null
    set u1=null
    set t=null
endfunction


function timer_2 takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer array li
    local unit u
    local group g1
    local group g2
    local unit u1
    local unit u2
    local unit u3
    local real s
    set li[0]=GetHandleId(t)
    set li[1]=LoadInteger(udg_hs,li[0],2)
    set g2=LoadGroupHandle(udg_hs,li[0],1)
    set u=LoadUnitHandle(udg_hs,li[0],0)
    set li[3]=LoadInteger(udg_hs,li[0],3)
    if li[3]==li[1] then
        set s=LoadReal(udg_hs,li[0],11)
        set u3=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(u)),StringHash("英雄"))
        loop
            set u2=FirstOfGroup(g2)
            exitwhen u2==null
            call libcf_cf1(u2,u)
            call BJDebugMsg(GetUnitName(u)+"     "+GetUnitName(u2))
            call UnitDamageTarget(u3,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
            call GroupRemoveUnit(g2,u2)
        endloop
        call DestroyEffect(LoadEffectHandle(udg_hs,li[0],10))
        call DestroyGroup(g2)
        call FlushChildHashtable(udg_hs,li[0])
        call DestroyTimer(t)
    else
        set g1=CreateGroup()
        call GroupEnumUnitsInRange(g1,GetUnitX(u),GetUnitY(u),600,null)
        loop
            set u2=FirstOfGroup(g1)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call GroupAddUnit(g2,u2)
                    
                endif
                call GroupRemoveUnit(g1,u2)
        endloop
        call DestroyGroup(g1)
    
    endif
    call SaveInteger(udg_hs,li[0],3,li[3]+1)

    set t=null
    set u=null
    set g1=null
    set u2=null
    set g2=null
    set u3=null
endfunction



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
    local timer t
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

    if GetSpellAbilityId()=='A011' then//箭雨突袭
        set t=CreateTimer()
        set li[0]=GetHandleId(t)
        call SaveReal(udg_hs,li[0],1,GetSpellTargetX())
        call SaveReal(udg_hs,li[0],2,GetSpellTargetY())
        call SaveInteger(udg_hs,li[0],4,3)
        call SaveReal(udg_hs,li[0],5,s/3)
        call SaveUnitHandle(udg_hs,li[0],0,u)
        call TimerStart(t,0.2,true,function libcf_cftimer_1)
    endif

    if GetSpellAbilityId()=='A013' then//幻影斩？
        set f[1]=GetUnitX(GetSpellTargetUnit())
        set f[2]=GetUnitY(GetSpellTargetUnit())
        call SaveInteger(udg_hs,0,105,1)//1是斧王
        call libcf_cf(u,f[1],f[2],0.5,0.025,true,true)
        call UnitDamageTarget(u,GetSpellTargetUnit(),s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
        call BJDebugMsg(R2S(s))
    endif

    if GetSpellAbilityId()=='A019' then//幻影斩？
        set f[1]=GetUnitX(GetSpellTargetUnit())
        set f[2]=GetUnitY(GetSpellTargetUnit())
        call SaveInteger(udg_hs,0,105,0)//黑贞德
        call libcf_cf(u,f[1],f[2],0.5,0.025,true,true)
        call UnitDamageTarget(u,GetSpellTargetUnit(),s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
        call BJDebugMsg(R2S(s))
    endif


    if GetSpellAbilityId()=='A01A' then//狂风不止
        set f[1]=GetSpellTargetX()
        set f[2]=GetSpellTargetY()
        //set f[0]=(180/3.14159)*Atan2(f[2]-GetUnitY(u),f[1]-GetUnitX(u))
        set u3=CreateUnit(p1,'n006',GetUnitX(u),GetUnitY(u),GetUnitFacing(u))
        call UnitApplyTimedLife(u3,'BHwe',1)//设置生命周期
        call libcf_cf(u3,f[1],f[2],0.5,0.025,false,false)
        set t=CreateTimer()
        call SaveEffectHandle(udg_hs,GetHandleId(t),10,AddSpecialEffectTarget("Abilities\\Spells\\Other\\Tornado\\TornadoElemental.mdx",u3,"sprite"))//绑定特效到单位
        call SaveGroupHandle(udg_hs,GetHandleId(t),1,CreateGroup())
        call SaveInteger(udg_hs,GetHandleId(t),2,R2I(0.5/0.025))
        call SaveUnitHandle(udg_hs,GetHandleId(t),0,u3)
        call SaveReal(udg_hs,GetHandleId(t),11,s)
        call TimerStart(t,0.025,true,function timer_2)
    
    endif


    if GetSpellAbilityId()=='A017' then//EX咖喱棒
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

    if GetSpellAbilityId()=='A018' then//吸斩
        call libcf_cf2(GetSpellTargetUnit(),u)
        call UnitDamageTarget(u,GetSpellTargetUnit(),s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
    endif


    if GetSpellAbilityId()=='A015' then//火焰雨
        set g=CreateGroup()
        set x=GetSpellTargetX()
        set y=GetSpellTargetY()
        set u3=CreateUnit(p1,'n000',GetSpellTargetX(),GetSpellTargetY(),0)//创建马甲
        call UnitApplyTimedLife(u3,'BHwe',2.01)//设置生命周期
        set t=CreateTimer()
        call SaveUnitHandle(udg_hs,GetHandleId(t),0,u3)
        call SaveInteger(udg_hs,GetHandleId(t),1,10)
        call SaveReal(udg_hs,GetHandleId(t),2,s/10)
        call TimerStart(t,0.2,true,function timerhyy)
        //可在此处创建一个特效来继续伤害敌人
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call libcf_cf2(u2,u3)
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)

    endif


    if GetSpellAbilityId()=='A016' then//火焰光线
        set f[1]=GetUnitX(u)
        set f[2]=GetUnitY(u)
        set f[3]=GetSpellTargetX()
        set f[4]=GetSpellTargetY()
        set f[0]=Atan2(f[4]-f[2],f[3]-f[1])
        set li[0]=0
        set g=CreateGroup()
        loop
            exitwhen li[0]==9
            call BJDebugMsg("wtf")
            set u3=CreateUnit(p1,'n000',f[1]+100*li[0]*Cos(f[0]),f[2]+100*li[0]*Sin(f[0]),(180/3.14159)*f[0])
            call SetUnitScale(u3,2,2,0.5)
            call UnitApplyTimedLife(u3,'BHwe',2)//设置生命周期
            //call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\LiquidFire\\Liquidfire.mdl",u3,"sprite")
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl",u3,"sprite"))

            set f[5]=GetUnitX(u3)
            set f[6]=GetUnitY(u3)
            call GroupEnumUnitsInRange(g,f[5],f[6],200,null)
            loop
                set u2=FirstOfGroup(g)
                exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then//选敌人
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
            endloop
            set li[0]=li[0]+1
        endloop
        call DestroyGroup(g)
    endif


    if GetSpellAbilityId()=='A01B' then//剑之意志
        call UnitAddItem(u,CreateItem('I000',GetUnitX(u),GetUnitY(u)))
    endif

    if GetSpellAbilityId()=='A01D' then//冰雪王朝
        set g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(g,x,y,600,null)
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl",GetUnitX(u2),GetUnitY(u2)))//创建特效
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call DestroyGroup(g)
    endif

    if GetSpellAbilityId()=='A01F' then//生命汲取
        set g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        set t=CreateTimer()
        set li[0]=GetHandleId(t)
        call GroupEnumUnitsInRange(g,x,y,600,null)
        set f[1]=GetUnitX(u)
        set f[2]=GetUnitY(u)
        
        loop
            set u2=FirstOfGroup(g)
            exitwhen u2==null
                if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
                    set li[1]=li[1]+1
                    call SaveLightningHandle(udg_hs,li[0],li[1],AddLightning("DRAL",true,f[1],f[2],GetUnitX(u2),GetUnitY(u2)))
                    call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
                endif
                call GroupRemoveUnit(g,u2)
        endloop
        call SaveInteger(udg_hs,li[0],0,li[1])
        call DestroyGroup(g)
        if li[1]==0 then
        call FlushChildHashtable(udg_hs,li[0])
        else
        call TimerStart(t,0.5,false,function timer_smjq)
        endif
        //加血没写上，没想好加血的公式
        
    endif


    if GetSpellAbilityId()=='A01G' then//血流爆炸
        call SetUnitState(u,UNIT_STATE_LIFE,GetUnitState(u,UNIT_STATE_LIFE)*60*0.01)
    endif

    set g=null
    set u=null
    set u1=null
    set u2=null
    set u3=null
    set p1=null
    set t=null
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
