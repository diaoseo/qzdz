
library libbgj


function bgj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetAttacker())),StringHash("英雄"))
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
