globals
//globals from libbgj:
constant boolean LIBRARY_libbgj=true
//endglobals from libbgj
//globals from libcf:
constant boolean LIBRARY_libcf=true
hashtable libcf__z_h=InitHashtable()
//endglobals from libcf
//globals from libchuguai:
constant boolean LIBRARY_libchuguai=true
//endglobals from libchuguai
//globals from libdeath:
constant boolean LIBRARY_libdeath=true
//endglobals from libdeath
//globals from libdmb:
constant boolean LIBRARY_libdmb=true
//endglobals from libdmb
//globals from libgy:
constant boolean LIBRARY_libgy=true
//endglobals from libgy
//globals from libhg:
constant boolean LIBRARY_libhg=true
//endglobals from libhg
//globals from libkj:
constant boolean LIBRARY_libkj=true
//endglobals from libkj
//globals from liblvup:
constant boolean LIBRARY_liblvup=true
//endglobals from liblvup
//globals from libmsg:
constant boolean LIBRARY_libmsg=true
//endglobals from libmsg
//globals from libsywp:
constant boolean LIBRARY_libsywp=true
//endglobals from libsywp
//globals from libtf:
constant boolean LIBRARY_libtf=true
//endglobals from libtf
//globals from libajidi:
constant boolean LIBRARY_libajidi=true
//endglobals from libajidi
//globals from libchoicelv:
constant boolean LIBRARY_libchoicelv=true
//endglobals from libchoicelv
//globals from libfuhuo:
constant boolean LIBRARY_libfuhuo=true
//endglobals from libfuhuo
//globals from libgetitem:
constant boolean LIBRARY_libgetitem=true
//endglobals from libgetitem
//globals from libinput:
constant boolean LIBRARY_libinput=true
//endglobals from libinput
//globals from liblist:
constant boolean LIBRARY_liblist=true
//endglobals from liblist
//globals from libselecthero:
constant boolean LIBRARY_libselecthero=true
//endglobals from libselecthero
//globals from libskill:
constant boolean LIBRARY_libskill=true
//endglobals from libskill
//globals from libtime0:
constant boolean LIBRARY_libtime0=true
//endglobals from libtime0
//globals from libyg:
constant boolean LIBRARY_libyg=true
//endglobals from libyg
//globals from csh:
constant boolean LIBRARY_csh=true
//                   _ooOoo_ 
//                  o8888888o 
//                  88" . "88 
//                  (| -_- |) 
//                  O\  =  /O 
//               ____/`---'\____ 
//             .'  \\|     |//  `. 
//            /  \\|||  :  |||//  \ 
//           /  _||||| -:- |||||-  \ 
//           |   | \\\  -  /// |   | 
//           | \_|  ''\---/''  |   | 
//           \  .-\__  `-`  ___/-. / 
//         ___`. .'  /--.--\  `. . __ 
//      ."" '<  `.___\_<|>_/___.'  >'"". 
//     | | :  `- \`.;`\ _ /`;.`/ - ` : | | 
//     \  \ `-.   \_ __\ /__ _/   .-` /  / 
//======`-.____`-.___\_____/___.-`____.-'====== 
//                   `=---=' 
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
//            佛祖保佑       永无BUG 
//掩耳盗铃 佛祖并不会保佑你永无BUG 都是你自己产生的
//改图可耻
integer i=0
integer b=0
integer g=0
real jsqjg=20
real array vx
real array cx
real array zx
real array yx
real array fx
real array dx
integer array kx
integer array m
integer array lgf
multiboard multi
multiboarditem array multiitem
integer array cl
integer array jn
//endglobals from csh
    // User-defined
hashtable udg_hs= null

trigger l__library_init

//JASSHelper struct globals:

endglobals


//library libbgj:
function bgj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetAttacker())), 1002)
    local integer bl=GetHeroStr(u, false)
    local integer bm=GetHeroAgi(u, false)
    local integer bz=GetHeroInt(u, false)
    local integer ql=GetHeroStr(u, true)
    local integer qm=GetHeroAgi(u, true)
    local integer qz=GetHeroInt(u, true)
    local integer ll=ql - bl
    local integer lm=qm - bm
    local integer lz=qz - bz
    local group l__g=CreateGroup()
    local unit u1=GetTriggerUnit()
    local unit u2
    local real x=GetUnitX(u1)
    local real y=GetUnitY(u1)
    local real s
    local integer id=GetPlayerId(GetOwningPlayer(u))
    local integer ids=GetHandleId(GetOwningPlayer(u))
    local boolean bo
    //伤害系数在这里设置
    if IsUnitType(GetAttacker(), UNIT_TYPE_HERO) and GetRandomInt(1, 100) > 95 then
        set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
        set s=s * ( ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] ) * 100 / GetHeroLevel(u) + dx[id] )
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect(LoadStr(udg_hs, GetUnitTypeId(u), 3), GetUnitX(u2), GetUnitY(u2)))
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP)
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetUnitTypeId(u) == 'HA0D' and GetRandomInt(1, 5) == 1 then //黑贞德攻击几率加敏捷
        call SetHeroInt(u, bm + 2, true)
    endif
    if HaveSavedBoolean(udg_hs, ids, 'A00D') and IsUnitType(GetAttacker(), UNIT_TYPE_HERO) then //冰冻天赋
        set u2=CreateUnit(GetOwningPlayer(u), 'n000', GetUnitX(u), GetUnitY(u), 0)
        call UnitAddAbility(u2, 'A01X') //添加技能
        call UnitApplyTimedLife(u2, 'BHwe', 1) //设置生命周期
        call IssueNeutralTargetOrderById(GetOwningPlayer(u), u2, 852075, u1) //放减速
    endif
    if HaveSavedBoolean(udg_hs, ids, 'A00C') and IsUnitType(GetAttacker(), UNIT_TYPE_HERO) then //火焰天赋
        set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
        set s=s * ( ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] ) * 100 / GetHeroLevel(u) + dx[id] )
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl", GetUnitX(u1), GetUnitY(u1)))
        call UnitDamageTarget(u, u1, s * 0.1, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP)
    endif
    if HaveSavedBoolean(udg_hs, ids, 'A00E') and IsUnitType(GetAttacker(), UNIT_TYPE_HERO) then //麻痹天赋
        set u2=CreateUnit(GetOwningPlayer(u), 'n000', GetUnitX(u), GetUnitY(u), 0)
        call UnitAddAbility(u2, 'A01Y') //添加技能
        call UnitApplyTimedLife(u2, 'BHwe', 1) //设置生命周期
        call IssueNeutralTargetOrderById(GetOwningPlayer(u), u2, 852190, u1) //放诅咒
    endif
    if HaveSavedBoolean(udg_hs, ids, 210) and IsUnitType(GetAttacker(), UNIT_TYPE_HERO) then
        set bo=LoadBoolean(udg_hs, ids, 210)
        if bo then
            if GetRandomInt(1, 10) == 1 then
                call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.1)
            endif
        else
            if GetRandomInt(1, 10) == 1 then
                set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
                set s=s * ( ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] ) * 100 / GetHeroLevel(u) + dx[id] )
                //可创建特效call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\SoulBurn\\SoulBurnbuff.mdl",GetUnitX(u1),GetUnitY(u1)))
                call UnitDamageTarget(u, u1, s * 8, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP)
            endif
        endif
    endif
    if HaveSavedBoolean(udg_hs, ids, 'A005') and IsUnitType(GetAttacker(), UNIT_TYPE_HERO) and GetRandomInt(1, 10) == 1 then //火焰天赋
        set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
        set s=s * ( ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] ) * 100 / GetHeroLevel(u) + dx[id] )
        set l__g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s * 0.5, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    set l__g=null
    set u=null
    set u1=null
    set u2=null
endfunction
function bgj takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function bgj_1)
    call TriggerRegisterPlayerUnitEvent(tr, Player(11), EVENT_PLAYER_UNIT_ATTACKED, null)
    set tr=null
endfunction

//library libbgj ends
//library libcf:
function libcf__hy3 takes nothing returns nothing
    local unit u=LoadUnitHandle(libcf__z_h, GetHandleId(GetExpiredTimer()), 0)
    call SetUnitTimeScale(u, 0)
    call FlushChildHashtable(libcf__z_h, GetHandleId(GetExpiredTimer()))
    call DestroyTimer(GetExpiredTimer())
    set u=null
endfunction
function libcf__hy2 takes nothing returns nothing
    local unit u=LoadUnitHandle(libcf__z_h, GetHandleId(GetExpiredTimer()), 0)
    local real sj=LoadReal(libcf__z_h, GetHandleId(GetExpiredTimer()), 1)
    local timer t=CreateTimer()
    call SetUnitTimeScale(u, 1)
    call TimerStart(t, sj, false, function libcf__hy3)
    call SaveUnitHandle(libcf__z_h, GetHandleId(t), 0, u)
    call FlushChildHashtable(libcf__z_h, GetHandleId(GetExpiredTimer()))
    call DestroyTimer(GetExpiredTimer())
    set u=null
    set t=null
endfunction
function libcf__hy1 takes nothing returns nothing
    local integer h=GetHandleId(GetExpiredTimer())
    local unit u=LoadUnitHandle(libcf__z_h, h, 0)
    local integer li=LoadInteger(libcf__z_h, h, 1)
    if li == 20 then //20级的透明度
        call RemoveUnit(u) //移除单位
        call DestroyTimer(GetExpiredTimer()) //删除到期计时器
        call FlushChildHashtable(libcf__z_h, h) //清理哈希表
    else
        set li=li + 1
        call SetUnitVertexColor(u, 255, 255, 255, R2I(( 255 / 20 ) * li)) //设置透明度
        call SaveInteger(libcf__z_h, h, 1, li) //保存当前透明度层次
    endif
    set u=null
endfunction
function libcf__cf_3 takes nothing returns nothing
    local integer h=GetHandleId(GetExpiredTimer())
    local unit u=LoadUnitHandle(libcf__z_h, h, 0)
    local real ux=GetUnitX(u)
    local real uy=GetUnitY(u)
    local integer c=LoadInteger(libcf__z_h, h, 1)
    local integer c1=LoadInteger(libcf__z_h, h, 2)
local timer t=CreateTimer()
    local integer h1=GetHandleId(t)
    local real gd=GetUnitFlyHeight(u)
    local real sj=LoadReal(libcf__z_h, h, 5)
    if c1 < c then
        set u=CreateUnit(GetOwningPlayer(u), LoadInteger(libcf__z_h, h, 99), ux, uy, GetUnitFacing(u)) //创建幻影
        call SetUnitFlyHeight(u, gd, 0) //设置幻影的高度
        call SetUnitVertexColor(u, 255, 255, 255, 0) //设置幻影初始透明度
        call UnitAddAbility(u, 'Arav') //添加风暴之鸦
        call UnitRemoveAbility(u, 'Arav') //删除风暴之鸦
        call SaveUnitHandle(libcf__z_h, h1, 0, u) //保存单位
        call TimerStart(t, 0.04, true, function libcf__hy1)
        call SetUnitAnimationByIndex(u, 3)
        call SetUnitTimeScale(u, 10)
        set t=CreateTimer()
        call SaveUnitHandle(libcf__z_h, GetHandleId(t), 0, u)
        call SaveReal(libcf__z_h, GetHandleId(t), 1, sj)
        call TimerStart(t, sj * 0.1 * c1, true, function libcf__hy2)
        set c1=c1 + 1
        call SaveInteger(libcf__z_h, h, 2, c1)
    else
        call FlushChildHashtable(libcf__z_h, h)
        call DestroyTimer(GetExpiredTimer())
    endif
    set u=null
    set t=null
endfunction
function libcf__cf_1 takes nothing returns nothing
    local integer h=GetHandleId(GetExpiredTimer())
    local unit u=LoadUnitHandle(libcf__z_h, h, 0)
    local real ux=GetUnitX(u)
    local real uy=GetUnitY(u)
    local real a=LoadReal(libcf__z_h, h, 1)
    local real jl=LoadReal(libcf__z_h, h, 2)
    local integer c=LoadInteger(libcf__z_h, h, 3)
    local integer c1=LoadInteger(libcf__z_h, h, 4)
local boolean ty=LoadBoolean(libcf__z_h, h, 7)
    local real gd=LoadReal(libcf__z_h, h, 6)
    if c1 < c then
        if IsTerrainPathable(ux + jl * Cos(a), uy, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(ux + jl * Cos(a), uy, PATHING_TYPE_BUILDABILITY) then
        call BJDebugMsg("出事了？")
        else
            call SetUnitX(u, ux + jl * Cos(a))
        endif
        if IsTerrainPathable(ux, uy + jl * Sin(a), PATHING_TYPE_WALKABILITY) and IsTerrainPathable(ux + jl * Cos(a), uy, PATHING_TYPE_BUILDABILITY) then
        //Y坐标停下来了
        else
            call SetUnitY(u, uy + jl * Sin(a))
        endif
        if ty then
            if c1 > c / 2 then //超过一半上升，未超过下降
                call SetUnitFlyHeight(u, ( c - c1 ) * gd, 0)
            else
                call SetUnitFlyHeight(u, c1 * gd, 0)
            endif
        endif
        set c1=c1 + 1
        call SaveInteger(libcf__z_h, h, 4, c1)
    else
        //call PauseUnit(u,false)
        call DestroyTimer(GetExpiredTimer())
        call FlushChildHashtable(libcf__z_h, h)
    endif
    set u=null
endfunction
function libcf_cf takes unit u,real x,real y,real s1,real s2,boolean yhy,boolean ty returns nothing
//                          单位    目标X,Y     时间        间隔    有无幻影    跳跃
    local timer t=CreateTimer()
    local real ux=GetUnitX(u)
    local real uy=GetUnitY(u)
    local real jl=SquareRoot(( x - ux ) * ( x - ux ) + ( y - uy ) * ( y - uy ))
    local real c=s1 / s2
    local real xjl=jl / c
    local integer h=GetHandleId(t)
    call SaveUnitHandle(libcf__z_h, h, 0, u) //单位
    call SaveReal(libcf__z_h, h, 1, Atan2(y - uy, x - ux)) // 角度
    call SaveReal(libcf__z_h, h, 2, xjl) //每次距离
    call SaveInteger(libcf__z_h, h, 3, R2I(c)) //刷新次数
    call TimerStart(t, s2, true, function libcf__cf_1) //冲锋
    call SetUnitAnimationByIndex(u, 3)
    if ty then
        call UnitAddAbility(u, 'Arav')
        call UnitRemoveAbility(u, 'Arav')
        call SaveBoolean(libcf__z_h, h, 7, ty)
        call SaveReal(libcf__z_h, h, 6, 400 / c) //每次跳跃高度
    endif
    if yhy then
        //call PauseUnit(u,true)
        set t=CreateTimer()
        set h=GetHandleId(t)
        call SaveUnitHandle(libcf__z_h, h, 0, u) //单位
        call SaveInteger(libcf__z_h, h, 1, R2I(s1 / 0.04)) //幻影数量
        if LoadInteger(udg_hs, 0, 105) == 1 then
            call SaveInteger(libcf__z_h, h, 99, 'n004')
        else
            call SaveInteger(libcf__z_h, h, 99, 'n005')
        endif
        call TimerStart(t, 0.04, true, function libcf__cf_3)
        call SaveReal(libcf__z_h, h, 5, s2)
    endif
    set t=null
endfunction
function libcf_cf1 takes unit u1,unit u2 returns nothing
    local real u1x=GetUnitX(u1)
    local real u1y=GetUnitY(u1)
    local real u2x=GetUnitX(u2)
    local real u2y=GetUnitY(u2)
    local real jl=800 - SquareRoot(( u1x - u2x ) * ( u1x - u2x ) + ( u1y - u2y ) * ( u1y - u2y ))
    local real a=Atan2(u1y - u2y, u1x - u2x)
    local real s=jl / 400
    local real c=s / 0.04
    local real xjl=jl / c
    local timer t=CreateTimer()
    local integer h=GetHandleId(t)
    call SaveUnitHandle(libcf__z_h, h, 0, u1)
    call SaveReal(libcf__z_h, h, 1, a)
    call SaveReal(libcf__z_h, h, 2, xjl)
    call SaveInteger(libcf__z_h, h, 3, R2I(c))
    call TimerStart(t, 0.04, true, function libcf__cf_1)
    set t=null
endfunction
function libcf_cf2 takes unit u1,unit u2 returns nothing
    local real u1x=GetUnitX(u1)
    local real u1y=GetUnitY(u1)
    local real u2x=GetUnitX(u2)
    local real u2y=GetUnitY(u2)
    local real jl=SquareRoot(( u1x - u2x ) * ( u1x - u2x ) + ( u1y - u2y ) * ( u1y - u2y ))
    local real a=Atan2(u2y - u1y, u2x - u1x)
    local real s=jl / 800
    local real c=s / 0.04
    local real xjl=jl / c
    local timer t=CreateTimer()
    local integer h=GetHandleId(t)
    call SaveUnitHandle(libcf__z_h, h, 0, u1)
    call SaveReal(libcf__z_h, h, 1, a)
    call SaveReal(libcf__z_h, h, 2, xjl)
    call SaveInteger(libcf__z_h, h, 3, R2I(c))
    call TimerStart(t, 0.04, true, function libcf__cf_1)
    set t=null
endfunction
function cfsh_1 takes nothing returns nothing
    local trigger tr=GetTriggeringTrigger()
    local integer li=GetHandleId(tr)
    local unit u= LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(LoadUnitHandle(udg_hs, li, 0))), StringHash("英雄"))
    local real s=LoadReal(udg_hs, li, 1)
    local unit u2=GetTriggerUnit()
    if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
        call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
        call BJDebugMsg(R2S(s))
    endif
    
    set tr=null
    set u=null
    set u2=null
endfunction
function shpx takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer li=GetHandleId(t)
    local trigger tr=LoadTriggerHandle(udg_hs, li, 0)
    call FlushChildHashtable(udg_hs, GetHandleId(tr))
    call FlushChildHashtable(udg_hs, li)
    call DestroyTrigger(tr)
    call DestroyTimer(t)
    set t=null
    set tr=null
endfunction
function libcf_cftimer_1 takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local timer t2
    local real array r
    local integer array li
    local unit u
    local player p1
    local unit u1
    local trigger tr
    set li[0]=GetHandleId(t)
    set u=LoadUnitHandle(udg_hs, li[0], 0)
    set p1=GetOwningPlayer(u)
    set r[1]=GetUnitX(u)
    set r[2]=GetUnitY(u)
    set r[3]=LoadReal(udg_hs, li[0], 1)
    set r[4]=LoadReal(udg_hs, li[0], 2)
    set r[5]=( 180 / 3.14159 ) * Atan2(r[4] - r[2], r[3] - r[1])
    set li[1]=- 4
    set li[2]=LoadInteger(udg_hs, li[0], 3) + 1
    set li[3]=LoadInteger(udg_hs, li[0], 4)
    set r[8]=LoadReal(udg_hs, li[0], 5)
    loop
        set r[6]=GetUnitX(u) + 600 * Cos(( r[5] + 15 * li[1] ) * 3.14159 / 180)
        set r[7]=GetUnitY(u) + 600 * Sin(( r[5] + 15 * li[1] ) * 3.14159 / 180)
        set u1=CreateUnit(p1, 'n003', r[1], r[2], r[5] + 15 * li[1])
        call SetUnitPathing(u1, false)
        call AddSpecialEffectTarget("Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl", u1, "sprite")
        call UnitApplyTimedLife(u1, 'BHwe', 0.5)
        set tr=CreateTrigger()
        call TriggerAddAction(tr, function cfsh_1)
        call SaveUnitHandle(udg_hs, GetHandleId(tr), 0, u1)
        call SaveReal(udg_hs, GetHandleId(tr), 1, r[8])
        call TriggerRegisterUnitInRange(tr, u1, 64, null)
        set t2=CreateTimer()
        call SaveTriggerHandle(udg_hs, GetHandleId(t2), 0, tr)
        call TimerStart(t2, 0.5, false, function shpx)
        call libcf_cf(u1 , r[6] , r[7] , 0.5 , 0.025 , false , false)
        exitwhen li[1] == 4
        set li[1]=li[1] + 1
    endloop
    if li[2] == li[3] then
        call FlushChildHashtable(udg_hs, li[0])
        call DestroyTimer(GetExpiredTimer())
    else
        call SaveInteger(udg_hs, li[0], 3, li[2])
    endif
    set tr=null
    set u=null
    set t=null
    set p1=null
    set u1=null
    set t2=null
endfunction

//library libcf ends
//library libchuguai:
function zzbs takes nothing returns nothing
    local unit u=CreateUnit(Player(11), LoadInteger(udg_hs, 13, 6), LoadReal(udg_hs, 1, 77), LoadReal(udg_hs, 2, 77), LoadReal(udg_hs, 3, 77))
    call IssueNeutralPointOrderById(Player(11), u, 851983, LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77))
    set u=null
endfunction
function cboss takes nothing returns nothing
    local unit u=CreateUnit(Player(11), LoadInteger(udg_hs, 13, b / 7), LoadReal(udg_hs, 1, 77), LoadReal(udg_hs, 2, 77), LoadReal(udg_hs, 3, 77))
    local trigger t
    call IssueNeutralPointOrderById(Player(11), u, 851983, LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77)) //发布命令
    if b / 7 == 5 and GetPlayerTechCount(Player(11), 'RA00', true) == 5 then //判断难5
        set t=CreateTrigger()
        call TriggerAddAction(t, function zzbs)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
    endif
    set u=null
    set t=null
endfunction
function chuguai_1 takes nothing returns nothing
    //出怪计时器循环
    if b < 35 then
        set b=b + 1
        set g=19 //出怪数量
        if ModuloInteger(b, 7) == 0 then
            call cboss()
        endif
        call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, 1014), "第" + I2S(b + 1) + "波敌人来袭") //修改计时器窗口显示标题
    endif
    if b == 35 then
        call DestroyTimerDialog(LoadTimerDialogHandle(udg_hs, 0, 1014)) //出怪完毕，删除计时器窗口
        call DestroyTimer(GetExpiredTimer()) //删除计时器
    endif
endfunction
function chuguai takes nothing returns nothing
    local trigger tr= CreateTrigger()
    call TriggerRegisterTimerExpireEvent(tr, LoadTimerHandle(udg_hs, 0, 1015))
    call TriggerAddAction(tr, function chuguai_1)
    //出怪计时器
    set tr=null
endfunction

//library libchuguai ends
//library libdeath:
function death_1 takes nothing returns nothing
    local unit u1=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetKillingUnit())), 1002)
    local unit u2=GetTriggerUnit()
    local player p1=GetOwningPlayer(u1)
    local integer array li
    local item it
    local unit u3
    local integer bl=GetHeroStr(u1, false)
    local integer bm=GetHeroAgi(u1, false)
    local integer bz=GetHeroInt(u1, false)
    local integer ql=GetHeroStr(u1, true)
    local integer qm=GetHeroAgi(u1, true)
    local integer qz=GetHeroInt(u1, true)
    local integer ll=ql - bl
    local integer lm=qm - bm
    local integer lz=qz - bz
    local group l__g
    local real x
    local real y
    local real s
    local integer id=GetPlayerId(p1)
    set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
    set s=s * ( ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] ) + dx[id] * 0.5 )
    set li[0]=GetHandleId(u1)
    set li[1]=GetHandleId(p1)
    set li[100]=GetPlayerId(p1)
    set kx[li[100]]=kx[li[100]] + 1
    if ModuloInteger(kx[li[100]], 1500) == 0 and dx[li[100]] - 1 < vx[li[100]] then //1.5K的经验升级E技能，DX不能大于VX-1
        set dx[li[100]]=dx[li[100]] + 0.1
    endif
    if HaveSavedHandle(udg_hs, li[1], 1) then //检测是否绑定有物品
        set it=LoadItemHandle(udg_hs, li[1], 1) //读取绑定的物品
        set li[9]=GetHandleId(it) //读取绑定物品的handle
        set li[10]=LoadInteger(udg_hs, li[9], GetItemLevel(it)) + 1 //读取经验和经验+1
        set li[11]=LoadInteger(udg_hs, 25, GetItemTypeId(it)) //读取升级对应的等级
        set li[12]=LoadInteger(udg_hs, GetItemTypeId(it), 2) //读取升级等级对应的强化石
        set li[13]=( li[11] + 4 ) / 5 //设置升级所需经验
        if li[10] >= li[13] * 100 then //判断升级经验是否足够
            if ModuloInteger(li[11], 5) != 0 then //判断是否需要材料
                call UnitAddItem(u1, CreateItem(li[12], GetUnitX(u1), GetUnitY(u1))) //给予强化石
            endif
        else //经验不足
            call SaveInteger(udg_hs, li[9], GetItemLevel(it), li[10]) //记录经验
            //此处应显示经验给玩家
        endif
    endif
    if HaveSavedHandle(udg_hs, li[1], 2) then //检测是否绑定有物品
        set it=LoadItemHandle(udg_hs, li[1], 2) //读取绑定的物品
        set li[19]=GetHandleId(it) //读取绑定物品的handle
        set li[20]=LoadInteger(udg_hs, li[19], GetItemLevel(it)) + 1 //读取经验和经验+1
        set li[21]=LoadInteger(udg_hs, 25, GetItemTypeId(it)) //读取升级对应的等级
        set li[22]=LoadInteger(udg_hs, GetItemTypeId(it), 2) //读取升级等级对应的强化石
        set li[23]=( li[21] + 4 ) / 5 //设置升级所需经验
        if li[20] >= li[23] * 100 then //判断升级经验是否足够
            if ModuloInteger(li[21], 5) != 0 then //判断是否需要材料
                call UnitAddItem(u1, CreateItem(li[22], GetUnitX(u1), GetUnitY(u1))) //给予强化石
            endif
        else //经验不足
            call SaveInteger(udg_hs, li[19], GetItemLevel(it), li[20]) //记录经验
        endif
        call BJDebugMsg(I2S(li[20]) + "衣服" + I2S(li[23] * 100))
    endif
    if HaveSavedHandle(udg_hs, li[1], 3) then //检测是否绑定有物品
        set it=LoadItemHandle(udg_hs, li[1], 3) //读取绑定的物品
        set li[29]=GetHandleId(it) //读取绑定物品的handle
        set li[30]=LoadInteger(udg_hs, li[29], GetItemLevel(it)) + 1 //读取经验和经验+1
        set li[31]=LoadInteger(udg_hs, 25, GetItemTypeId(it)) //读取升级对应的等级
        set li[32]=LoadInteger(udg_hs, GetItemTypeId(it), 2) //读取升级等级对应的强化石
        set li[33]=li[31] //设置升级所需经验
        if li[30] >= li[33] * 100 then //判断升级经验是否足够
            if ModuloInteger(li[31], 5) != 0 then //判断是否需要材料
                call UnitAddItem(u1, CreateItem(li[32], GetUnitX(u1), GetUnitY(u1))) //给予强化石
            endif
        else //经验不足
            call SaveInteger(udg_hs, li[29], GetItemLevel(it), li[30]) //记录经验
            call BJDebugMsg(I2S(li[30]) + "手套" + I2S(li[33] * 100))
        endif
    endif
    if GetUnitTypeId(u1) == 'HA0G' then //检测是否魔术师凶手
        set l__g=CreateGroup()
        set x=GetUnitX(u2)
        set y=GetUnitY(u2)
        call GroupEnumUnitsInRange(l__g, x, y, 200, null)
        loop
            set u3=FirstOfGroup(l__g)
            exitwhen u3 == null
                if GetUnitState(u3, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u3, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetUnitX(u3), GetUnitY(u3))) //创建特效
                    call UnitDamageTarget(u1, u3, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u3)
        endloop
        call DestroyGroup(l__g)
    endif
    if HaveSavedInteger(udg_hs, GetHandleId(u2), 666) then //检测是否练功房单位
        set lgf[LoadInteger(udg_hs, GetHandleId(u2), 666) + 6]=lgf[LoadInteger(udg_hs, GetHandleId(u2), 666) + 6] - 1
        if GetUnitTypeId(u2) == 'uAA0' then
            call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.12), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
        else
            if GetUnitTypeId(u2) == 'uAA1' then
                call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.24), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
            else
                if GetUnitTypeId(u2) == 'uAA2' then
                    call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.02), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
                else
                    if GetUnitTypeId(u2) == 'uAA3' then
                        call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.02), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
                    else
                        if GetUnitTypeId(u2) == 'uAA4' then
                            call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.02), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
                        else
                            if GetUnitTypeId(u2) == 'uAA5' then
                                call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 0.02), true) //未判断死亡，死亡增加经验不知道有没有效果和影响
                            endif
                        endif
                    endif
                endif
            endif
        endif
        call FlushChildHashtable(udg_hs, GetHandleId(u2))
        call RemoveUnit(u2)
    else
        if IsUnitType(u2, UNIT_TYPE_HERO) then
            call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * 1.5), true) //为判断死亡，死亡增加经验不知道有没有效果和影响
        else
            call AddHeroXP(u1, R2I(300 + 15 * I2R(GetHeroLevel(u1)) * ( 0.3 + 0.02 * I2R(b) )), true) //为判断死亡，死亡增加经验不知道有没有效果和影响
        endif
        if HaveSavedInteger(udg_hs, GetHandleId(u2), 51) then
            set li[2]=LoadInteger(udg_hs, GetHandleId(u2), 51)
            set zx[li[2]]=zx[li[2]] + 0.1
            call BJDebugMsg("恭喜傻逼转生到 " + I2S(R2I(( zx[li[2]] * 10 ) + 0.5)) + " 转") //调试时显示
            if HaveSavedInteger(udg_hs, GetHandleId(u2), 52) then
                set li[3]=LoadInteger(udg_hs, GetHandleId(u2), 52)
                //在此开启最终进阶动作
                if li[3] == 0 then
                    call SaveBoolean(udg_hs, GetHandleId(p1), 210, true)
                else
                    call SaveBoolean(udg_hs, GetHandleId(p1), 210, false)
                endif
                call BJDebugMsg(I2S(li[3])) //输出是入灵还是入魔
                call RemoveSavedInteger(udg_hs, GetHandleId(u2), 52)
            endif
            call RemoveSavedInteger(udg_hs, GetHandleId(u2), 51)
            call RemoveSavedInteger(udg_hs, li[1], 51)
        endif
    endif
    set u3=null
    set l__g=null
    set it=null
    set p1=null
    set u2=null
    set u1=null
endfunction
function death takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function death_1)
    call TriggerRegisterPlayerUnitEvent(tr, Player(11), EVENT_PLAYER_UNIT_DEATH, null)
    set tr=null
endfunction

//library libdeath ends
//library libdmb:
function dmb takes nothing returns nothing
    local integer array li
    local string array st
    set multi=CreateMultiboard()
    call MultiboardSetColumnCount(multi, 7)
    call MultiboardSetRowCount(multi, 7)
    set st[0]="荣誉"
    set st[1]="玩家名字"
    set st[2]="英雄"
    set st[3]="称号"
    set st[4]="转生"
    set st[5]="斗者结晶"
    set st[6]="备用"
    set li[1]=0
    set li[2]=0
    set li[7]=0xFF
    set li[8]=0x00
    set li[9]=0x1C
    set li[10]=0x54
    set li[11]=0xFF
    set li[12]=0xFE
    set li[13]=0x20
    set li[14]=0x03
    set li[15]=0x42
    set li[16]=0xE6
    set li[17]=0x00
    set li[18]=0xFC
    set li[19]=0xA0
    set li[20]=0xC0
    set li[21]=0x03
    set li[22]=0xFF
    set li[23]=0xB9
    set li[24]=0x81
    set li[25]=0x01
    set li[26]=0x0E
    set li[27]=0x00
    call MultiboardSetItemsWidth(multi, 0.03) //所有项目宽度
    call MultiboardSetItemsStyle(multi, true, false) //所有项目风格
    loop
        loop
            set multiitem[li[1] * 7 + li[2]]=MultiboardGetItem(multi, li[1], li[2]) //绑定多面板项目
            call MultiboardSetItemValueColor(multiitem[li[1] * 7 + li[2]], li[li[1] + 7], li[li[1] + 14], li[li[1] + 21], 255) //设置项目颜色，红，绿，蓝，透明
            if li[1] == 6 then
                call MultiboardSetItemValue(multiitem[li[1] * 7 + li[2]], st[li[2]])
            endif
            exitwhen li[2] == 6
            set li[2]=li[2] + 1
        endloop
        exitwhen li[1] == 6
        set li[1]=li[1] + 1
        set li[2]=0
    endloop
endfunction

//library libdmb ends
//library libgy:
    function jz_i2s takes integer inputi returns string
    //进制转换
    local integer tempi=inputi
    local string lr
    local string array lx
    local integer imin=1
    local integer imax=2
    local integer li1
    local string temps= "123456789ABCDEF0"
    loop
	    exitwhen imin > imax
	    set li1=ModuloInteger(tempi, 16)
		    if ( li1 == 0 ) then
			    set li1=16
    		endif
	    	set lx[imin]=SubString(temps, li1 - 1, li1)
    	set tempi=tempi / 16
	    set imin=imin + 1
    endloop
    set lr=lx[2] + lx[1]
    return lr
    endfunction
    function msgys takes string xgstr returns string
        return "|cFF" + jz_i2s(GetRandomInt(0, 255)) + jz_i2s(GetRandomInt(0, 255)) + jz_i2s(GetRandomInt(0, 255)) + xgstr + "|r"
    endfunction
    function H2I takes handle h returns integer
        return GetHandleId(h)
    endfunction

//library libgy ends
//library libhg:
function hg takes unit hghero returns nothing
    //回城动作
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77) + 128
    call SetUnitPosition(hghero, x, y) //传送
    set lgf[GetPlayerId(GetOwningPlayer(hghero))]=0 //关闭练功房
    if GetOwningPlayer(hghero) == GetLocalPlayer() then //异步
        call SetCameraPosition(x, y)
        call ClearSelection()
        call SelectUnit(hghero, true)
    endif
endfunction

//library libhg ends
//library libkj:
function kj_1 takes nothing returns nothing
    local integer li=GetPlayerTechCount(GetOwningPlayer(GetTriggerUnit()), GetResearched(), true)
    local integer li1=0
    loop
        exitwhen li1 == 7
        call SetPlayerTechResearched(Player(li1), GetResearched(), li) //同步科技等级
        set li1=li1 + 1
    endloop
endfunction
function kj takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function kj_1)
    call SaveTriggerHandle(udg_hs, 0, 1008, tr)
    set tr=null
endfunction

//library libkj ends
//library liblvup:
function lvup1 takes nothing returns nothing
    if GetHeroLevel(GetTriggerUnit()) == 200 or GetHeroLevel(GetTriggerUnit()) == 500 or GetHeroLevel(GetTriggerUnit()) == 800 or GetHeroLevel(GetTriggerUnit()) == 1000 then
        set jn[20 * GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 20]=jn[20 * GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 20] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "你获得斗魂技能 :" + GetObjectName(jn[jn[20 * GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 20]]))
        call SetPlayerAbilityAvailable(GetTriggerPlayer(), jn[jn[20 * GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 20]], true) //获得一个天赋点
        call SaveBoolean(udg_hs, GetHandleId(GetTriggerPlayer()), jn[20 * GetPlayerId(GetTriggerPlayer()) + jn[20 * GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 20]], true) //开启该技能
        call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, false) //禁用下一页
        call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, true) //启用下一页
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'HA05' and ( GetHeroLevel(GetTriggerUnit()) == 300 or GetHeroLevel(GetTriggerUnit()) == 600 or GetHeroLevel(GetTriggerUnit()) == 900 ) then
        call IncUnitAbilityLevel(GetTriggerUnit(), 'A00T')
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'HA08' and ( GetHeroLevel(GetTriggerUnit()) == 300 or GetHeroLevel(GetTriggerUnit()) == 600 or GetHeroLevel(GetTriggerUnit()) == 900 ) then
        call IncUnitAbilityLevel(GetTriggerUnit(), 'A00Z')
    endif
endfunction
function lvup takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function lvup1)
    call SaveTriggerHandle(udg_hs, 0, 300, tr)
    set tr=null
endfunction

//library liblvup ends
//library libmsg:
function msg takes integer v returns string
    if v == 1 then
        return "|cffff0000【信息】|r"
    endif
    return ""
endfunction

//library libmsg ends
//library libsywp:
function sywp_1 takes nothing returns nothing
    local unit u1=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), 1002)
    local unit u2=GetTriggerUnit()
    local item litem=GetManipulatedItem()
    local integer array li
    local real array r
    set li[0]=GetItemTypeId(litem)
    if li[0] == 'IB2Y' then //一级回复药
        set r[0]=GetUnitState(u1, UNIT_STATE_LIFE)
        if r[0] > 0.405 then
            call SetUnitState(u1, UNIT_STATE_LIFE, r[0] + 5000)
        endif
    endif
    if li[0] == 'IB2Z' then //二级回复药
        set r[0]=GetUnitState(u1, UNIT_STATE_LIFE)
        if r[0] > 0.405 then
            call SetUnitState(u1, UNIT_STATE_LIFE, r[0] + 20000)
        endif
    endif
    if li[0] == 'IB30' then //三级回复药
        set r[0]=GetUnitState(u1, UNIT_STATE_LIFE)
        if r[0] > 0.405 then
            call SetUnitState(u1, UNIT_STATE_LIFE, r[0] + 100000)
        endif
    endif
    if li[0] == 'IB31' then //四级回复药
        set r[0]=GetUnitState(u1, UNIT_STATE_LIFE)
        set r[1]=GetUnitState(u1, UNIT_STATE_MAX_LIFE)
        if r[0] > 0.405 then
            call SetUnitState(u1, UNIT_STATE_LIFE, r[0] + r[1] / 2)
        endif
    endif
    if li[0] == 'IB41' then //蜘蛛之血
        if u2 == u1 then
            set li[0]=0
            set li[1]=GetHandleId(GetOwningPlayer(u1))
            loop
                set li[0]=li[0] + 1
                if HaveSavedHandle(udg_hs, li[1], li[0]) then //检测是否绑定有物品
                    set litem=LoadItemHandle(udg_hs, li[1], li[0]) //读取绑定的物品
                    set li[9]=GetHandleId(litem) //读取绑定物品的handle
                    set li[11]=LoadInteger(udg_hs, 25, GetItemTypeId(litem)) //读取升级对应的等级
                    if li[11] > 5 and li[11] <= 10 then
                        set li[10]=LoadInteger(udg_hs, li[9], GetItemLevel(litem)) + 30 //读取经验和经验+30
                        set li[12]=LoadInteger(udg_hs, GetItemTypeId(litem), 2) //读取升级等级对应的强化石
                        set li[13]=( li[11] + 4 ) / 5 //设置升级所需经验
                        call BJDebugMsg(I2S(li[10]) + "   " + I2S(li[13] * 100))
                        if li[10] >= li[13] * 100 then //判断升级经验是否足够
                            if ModuloInteger(li[11], 5) != 0 then //判断是否需要材料
                                call UnitAddItem(u1, CreateItem(li[12], GetUnitX(u1), GetUnitY(u1))) //给予强化石
                            endif
                        else //经验不足
                            call SaveInteger(udg_hs, li[9], GetItemLevel(litem), li[10]) //记录经验
                            //此处应显示经验给玩家
                        endif
                    endif
                endif
                exitwhen li[0] == 2
            endloop
        endif
    endif
    if li[0] == 'IB40' then //蛇龙之胆
        if u2 == u1 then
            set li[0]=0
            set li[1]=GetHandleId(GetOwningPlayer(u1))
            loop
                set li[0]=li[0] + 1
                if HaveSavedHandle(udg_hs, li[1], li[0]) then //检测是否绑定有物品
                    set litem=LoadItemHandle(udg_hs, li[1], li[0]) //读取绑定的物品
                    set li[9]=GetHandleId(litem) //读取绑定物品的handle
                    set li[11]=LoadInteger(udg_hs, 25, GetItemTypeId(litem)) //读取升级对应的等级
                    if li[11] > 10 and li[11] <= 15 then
                        set li[10]=LoadInteger(udg_hs, li[9], GetItemLevel(litem)) + 30 //读取经验和经验+30
                        set li[12]=LoadInteger(udg_hs, GetItemTypeId(litem), 2) //读取升级等级对应的强化石
                        set li[13]=( li[11] + 4 ) / 5 //设置升级所需经验
                        call BJDebugMsg(I2S(li[10]) + "   " + I2S(li[13] * 100))
                        if li[10] >= li[13] * 100 then //判断升级经验是否足够
                            if ModuloInteger(li[11], 5) != 0 then //判断是否需要材料
                                call UnitAddItem(u1, CreateItem(li[12], GetUnitX(u1), GetUnitY(u1))) //给予强化石
                            endif
                        else //经验不足
                            call SaveInteger(udg_hs, li[9], GetItemLevel(litem), li[10]) //记录经验
                            //此处应显示经验给玩家
                        endif
                    endif
                endif
                exitwhen li[0] == 2
            endloop
        endif
    endif
    if li[0] == 'IB39' then //暗淡的斗者意志
        set li[0]=GetPlayerId(GetOwningPlayer(u1))
        set kx[li[0]]=kx[li[0]] + 100
        if ModuloInteger(kx[li[0]], 1500) <= 100 and dx[li[0]] - 1 < vx[li[0]] then //1.5K的经验升级E技能，DX不能大于VX-1
            set dx[li[0]]=dx[li[0]] + 0.1
        endif
    endif
    if li[0] == 'IB3A' then //绚丽的斗者意志
        set li[0]=GetPlayerId(GetOwningPlayer(u1))
        set kx[li[0]]=kx[li[0]] + 500
        if ModuloInteger(kx[li[0]], 1500) <= 500 and dx[li[0]] - 1 < vx[li[0]] then //1.5K的经验升级E技能，DX不能大于VX-1
            set dx[li[0]]=dx[li[0]] + 0.1
        endif
    endif
    //开箱子，神器改成可以使用，可分解，宝器改为可分解
    if li[0] == 'IB32' or li[0] == 'IB33' or li[0] == 'IB34' or li[0] == 'IB35' or li[0] == 'IB36' then
        set li[1]=li[0] - 'IB31'
        set li[2]=GetRandomInt(1, 20)
        if li[1] < 4 then
            if li[2] <= 12 + li[1] * 2 then
                set litem=CreateItem(GetRandomInt('IB2O', 'IB2W'), GetUnitX(u2), GetUnitY(u2))
                call UnitAddItem(u2, litem)
                call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
            endif
        else
            if li[1] == 4 then
                if li[2] <= 14 then
                    set litem=CreateItem(GetRandomInt('IB2O', 'IB2W'), GetUnitX(u2), GetUnitY(u2))
                    call UnitAddItem(u2, litem)
                    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                else
                    if li[2] <= 17 then
                        set li[3]='IBB0'
                        set li[4]='IBB3'
                        set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                        call UnitAddItem(u2, litem)
                        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                    else
                        if li[2] <= 19 then
                            set li[3]='IBB1'
                            set li[4]='IBB4'
                            set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                            call UnitAddItem(u2, litem)
                            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                        else
                            set li[3]='IBB2'
                            set li[4]='IBB5'
                            set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                            call UnitAddItem(u2, litem)
                            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                        endif
                    endif
                endif
            else
                if li[2] <= 11 then
                    set litem=CreateItem(GetRandomInt('IB2O', 'IB2W'), GetUnitX(u2), GetUnitY(u2))
                    call UnitAddItem(u2, litem)
                    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                else
                    if li[2] <= 15 then
                        set li[3]='IBB0'
                        set li[4]='IBB3'
                        set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                        call UnitAddItem(u2, litem)
                        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                    else
                        if li[2] <= 18 then
                            set li[3]='IBB1'
                            set li[4]='IBB4'
                            set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                            call UnitAddItem(u2, litem)
                            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                        else
                            set li[3]='IBB2'
                            set li[4]='IBB5'
                            set litem=CreateItem(li[GetRandomInt(3, 4)], GetUnitX(u2), GetUnitY(u2))
                            call UnitAddItem(u2, litem)
                            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "恭喜 " + GetPlayerName(GetOwningPlayer(u2)) + " 在宝箱中获得 " + GetItemName(litem))
                        endif
                    endif
                endif
            endif
        endif
    endif
    if li[0] == 'IBB0' or li[0] == 'IBB1' or li[0] == 'IBB2' then
        call UnitAddAbility(u1, li[0] + 134024960) //添加技能
        call SetPlayerTechResearched(GetOwningPlayer(u1), li[0] + 149815040, 1) //添加科技
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, GetPlayerName(GetOwningPlayer(u1)) + " 解锁了神器 " + GetObjectName(li[0]))
    endif
    if li[0] == 'IBB3' or li[0] == 'IBB4' or li[0] == 'IBB5' then
        call UnitAddAbility(u1, li[0] + 134024707) //添加技能
        call SetPlayerTechResearched(GetOwningPlayer(u1), li[0] + 149815293, 1) //添加科技
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, GetPlayerName(GetOwningPlayer(u1)) + " 解锁了神器 " + GetObjectName(li[0]))
    endif
    set litem=null
    set u1=null
    set u2=null
endfunction
function sywp takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function sywp_1)
    call TriggerRegisterPlayerUnitEvent(tr, Player(0), EVENT_PLAYER_UNIT_USE_ITEM, null)
    call TriggerRegisterPlayerUnitEvent(tr, Player(1), EVENT_PLAYER_UNIT_USE_ITEM, null)
    call TriggerRegisterPlayerUnitEvent(tr, Player(2), EVENT_PLAYER_UNIT_USE_ITEM, null)
    call TriggerRegisterPlayerUnitEvent(tr, Player(3), EVENT_PLAYER_UNIT_USE_ITEM, null)
    call TriggerRegisterPlayerUnitEvent(tr, Player(4), EVENT_PLAYER_UNIT_USE_ITEM, null)
    call TriggerRegisterPlayerUnitEvent(tr, Player(5), EVENT_PLAYER_UNIT_USE_ITEM, null)
    set tr=null
endfunction

//library libsywp ends
//library libtf:
function zhan takes nothing returns nothing
    set jn[201]='A002'
    set jn[202]='A003'
    set jn[203]='A004'
    set jn[204]='A005'
    set jn[205]='A006'
    set jn[206]='A007'
    set jn[207]='A008'
    set jn[208]='A009'
    set jn[209]='A00A'
    set jn[210]='A00B'
    set jn[211]='A00C'
    set jn[212]='A00D'
    set jn[213]='A00E'
    set jn[214]='A00F'
    set jn[179]=0
    loop
        set jn[0]=0
        loop //初始化数组
            exitwhen jn[0] == 14
            set jn[0]=jn[0] + 1
            set jn[180 + jn[0]]=jn[200 + jn[0]]
        endloop
        set jn[0]=0
        loop //重新随机数组
            exitwhen jn[0] == 14 //14个技能
            set jn[0]=jn[0] + 1 //记录循环次数
            set jn[178]=GetRandomInt(1, 15 - jn[0]) //获取一个随机数
            set jn[20 * jn[179] + jn[0]]=jn[180 + jn[178]] //重新分配数组
            set jn[177]=0 //初始化重新入栈的数组
            loop //处理栈
                exitwhen jn[177] == 15 - jn[0] - jn[178]
                set jn[180 + jn[178] + jn[177]]=jn[180 + jn[178] + jn[177] + 1]
                set jn[177]=jn[177] + 1
            endloop
        endloop
        exitwhen jn[179] == 5
        set jn[179]=jn[179] + 1
    endloop
endfunction

//library libtf ends
//library libajidi:
function ajidi_3 takes nothing returns nothing
    //call CustomDefeatBJ(GetLocalPlayer(),msgys("失败！"))
endfunction
function ajidi_2 takes nothing returns nothing
    local timer t=CreateTimer()
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, msgys("你失败了，20秒后游戏结束"))
    call TimerStart(t, 20, false, function ajidi_3)
    set t=null
endfunction
function ajidi_1 takes nothing returns nothing
    local real maxl=GetUnitState(GetTriggerUnit(), UNIT_STATE_MAX_LIFE)
    local real l=GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE)
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, msgys("基地被攻击了!!!，血量剩余百分比为： ") + R2S(( l / maxl ) * 100))
endfunction
function ajidi takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function ajidi_1)
    call TriggerRegisterUnitEvent(tr, LoadUnitHandle(udg_hs, 0, StringHash("基地")), EVENT_UNIT_ATTACKED)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function ajidi_2)
    call TriggerRegisterUnitEvent(tr, LoadUnitHandle(udg_hs, 0, StringHash("基地")), EVENT_UNIT_DEATH)
    set tr=null
endfunction

//library libajidi ends
//library libchoicelv:
function choicelv_1 takes nothing returns nothing
    local integer li=LoadInteger(udg_hs, 0, H2I(GetClickedButton()))
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, msgys(" 选择了难度 " + I2S(li))) //发消息
    call SaveBoolean(udg_hs, 0, 1013, true) //确认已选择难度
    call SetPlayerTechResearched(Player(11), 'RA00', li) //设置难度
    //在这里设置难度
    call MultiboardSetTitleText(multi, "当前难度 " + I2S(li)) //标题
    call MultiboardDisplay(multi, true) //显示多面板
    //以下是启动出怪计时器
    call SaveTimerDialogHandle(udg_hs, 0, 1014, CreateTimerDialog(LoadTimerHandle(udg_hs, 0, 1015))) //保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs, 0, 1015), jsqjg, true, null) //启动出怪计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs, 0, 1014), true) //显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, 1014), "第" + I2S(b + 1) + "波") //修改计时器窗口标题
    call DestroyTrigger(GetTriggeringTrigger()) //删除触发
endfunction

function playcd_1 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(0)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function playcd_2 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(1)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function playcd_3 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(2)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function playcd_4 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(3)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function playcd_5 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(4)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function playcd_6 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(5)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    local integer xx
    local integer yy
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), 1016) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), 1016, false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), 1017)) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), 1016, true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), 1017, u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
            call SuspendHeroXP(u1, true) //禁止回城英雄获得经验
            if GetLocalPlayer() == p1 then
                call SetUnitFlyHeight(u1, 0, 0) //异步高度
            endif
            call UnitRemoveAbility(u1, 'Amov') //删除移动技能
        endif
    endif
    if li == 2 then //第二个按钮
        if GetLocalPlayer() == p1 then //本地玩家
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + 50, 0) //镜头+50
        endif
    endif
    if li == 3 then
        if GetLocalPlayer() == p1 then
            call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) - 50, 0)
        endif
    endif
    if li == 4 then //第四个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), 1018)
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), 1018, x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 6 then //第六个按钮
        set xx=GetPlayerId(p1)
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90荣誉系数 = " + R2S(vx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90翅膀系数 = " + R2S(cx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90转生系数 = " + R2S(zx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90英雄系数 = " + R2S(yx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90法强系数 = " + R2S(fx[xx]))
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90斗者系数 = " + R2S(dx[xx]))
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 1) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff武器经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 1)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 1)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 1))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 2) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff衣服经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 2)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 2)))) + " / " + I2S(( ( LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 2))) + 4 ) / 5 ) * 100))
        endif
        if HaveSavedHandle(udg_hs, GetHandleId(p1), 3) then
            call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff97ffff护手经验 = " + I2S(LoadInteger(udg_hs, GetHandleId(LoadItemHandle(udg_hs, GetHandleId(p1), 3)), GetItemLevel(LoadItemHandle(udg_hs, GetHandleId(p1), 3)))) + " / " + I2S(LoadInteger(udg_hs, 25, GetItemTypeId(LoadItemHandle(udg_hs, GetHandleId(p1), 3))) * 100))
        endif
        call DisplayTimedTextToPlayer(p1, 0, 0, 30, "|cff90ee90仅供参考 Powered By 张耀畅|r")
    endif
    if li == 7 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 322), true) //显示选择翅膀对话框
    endif
    if li == 8 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 324), true) //显示选择称号对话框
    endif
    if li == 9 then
        call DialogDisplay(p1, LoadDialogHandle(udg_hs, GetHandleId(p1), 323), true) //显示选择称号对话框
    endif
    if li > 10 and li < 19 then
        set xx=li - 10
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 8
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA3@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA3@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    if li > 24 and li < 28 then
        set xx=li - 24
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 3
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AE0/' + yy)
            endloop
            call UnitAddAbility(u1, 'AE0/' + xx)
            call BJDebugMsg(GetObjectName('AE0/' + xx))
        endif
    endif
    if li > 30 and li < 41 then
        set xx=li - 30
        if true then
            set yy=0
            set u1=LoadUnitHandle(udg_hs, GetHandleId(p1), 1002)
            loop
                exitwhen yy == 10
                set yy=yy + 1
                call UnitRemoveAbility(u1, 'AA4@' + yy)
            endloop
            call UnitAddAbility(u1, 'AA4@' + xx)
            call BJDebugMsg(GetObjectName('AA3@' + xx))
        endif
    endif
    set an=null
    set p1=null
    set u1=null
endfunction

function choicelv takes nothing returns nothing
    local trigger tr=CreateTrigger()
    local integer li=0
    call TriggerAddAction(tr, function choicelv_1)
    call SaveTriggerHandle(udg_hs, 0, StringHash("对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_1)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(1) + "对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_2)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(2) + "对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_3)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(3) + "对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_4)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(4) + "对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_5)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(5) + "对话框"), tr)
    
    //创建作弊触发
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function playcd_6)
    call SaveTriggerHandle(udg_hs, 0, StringHash(I2S(6) + "对话框"), tr)
    
    set tr=null
endfunction

//library libchoicelv ends
//library libfuhuo:
function fuhuo_2 takes nothing returns nothing
    //复活计时器
    local timer ti1=GetExpiredTimer()
    local unit lu1=LoadUnitHandle(udg_hs, H2I(ti1), 444)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77) + 128
    call ReviveHero(lu1, x, y, true) //复活
    call DestroyTimer(GetExpiredTimer()) //删除到期的计时器
        if GetOwningPlayer(lu1) == GetLocalPlayer() then //异步
            call SetCameraPosition(x, y) //设置镜头
            call ClearSelection() //清除选择
            call SelectUnit(lu1, true) //选择英雄
        endif
    set ti1=null
    set lu1=null
endfunction
function fuhuo_1 takes nothing returns nothing
    //复活触发
    local timer lti
    if HaveSavedBoolean(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), 'A00B') then //死而后已
        call SetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER) + b * GetPlayerTechCount(Player(11), 'RA00', true))
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "你在天赋死而后已中获得木材 : " + I2S(b * GetPlayerTechCount(Player(11), 'RA00', true)))
    endif
    set lti=CreateTimer()
    call TimerStart(lti, 5, false, function fuhuo_2)
    call SaveUnitHandle(udg_hs, H2I(lti), 444, GetTriggerUnit())
    set lti=null
endfunction
function fuhuo takes nothing returns nothing
    local trigger tr
    set tr=CreateTrigger()
    //创建英雄死亡触发
    call SaveTriggerHandle(udg_hs, 0, 1003, tr)
    call TriggerAddAction(tr, function fuhuo_1)
    set tr=null
endfunction

//library libfuhuo ends
//library libgetitem:
function getitem_2 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), 1002)
    local item litem=GetManipulatedItem()
    local integer ti= GetItemTypeId(litem)
    local integer ti1=LoadInteger(udg_hs, 10, ti)
    local real x= LoadReal(udg_hs, 4, ti1)
    local real y= LoadReal(udg_hs, 5, ti1)
    local real face= LoadReal(udg_hs, 6, ti1)
    local unit u1= GetTriggerUnit()
    local integer lv=GetItemLevel(litem)
    local integer array li
    if GetItemType(litem) == ITEM_TYPE_POWERUP then //判断能量提升
        if lv == 1 and GetUnitState(u, UNIT_STATE_LIFE) > 0.405 then //判断等级开启传送
            call UnitAddItem(u1, litem) //转移物品
            return //退出
        endif
        if lv == 2 or lv == 3 or lv == 4 then //2级武器,3级衣服,4级护手
            set li[0]=0 //初始化循环
            set li[1]=LoadInteger(udg_hs, 22, ti) //读取强化书等级
            set li[2]=LoadInteger(udg_hs, ti, lv) //读取强化书对应武器类型
            loop //遍历物品栏
                exitwhen li[0] == 6
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == li[2] then //判断有无对应装备
                    set li[3]=GetItemTypeId(UnitItemInSlot(u1, li[0])) //读取对应装备
                    call RemoveSavedInteger(udg_hs, GetHandleId(UnitItemInSlot(u1, li[0])), GetItemLevel(UnitItemInSlot(u1, li[0]))) //清除即将移除的物品绑定哈希表
                    call RemoveItem(UnitItemInSlot(u1, li[0])) //删除旧装备
                    set litem=CreateItem(LoadInteger(udg_hs, 21, li[3]), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())) //创建新装备
                    call UnitAddItem(u1, litem) //添加给单位
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "装备已升级成" + GetItemName(litem)) //发送辣鸡消息
                    set litem=null
                    set u1=null
                    call RemoveItem(GetManipulatedItem()) //能量提升直排
                    return //退出
                endif
                set li[0]=li[0] + 1
            endloop
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "装备强化失败，请检查你的装备")
            call RemoveItem(GetManipulatedItem()) //能量提升直排
            set litem=null
            set u1=null
            return
        endif
        if lv == 7 then
            set lgf[GetPlayerId(GetOwningPlayer(u1))]=1
            set lgf[GetPlayerId(GetOwningPlayer(u1)) + 12]=ti + 738131968
        endif
        if lv == 8 and GetUnitState(u, UNIT_STATE_LIFE) > 0.405 then
            call UnitAddItem(u, CreateItem(1229008944 + GetPlayerId(GetOwningPlayer(u)), GetUnitX(u), GetUnitY(u)))
        endif
        call RemoveItem(GetManipulatedItem()) //能量提升直排
    endif
    if GetItemType(litem) == ITEM_TYPE_PURCHASABLE then //判断是否材料，类型为可购买
        if lv == 1 then //一级新手装备，直接给予英雄真强化书
            call UnitAddItem(u, litem) //转移物品
            
        endif
        if lv == 2 then //二级属于真材实料，需要判断玩家是否材料齐全
            //目前如果玩家拾取到未注册的可购买类物品会崩溃，原因是死循环，因为未注册无法获取需要几个材料
            set li[0]=LoadInteger(udg_hs, ti, 0) //获取物品合成需要几个材料
            set li[1]=0 //初始化主循环
            set li[2]=0 //初始化子循环
            set li[3]=0 //初始化玩家拥有材料种类数量
            set li[4]=0 //初始化合成循环
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1, li[2])) == LoadInteger(udg_hs, ti, li[1] + 1) then //判断单位是否有所需材料
                        call SaveItemHandle(udg_hs, 9999, li[3], UnitItemInSlot(u1, li[2])) //保存判断到的材料
                        set li[3]=li[3] + 1 //记录材料种类数量
                        set li[2]=5
                        if li[1] == 0 then
                            set li[5]=GetItemTypeId(UnitItemInSlot(u1, li[2]))
                        endif
                    endif
                    exitwhen li[2] == 5
                    set li[2]=li[2] + 1
                endloop
                set li[1]=li[1] + 1
                set li[2]=0 //恢复循环数
                exitwhen li[1] == li[0] //循环所需材料次数
            endloop
            if li[0] == li[3] then //玩家已拥有足够的材料
                set litem=LoadItemHandle(udg_hs, 9999, 0) //读取主线材料
                set li[5]=GetItemTypeId(litem) //读取主线材料ID
                set li[6]=LoadInteger(udg_hs, 25, li[5]) //读取升级对应的等级
                set li[7]=( ( li[6] + 4 ) / 5 ) * 100 //读取升级所需经验
                set li[8]=GetHandleId(litem)
                set li[9]=GetItemLevel(litem)
                set li[10]=LoadInteger(udg_hs, li[8], li[9]) + 1
                set li[11]=0 //判读是否具备升级条件
                if GetItemType(litem) == ITEM_TYPE_PERMANENT and li[6] < 16 and ModuloInteger(li[6], 5) == 0 and ( li[9] == 2 or li[9] == 1 ) then //只有武器和衣服需要判断经验来合成
                    if li[7] <= li[10] then //判断经验是否足够
                    else
                    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "材料已齐全，装备经验不足")
                    set li[11]=1 //拒绝升级
                    call BJDebugMsg(I2S(li[7]) + "   " + I2S(li[10]))
                    endif
                endif
                if li[11] == 0 then
                    if LoadBoolean(udg_hs, ti, 10) then //判断是合成还是强化，区别在强化的循环
                        loop //删除多余物品
                            set li[4]=li[4] + 1
                            call RemoveItem(LoadItemHandle(udg_hs, 9999, li[4]))
                            exitwhen li[4] == li[0]
                        endloop
                        //进入强化阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    else
                        loop //删除多余物品
                            call RemoveItem(LoadItemHandle(udg_hs, 9999, li[4]))
                            exitwhen li[4] == li[0]
                            set li[4]=li[4] + 1
                        endloop
                        //进入合成阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    endif
                endif
            endif
            call FlushChildHashtable(udg_hs, 9999) //清空哈希表
        endif
        if lv == 3 then //三级五行强化
            set li[0]=0 //初始化循环
            set li[1]=0
            loop
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == 'IB13' or GetItemTypeId(UnitItemInSlot(u1, li[0])) == 'IB2E' then
                    set li[1]=GetItemTypeId(UnitItemInSlot(u1, li[0]))
                    set li[3]=li[0]
                    set li[0]=5
                endif
                exitwhen li[0] == 5
                set li[0]=li[0] + 1
            endloop
            if li[1] != 0 then
                set li[4]=GetRandomInt(1, 5)
                call RemoveItem(UnitItemInSlot(u1, li[3]))
                call RemoveItem(litem)
                set litem=CreateItem(LoadInteger(udg_hs, li[1], li[4]), GetUnitX(u1), GetUnitY(u1))
                call UnitAddItem(u1, litem)
            endif
        endif
        if lv == 4 then //四级也是直接给
            set li[1]=LoadInteger(udg_hs, GetItemTypeId(litem), 0)
            set li[0]=0 //初始化循环
            set li[2]=LoadInteger(udg_hs, GetItemTypeId(litem), 1)
            loop
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == li[1] then
                    call RemoveItem(UnitItemInSlot(u1, li[0]))
                    call RemoveItem(litem)
                    call UnitAddItem(u1, CreateItem(li[2], GetUnitX(u1), GetUnitY(u1)))
                    set li[0]=5
                endif
                exitwhen li[0] == 5
                set li[0]=li[0] + 1
            endloop
        endif
        if lv == 5 then //五级只有一个辣鸡
            set li[0]='IB3Q'
            set li[1]='IB3R'
            set li[2]='IB3S'
            set li[3]='IB3T'
            set li[4]=0
            set li[5]=0
            set li[6]=0
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1, li[5])) == li[li[4]] then
                        set li[6]=li[6] + 1
                        call SaveItemHandle(udg_hs, 10086, li[6], UnitItemInSlot(u1, li[5]))
                        set li[5]=5
                    endif
                    exitwhen li[5] == 5
                    set li[5]=li[5] + 1
                endloop
                exitwhen li[4] == 3
                set li[4]=li[4] + 1
                set li[5]=0
            endloop
            if li[6] == 4 then
                set li[5]=0
                loop
                    exitwhen li[5] == 4
                    set li[5]=li[5] + 1
                    call RemoveItem(LoadItemHandle(udg_hs, 10086, li[5]))
                endloop
                call UnitAddItem(u1, CreateItem('IB2D', GetUnitX(u1), GetUnitY(u1)))
            endif
        endif
    endif
    if GetItemType(litem) == ITEM_TYPE_CHARGED then //判断是否可充物品
        set li[0]=0
        loop
            if GetItemTypeId(UnitItemInSlot(u1, li[0])) == GetItemTypeId(litem) and litem != UnitItemInSlot(u1, li[0]) then
                call SetItemCharges(UnitItemInSlot(u1, li[0]), GetItemCharges(UnitItemInSlot(u1, li[0])) + GetItemCharges(litem)) //可充物品自动叠加
                call RemoveItem(litem) //移除已叠加物品
                set li[0]=5
            endif
            exitwhen li[0] == 5
            set li[0]=li[0] + 1
        endloop
    endif
    set litem=null
    set u=null
    set u1=null
endfunction
function getitem_1 takes nothing returns nothing
    local item litem=GetManipulatedItem()
    local integer ti= GetItemTypeId(litem)
    local integer ti1=LoadInteger(udg_hs, 10, ti)
    local real x= LoadReal(udg_hs, 4, ti1)
    local real y= LoadReal(udg_hs, 5, ti1)
    local real face= LoadReal(udg_hs, 6, ti1)
    local unit u1= GetTriggerUnit()
    local integer lv=GetItemLevel(litem)
    local integer array li
    local unit u2
    if GetItemType(litem) == ITEM_TYPE_POWERUP then //判断能量提升
        if lv == 1 then //判断等级开启传送
            call SetUnitPosition(u1, x, y) //传送
            call SetUnitFacing(u1, face) //设置面向角度
            if GetOwningPlayer(GetTriggerUnit()) == GetLocalPlayer() then //异步
                call SetCameraPosition(x, y)
                call ClearSelection()
                call SelectUnit(GetTriggerUnit(), true)
            endif
            call RemoveItem(litem) //能量提升直排
            set u1=null
            set litem=null
            return //退出
        endif
        if lv == 2 or lv == 3 or lv == 4 then //2级武器,3级衣服
            set li[0]=0 //初始化循环
            set li[1]=LoadInteger(udg_hs, 22, ti) //读取强化书等级
            set li[2]=LoadInteger(udg_hs, ti, lv) //读取强化书对应武器类型
            loop //遍历物品栏
                exitwhen li[0] == 6
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == li[2] then //判断有无对应装备
                    set li[3]=GetItemTypeId(UnitItemInSlot(u1, li[0])) //读取对应装备
                    call RemoveSavedInteger(udg_hs, GetHandleId(UnitItemInSlot(u1, li[0])), GetItemLevel(UnitItemInSlot(u1, li[0]))) //清除即将移除的物品绑定哈希表
                    call RemoveSavedHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), GetItemLevel(UnitItemInSlot(u1, li[0]))) //清除物品绑定玩家
                    call RemoveItem(UnitItemInSlot(u1, li[0])) //删除旧装备
                    set litem=CreateItem(LoadInteger(udg_hs, 21, li[3]), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())) //创建新装备
                    call UnitAddItem(u1, litem) //添加给单位
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "装备已升级成" + GetItemName(litem)) //发送辣鸡消息
                    set litem=null
                    set u1=null
                    call RemoveItem(GetManipulatedItem()) //能量提升直排
                    return //退出
                endif
                set li[0]=li[0] + 1
            endloop
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "装备强化失败，请检查你的装备")
            call RemoveItem(GetManipulatedItem()) //能量提升直排
            set litem=null
            set u1=null
            return
        endif
        if lv == 7 then //切换刷怪类型，后续判断是否够钱
            set lgf[GetPlayerId(GetOwningPlayer(u1))]=1
            set lgf[GetPlayerId(GetOwningPlayer(u1)) + 12]=ti + 738131968
        endif
        if lv == 8 then //转生
            if ti == 'I001' then //进入转生房
                call UnitAddItem(u1, CreateItem(1229008944 + GetPlayerId(GetOwningPlayer(u1)), GetUnitX(u1), GetUnitY(u1)))
            else
                if ti == 'I002' then //进入转生
                    set li[0]=GetPlayerId(GetOwningPlayer(u1))
                    if true then //足够的钱
                        if zx[li[0]] <= 0.6 and GetHeroLevel(u1) >= li[0] * 1000 then //足够的等级，或者可以转生
                            if li[0] > 3 then
                                call UnitAddItem(u1, CreateItem('IA0=' + GetPlayerId(GetOwningPlayer(u1)), GetUnitX(u1), GetUnitY(u1))) //给予进入转生房的物品
                                if HaveSavedInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51) then
                                else
                                    set u2=CreateUnit(Player(11), 'UB10' + R2I(zx[li[0]] * 10), LoadReal(udg_hs, 1, li[0] + 7), LoadReal(udg_hs, 2, li[0] + 7), LoadReal(udg_hs, 3, li[0] + 7)) //创建转生BOSS
                                    call SaveInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51, li[0])
                                    call SaveInteger(udg_hs, GetHandleId(u2), 51, li[0])
                                endif
                            else
                                call UnitAddItem(u1, CreateItem('IA06' + GetPlayerId(GetOwningPlayer(u1)), GetUnitX(u1), GetUnitY(u1))) //给予进入转生房的物品
                                if HaveSavedInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51) then
                                else
                                    set u2=CreateUnit(Player(11), 'UB10' + R2I(zx[li[0]] * 10), LoadReal(udg_hs, 1, li[0] + 7), LoadReal(udg_hs, 2, li[0] + 7), LoadReal(udg_hs, 3, li[0] + 7)) //创建转生BOSS
                                    call SaveInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51, li[0])
                                    call SaveInteger(udg_hs, GetHandleId(u2), 51, li[0])
                                endif
                            endif
                        endif
                    endif
                else
                    if ti == 'I003' or ti == 'I004' then //修神或入魔
                        if true then //足够的钱
                            if zx[li[0]] == 0.7 and GetHeroLevel(u1) >= li[0] * 1000 then //足够的等级和转生
                                if li[0] > 3 then
                                    call UnitAddItem(u1, CreateItem('IA0=' + GetPlayerId(GetOwningPlayer(u1)), GetUnitX(u1), GetUnitY(u1))) //给予进入转生房的物品
                                    if HaveSavedInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51) then
                                    else
                                        set u2=CreateUnit(Player(11), ti + 202506499, LoadReal(udg_hs, 1, li[0] + 7), LoadReal(udg_hs, 2, li[0] + 7), LoadReal(udg_hs, 3, li[0] + 7)) //创建转生BOSS
                                        call SaveInteger(udg_hs, GetHandleId(u2), 51, li[0])
                                        call SaveInteger(udg_hs, GetHandleId(u2), 52, ti - 'I003')
                                        call SaveInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51, li[0])
                                        
                                    endif
                                else
                                    call UnitAddItem(u1, CreateItem('IA06' + GetPlayerId(GetOwningPlayer(u1)), GetUnitX(u1), GetUnitY(u1))) //给予进入转生房的物品
                                    if HaveSavedInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51) then
                                    else
                                        set u2=CreateUnit(Player(11), ti + 202506499, LoadReal(udg_hs, 1, li[0] + 7), LoadReal(udg_hs, 2, li[0] + 7), LoadReal(udg_hs, 3, li[0] + 7)) //创建转生BOSS
                                        call SaveInteger(udg_hs, GetHandleId(u2), 52, ti - 'I003')
                                        call SaveInteger(udg_hs, GetHandleId(u2), 51, li[0])
                                        call SaveInteger(udg_hs, GetHandleId(GetOwningPlayer(u1)), 51, li[0])
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
        call RemoveItem(GetManipulatedItem()) //能量提升直排
    endif
    if GetItemType(litem) == ITEM_TYPE_PERMANENT then //判断永久物品
        if lv > 0 and lv < 6 then //一级武器，二级衣服，三级手套，四级护符，五级项链
            set li[0]=0
            loop
                exitwhen li[0] == 6
                if GetItemLevel(UnitItemInSlot(u1, li[0])) == lv and UnitItemInSlot(u1, li[0]) != litem and ITEM_TYPE_PERMANENT == GetItemType(UnitItemInSlot(u1, li[0])) then //只能携带一件同类装备
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "你身上已有同类物品")
                    call UnitRemoveItem(u1, litem) //丢掉捡到的物品
                    set litem=UnitItemInSlot(u1, li[0]) //记录匹配的物品
                    call UnitRemoveItem(u1, litem) //丢掉匹配的物品
                    call UnitAddItem(u1, litem) //在捡起丢掉的物品
                    set litem=null
                    set u1=null
                    return
                endif
                set li[0]=li[0] + 1
            endloop
            if ( lv < 3 and LoadInteger(udg_hs, 25, ti) < 16 and LoadInteger(udg_hs, 25, ti) > 0 ) or ( lv == 3 and LoadInteger(udg_hs, 25, ti) < 6 and LoadInteger(udg_hs, 25, ti) > 0 ) then //小于15级的武器和衣服才绑定
                call SaveItemHandle(udg_hs, GetHandleId(GetOwningPlayer(u1)), lv, litem) //物品绑定玩家
            endif
        endif
    endif
    if GetItemType(litem) == ITEM_TYPE_PURCHASABLE then //判断是否材料，类型为可购买
        if lv == 1 then //一级新手装备，直接给予英雄真强化书
            set li[0]=0 //初始化循环
            set li[1]=LoadInteger(udg_hs, GetItemTypeId(litem), 0) //读取是武器还是衣服
            set li[2]=0 //判断装备的内置等级
            loop
                if GetItemType(UnitItemInSlot(u1, li[0])) == ITEM_TYPE_PERMANENT and GetItemLevel(UnitItemInSlot(u1, li[0])) == li[1] then
                    set li[2]=LoadInteger(udg_hs, 25, GetItemTypeId(UnitItemInSlot(u1, li[0]))) //获取装备内置等级
                    set li[0]=5
                endif
                exitwhen li[0] == 5
                set li[0]=li[0] + 1
            endloop
            call RemoveItem(litem)
            if li[2] > 0 and li[2] < 5 then
                //在这里判读穷逼有没有足够的金币，没有就拒绝强化
                call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, ti, li[2]), GetUnitX(u1), GetUnitY(u1)))
            else
                call DisplayTimedTextToPlayer(GetOwningPlayer(u1), 0, 0, 10, msg(1) + "你没有合适的装备能升级") //发送辣鸡消息
            endif
        endif
        if lv == 2 then //二级属于真材实料，需要判断玩家是否材料齐全
            //目前如果玩家拾取到未注册的可购买类物品会崩溃，原因是死循环，因为未注册无法获取需要几个材料
            set li[0]=LoadInteger(udg_hs, ti, 0) //获取物品合成需要几个材料
            set li[1]=0 //初始化主循环
            set li[2]=0 //初始化子循环
            set li[3]=0 //初始化玩家拥有材料种类数量
            set li[4]=0 //初始化合成循环
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1, li[2])) == LoadInteger(udg_hs, ti, li[1] + 1) then //判断单位是否有所需材料
                        call SaveItemHandle(udg_hs, 9999, li[3], UnitItemInSlot(u1, li[2])) //保存判断到的材料
                        set li[3]=li[3] + 1 //记录材料种类数量
                        set li[2]=5
                        if li[1] == 0 then
                            set li[5]=GetItemTypeId(UnitItemInSlot(u1, li[2]))
                        endif
                    endif
                    exitwhen li[2] == 5
                    set li[2]=li[2] + 1
                endloop
                set li[1]=li[1] + 1
                set li[2]=0 //恢复循环数
                exitwhen li[1] == li[0] //循环所需材料次数
            endloop
            if li[0] == li[3] then //玩家已拥有足够的材料
                set litem=LoadItemHandle(udg_hs, 9999, 0) //读取主线材料
                set li[5]=GetItemTypeId(litem) //读取主线材料ID
                set li[6]=LoadInteger(udg_hs, 25, li[5]) //读取升级对应的等级
                set li[7]=( ( li[6] + 4 ) / 5 ) * 100 //读取升级所需经验
                set li[8]=GetHandleId(litem)
                set li[9]=GetItemLevel(litem)
                set li[10]=LoadInteger(udg_hs, li[8], li[9]) + 1
                set li[11]=0 //判读是否具备升级条件
                if GetItemType(litem) == ITEM_TYPE_PERMANENT and li[6] < 16 and ModuloInteger(li[6], 5) == 0 and ( li[9] == 2 or li[9] == 1 ) then //只有武器和衣服需要判断经验来合成
                    if li[7] <= li[10] then //判断经验是否足够
                    else
                    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "材料已齐全，装备经验不足")
                    set li[11]=1 //拒绝升级
                    call BJDebugMsg(I2S(li[7]) + "   " + I2S(li[10]))
                    endif
                endif
                if li[11] == 0 then
                    if LoadBoolean(udg_hs, ti, 10) then //判断是合成还是强化，区别在强化的循环
                        loop //删除多余物品
                            set li[4]=li[4] + 1
                            call RemoveItem(LoadItemHandle(udg_hs, 9999, li[4]))
                            exitwhen li[4] == li[0]
                        endloop
                        //进入强化阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    else
                        loop //删除多余物品
                            call RemoveItem(LoadItemHandle(udg_hs, 9999, li[4]))
                            exitwhen li[4] == li[0]
                            set li[4]=li[4] + 1
                        endloop
                        //进入合成阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    endif
                endif
            endif
            call FlushChildHashtable(udg_hs, 9999) //清空哈希表
        endif
        if lv == 3 then //三级五行强化
            set li[0]=0 //初始化循环
            set li[1]=0
            loop
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == 'IB13' or GetItemTypeId(UnitItemInSlot(u1, li[0])) == 'IB2E' then
                    set li[1]=GetItemTypeId(UnitItemInSlot(u1, li[0]))
                    set li[3]=li[0]
                    set li[0]=5
                endif
                exitwhen li[0] == 5
                set li[0]=li[0] + 1
            endloop
            if li[1] != 0 then
                set li[4]=GetRandomInt(1, 5)
                call RemoveItem(UnitItemInSlot(u1, li[3]))
                call RemoveItem(litem)
                set litem=CreateItem(LoadInteger(udg_hs, li[1], li[4]), GetUnitX(u1), GetUnitY(u1))
                call UnitAddItem(u1, litem)
            endif
        endif
        if lv == 4 then //四级也是直接给
            set li[1]=LoadInteger(udg_hs, GetItemTypeId(litem), 0)
            set li[0]=0 //初始化循环
            set li[2]=LoadInteger(udg_hs, GetItemTypeId(litem), 1)
            loop
                if GetItemTypeId(UnitItemInSlot(u1, li[0])) == li[1] then
                    call RemoveItem(UnitItemInSlot(u1, li[0]))
                    call RemoveItem(litem)
                    call UnitAddItem(u1, CreateItem(li[2], GetUnitX(u1), GetUnitY(u1)))
                    set li[0]=5
                endif
                exitwhen li[0] == 5
                set li[0]=li[0] + 1
            endloop
        endif
        if lv == 5 then //五级只有一个辣鸡
            set li[0]='IB3Q'
            set li[1]='IB3R'
            set li[2]='IB3S'
            set li[3]='IB3T'
            set li[4]=0
            set li[5]=0
            set li[6]=0
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1, li[5])) == li[li[4]] then
                        set li[6]=li[6] + 1
                        call SaveItemHandle(udg_hs, 10086, li[6], UnitItemInSlot(u1, li[5]))
                        set li[5]=5
                    endif
                    exitwhen li[5] == 5
                    set li[5]=li[5] + 1
                endloop
                exitwhen li[4] == 3
                set li[4]=li[4] + 1
                set li[5]=0
            endloop
            if li[6] == 4 then
                set li[5]=0
                loop
                    exitwhen li[5] == 4
                    set li[5]=li[5] + 1
                    call RemoveItem(LoadItemHandle(udg_hs, 10086, li[5]))
                endloop
                call UnitAddItem(u1, CreateItem('IB2D', GetUnitX(u1), GetUnitY(u1)))
            endif
        endif
    endif
    if GetItemType(litem) == ITEM_TYPE_CHARGED then //判断是否可充物品
        set li[0]=0
        loop
            if GetItemTypeId(UnitItemInSlot(u1, li[0])) == GetItemTypeId(litem) and litem != UnitItemInSlot(u1, li[0]) then
                call SetItemCharges(UnitItemInSlot(u1, li[0]), GetItemCharges(UnitItemInSlot(u1, li[0])) + GetItemCharges(litem)) //可充物品自动叠加
                call RemoveItem(litem) //移除已叠加物品
                set li[0]=5
            endif
            exitwhen li[0] == 5
            set li[0]=li[0] + 1
        endloop
    endif
    set litem=null
    set u1=null
    set u2=null
endfunction
function dropitem takes nothing returns nothing
    if GetItemType(GetManipulatedItem()) == ITEM_TYPE_PERMANENT then //判断丢弃了永久物品
        call RemoveSavedHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), GetItemLevel(GetManipulatedItem())) //清除单位的绑定
    endif
endfunction
function getitem takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function getitem_1)
    call SaveTriggerHandle(udg_hs, 0, 1004, tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function getitem_2)
    call SaveTriggerHandle(udg_hs, 0, 1006, tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function dropitem)
    call SaveTriggerHandle(udg_hs, 0, 1005, tr)
    set tr=null
endfunction

//library libgetitem ends
//library libinput:
function input_1 takes nothing returns nothing
    //输入触发
    local string s1=GetEventPlayerChatString()
    local integer len= StringLength(s1)
    local string s2=SubString(s1, 1, 3)
    local player p1=GetTriggerPlayer()
    local integer tempi=S2I(SubString(s1, 1, 30))
    if s2 == "hg" then //判断输入
        call hg(LoadUnitHandle(udg_hs, H2I(p1), 1002)) //调用回城函数
    endif
    //call SetPlayerAbilityAvailable(p1,tempi,true)//测试添加技能
    //call SetPlayerAbilityAvailable(p1,1093677105,false)
    //call SetPlayerAbilityAvailable(p1,1093677105,true)
    //call BJDebugMsg(GetObjectName(tempi))
    if s2 == "1" then
        call IncUnitAbilityLevel(LoadUnitHandle(udg_hs, H2I(p1), 1002), 'A00T')
    endif
endfunction
function input takes nothing returns nothing
    local trigger tr
        set tr=CreateTrigger()
        //创建输入触发
        call SaveTriggerHandle(udg_hs, 0, 1011, tr)
        call TriggerAddAction(tr, function input_1)
        set tr=null
endfunction

//library libinput ends
//library liblist:
function list_2 takes nothing returns nothing
    local player p1=LoadPlayerHandle(udg_hs, 0, H2I(GetExpiredTimer()))
    call SaveBoolean(udg_hs, H2I(p1), 1020, false)
    set p1=null
endfunction
function list_1 takes nothing returns nothing
    local unit u1=GetTriggerUnit()
    local integer li=GetUnitTypeId(u1)
    local player p1=GetOwningPlayer(u1)
    local boolean bool=LoadBoolean(udg_hs, H2I(p1), 1020)
    local timer t1
    if li == 'HB00' then
        if bool then
            call SaveBoolean(udg_hs, H2I(p1), 1020, false) //保存正在双击
            if GetLocalPlayer() == p1 then //异步
                call ClearSelection()
            endif
            call DialogDisplay(p1, LoadDialogHandle(udg_hs, H2I(p1), 321), true) //显示对话框
        else
            set t1=CreateTimer() //启动计时器
            call TimerStart(t1, 0.5, false, function list_2) //设置计时器回调函数
            call SavePlayerHandle(udg_hs, 0, H2I(t1), p1) //保存handle
            call SaveBoolean(udg_hs, H2I(p1), 1020, true) ///确认已单击
            if GetLocalPlayer() == p1 then //异步
                //call ClearSelection()//清空玩家选择，往后可能取消这个选项，作为宠物使用，条件也需要修改
            endif
        endif
    endif
    if li == 'HB01' then
        call hg(LoadUnitHandle(udg_hs, H2I(p1), 1002)) //回城函数
    endif
    set u1=null
    set p1=null
    set t1=null
endfunction
function list takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call SaveTriggerHandle(udg_hs, 0, 1007, tr)
    call TriggerAddAction(tr, function list_1)
    set tr=null
endfunction

//library liblist ends
//library libselecthero:
function temptime takes nothing returns nothing
    local player lp= LoadPlayerHandle(udg_hs, H2I(GetExpiredTimer()), 1)
    call RemoveSavedHandle(udg_hs, H2I(lp), 999)
    call DestroyTimer(GetExpiredTimer())
endfunction
function xzyx1 takes nothing returns nothing
    local timer tti
    local integer li1=0
    local integer li2
    local unit u1
    if GetOwningPlayer(GetTriggerUnit()) == Player(15) then //判断选择的英雄是否玩家16
        if HaveSavedHandle(udg_hs, H2I(GetTriggerPlayer()), 1002) then //判断玩家是否已选英雄
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, msgys("你已经选择了英雄!"))
        else
            if LoadUnitHandle(udg_hs, H2I(GetTriggerPlayer()), 999) == GetTriggerUnit() then //判断玩家当前选择是同一个英雄
                call SetUnitOwner(GetTriggerUnit(), GetTriggerPlayer(), true) //改变单位所有者
                call SaveUnitHandle(udg_hs, H2I(GetTriggerPlayer()), 1002, GetTriggerUnit()) //记录玩家英雄
                //开始设置多面板数据
                set li2=GetPlayerId(GetTriggerPlayer())
                call MultiboardSetItemValue(multiitem[li2 * 7], "最强王者") //荣誉
                call MultiboardSetItemValue(multiitem[li2 * 7 + 1], GetPlayerName(GetTriggerPlayer())) //玩家名
                call MultiboardSetItemValue(multiitem[li2 * 7 + 2], GetUnitName(GetTriggerUnit())) //英雄
                call MultiboardSetItemValue(multiitem[li2 * 7 + 3], "最强输出") //称号
                call MultiboardSetItemValue(multiitem[li2 * 7 + 4], "普通") //进阶
                call MultiboardSetItemValue(multiitem[li2 * 7 + 5], "88888888") //结晶
                call MultiboardSetItemValue(multiitem[li2 * 7 + 6], "屠杀野猪捡奶酪V2.0") //备用
                //结束设置多面板数据
                set li2=LoadInteger(udg_hs, 0, 1001) //同下
                call SaveInteger(udg_hs, 0, 1001, li2 + 1) //记录已选择英雄的人数
                call SetUnitX(GetTriggerUnit(), LoadReal(udg_hs, 4, 77)) //设置坐标
                call SetUnitY(GetTriggerUnit(), LoadReal(udg_hs, 5, 77) + 128) //同上
                set yx[GetPlayerId(GetTriggerPlayer())]=LoadReal(udg_hs, 30, GetUnitTypeId(GetTriggerUnit())) //设置英雄系数
                call SetPlayerAbilityAvailable(GetTriggerPlayer(), jn[20 * GetPlayerId(GetTriggerPlayer()) + 1], true) //开局获得一个天赋点
                call SaveBoolean(udg_hs, GetHandleId(GetTriggerPlayer()), jn[20 * GetPlayerId(GetTriggerPlayer()) + 1], true) //开启该技能
                call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, false) //禁用下一页
                call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, true) //启用下一页
                set jn[20 * GetPlayerId(GetTriggerPlayer()) + 20]=1
                if GetUnitTypeId(GetTriggerUnit()) == 'HA0G' then //神代魔术师
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(), jn[20 * GetPlayerId(GetTriggerPlayer()) + 2], true) //开局获得一个天赋点
                    call SaveBoolean(udg_hs, GetHandleId(GetTriggerPlayer()), jn[20 * GetPlayerId(GetTriggerPlayer()) + 2], true) //开启该技能
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(), jn[20 * GetPlayerId(GetTriggerPlayer()) + 3], true) //开局获得一个天赋点
                    call SaveBoolean(udg_hs, GetHandleId(GetTriggerPlayer()), jn[20 * GetPlayerId(GetTriggerPlayer()) + 3], true) //开启该技能
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, false) //禁用下一页
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(), 1093677105, true) //启用下一页
                    set jn[20 * GetPlayerId(GetTriggerPlayer()) + 20]=3
                endif
                set jn[20 * GetPlayerId(GetTriggerPlayer()) + 19]=0 //用来限制购买的天赋
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 300), GetTriggerUnit(), EVENT_UNIT_HERO_LEVEL) //注册英雄升级事件
                //set yx[GetPlayerId(GetTriggerPlayer())]=LoadReal(udg_hs,31,GetUnitTypeId(GetTriggerUnit()))//设置法强系数
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 1003), GetTriggerUnit(), EVENT_UNIT_DEATH) //注册复活英雄事件
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, msgys(GetPlayerName(GetTriggerPlayer()) + " 选择了 " + GetObjectName(GetUnitTypeId(GetTriggerUnit())))) //发送消息
                call SetUnitInvulnerable(GetTriggerUnit(), false) //取消无敌
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 1004), GetTriggerUnit(), EVENT_UNIT_PICKUP_ITEM) //注册单位获得物品事件
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 1005), GetTriggerUnit(), EVENT_UNIT_DROP_ITEM) //注册单位丢弃物品事件
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 99), GetTriggerUnit(), EVENT_UNIT_SPELL_EFFECT) //注册发动技能效果事件
                set u1=CreateUnit(Player(15), 'HB00', LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77), LoadReal(udg_hs, 6, 77)) //创建菜单英雄
                call TriggerRegisterPlayerUnitEvent(LoadTriggerHandle(udg_hs, 0, 1007), GetTriggerPlayer(), EVENT_PLAYER_UNIT_SELECTED, null) //再次注册选择单位触发
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 1008), u1, EVENT_UNIT_RESEARCH_FINISH) //注册科技共享触发
                call SetUnitOwner(u1, GetTriggerPlayer(), true) //改变单位所有者
                call SuspendHeroXP(u1, true) //禁止菜单英雄获得经验
                call SetUnitInvulnerable(u1, true) //设置无敌
                call SetUnitFlyHeight(u1, 10000, 0) //设置飞行高度
                if GetTriggerPlayer() == GetLocalPlayer() then //判断本地玩家，异步
                    call SetCameraPosition(LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77) + 128) //异步镜头
                    call SetUnitFlyHeight(u1, 0, 0) //异步高度
                endif
                set u1=CreateUnit(GetTriggerPlayer(), 'hCZZ', LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77) + 256, LoadReal(udg_hs, 6, 77)) //创建宠物
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 1006), u1, EVENT_UNIT_PICKUP_ITEM) //注册单位获得物品事件
                call SaveUnitHandle(udg_hs, GetHandleId(GetTriggerPlayer()), 49, u1) //存储宠物
                call SetUnitInvulnerable(u1, true) //设置无敌
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 102), u1, EVENT_UNIT_SPELL_EFFECT) //注册宠物发动技能效果事件
                set u1=null
                if GetUnitTypeId(GetTriggerUnit()) == 'HA07' then //注册召唤事件
                    call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, 101), GetTriggerUnit(), EVENT_UNIT_SUMMON)
                endif
                if li2 + 1 == LoadInteger(udg_hs, 0, 1009) then //判断所有人都选了英雄
                    call DisableTrigger(GetTriggeringTrigger()) //关闭触发
                    call DestroyTrigger(GetTriggeringTrigger()) //删除触发
                    loop
                        exitwhen li1 == 18
                        if GetOwningPlayer(LoadUnitHandle(udg_hs, 8, li1)) == Player(15) then //判断单位是否被选取
                            call RemoveUnit(LoadUnitHandle(udg_hs, 8, li1)) //没有被选取的会直接删除
                        endif
                        set li1=li1 + 1
                    endloop
                    call FlushChildHashtable(udg_hs, 8) //清空哈希表
                    call RemoveSavedInteger(udg_hs, 0, 1001)
                    call RemoveSavedHandle(udg_hs, 0, 1010)
                endif
            else
                call SaveUnitHandle(udg_hs, H2I(GetTriggerPlayer()), 999, GetTriggerUnit()) //存储临时选择
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "你选择了  【" + msgys(GetObjectName(GetUnitTypeId(GetTriggerUnit()))) + "】  确认请双击！") //信息
                set tti=CreateTimer() //创建双击计时器
                call TimerStart(tti, 0.5, false, function temptime) //计时器回调和启动
                call SavePlayerHandle(udg_hs, H2I(tti), 1, GetTriggerPlayer()) //保存玩家handle到计时器
                set tti=null
            endif
        endif
    endif
endfunction
function xzyx takes nothing returns nothing
    local integer li=0
    local trigger tr=CreateTrigger()
    call SaveTriggerHandle(udg_hs, 0, 1010, tr)
    loop
        exitwhen li == 6
            if ( ( GetPlayerSlotState(Player(li)) == PLAYER_SLOT_STATE_PLAYING ) and ( GetPlayerController(Player(li)) != MAP_CONTROL_COMPUTER ) ) then
                call TriggerRegisterPlayerUnitEvent(tr, Player(li), EVENT_PLAYER_UNIT_SELECTED, null)
                call SaveInteger(udg_hs, 0, 1009, LoadInteger(udg_hs, 0, 1009) + 1)
                call TriggerRegisterPlayerChatEvent(LoadTriggerHandle(udg_hs, 0, 1011), Player(li), "-", false)
            endif
            set li=li + 1
    endloop
    call TriggerAddAction(tr, function xzyx1)
    set tr=null
endfunction

//library libselecthero ends
//library libskill:
function cw_skill takes nothing returns nothing
    call UnitAddItem(LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), 1002), GetSpellTargetItem())
endfunction
function timer_smjq takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer i0=GetHandleId(t)
    local integer i1=LoadInteger(udg_hs, i0, 0)
    local integer i2=0
    loop
        set i2=i2 + 1
        call DestroyLightning(LoadLightningHandle(udg_hs, i0, i2))
        exitwhen i2 == i1
    endloop
    call FlushChildHashtable(udg_hs, i0)
    call DestroyTimer(t)
    set t=null
endfunction
function timerhyy takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer i1=GetHandleId(t)
    local integer i2=LoadInteger(udg_hs, i1, 1)
    local unit u1=LoadUnitHandle(udg_hs, i1, 0)
    local real s=LoadReal(udg_hs, i1, 2)
    local unit u2
    local integer i3=LoadInteger(udg_hs, i1, 3)
    local group l__g
    local unit u3=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(u1)), 1002)
    if i3 == i2 then
        call FlushChildHashtable(udg_hs, i1)
        call DestroyTimer(GetExpiredTimer())
    else
        set l__g=CreateGroup()
        call GroupEnumUnitsInRange(l__g, GetUnitX(u1), GetUnitY(u1), 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call UnitDamageTarget(u3, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    set i3=i3 + 1
    call SaveInteger(udg_hs, i1, 3, i3)
    endif
    set u3=null
    set l__g=null
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
    set li[1]=LoadInteger(udg_hs, li[0], 2)
    set g2=LoadGroupHandle(udg_hs, li[0], 1)
    set u=LoadUnitHandle(udg_hs, li[0], 0)
    set li[3]=LoadInteger(udg_hs, li[0], 3)
    if li[3] == li[1] then
        set s=LoadReal(udg_hs, li[0], 11)
        set u3=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(u)), 1002)
        loop
            set u2=FirstOfGroup(g2)
            exitwhen u2 == null
            call libcf_cf1(u2 , u)
            call BJDebugMsg(GetUnitName(u) + "     " + GetUnitName(u2))
            call UnitDamageTarget(u3, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
            call GroupRemoveUnit(g2, u2)
        endloop
        call DestroyEffect(LoadEffectHandle(udg_hs, li[0], 10))
        call DestroyGroup(g2)
        call FlushChildHashtable(udg_hs, li[0])
        call DestroyTimer(t)
    else
        set g1=CreateGroup()
        call GroupEnumUnitsInRange(g1, GetUnitX(u), GetUnitY(u), 600, null)
        loop
            set u2=FirstOfGroup(g1)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call GroupAddUnit(g2, u2)
                    
                endif
                call GroupRemoveUnit(g1, u2)
        endloop
        call DestroyGroup(g1)
    
    endif
    call SaveInteger(udg_hs, li[0], 3, li[3] + 1)
    set t=null
    set u=null
    set g1=null
    set u2=null
    set g2=null
    set u3=null
endfunction
function skill_1 takes nothing returns nothing
    local unit u=GetTriggerUnit()
    local integer bl=GetHeroStr(u, false)
    local integer bm=GetHeroAgi(u, false)
    local integer bz=GetHeroInt(u, false)
    local integer ql=GetHeroStr(u, true)
    local integer qm=GetHeroAgi(u, true)
    local integer qz=GetHeroInt(u, true)
    local player p1=GetOwningPlayer(u)
    local integer ll=ql - bl
    local integer lm=qm - bm
    local integer lz=qz - bz
    local integer array li
    local group l__g
    local unit u1
    local unit u2
    local unit u3
    local real x
    local real y
    local real array f
    local real s
    local timer t
    local integer id=GetPlayerId(p1)
    local integer randomint
    set s=( ll + lm + lz ) * 0.4 + ( bl + bm + bz ) * 0.2
    set s=s * ( vx[id] + zx[id] + cx[id] + yx[id] + fx[id] )
    if GetSpellAbilityId() == 'A00I' then //骑士之志
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A00K' then //雷神领域
        set u1=GetSpellTargetUnit()
        set l__g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        set u3=CreateUnit(p1, 'n000', GetUnitX(u), GetUnitY(u), 0) //创建马甲
        call UnitAddAbility(u3, 'A01J') //添加技能
        call UnitApplyTimedLife(u3, 'BHwe', 1) //设置生命周期
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call IssueNeutralTargetOrderById(p1, u3, 852095, u2) //扔锤子
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A00M' then //野蛮冲撞
        set x=GetUnitX(GetSpellTargetUnit())
        set y=GetUnitY(GetSpellTargetUnit())
        call libcf_cf(u , x , y , 0.4 , 0.02 , false , false)
        set l__g=CreateGroup()
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    //无影手技能在此
    if GetSpellAbilityId() == 'A00O' then
        set randomint=GetRandomInt(1, 10)
        set u2=GetSpellTargetUnit()
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
        call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
        if randomint == 1 then
            call UnitAddItem(u, CreateItem(cl[GetRandomInt(5, 32)], GetUnitX(u), GetUnitY(u)))
        else
            call UnitAddItem(u, CreateItem(cl[GetRandomInt(1, 4)], GetUnitX(u), GetUnitY(u)))
            call SetPlayerState(p1, PLAYER_STATE_GOLD_GATHERED, GetPlayerState(p1, PLAYER_STATE_GOLD_GATHERED) + R2I(s / 10))
            call DisplayTextToPlayer(p1, 0, 0, "偷到了金币" + R2S(s / 10))
        endif
    endif
    //破甲阵的触发就省下了
    if GetSpellAbilityId() == 'A00V' then //绝对陷阱
        set u1=GetSpellTargetUnit()
        set l__g=CreateGroup()
        set x=GetUnitX(u1)
        set y=GetUnitY(u1)
        set u3=CreateUnit(p1, 'n000', GetUnitX(u), GetUnitY(u), 0) //创建马甲
        call UnitAddAbility(u3, 'A01P') //添加技能
        call UnitApplyTimedLife(u3, 'BHwe', 1) //设置生命周期
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call IssueNeutralTargetOrderById(p1, u3, 852106, u2) //扔网
                    if IsUnitType(u2, UNIT_TYPE_HERO) then
                        call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                    else
                        if GetRandomInt(1, 100) < 8 then
                            call SetUnitOwner(u2, p1, true)
                            call UnitApplyTimedLife(u2, 'BHwe', 120)
                        else
                            call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                        endif
                    endif
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A00Y' then //斗者怒吼
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        set u3=CreateUnit(p1, 'n000', GetUnitX(u), GetUnitY(u), 0) //创建马甲
        call UnitAddAbility(u3, 'A01Q') //添加技能
        call UnitApplyTimedLife(u3, 'BHwe', 1) //设置生命周期
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and false == IsUnitOwnedByPlayer(u2, Player(11)) then //选队友
                    call IssueNeutralTargetOrderById(p1, u3, 852101, u2) //放嗜血术
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A010' then //削铁如泥
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A011' then //箭雨突袭
        set t=CreateTimer()
        set li[0]=GetHandleId(t)
        call SaveReal(udg_hs, li[0], 1, GetSpellTargetX())
        call SaveReal(udg_hs, li[0], 2, GetSpellTargetY())
        call SaveInteger(udg_hs, li[0], 4, 3)
        call SaveReal(udg_hs, li[0], 5, s / 3)
        call SaveUnitHandle(udg_hs, li[0], 0, u)
        call TimerStart(t, 0.2, true, function libcf_cftimer_1)
    endif
    if GetSpellAbilityId() == 'A013' then //幻影斩？
        set f[1]=GetUnitX(GetSpellTargetUnit())
        set f[2]=GetUnitY(GetSpellTargetUnit())
        call SaveInteger(udg_hs, 0, 105, 1) //1是斧王
        call libcf_cf(u , f[1] , f[2] , 0.5 , 0.025 , true , true)
        call UnitDamageTarget(u, GetSpellTargetUnit(), s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
        call BJDebugMsg(R2S(s))
    endif
    if GetSpellAbilityId() == 'A019' then //幻影斩？
        set f[1]=GetUnitX(GetSpellTargetUnit())
        set f[2]=GetUnitY(GetSpellTargetUnit())
        call SaveInteger(udg_hs, 0, 105, 0) //黑贞德
        call libcf_cf(u , f[1] , f[2] , 0.5 , 0.025 , true , true)
        if GetRandomInt(1, 100) < 10 then
            call UnitDamageTarget(u, GetSpellTargetUnit(), s * 5, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
        else
            call UnitDamageTarget(u, GetSpellTargetUnit(), s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
        endif
        call BJDebugMsg(R2S(s))
    endif
    if GetSpellAbilityId() == 'A01A' then //狂风不止
        set f[1]=GetSpellTargetX()
        set f[2]=GetSpellTargetY()
        //set f[0]=(180/3.14159)*Atan2(f[2]-GetUnitY(u),f[1]-GetUnitX(u))
        set u3=CreateUnit(p1, 'n006', GetUnitX(u), GetUnitY(u), GetUnitFacing(u))
        call UnitApplyTimedLife(u3, 'BHwe', 1) //设置生命周期
        call libcf_cf(u3 , f[1] , f[2] , 0.5 , 0.025 , false , false)
        set t=CreateTimer()
        call SaveEffectHandle(udg_hs, GetHandleId(t), 10, AddSpecialEffectTarget("Abilities\\Spells\\Other\\Tornado\\TornadoElemental.mdx", u3, "sprite")) //绑定特效到单位
        call SaveGroupHandle(udg_hs, GetHandleId(t), 1, CreateGroup())
        call SaveInteger(udg_hs, GetHandleId(t), 2, R2I(0.5 / 0.025))
        call SaveUnitHandle(udg_hs, GetHandleId(t), 0, u3)
        call SaveReal(udg_hs, GetHandleId(t), 11, s)
        call TimerStart(t, 0.025, true, function timer_2)
    
    endif
    if GetSpellAbilityId() == 'A017' then //EX咖喱棒
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Levelup\\LevelupCaster.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A018' then //吸斩
        call libcf_cf2(GetSpellTargetUnit() , u)
        call UnitDamageTarget(u, GetSpellTargetUnit(), s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
    endif
    if GetSpellAbilityId() == 'A015' then //火焰雨
        set l__g=CreateGroup()
        set x=GetSpellTargetX()
        set y=GetSpellTargetY()
        set u3=CreateUnit(p1, 'n000', GetSpellTargetX(), GetSpellTargetY(), 0) //创建马甲
        call UnitApplyTimedLife(u3, 'BHwe', 2.01) //设置生命周期
        set t=CreateTimer()
        call SaveUnitHandle(udg_hs, GetHandleId(t), 0, u3)
        call SaveInteger(udg_hs, GetHandleId(t), 1, 10)
        call SaveReal(udg_hs, GetHandleId(t), 2, s / 10)
        call TimerStart(t, 0.2, true, function timerhyy)
        //可在此处创建一个特效来继续伤害敌人
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call libcf_cf2(u2 , u3)
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A016' then //火焰光线
        set f[1]=GetUnitX(u)
        set f[2]=GetUnitY(u)
        set f[3]=GetSpellTargetX()
        set f[4]=GetSpellTargetY()
        set f[0]=Atan2(f[4] - f[2], f[3] - f[1])
        set li[0]=0
        set l__g=CreateGroup()
        loop
            exitwhen li[0] == 9
            set u3=CreateUnit(p1, 'n000', f[1] + 100 * li[0] * Cos(f[0]), f[2] + 100 * li[0] * Sin(f[0]), ( 180 / 3.14159 ) * f[0])
            //call SetUnitScale(u3,1,1,0.5)
            call UnitApplyTimedLife(u3, 'BHwe', 2) //设置生命周期
            //call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\LiquidFire\\Liquidfire.mdl",u3,"sprite")
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", u3, "sprite"))
            set f[5]=GetUnitX(u3)
            set f[6]=GetUnitY(u3)
            call GroupEnumUnitsInRange(l__g, f[5], f[6], 200, null)
            loop
                set u2=FirstOfGroup(l__g)
                exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then //选敌人
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
            endloop
            set li[0]=li[0] + 1
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A01B' then //剑之意志
        call UnitAddItem(u, CreateItem('I000', GetUnitX(u), GetUnitY(u)))
    endif
    if GetSpellAbilityId() == 'A01D' then //冰雪王朝
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", GetUnitX(u2), GetUnitY(u2))) //创建特效
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call DestroyGroup(l__g)
    endif
    if GetSpellAbilityId() == 'A01F' then //生命汲取
        set l__g=CreateGroup()
        set x=GetUnitX(u)
        set y=GetUnitY(u)
        set t=CreateTimer()
        set li[0]=GetHandleId(t)
        call GroupEnumUnitsInRange(l__g, x, y, 600, null)
        set f[1]=GetUnitX(u)
        set f[2]=GetUnitY(u)
        
        loop
            set u2=FirstOfGroup(l__g)
            exitwhen u2 == null
                if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                    set li[1]=li[1] + 1
                    call SaveLightningHandle(udg_hs, li[0], li[1], AddLightning("DRAL", true, f[1], f[2], GetUnitX(u2), GetUnitY(u2)))
                    call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP) //给予伤害
                endif
                call GroupRemoveUnit(l__g, u2)
        endloop
        call SaveInteger(udg_hs, li[0], 0, li[1])
        call DestroyGroup(l__g)
        if li[1] == 0 then
        call FlushChildHashtable(udg_hs, li[0])
        else
        call TimerStart(t, 0.5, false, function timer_smjq)
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + li[0] * s)
        endif
        
        
    endif
    if GetSpellAbilityId() == 'A01G' then //血流爆炸
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) * 60 * 0.01)
    endif
    if GetSpellAbilityId() == 'A01V' then //传送物品
        call UnitAddItem(LoadUnitHandle(udg_hs, GetHandleId(p1), 49), GetSpellTargetItem())
    endif
    if GetSpellAbilityId() == 'A00H' then //全体大招
        if LoadBoolean(udg_hs, GetHandleId(p1), 210) then
            call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.1)
        else
            call DisplayTextToPlayer(p1, 0, 0, "你还没有这个技能！")
        endif
    endif
    set l__g=null
    set u=null
    set u1=null
    set u2=null
    set u3=null
    set p1=null
    set t=null
endfunction
function skill_jzxj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), 1002)
    local integer bl=GetHeroStr(u, false)
    local integer bm=GetHeroAgi(u, false)
    local integer bz=GetHeroInt(u, false)
    local integer ql=GetHeroStr(u, true)
    local integer qm=GetHeroAgi(u, true)
    local integer qz=GetHeroInt(u, true)
    local player p1=GetOwningPlayer(u)
    local integer ll=ql - bl
    local integer lm=qm - bm
    local integer lz=qz - bz
    local group l__g=CreateGroup()
    local unit u2
    local real x=GetUnitX(GetTriggerUnit())
    local real y=GetUnitY(GetTriggerUnit())
    local real s
    set s=ql + qm + qz
    call GroupEnumUnitsInRange(l__g, x, y, 600, null)
    loop
        set u2=FirstOfGroup(l__g)
        exitwhen u2 == null
            if GetUnitState(u2, UNIT_STATE_LIFE) > 0 and IsUnitOwnedByPlayer(u2, Player(11)) then
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(u2), GetUnitY(u2)))
                call UnitDamageTarget(u, u2, s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP)
            endif
            call GroupRemoveUnit(l__g, u2)
    endloop
    call DestroyGroup(l__g)
    call DestroyTrigger(GetTriggeringTrigger())
    set l__g=null
    set u=null
    set u2=null
    set p1=null
endfunction
function skill_jzxj takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function skill_jzxj_1)
    call TriggerRegisterUnitEvent(tr, GetSummonedUnit(), EVENT_UNIT_DEATH)
    set tr=null
endfunction
function skill takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function skill_1)
    call SaveTriggerHandle(udg_hs, 0, 99, tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function skill_jzxj)
    call SaveTriggerHandle(udg_hs, 0, 101, tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function cw_skill)
    call SaveTriggerHandle(udg_hs, 0, 102, tr)
    set tr=null
endfunction

//library libskill ends
//library libtime0:
function sys_cg takes nothing returns nothing
    local integer li1= - 1
    local unit unitt
    local integer loopli=0
        loop
            exitwhen li1 == 2
            set unitt=CreateUnit(Player(11), LoadInteger(udg_hs, 7, b), li1 * 1536, 3840, 270)
            call IssueNeutralPointOrderById(Player(11), unitt, 851983, 0, - 3840)
            set loopli=0
            loop
                exitwhen loopli == 6
                call UnitShareVision(unitt, Player(loopli), true) //共享视野
                set loopli=loopli + 1
            endloop
            set li1=li1 + 1
        endloop
    set g=g - 1
    set unitt=null
endfunction
function time1s takes nothing returns nothing
    local integer li0=0
    local integer li1
    local real x=- 4480
    local real y=- 4480
    local unit u
    set i=i + 1
    if g > 0 then
        call sys_cg()
    endif
    loop
        if lgf[li0] == 1 then //前六位表示开启刷怪
            if lgf[li0 + 6] < 5 then //中间六位表示练功房怪物不足
                set li1=0
                loop
                    exitwhen li1 == 20
                    set li1=li1 + 1
                    set u=CreateUnit(Player(11), lgf[li0 + 12], x, y, 225) //末六位表示刷出的怪
                    call SaveInteger(udg_hs, GetHandleId(u), 666, li0)
                endloop
                set lgf[li0 + 6]=lgf[li0 + 6] + 20
            endif
        endif
        exitwhen li0 == 5
        set li0=li0 + 1
        set y=y + 1792
    endloop
    set u=null
endfunction
function xzndjsq takes nothing returns nothing
    if LoadBoolean(udg_hs, 0, 1013) then //判断是否已选择难度
    else
    call DialogDisplay(Player(0), LoadDialogHandle(udg_hs, 0, StringHash("选择难度对话框")), false) //取消显示对话框
    call DialogDestroy(LoadDialogHandle(udg_hs, 0, StringHash("选择难度对话框"))) //删除对话框
    call SetPlayerTechResearched(Player(11), 'RA00', 1) //默认难度
    //在这里设置默认难度
    call MultiboardSetTitleText(multi, "当前难度 1 ") //标题
    call MultiboardDisplay(multi, true) //显示多面板
    //以下测试模式使用，实际需要在选择难度后再启动计时器
    call SaveTimerDialogHandle(udg_hs, 0, 1014, CreateTimerDialog(LoadTimerHandle(udg_hs, 0, 1015))) //保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs, 0, 1015), jsqjg, true, null) //启动计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs, 0, 1014), true) //显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, 1014), "第" + I2S(b + 1) + "波") //设置计时器窗口标题
    //测试模式代码到此
    endif
endfunction
function time0_1 takes nothing returns nothing
    local timer lti=CreateTimer()
    local integer array li
    local dialog dhk
    local button an
    local string array str
    call TimerStart(lti, 1, true, function time1s) //启动难度选择时限计时器
    call BJDebugMsg(I2S(m[0]))
    call BJDebugMsg(I2S(StringHash(GetPlayerName(Player(0)))))
    call BJDebugMsg(I2S(StringHash("0")))
    call BJDebugMsg(I2S(LoadInteger(udg_hs, m[0] + StringHash(GetPlayerName(Player(0))), m[0])))
    set lti=null
    set dhk=DialogCreate()
    call DialogSetMessage(dhk, "选择难度")
    set li[0]=0
    set li[1]='1'
    set li[2]='2'
    set li[3]='3'
    set li[4]='4'
    set li[5]='5'
    call SaveDialogHandle(udg_hs, 0, StringHash("选择难度对话框"), dhk)
    //创建对话框
    loop
        exitwhen li[0] == 5
        set li[0]=li[0] + 1
        set an=DialogAddButton(dhk, msgys("按下对应的数字选择难度( " + msgys(I2S(li[0])) + msgys(" )")), li[li[0]])
        call SaveInteger(udg_hs, 0, H2I(an), li[0])
    endloop
    
    call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash("对话框")), dhk)
    call DialogDisplay(Player(0), dhk, true) //显示对话框给某个玩家，请及时修改
    call TimerStart(CreateTimer(), 10, false, function xzndjsq)
    //以下创建作弊菜单
    set str[1]="开启F3回城(再次点击关闭)"
    set str[2]="镜头升高"
    set str[3]="镜头降低"
    set str[4]="背景音量+"
    set str[5]="背景音量-"
    set str[6]="查看隐藏信息"
    set str[7]="切换翅膀"
    set str[8]="切换神器"
    set str[9]="切换称号"
    set str[10]="返回"
    set str[11]="1号翅膀"
    set str[12]="2号翅膀"
    set str[13]="3号翅膀"
    set str[14]="4号翅膀"
    set str[15]="5号翅膀"
    set str[16]="6号翅膀"
    set str[17]="7号翅膀"
    set str[18]="8号翅膀"
    set str[19]=str[10]
    set str[25]="1号神器"
    set str[26]="2号神器"
    set str[27]="3号神器"
    set str[28]=str[10]
    set str[31]="1号称号"
    set str[32]="2号称号"
    set str[33]="3号称号"
    set str[34]="4号称号"
    set str[35]="5号称号"
    set str[36]="6号称号"
    set str[37]="7号称号"
    set str[38]="8号称号"
    set str[39]="9号称号"
    set str[40]="10号称号"
    set str[41]=str[10]
    set li[0]=0
    set li[1]=0
    loop
        exitwhen li[0] == 6 //6个玩家
        set li[0]=li[0] + 1
        set dhk=DialogCreate()
        call DialogSetMessage(dhk, "作弊菜单")
        call SaveDialogHandle(udg_hs, H2I(Player(li[0] - 1)), 321, dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash(I2S(li[0]) + "对话框")), dhk)
        //基础作弊菜单
        set li[1]=0
        loop
            exitwhen li[1] == 10 //10个按钮
            set li[1]=li[1] + 1
            set an=DialogAddButton(dhk, str[li[1]], 0)
            call SaveInteger(udg_hs, 0, H2I(an), li[1])
        endloop
        //选择翅膀菜单
        set dhk=DialogCreate()
        call DialogSetMessage(dhk, "选择翅膀")
        call SaveDialogHandle(udg_hs, H2I(Player(li[0] - 1)), 322, dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash(I2S(li[0]) + "对话框")), dhk)
        set li[1]=10
        loop
            exitwhen li[1] == 19 //9个按钮
            set li[1]=li[1] + 1
            set an=DialogAddButton(dhk, str[li[1]], 0)
            call SaveInteger(udg_hs, 0, H2I(an), li[1])
        endloop
        //选择神器菜单
        set dhk=DialogCreate()
        call DialogSetMessage(dhk, "选择神器")
        call SaveDialogHandle(udg_hs, H2I(Player(li[0] - 1)), 324, dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash(I2S(li[0]) + "对话框")), dhk)
        set li[1]=24
        loop
            exitwhen li[1] == 28 //4个按钮
            set li[1]=li[1] + 1
            set an=DialogAddButton(dhk, str[li[1]], 0)
            call SaveInteger(udg_hs, 0, H2I(an), li[1])
        endloop
        //选择称号菜单
        set dhk=DialogCreate()
        //call DialogSetMessage(dhk,"选择称号")
        call SaveDialogHandle(udg_hs, H2I(Player(li[0] - 1)), 323, dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash(I2S(li[0]) + "对话框")), dhk)
        set li[1]=30
        loop
            exitwhen li[1] == 41 //11个按钮
            set li[1]=li[1] + 1
            set an=DialogAddButton(dhk, str[li[1]], 0)
            call SaveInteger(udg_hs, 0, H2I(an), li[1])
        endloop
        
        
    endloop
    call dmb() //创建多面板
    
    set an=null
    set dhk=null
endfunction
function time0 takes nothing returns nothing
    local trigger tr=CreateTrigger()
    //逝去0秒
    call TriggerRegisterTimerEvent(tr, 0, false)
    call TriggerAddAction(tr, function time0_1)
    set tr=null
endfunction

//library libtime0 ends
//library libyg:
function bossfh takes nothing returns nothing
    local integer li=LoadInteger(udg_hs, GetHandleId(GetExpiredTimer()), 333)
    local trigger t=LoadTriggerHandle(udg_hs, GetHandleId(GetExpiredTimer()), 0)
    local integer zb=LoadInteger(udg_hs, 11, li)
    local real x=LoadReal(udg_hs, 1, zb)
    local real y=LoadReal(udg_hs, 2, zb)
    local real f=LoadReal(udg_hs, 3, zb)
    local unit u1=CreateUnit(Player(11), li, x, y, f)
    call RemoveUnit(LoadUnitHandle(udg_hs, GetHandleId(GetExpiredTimer()), 222)) //移除死亡单位
    call TriggerRegisterUnitEvent(t, u1, EVENT_UNIT_DEATH) //添加事件到触发器
    call FlushChildHashtable(udg_hs, GetHandleId(GetExpiredTimer())) //清除哈希表
    call DestroyTimer(GetExpiredTimer()) //清除计时器
    set u1=null
    set t=null
endfunction
function yg takes nothing returns nothing
    local timer t=CreateTimer()
    local trigger tr=CreateTrigger()
    local integer li
    if HaveSavedInteger(udg_hs, GetUnitTypeId(GetTriggerUnit()), 1000) then
        set li=LoadInteger(udg_hs, GetUnitTypeId(GetTriggerUnit()), 1000)
        call CreateItem(LoadInteger(udg_hs, GetUnitTypeId(GetTriggerUnit()), GetRandomInt(1, li)), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
    endif
    call TriggerAddAction(tr, function yg) //新触发添加动作
    call DestroyTrigger(GetTriggeringTrigger()) //删除触发触发
    call SaveInteger(udg_hs, GetHandleId(t), 333, GetUnitTypeId(GetTriggerUnit())) //保存死亡的类型
    call SaveUnitHandle(udg_hs, GetHandleId(t), 222, GetTriggerUnit()) //保存死亡的单位
    call TimerStart(t, 10, false, function bossfh) //启动计时器
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, msg(1) + GetUnitName(GetTriggerUnit()) + "已被击杀，10秒后复活") //发消息
    call SaveTriggerHandle(udg_hs, GetHandleId(t), 0, tr) //保存触发器
    set t=null
    set tr=null
endfunction
function xgfh takes nothing returns nothing
    local integer li=LoadInteger(udg_hs, GetHandleId(GetExpiredTimer()), 333)
    local trigger t=LoadTriggerHandle(udg_hs, GetHandleId(GetExpiredTimer()), 0)
    local integer zb=LoadInteger(udg_hs, 11, li)
    local real x=LoadReal(udg_hs, 1, zb)
    local real y=LoadReal(udg_hs, 2, zb)
    local unit u1=CreateUnit(Player(11), li, x + GetRandomReal(- 640, 640), y + GetRandomReal(- 640, 640), GetRandomReal(0, 360))
    call RemoveUnit(LoadUnitHandle(udg_hs, GetHandleId(GetExpiredTimer()), 222)) //移除死亡单位
    call TriggerRegisterUnitEvent(t, u1, EVENT_UNIT_DEATH) //添加事件到触发器
    call FlushChildHashtable(udg_hs, GetHandleId(GetExpiredTimer())) //清除哈希表
    call DestroyTimer(GetExpiredTimer()) //清除计时器
    set u1=null
    set t=null
endfunction
function xg takes nothing returns nothing
    local timer t=CreateTimer()
    local trigger tr=CreateTrigger()
    call DestroyTrigger(GetTriggeringTrigger()) //删除触发触发
    call SaveInteger(udg_hs, GetHandleId(t), 333, GetUnitTypeId(GetTriggerUnit())) //保存死亡的类型
    call SaveUnitHandle(udg_hs, GetHandleId(t), 222, GetTriggerUnit()) //保存死亡的单位
    call TimerStart(t, 10, false, function xgfh) //启动计时器
    call TriggerAddAction(tr, function xg) //新触发添加动作
    call SaveTriggerHandle(udg_hs, GetHandleId(t), 0, tr) //保存触发器
    set t=null
    set tr=null
endfunction


//library libyg ends
//library csh:
    function itemreg takes integer id1,integer n1,integer id2,integer n2,integer id3,integer n3,integer id4,integer n4,integer id5,integer n5,integer id6,integer n6,integer id7,integer n7,boolean bo returns nothing
    local integer array id
    set id[0]=6
    set id[1]=id1
    set id[2]=id2
    set id[3]=id3
    set id[4]=id4
    set id[5]=id5
    set id[6]=id6
    set id[7]=n1
    set id[8]=n2
    set id[9]=n3
    set id[10]=n4
    set id[11]=n5
    set id[12]=n6
    call SaveInteger(udg_hs, id1, 20, id7) //第一个参数要强化的装备，第二个固定参数，第三个要给予的结果
    loop
        set id[0]=id[0] + 1
        call SaveInteger(udg_hs, id[id[0] - 5], 0, n7) //合成所需材料数量
        call SaveInteger(udg_hs, id[id[0] - 5], 1, id1) //合成的主线装备
        if n1 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 1, id1) //合成的材料
        endif
        if n2 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 2, id2) //合成的材料
        endif
        if n3 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 3, id3) //合成的材料
        endif
        if n4 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 4, id4) //合成的材料
        endif
        if n5 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 5, id5) //合成的材料
        endif
        if n6 != 0 then
            call SaveInteger(udg_hs, id[id[0] - 5], 6, id6) //合成的材料
        endif
        call SaveBoolean(udg_hs, id[id[0] - 5], 10, bo) //属于强化
        exitwhen id[id[0]] == 0
    endloop
    endfunction
    function LUAcreateunit takes nothing returns nothing
    local unit unitt
    local integer loopli=0
    local trigger ttt
    local integer m1
    local integer tempint
    //下面这些用来防止SLK工具优化的
    set tempint='uAA0'
    set tempint='uAA1'
    set tempint='uAA2'
    set tempint='uAA3'
    set tempint='uAA4'
    set tempint='uAA5'
    set tempint='AE00'
    set tempint='AE01'
    set tempint='AE02'
    //初始化函数
    set udg_hs=InitHashtable()
    
        call SaveReal(udg_hs, 1, 1, - 4480)
        call SaveReal(udg_hs, 2, 1, - 4480)
        call SaveReal(udg_hs, 3, 1, 225)
        call SaveReal(udg_hs, 4, 1, - 4992)
        call SaveReal(udg_hs, 5, 1, - 4992)
        call SaveReal(udg_hs, 6, 1, 45)
        call SaveInteger(udg_hs, 10, 'IA00', 1)
        call CreateItem('IA00', - 1216, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 2, - 4480)
        call SaveReal(udg_hs, 2, 2, - 2688)
        call SaveReal(udg_hs, 3, 2, 225)
        call SaveReal(udg_hs, 4, 2, - 4992)
        call SaveReal(udg_hs, 5, 2, - 3200)
        call SaveReal(udg_hs, 6, 2, 45)
        call SaveInteger(udg_hs, 10, 'IA01', 2)
        call CreateItem('IA01', - 1184, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 3, - 4480)
        call SaveReal(udg_hs, 2, 3, - 896)
        call SaveReal(udg_hs, 3, 3, 225)
        call SaveReal(udg_hs, 4, 3, - 4992)
        call SaveReal(udg_hs, 5, 3, - 1408)
        call SaveReal(udg_hs, 6, 3, 45)
        call SaveInteger(udg_hs, 10, 'IA02', 3)
        call CreateItem('IA02', - 1152, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 4, - 4480)
        call SaveReal(udg_hs, 2, 4, 896)
        call SaveReal(udg_hs, 3, 4, 225)
        call SaveReal(udg_hs, 4, 4, - 4992)
        call SaveReal(udg_hs, 5, 4, 384)
        call SaveReal(udg_hs, 6, 4, 45)
        call SaveInteger(udg_hs, 10, 'IA03', 4)
        call CreateItem('IA03', - 1120, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 5, - 4480)
        call SaveReal(udg_hs, 2, 5, 2688)
        call SaveReal(udg_hs, 3, 5, 225)
        call SaveReal(udg_hs, 4, 5, - 4992)
        call SaveReal(udg_hs, 5, 5, 2176)
        call SaveReal(udg_hs, 6, 5, 45)
        call SaveInteger(udg_hs, 10, 'IA04', 5)
        call CreateItem('IA04', - 1088, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 6, - 4480)
        call SaveReal(udg_hs, 2, 6, 4480)
        call SaveReal(udg_hs, 3, 6, 225)
        call SaveReal(udg_hs, 4, 6, - 4992)
        call SaveReal(udg_hs, 5, 6, 3968)
        call SaveReal(udg_hs, 6, 6, 45)
        call SaveInteger(udg_hs, 10, 'IA05', 6)
        call CreateItem('IA05', - 1056, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 7, 4992)
        call SaveReal(udg_hs, 2, 7, - 4480)
        call SaveReal(udg_hs, 3, 7, 180)
        call SaveReal(udg_hs, 4, 7, 3968)
        call SaveReal(udg_hs, 5, 7, - 4480)
        call SaveReal(udg_hs, 6, 7, 0)
        call SaveInteger(udg_hs, 10, 'IA06', 7)
        call CreateItem('IA06', - 1024, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 8, 4992)
        call SaveReal(udg_hs, 2, 8, - 2688)
        call SaveReal(udg_hs, 3, 8, 180)
        call SaveReal(udg_hs, 4, 8, 3968)
        call SaveReal(udg_hs, 5, 8, - 2688)
        call SaveReal(udg_hs, 6, 8, 0)
        call SaveInteger(udg_hs, 10, 'IA07', 8)
        call CreateItem('IA07', - 992, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 9, 4992)
        call SaveReal(udg_hs, 2, 9, - 896)
        call SaveReal(udg_hs, 3, 9, 180)
        call SaveReal(udg_hs, 4, 9, 3968)
        call SaveReal(udg_hs, 5, 9, - 896)
        call SaveReal(udg_hs, 6, 9, 0)
        call SaveInteger(udg_hs, 10, 'IA08', 9)
        call CreateItem('IA08', - 960, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 10, 4992)
        call SaveReal(udg_hs, 2, 10, 896)
        call SaveReal(udg_hs, 3, 10, 180)
        call SaveReal(udg_hs, 4, 10, 3968)
        call SaveReal(udg_hs, 5, 10, 896)
        call SaveReal(udg_hs, 6, 10, 0)
        call SaveInteger(udg_hs, 10, 'IA09', 10)
        call CreateItem('IA09', - 928, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 11, 4992)
        call SaveReal(udg_hs, 2, 11, 2688)
        call SaveReal(udg_hs, 3, 11, 180)
        call SaveReal(udg_hs, 4, 11, 3968)
        call SaveReal(udg_hs, 5, 11, 2688)
        call SaveReal(udg_hs, 6, 11, 0)
        call SaveInteger(udg_hs, 10, 'IA0A', 11)
        call CreateItem('IA0A', - 896, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 12, 4992)
        call SaveReal(udg_hs, 2, 12, 4480)
        call SaveReal(udg_hs, 3, 12, 180)
        call SaveReal(udg_hs, 4, 12, 3968)
        call SaveReal(udg_hs, 5, 12, 4480)
        call SaveReal(udg_hs, 6, 12, 0)
        call SaveInteger(udg_hs, 10, 'IA0B', 12)
        call CreateItem('IA0B', - 864, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 13, - 9216)
        call SaveReal(udg_hs, 2, 13, 9216)
        call SaveReal(udg_hs, 3, 13, 315)
        call SaveReal(udg_hs, 4, 13, - 7936)
        call SaveReal(udg_hs, 5, 13, 7936)
        call SaveReal(udg_hs, 6, 13, 0)
        call SaveInteger(udg_hs, 10, 'IA0C', 13)
        call CreateItem('IA0C', - 832, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 14, - 6656)
        call SaveReal(udg_hs, 2, 14, 9216)
        call SaveReal(udg_hs, 3, 14, 225)
        call SaveReal(udg_hs, 4, 14, - 7936)
        call SaveReal(udg_hs, 5, 14, 7936)
        call SaveReal(udg_hs, 6, 14, 0)
        call SaveInteger(udg_hs, 10, 'IA0D', 14)
        call CreateItem('IA0D', - 800, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 15, - 6656)
        call SaveReal(udg_hs, 2, 15, 6656)
        call SaveReal(udg_hs, 3, 15, 135)
        call SaveReal(udg_hs, 4, 15, - 7936)
        call SaveReal(udg_hs, 5, 15, 7936)
        call SaveReal(udg_hs, 6, 15, 0)
        call SaveInteger(udg_hs, 10, 'IA0E', 15)
        call CreateItem('IA0E', - 768, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 16, - 9216)
        call SaveReal(udg_hs, 2, 16, 6656)
        call SaveReal(udg_hs, 3, 16, 45)
        call SaveReal(udg_hs, 4, 16, - 7936)
        call SaveReal(udg_hs, 5, 16, 7936)
        call SaveReal(udg_hs, 6, 16, 0)
        call SaveInteger(udg_hs, 10, 'IA0F', 16)
        call CreateItem('IA0F', - 736, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 17, 6656)
        call SaveReal(udg_hs, 2, 17, 9216)
        call SaveReal(udg_hs, 3, 17, 315)
        call SaveReal(udg_hs, 4, 17, 7936)
        call SaveReal(udg_hs, 5, 17, 7936)
        call SaveReal(udg_hs, 6, 17, 0)
        call SaveInteger(udg_hs, 10, 'IA0G', 17)
        call CreateItem('IA0G', - 704, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 18, 9216)
        call SaveReal(udg_hs, 2, 18, 9216)
        call SaveReal(udg_hs, 3, 18, 225)
        call SaveReal(udg_hs, 4, 18, 7936)
        call SaveReal(udg_hs, 5, 18, 7936)
        call SaveReal(udg_hs, 6, 18, 0)
        call SaveInteger(udg_hs, 10, 'IA0H', 18)
        call CreateItem('IA0H', - 672, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 19, 9216)
        call SaveReal(udg_hs, 2, 19, 6656)
        call SaveReal(udg_hs, 3, 19, 135)
        call SaveReal(udg_hs, 4, 19, 7936)
        call SaveReal(udg_hs, 5, 19, 7936)
        call SaveReal(udg_hs, 6, 19, 0)
        call SaveInteger(udg_hs, 10, 'IA0I', 19)
        call CreateItem('IA0I', - 640, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 20, 6656)
        call SaveReal(udg_hs, 2, 20, 6656)
        call SaveReal(udg_hs, 3, 20, 45)
        call SaveReal(udg_hs, 4, 20, 7936)
        call SaveReal(udg_hs, 5, 20, 7936)
        call SaveReal(udg_hs, 6, 20, 0)
        call SaveInteger(udg_hs, 10, 'IA0J', 20)
        call CreateItem('IA0J', - 608, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 21, 6656)
        call SaveReal(udg_hs, 2, 21, - 6656)
        call SaveReal(udg_hs, 3, 21, 315)
        call SaveReal(udg_hs, 4, 21, 7936)
        call SaveReal(udg_hs, 5, 21, - 7936)
        call SaveReal(udg_hs, 6, 21, 0)
        call SaveInteger(udg_hs, 10, 'IA0K', 21)
        call CreateItem('IA0K', - 576, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 22, 9216)
        call SaveReal(udg_hs, 2, 22, - 6656)
        call SaveReal(udg_hs, 3, 22, 225)
        call SaveReal(udg_hs, 4, 22, 7936)
        call SaveReal(udg_hs, 5, 22, - 7936)
        call SaveReal(udg_hs, 6, 22, 0)
        call SaveInteger(udg_hs, 10, 'IA0L', 22)
        call CreateItem('IA0L', - 544, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 23, 9216)
        call SaveReal(udg_hs, 2, 23, - 9216)
        call SaveReal(udg_hs, 3, 23, 135)
        call SaveReal(udg_hs, 4, 23, 7936)
        call SaveReal(udg_hs, 5, 23, - 7936)
        call SaveReal(udg_hs, 6, 23, 0)
        call SaveInteger(udg_hs, 10, 'IA0M', 23)
        call CreateItem('IA0M', - 512, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 24, 6656)
        call SaveReal(udg_hs, 2, 24, - 9216)
        call SaveReal(udg_hs, 3, 24, 45)
        call SaveReal(udg_hs, 4, 24, 7936)
        call SaveReal(udg_hs, 5, 24, - 7936)
        call SaveReal(udg_hs, 6, 24, 0)
        call SaveInteger(udg_hs, 10, 'IA0N', 24)
        call CreateItem('IA0N', - 480, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 25, - 9216)
        call SaveReal(udg_hs, 2, 25, - 6656)
        call SaveReal(udg_hs, 3, 25, 315)
        call SaveReal(udg_hs, 4, 25, - 7936)
        call SaveReal(udg_hs, 5, 25, - 7936)
        call SaveReal(udg_hs, 6, 25, 0)
        call SaveInteger(udg_hs, 10, 'IA0O', 25)
        call CreateItem('IA0O', - 448, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 26, - 6656)
        call SaveReal(udg_hs, 2, 26, - 6656)
        call SaveReal(udg_hs, 3, 26, 225)
        call SaveReal(udg_hs, 4, 26, - 7936)
        call SaveReal(udg_hs, 5, 26, - 7936)
        call SaveReal(udg_hs, 6, 26, 0)
        call SaveInteger(udg_hs, 10, 'IA0P', 26)
        call CreateItem('IA0P', - 416, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 27, - 6656)
        call SaveReal(udg_hs, 2, 27, - 9216)
        call SaveReal(udg_hs, 3, 27, 135)
        call SaveReal(udg_hs, 4, 27, - 7936)
        call SaveReal(udg_hs, 5, 27, - 7936)
        call SaveReal(udg_hs, 6, 27, 0)
        call SaveInteger(udg_hs, 10, 'IA0Q', 27)
        call CreateItem('IA0Q', - 384, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 28, - 9216)
        call SaveReal(udg_hs, 2, 28, - 9216)
        call SaveReal(udg_hs, 3, 28, 45)
        call SaveReal(udg_hs, 4, 28, - 7936)
        call SaveReal(udg_hs, 5, 28, - 7936)
        call SaveReal(udg_hs, 6, 28, 0)
        call SaveInteger(udg_hs, 10, 'IA0R', 28)
        call CreateItem('IA0R', - 352, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 29, - 7552)
        call SaveReal(udg_hs, 2, 29, - 4480)
        call SaveReal(udg_hs, 3, 29, 0)
        call SaveReal(udg_hs, 4, 29, - 6528)
        call SaveReal(udg_hs, 5, 29, - 4480)
        call SaveReal(udg_hs, 6, 29, 180)
        call SaveInteger(udg_hs, 10, 'IA0S', 29)
        call CreateItem('IA0S', - 320, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 30, - 7552)
        call SaveReal(udg_hs, 2, 30, - 2688)
        call SaveReal(udg_hs, 3, 30, 0)
        call SaveReal(udg_hs, 4, 30, - 6528)
        call SaveReal(udg_hs, 5, 30, - 2688)
        call SaveReal(udg_hs, 6, 30, 180)
        call SaveInteger(udg_hs, 10, 'IA0T', 30)
        call CreateItem('IA0T', - 288, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 31, - 7552)
        call SaveReal(udg_hs, 2, 31, - 896)
        call SaveReal(udg_hs, 3, 31, 0)
        call SaveReal(udg_hs, 4, 31, - 6528)
        call SaveReal(udg_hs, 5, 31, - 896)
        call SaveReal(udg_hs, 6, 31, 180)
        call SaveInteger(udg_hs, 10, 'IA0U', 31)
        call CreateItem('IA0U', - 256, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 32, - 7552)
        call SaveReal(udg_hs, 2, 32, 896)
        call SaveReal(udg_hs, 3, 32, 0)
        call SaveReal(udg_hs, 4, 32, - 6528)
        call SaveReal(udg_hs, 5, 32, 896)
        call SaveReal(udg_hs, 6, 32, 180)
        call SaveInteger(udg_hs, 10, 'IA0V', 32)
        call CreateItem('IA0V', - 224, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 33, - 7040)
        call SaveReal(udg_hs, 2, 33, 2688)
        call SaveReal(udg_hs, 3, 33, 0)
        call SaveReal(udg_hs, 4, 33, - 6528)
        call SaveReal(udg_hs, 5, 33, 2688)
        call SaveReal(udg_hs, 6, 33, 180)
        call SaveInteger(udg_hs, 10, 'IA0W', 33)
        call CreateItem('IA0W', - 192, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 34, - 7552)
        call SaveReal(udg_hs, 2, 34, 4480)
        call SaveReal(udg_hs, 3, 34, 0)
        call SaveReal(udg_hs, 4, 34, - 6528)
        call SaveReal(udg_hs, 5, 34, 4480)
        call SaveReal(udg_hs, 6, 34, 180)
        call SaveInteger(udg_hs, 10, 'IA0X', 34)
        call CreateItem('IA0X', - 160, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 35, - 9344)
        call SaveReal(udg_hs, 2, 35, - 4480)
        call SaveReal(udg_hs, 3, 35, 0)
        call SaveReal(udg_hs, 4, 35, - 8320)
        call SaveReal(udg_hs, 5, 35, - 4480)
        call SaveReal(udg_hs, 6, 35, 180)
        call SaveInteger(udg_hs, 10, 'IA0Y', 35)
        call CreateItem('IA0Y', - 128, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 36, - 9344)
        call SaveReal(udg_hs, 2, 36, - 2688)
        call SaveReal(udg_hs, 3, 36, 0)
        call SaveReal(udg_hs, 4, 36, - 8320)
        call SaveReal(udg_hs, 5, 36, - 2688)
        call SaveReal(udg_hs, 6, 36, 180)
        call SaveInteger(udg_hs, 10, 'IA0Z', 36)
        call CreateItem('IA0Z', - 96, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 37, - 9344)
        call SaveReal(udg_hs, 2, 37, - 896)
        call SaveReal(udg_hs, 3, 37, 0)
        call SaveReal(udg_hs, 4, 37, - 8320)
        call SaveReal(udg_hs, 5, 37, - 896)
        call SaveReal(udg_hs, 6, 37, 180)
        call SaveInteger(udg_hs, 10, 'IA10', 37)
        call CreateItem('IA10', - 64, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 38, - 9344)
        call SaveReal(udg_hs, 2, 38, 896)
        call SaveReal(udg_hs, 3, 38, 0)
        call SaveReal(udg_hs, 4, 38, - 8320)
        call SaveReal(udg_hs, 5, 38, 896)
        call SaveReal(udg_hs, 6, 38, 180)
        call SaveInteger(udg_hs, 10, 'IA11', 38)
        call CreateItem('IA11', - 32, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 39, - 8832)
        call SaveReal(udg_hs, 2, 39, 2688)
        call SaveReal(udg_hs, 3, 39, 0)
        call SaveReal(udg_hs, 4, 39, - 8320)
        call SaveReal(udg_hs, 5, 39, 2688)
        call SaveReal(udg_hs, 6, 39, 180)
        call SaveInteger(udg_hs, 10, 'IA12', 39)
        call CreateItem('IA12', 0, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 40, - 9344)
        call SaveReal(udg_hs, 2, 40, 4480)
        call SaveReal(udg_hs, 3, 40, 0)
        call SaveReal(udg_hs, 4, 40, - 8320)
        call SaveReal(udg_hs, 5, 40, 4480)
        call SaveReal(udg_hs, 6, 40, 180)
        call SaveInteger(udg_hs, 10, 'IA13', 40)
        call CreateItem('IA13', 32, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 41, - 4480)
        call SaveReal(udg_hs, 2, 41, 7552)
        call SaveReal(udg_hs, 3, 41, 270)
        call SaveReal(udg_hs, 4, 41, - 4480)
        call SaveReal(udg_hs, 5, 41, 6528)
        call SaveReal(udg_hs, 6, 41, 90)
        call SaveInteger(udg_hs, 10, 'IA14', 41)
        call CreateItem('IA14', 64, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 42, - 2688)
        call SaveReal(udg_hs, 2, 42, 7552)
        call SaveReal(udg_hs, 3, 42, 270)
        call SaveReal(udg_hs, 4, 42, - 2688)
        call SaveReal(udg_hs, 5, 42, 6528)
        call SaveReal(udg_hs, 6, 42, 90)
        call SaveInteger(udg_hs, 10, 'IA15', 42)
        call CreateItem('IA15', 96, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 43, - 896)
        call SaveReal(udg_hs, 2, 43, 7552)
        call SaveReal(udg_hs, 3, 43, 270)
        call SaveReal(udg_hs, 4, 43, - 896)
        call SaveReal(udg_hs, 5, 43, 6528)
        call SaveReal(udg_hs, 6, 43, 90)
        call SaveInteger(udg_hs, 10, 'IA16', 43)
        call CreateItem('IA16', 128, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 44, 896)
        call SaveReal(udg_hs, 2, 44, 7552)
        call SaveReal(udg_hs, 3, 44, 270)
        call SaveReal(udg_hs, 4, 44, 896)
        call SaveReal(udg_hs, 5, 44, 6528)
        call SaveReal(udg_hs, 6, 44, 90)
        call SaveInteger(udg_hs, 10, 'IA17', 44)
        call CreateItem('IA17', 160, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 45, 2688)
        call SaveReal(udg_hs, 2, 45, 7552)
        call SaveReal(udg_hs, 3, 45, 270)
        call SaveReal(udg_hs, 4, 45, 2688)
        call SaveReal(udg_hs, 5, 45, 6528)
        call SaveReal(udg_hs, 6, 45, 90)
        call SaveInteger(udg_hs, 10, 'IA18', 45)
        call CreateItem('IA18', 192, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 46, 4480)
        call SaveReal(udg_hs, 2, 46, 7552)
        call SaveReal(udg_hs, 3, 46, 270)
        call SaveReal(udg_hs, 4, 46, 4480)
        call SaveReal(udg_hs, 5, 46, 6528)
        call SaveReal(udg_hs, 6, 46, 90)
        call SaveInteger(udg_hs, 10, 'IA19', 46)
        call CreateItem('IA19', 224, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 47, - 4480)
        call SaveReal(udg_hs, 2, 47, 9344)
        call SaveReal(udg_hs, 3, 47, 270)
        call SaveReal(udg_hs, 4, 47, - 4480)
        call SaveReal(udg_hs, 5, 47, 8320)
        call SaveReal(udg_hs, 6, 47, 90)
        call SaveInteger(udg_hs, 10, 'IA1A', 47)
        call CreateItem('IA1A', 256, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 48, - 2688)
        call SaveReal(udg_hs, 2, 48, 9344)
        call SaveReal(udg_hs, 3, 48, 270)
        call SaveReal(udg_hs, 4, 48, - 2688)
        call SaveReal(udg_hs, 5, 48, 8320)
        call SaveReal(udg_hs, 6, 48, 90)
        call SaveInteger(udg_hs, 10, 'IA1B', 48)
        call CreateItem('IA1B', 288, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 49, - 896)
        call SaveReal(udg_hs, 2, 49, 9344)
        call SaveReal(udg_hs, 3, 49, 270)
        call SaveReal(udg_hs, 4, 49, - 896)
        call SaveReal(udg_hs, 5, 49, 8320)
        call SaveReal(udg_hs, 6, 49, 90)
        call SaveInteger(udg_hs, 10, 'IA1C', 49)
        call CreateItem('IA1C', 320, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 50, 896)
        call SaveReal(udg_hs, 2, 50, 9344)
        call SaveReal(udg_hs, 3, 50, 270)
        call SaveReal(udg_hs, 4, 50, 896)
        call SaveReal(udg_hs, 5, 50, 8320)
        call SaveReal(udg_hs, 6, 50, 90)
        call SaveInteger(udg_hs, 10, 'IA1D', 50)
        call CreateItem('IA1D', 352, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 51, 2688)
        call SaveReal(udg_hs, 2, 51, 9344)
        call SaveReal(udg_hs, 3, 51, 270)
        call SaveReal(udg_hs, 4, 51, 2688)
        call SaveReal(udg_hs, 5, 51, 8320)
        call SaveReal(udg_hs, 6, 51, 90)
        call SaveInteger(udg_hs, 10, 'IA1E', 51)
        call CreateItem('IA1E', 384, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 52, 4480)
        call SaveReal(udg_hs, 2, 52, 9344)
        call SaveReal(udg_hs, 3, 52, 270)
        call SaveReal(udg_hs, 4, 52, 4480)
        call SaveReal(udg_hs, 5, 52, 8320)
        call SaveReal(udg_hs, 6, 52, 90)
        call SaveInteger(udg_hs, 10, 'IA1F', 52)
        call CreateItem('IA1F', 416, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 53, 7552)
        call SaveReal(udg_hs, 2, 53, 4480)
        call SaveReal(udg_hs, 3, 53, 180)
        call SaveReal(udg_hs, 4, 53, 6528)
        call SaveReal(udg_hs, 5, 53, 4480)
        call SaveReal(udg_hs, 6, 53, 0)
        call SaveInteger(udg_hs, 10, 'IA1G', 53)
        call CreateItem('IA1G', 448, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 54, 7552)
        call SaveReal(udg_hs, 2, 54, 2688)
        call SaveReal(udg_hs, 3, 54, 180)
        call SaveReal(udg_hs, 4, 54, 6528)
        call SaveReal(udg_hs, 5, 54, 2688)
        call SaveReal(udg_hs, 6, 54, 0)
        call SaveInteger(udg_hs, 10, 'IA1H', 54)
        call CreateItem('IA1H', 480, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 55, 7552)
        call SaveReal(udg_hs, 2, 55, 896)
        call SaveReal(udg_hs, 3, 55, 180)
        call SaveReal(udg_hs, 4, 55, 6528)
        call SaveReal(udg_hs, 5, 55, 896)
        call SaveReal(udg_hs, 6, 55, 0)
        call SaveInteger(udg_hs, 10, 'IA1I', 55)
        call CreateItem('IA1I', 512, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 56, 7552)
        call SaveReal(udg_hs, 2, 56, - 896)
        call SaveReal(udg_hs, 3, 56, 180)
        call SaveReal(udg_hs, 4, 56, 6528)
        call SaveReal(udg_hs, 5, 56, - 896)
        call SaveReal(udg_hs, 6, 56, 0)
        call SaveInteger(udg_hs, 10, 'IA1J', 56)
        call CreateItem('IA1J', 544, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 57, 7552)
        call SaveReal(udg_hs, 2, 57, - 2688)
        call SaveReal(udg_hs, 3, 57, 180)
        call SaveReal(udg_hs, 4, 57, 6528)
        call SaveReal(udg_hs, 5, 57, - 2688)
        call SaveReal(udg_hs, 6, 57, 0)
        call SaveInteger(udg_hs, 10, 'IA1K', 57)
        call CreateItem('IA1K', 576, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 58, 7552)
        call SaveReal(udg_hs, 2, 58, - 4480)
        call SaveReal(udg_hs, 3, 58, 180)
        call SaveReal(udg_hs, 4, 58, 6528)
        call SaveReal(udg_hs, 5, 58, - 4480)
        call SaveReal(udg_hs, 6, 58, 0)
        call SaveInteger(udg_hs, 10, 'IA1L', 58)
        call CreateItem('IA1L', 608, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 59, 9344)
        call SaveReal(udg_hs, 2, 59, 4480)
        call SaveReal(udg_hs, 3, 59, 180)
        call SaveReal(udg_hs, 4, 59, 8320)
        call SaveReal(udg_hs, 5, 59, 4480)
        call SaveReal(udg_hs, 6, 59, 0)
        call SaveInteger(udg_hs, 10, 'IA1M', 59)
        call CreateItem('IA1M', 640, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 60, 9344)
        call SaveReal(udg_hs, 2, 60, 2688)
        call SaveReal(udg_hs, 3, 60, 180)
        call SaveReal(udg_hs, 4, 60, 8320)
        call SaveReal(udg_hs, 5, 60, 2688)
        call SaveReal(udg_hs, 6, 60, 0)
        call SaveInteger(udg_hs, 10, 'IA1N', 60)
        call CreateItem('IA1N', 672, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 61, 9344)
        call SaveReal(udg_hs, 2, 61, 896)
        call SaveReal(udg_hs, 3, 61, 180)
        call SaveReal(udg_hs, 4, 61, 8320)
        call SaveReal(udg_hs, 5, 61, 896)
        call SaveReal(udg_hs, 6, 61, 0)
        call SaveInteger(udg_hs, 10, 'IA1O', 61)
        call CreateItem('IA1O', 704, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 62, 9344)
        call SaveReal(udg_hs, 2, 62, - 896)
        call SaveReal(udg_hs, 3, 62, 180)
        call SaveReal(udg_hs, 4, 62, 8320)
        call SaveReal(udg_hs, 5, 62, - 896)
        call SaveReal(udg_hs, 6, 62, 0)
        call SaveInteger(udg_hs, 10, 'IA1P', 62)
        call CreateItem('IA1P', 736, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 63, 9344)
        call SaveReal(udg_hs, 2, 63, - 2688)
        call SaveReal(udg_hs, 3, 63, 180)
        call SaveReal(udg_hs, 4, 63, 8320)
        call SaveReal(udg_hs, 5, 63, - 2688)
        call SaveReal(udg_hs, 6, 63, 0)
        call SaveInteger(udg_hs, 10, 'IA1Q', 63)
        call CreateItem('IA1Q', 768, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 64, 9344)
        call SaveReal(udg_hs, 2, 64, - 4480)
        call SaveReal(udg_hs, 3, 64, 180)
        call SaveReal(udg_hs, 4, 64, 8320)
        call SaveReal(udg_hs, 5, 64, - 4480)
        call SaveReal(udg_hs, 6, 64, 0)
        call SaveInteger(udg_hs, 10, 'IA1R', 64)
        call CreateItem('IA1R', 800, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 65, 4480)
        call SaveReal(udg_hs, 2, 65, - 7552)
        call SaveReal(udg_hs, 3, 65, 90)
        call SaveReal(udg_hs, 4, 65, 4480)
        call SaveReal(udg_hs, 5, 65, - 6528)
        call SaveReal(udg_hs, 6, 65, 270)
        call SaveInteger(udg_hs, 10, 'IA1S', 65)
        call CreateItem('IA1S', 832, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 66, 2688)
        call SaveReal(udg_hs, 2, 66, - 7552)
        call SaveReal(udg_hs, 3, 66, 90)
        call SaveReal(udg_hs, 4, 66, 2688)
        call SaveReal(udg_hs, 5, 66, - 6528)
        call SaveReal(udg_hs, 6, 66, 270)
        call SaveInteger(udg_hs, 10, 'IA1T', 66)
        call CreateItem('IA1T', 864, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 67, 896)
        call SaveReal(udg_hs, 2, 67, - 7552)
        call SaveReal(udg_hs, 3, 67, 90)
        call SaveReal(udg_hs, 4, 67, 896)
        call SaveReal(udg_hs, 5, 67, - 6528)
        call SaveReal(udg_hs, 6, 67, 270)
        call SaveInteger(udg_hs, 10, 'IA1U', 67)
        call CreateItem('IA1U', 896, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 68, - 896)
        call SaveReal(udg_hs, 2, 68, - 7552)
        call SaveReal(udg_hs, 3, 68, 90)
        call SaveReal(udg_hs, 4, 68, - 896)
        call SaveReal(udg_hs, 5, 68, - 6528)
        call SaveReal(udg_hs, 6, 68, 270)
        call SaveInteger(udg_hs, 10, 'IA1V', 68)
        call CreateItem('IA1V', 928, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 69, - 2688)
        call SaveReal(udg_hs, 2, 69, - 7552)
        call SaveReal(udg_hs, 3, 69, 90)
        call SaveReal(udg_hs, 4, 69, - 2688)
        call SaveReal(udg_hs, 5, 69, - 6528)
        call SaveReal(udg_hs, 6, 69, 270)
        call SaveInteger(udg_hs, 10, 'IA1W', 69)
        call CreateItem('IA1W', 960, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 70, - 4480)
        call SaveReal(udg_hs, 2, 70, - 7552)
        call SaveReal(udg_hs, 3, 70, 90)
        call SaveReal(udg_hs, 4, 70, - 4480)
        call SaveReal(udg_hs, 5, 70, - 6528)
        call SaveReal(udg_hs, 6, 70, 270)
        call SaveInteger(udg_hs, 10, 'IA1X', 70)
        call CreateItem('IA1X', 992, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 71, 4480)
        call SaveReal(udg_hs, 2, 71, - 9344)
        call SaveReal(udg_hs, 3, 71, 90)
        call SaveReal(udg_hs, 4, 71, 4480)
        call SaveReal(udg_hs, 5, 71, - 8320)
        call SaveReal(udg_hs, 6, 71, 270)
        call SaveInteger(udg_hs, 10, 'IA1Y', 71)
        call CreateItem('IA1Y', 1024, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 72, 2688)
        call SaveReal(udg_hs, 2, 72, - 9344)
        call SaveReal(udg_hs, 3, 72, 90)
        call SaveReal(udg_hs, 4, 72, 2688)
        call SaveReal(udg_hs, 5, 72, - 8320)
        call SaveReal(udg_hs, 6, 72, 270)
        call SaveInteger(udg_hs, 10, 'IA1Z', 72)
        call CreateItem('IA1Z', 1056, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 73, 896)
        call SaveReal(udg_hs, 2, 73, - 9344)
        call SaveReal(udg_hs, 3, 73, 90)
        call SaveReal(udg_hs, 4, 73, 896)
        call SaveReal(udg_hs, 5, 73, - 8320)
        call SaveReal(udg_hs, 6, 73, 270)
        call SaveInteger(udg_hs, 10, 'IA20', 73)
        call CreateItem('IA20', 1088, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 74, - 896)
        call SaveReal(udg_hs, 2, 74, - 9344)
        call SaveReal(udg_hs, 3, 74, 90)
        call SaveReal(udg_hs, 4, 74, - 896)
        call SaveReal(udg_hs, 5, 74, - 8320)
        call SaveReal(udg_hs, 6, 74, 270)
        call SaveInteger(udg_hs, 10, 'IA21', 74)
        call CreateItem('IA21', 1120, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 75, - 2688)
        call SaveReal(udg_hs, 2, 75, - 9344)
        call SaveReal(udg_hs, 3, 75, 90)
        call SaveReal(udg_hs, 4, 75, - 2688)
        call SaveReal(udg_hs, 5, 75, - 8320)
        call SaveReal(udg_hs, 6, 75, 270)
        call SaveInteger(udg_hs, 10, 'IA22', 75)
        call CreateItem('IA22', 1152, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 76, - 4480)
        call SaveReal(udg_hs, 2, 76, - 9344)
        call SaveReal(udg_hs, 3, 76, 90)
        call SaveReal(udg_hs, 4, 76, - 4480)
        call SaveReal(udg_hs, 5, 76, - 8320)
        call SaveReal(udg_hs, 6, 76, 270)
        call SaveInteger(udg_hs, 10, 'IA23', 76)
        call CreateItem('IA23', 1184, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 77, 0)
        call SaveReal(udg_hs, 2, 77, 3840)
        call SaveReal(udg_hs, 3, 77, 270)
        call SaveReal(udg_hs, 4, 77, 0)
        call SaveReal(udg_hs, 5, 77, - 3840)
        call SaveReal(udg_hs, 6, 77, 90)
        call SaveInteger(udg_hs, 10, 'IA24', 77)
        call CreateItem('IA24', 1216, 1280) //测试用
    
        call SaveReal(udg_hs, 1, 78, - 2560)
        call SaveReal(udg_hs, 2, 78, 0)
        call SaveReal(udg_hs, 3, 78, 270)
        call SaveReal(udg_hs, 4, 78, - 2560)
        call SaveReal(udg_hs, 5, 78, 0)
        call SaveReal(udg_hs, 6, 78, 270)
        call SaveInteger(udg_hs, 10, 'IA25', 78)
        call CreateItem('IA25', 1248, 1280) //测试用
    
        call SaveInteger(udg_hs, 7, 1, 'uA00')
        
        call SaveInteger(udg_hs, 7, 2, 'uA01')
        
        call SaveInteger(udg_hs, 7, 3, 'uA02')
        
        call SaveInteger(udg_hs, 7, 4, 'uA03')
        
        call SaveInteger(udg_hs, 7, 5, 'uA04')
        
        call SaveInteger(udg_hs, 7, 6, 'uA05')
        
        call SaveInteger(udg_hs, 7, 7, 'uA06')
        
        call SaveInteger(udg_hs, 7, 8, 'uA07')
        
        call SaveInteger(udg_hs, 7, 9, 'uA08')
        
        call SaveInteger(udg_hs, 7, 10, 'uA09')
        
        call SaveInteger(udg_hs, 7, 11, 'uA0A')
        
        call SaveInteger(udg_hs, 7, 12, 'uA0B')
        
        call SaveInteger(udg_hs, 7, 13, 'uA0C')
        
        call SaveInteger(udg_hs, 7, 14, 'uA0D')
        
        call SaveInteger(udg_hs, 7, 15, 'uA0E')
        
        call SaveInteger(udg_hs, 7, 16, 'uA0F')
        
        call SaveInteger(udg_hs, 7, 17, 'uA0G')
        
        call SaveInteger(udg_hs, 7, 18, 'uA0H')
        
        call SaveInteger(udg_hs, 7, 19, 'uA0I')
        
        call SaveInteger(udg_hs, 7, 20, 'uA0J')
        
        call SaveInteger(udg_hs, 7, 21, 'uA0K')
        
        call SaveInteger(udg_hs, 7, 22, 'uA0L')
        
        call SaveInteger(udg_hs, 7, 23, 'uA0M')
        
        call SaveInteger(udg_hs, 7, 24, 'uA0N')
        
        call SaveInteger(udg_hs, 7, 25, 'uA0O')
        
        call SaveInteger(udg_hs, 7, 26, 'uA0P')
        
        call SaveInteger(udg_hs, 7, 27, 'uA0Q')
        
        call SaveInteger(udg_hs, 7, 28, 'uA0R')
        
        call SaveInteger(udg_hs, 7, 29, 'uA0S')
        
        call SaveInteger(udg_hs, 7, 30, 'uA0T')
        
        call SaveInteger(udg_hs, 7, 31, 'uA0U')
        
        call SaveInteger(udg_hs, 7, 32, 'uA0V')
        
        call SaveInteger(udg_hs, 7, 33, 'uA0W')
        
        call SaveInteger(udg_hs, 7, 34, 'uA0X')
        
        call SaveInteger(udg_hs, 7, 35, 'uA0Y')
        
    call SaveInteger(udg_hs, 13, 1, 'UBB0')
    
    call SaveInteger(udg_hs, 13, 2, 'UBB1')
    
    call SaveInteger(udg_hs, 13, 3, 'UBB2')
    
    call SaveInteger(udg_hs, 13, 4, 'UBB3')
    
    call SaveInteger(udg_hs, 13, 5, 'UBB4')
    
    call SaveInteger(udg_hs, 13, 6, 'UBB5')
    
    call SaveInteger(udg_hs, 9, 'HA00', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA00', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA00', - 1280, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 1, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA00', 3, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA01', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA01', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA01', - 768, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 2, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA01', 3, "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA02', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA02', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA02', - 256, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 3, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA02', 3, "Units\\Demon\\Infernal\\InfernalBirth.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA03', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA03', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA03', 256, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 4, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA03', 3, "Abilities\\Spells\\NightElf\\FanOfKnives\\FanOfKnivesCaster.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA04', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA04', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA04', 768, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 5, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA04', 3, "Abilities\\Spells\\Undead\\ReplenishHealth\\ReplenishHealthCasterOverhead.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA05', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA05', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA05', 1280, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 6, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA05', 3, "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA06', 1) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA06', 0.9) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA06', - 1280, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 7, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA06', 3, "Abilities\\Spells\\NightElf\\SpiritOfVengeance\\SpiritOfVengeanceBirthMissile.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA07', 2) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA07', 0.95) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA07', - 768, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 8, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA07', 3, "Abilities\\Spells\\Human\\Slow\\SlowCaster.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA08', 3) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA08', 1) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA08', - 256, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 9, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA08', 3, "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA09', 4) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA09', 1.05) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA09', 256, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 10, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA09', 3, "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0A', 5) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0A', 1.1) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0A', 768, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 11, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0A', 3, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0B', 11) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0B', 1.15) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0B', 1280, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 12, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0B', 3, "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0C', 12) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0C', 1.2) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0C', - 1280, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 13, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0C', 3, "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0D', 13) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0D', 1.25) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0D', - 768, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 14, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0D', 3, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0E', 21) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0E', 1.3) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0E', - 256, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 15, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0E', 3, "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0F', 22) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0F', 1.35) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0F', 256, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 16, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0F', 3, "Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0G', 23) //最后用权限来代替
    call SaveReal(udg_hs, 30, 'HA0G', 1.4) //保存英雄系数
    set unitt=CreateUnit(Player(15), 'HA0G', 768, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 17, unitt) //保存到哈希表
    call SaveStr(udg_hs, 'HA0G', 3, "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl") //保存特效
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    set unitt=null
    call SaveTimerHandle(udg_hs, 0, 1015, CreateTimer()) //保存出怪计时器
    
    set unitt=CreateUnit(Player(6), 'hC00', 0, - 3840, 90) //创建基地
    call SaveUnitHandle(udg_hs, 0, StringHash("基地"), unitt)
    
    set unitt=CreateUnit(Player(6), 'hC01', 253, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC02', - 256, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC03', 768, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC04', - 768, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC05', 1280, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC06', - 1280, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC07', 1792, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC08', - 1792, - 4864, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=null
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB00', 29) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB00', - 7552, - 4480, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB01', 31) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB01', - 7552, - 896, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB02', 30) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB02', - 7552, - 2688, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB03', 25) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB03', - 9216, - 6656, 315) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB04', 26) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB04', - 6656, - 6656, 225) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB05', 27) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB05', - 6656, - 9216, 135) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB06', 28) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB06', - 9216, - 9216, 45) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB07', 13) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB07', - 9216, 9216, 315) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB08', 14) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB08', - 6656, 9216, 225) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB09', 15) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB09', - 6656, 6656, 135) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0A', 16) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0A', - 9216, 6656, 45) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0B', 32) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0B', - 7552, 896, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0C', 21) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0C', 6656, - 6656, 315) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0D', 22) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0D', 9216, - 6656, 225) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0E', 23) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0E', 9216, - 9216, 135) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0F', 24) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0F', 6656, - 9216, 45) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0G', 17) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0G', 6656, 9216, 315) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0H', 18) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0H', 9216, 9216, 225) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0I', 19) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0I', 9216, 6656, 135) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0J', 20) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0J', 6656, 6656, 45) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0K', 34) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0K', - 7552, 4480, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0L', 40) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0L', - 9344, 4480, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0M', 41) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0M', - 4480, 7552, 270) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0N', 42) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0N', - 2688, 7552, 270) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0O', 43) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0O', - 896, 7552, 270) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0P', 44) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0P', 896, 7552, 270) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, 11, 'UB0Q', 35) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0Q', - 9344, - 4480, 0) //创建单位
    call TriggerAddAction(ttt, function yg)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    //保存掉落物品
    //暗夜洞穴
    call SaveInteger(udg_hs, 'UB00', 1, 'IB3Y')
    call SaveInteger(udg_hs, 'UB00', 2, 'IB3Z')
    call SaveInteger(udg_hs, 'UB00', 3, 'IB43')
    call SaveInteger(udg_hs, 'UB00', 1000, 3)
    //蛇龙之巢
    call SaveInteger(udg_hs, 'UB01', 1, 'IB40')
    call SaveInteger(udg_hs, 'UB01', 2, 'IB41')
    call SaveInteger(udg_hs, 'UB01', 3, 'IB42')
    call SaveInteger(udg_hs, 'UB01', 1000, 3)
    //雪域宫
    call SaveInteger(udg_hs, 'UB02', 1, 'IB39')
    call SaveInteger(udg_hs, 'UB02', 2, 'IB3A')
    call SaveInteger(udg_hs, 'UB02', 1000, 2)
    //熔岩穴
    call SaveInteger(udg_hs, 'UB03', 1, 'IB3Q')
    call SaveInteger(udg_hs, 'UB03', 1000, 1)
    call SaveInteger(udg_hs, 'UB04', 1, 'IB3R')
    call SaveInteger(udg_hs, 'UB04', 1000, 1)
    call SaveInteger(udg_hs, 'UB05', 1, 'IB3S')
    call SaveInteger(udg_hs, 'UB05', 1000, 1)
    call SaveInteger(udg_hs, 'UB06', 1, 'IB3T')
    call SaveInteger(udg_hs, 'UB06', 1000, 1)
    //圣兽岛
    call SaveInteger(udg_hs, 'UB07', 1, 'IB2K')
    call SaveInteger(udg_hs, 'UB07', 1000, 1)
    call SaveInteger(udg_hs, 'UB08', 1, 'IB2M')
    call SaveInteger(udg_hs, 'UB08', 1000, 1)
    call SaveInteger(udg_hs, 'UB09', 1, 'IB2N')
    call SaveInteger(udg_hs, 'UB09', 1000, 1)
    call SaveInteger(udg_hs, 'UB0A', 1, 'IB2L')
    call SaveInteger(udg_hs, 'UB0A', 1000, 1)
    //斗者结晶的？？
    //龙渊泽
    call SaveInteger(udg_hs, 'UB0C', 1, 'IB3D')
    call SaveInteger(udg_hs, 'UB0C', 2, 'IB3H')
    call SaveInteger(udg_hs, 'UB0C', 1000, 2)
    call SaveInteger(udg_hs, 'UB0D', 1, 'IB3E')
    call SaveInteger(udg_hs, 'UB0D', 2, 'IB3I')
    call SaveInteger(udg_hs, 'UB0D', 1000, 2)
    call SaveInteger(udg_hs, 'UB0E', 1, 'IB3F')
    call SaveInteger(udg_hs, 'UB0E', 2, 'IB3J')
    call SaveInteger(udg_hs, 'UB0E', 1000, 2)
    call SaveInteger(udg_hs, 'UB0F', 1, 'IB3G')
    call SaveInteger(udg_hs, 'UB0F', 2, 'IB3K')
    call SaveInteger(udg_hs, 'UB0F', 1000, 2)
    //圣兽魂谷
    call SaveInteger(udg_hs, 'UB0G', 1, 'IB3M')
    call SaveInteger(udg_hs, 'UB0G', 1000, 1)
    call SaveInteger(udg_hs, 'UB0H', 1, 'IB3O')
    call SaveInteger(udg_hs, 'UB0H', 1000, 1)
    call SaveInteger(udg_hs, 'UB0I', 1, 'IB3P')
    call SaveInteger(udg_hs, 'UB0I', 1000, 1)
    call SaveInteger(udg_hs, 'UB0J', 1, 'IB3N')
    call SaveInteger(udg_hs, 'UB0J', 1000, 1)
    //怒焰谷
    call SaveInteger(udg_hs, 'UB0K', 1, 'IB0Z')
    call SaveInteger(udg_hs, 'UB0K', 1000, 1)
    
    set unitt=CreateUnit(Player(11), 'UB0R', - 9344, - 896, 0)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0S', 39) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0S', - 8832 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs, 11, 'uB0T', 33) //保存坐标
            set unitt=CreateUnit(Player(11), 'uB0T', - 7040 + GetRandomReal(- 640, 640), 2688 + GetRandomReal(- 640, 640), GetRandomReal(0, 360)) //创建单位
            call TriggerAddAction(ttt, function xg)
            call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    
    call SaveInteger(udg_hs, 15, 1, 'UB0V')
    //call CreateUnit(Player(15),'UB0V',-1280,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 2, 'UB0W')
    //call CreateUnit(Player(15),'UB0W',-1024,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 3, 'UB0X')
    //call CreateUnit(Player(15),'UB0X',-768,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 4, 'UB0Y')
    //call CreateUnit(Player(15),'UB0Y',-512,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 5, 'UB0Z')
    //call CreateUnit(Player(15),'UB0Z',-256,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 6, 'UB10')
    //call CreateUnit(Player(15),'UB10',0,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 7, 'UB11')
    //call CreateUnit(Player(15),'UB11',256,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 8, 'UB12')
    //call CreateUnit(Player(15),'UB12',512,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 9, 'UB13')
    //call CreateUnit(Player(15),'UB13',768,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 10, 'UB14')
    //call CreateUnit(Player(15),'UB14',1024,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 11, 'UB15')
    //call CreateUnit(Player(15),'UB15',1280,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 12, 'UB16')
    //call CreateUnit(Player(15),'UB16',1536,1024,270)//测试的时候用来看的
    
    call SaveInteger(udg_hs, 15, 13, 'UB17')
    //call CreateUnit(Player(15),'UB17',1792,1024,270)//测试的时候用来看的
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 47) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', - 4480, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(0)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 48) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', - 2688, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(1)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 49) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', - 896, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(2)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 50) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 896, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(3)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 51) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 2688, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(4)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 52) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 4480, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    
    call SaveReal(udg_hs, GetHandleId(Player(5)), StringHash("音量"), 50)
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, - 4992, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, - 3200, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, - 1408, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, 384, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, 2176, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC0B', - 4992, 3968, 45) //创建练功房
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=null
    
    call CreateItem('IB00', - 570, - 3840)
    
    call CreateItem('IB01', - 560, - 3840)
    
    call CreateItem('IB02', - 550, - 3840)
    
    call CreateItem('IB03', - 540, - 3840)
    
    call CreateItem('IB04', - 530, - 3840)
    
    call CreateItem('IB05', - 520, - 3840)
    
    call CreateItem('IB06', - 510, - 3840)
    
    call CreateItem('IB07', - 500, - 3840)
    
    call CreateItem('IB08', - 490, - 3840)
    
    call CreateItem('IB09', - 480, - 3840)
    
    call CreateItem('IB0A', - 470, - 3840)
    
    call CreateItem('IB0B', - 460, - 3840)
    
    call CreateItem('IB0C', - 450, - 3840)
    
    call CreateItem('IB0D', - 440, - 3840)
    
    call CreateItem('IB0E', - 430, - 3840)
    
    call CreateItem('IB0F', - 420, - 3840)
    
    call CreateItem('IB0G', - 410, - 3840)
    
    call CreateItem('IB0H', - 400, - 3840)
    
    call CreateItem('IB0I', - 390, - 3840)
    
    call CreateItem('IB0J', - 380, - 3840)
    
    call CreateItem('IB0K', - 370, - 3840)
    
    call CreateItem('IB0L', - 360, - 3840)
    
    call CreateItem('IB0M', - 350, - 3840)
    
    call CreateItem('IB0N', - 340, - 3840)
    
    call CreateItem('IB0O', - 330, - 3840)
    
    call CreateItem('IB0P', - 320, - 3840)
    
    call CreateItem('IB0Q', - 310, - 3840)
    
    call CreateItem('IB0R', - 300, - 3840)
    
    call CreateItem('IB0S', - 290, - 3840)
    
    call CreateItem('IB0T', - 280, - 3840)
    
    call CreateItem('IB0U', - 270, - 3840)
    
    call CreateItem('IB0V', - 260, - 3840)
    
    call CreateItem('IB0W', - 250, - 3840)
    
    call CreateItem('IB0X', - 240, - 3840)
    
    call CreateItem('IB0Y', - 230, - 3840)
    
    call CreateItem('IB0Z', - 220, - 3840)
    
    call CreateItem('IB10', - 210, - 3840)
    
    call CreateItem('IB11', - 200, - 3840)
    
    call CreateItem('IB12', - 190, - 3840)
    
    call CreateItem('IB13', - 180, - 3840)
    
    call CreateItem('IB14', - 170, - 3840)
    
    call CreateItem('IB15', - 160, - 3840)
    
    call CreateItem('IB16', - 150, - 3840)
    
    call CreateItem('IB17', - 140, - 3840)
    
    call CreateItem('IB18', - 130, - 3840)
    
    call CreateItem('IB19', - 120, - 3840)
    
    call CreateItem('IB1A', - 110, - 3840)
    
    call CreateItem('IB1B', - 100, - 3840)
    
    call CreateItem('IB1C', - 90, - 3840)
    
    call CreateItem('IB1D', - 80, - 3840)
    
    call CreateItem('IB1E', - 70, - 3840)
    
    call CreateItem('IB1F', - 60, - 3840)
    
    call CreateItem('IB1G', - 50, - 3840)
    
    call CreateItem('IB1H', - 40, - 3840)
    
    call CreateItem('IB1I', - 30, - 3840)
    
    call CreateItem('IB1J', - 20, - 3840)
    
    call CreateItem('IB1K', - 10, - 3840)
    
    call CreateItem('IB1L', 0, - 3840)
    
    call CreateItem('IB1M', 10, - 3840)
    
    call CreateItem('IB1N', 20, - 3840)
    
    call CreateItem('IB1O', 30, - 3840)
    
    call CreateItem('IB1P', 40, - 3840)
    
    call CreateItem('IB1Q', 50, - 3840)
    
    call CreateItem('IB1R', 60, - 3840)
    
    call CreateItem('IB1S', 70, - 3840)
    
    call CreateItem('IB1T', 80, - 3840)
    
    call CreateItem('IB1U', 90, - 3840)
    
    call CreateItem('IB1V', 100, - 3840)
    
    call CreateItem('IB1W', 110, - 3840)
    
    call CreateItem('IB1X', 120, - 3840)
    
    call CreateItem('IB1Y', 130, - 3840)
    
    call CreateItem('IB1Z', 140, - 3840)
    
    call CreateItem('IB20', 150, - 3840)
    
    call CreateItem('IB21', 160, - 3840)
    
    call CreateItem('IB22', 170, - 3840)
    
    call CreateItem('IB23', 180, - 3840)
    
    call CreateItem('IB24', 190, - 3840)
    
    call CreateItem('IB25', 200, - 3840)
    
    call CreateItem('IB26', 210, - 3840)
    
    call CreateItem('IB27', 220, - 3840)
    
    call CreateItem('IB28', 230, - 3840)
    
    call CreateItem('IB29', 240, - 3840)
    
    call CreateItem('IB2A', 250, - 3840)
    
    call CreateItem('IB2B', 260, - 3840)
    
    call CreateItem('IB2C', 270, - 3840)
    
    call CreateItem('IB2D', 280, - 3840)
    
    call CreateItem('IB2E', 290, - 3840)
    
    call CreateItem('IB2F', 300, - 3840)
    
    call CreateItem('IB2G', 310, - 3840)
    
    call CreateItem('IB2H', 320, - 3840)
    
    call CreateItem('IB2I', 330, - 3840)
    
    call CreateItem('IB2J', 340, - 3840)
    
    call CreateItem('IB2K', 350, - 3840)
    
    call CreateItem('IB2L', 360, - 3840)
    
    call CreateItem('IB2M', 370, - 3840)
    
    call CreateItem('IB2N', 380, - 3840)
    
    call CreateItem('IB2O', 390, - 3840)
    
    call CreateItem('IB2P', 400, - 3840)
    
    call CreateItem('IB2Q', 410, - 3840)
    
    call CreateItem('IB2R', 420, - 3840)
    
    call CreateItem('IB2S', 430, - 3840)
    
    call CreateItem('IB2T', 440, - 3840)
    
    call CreateItem('IB2U', 450, - 3840)
    
    call CreateItem('IB2V', 460, - 3840)
    
    call CreateItem('IB2W', 470, - 3840)
    
    call CreateItem('IB2X', 480, - 3840)
    
    call CreateItem('IB2Y', 490, - 3840)
    
    call CreateItem('IB2Z', 500, - 3840)
    
    call CreateItem('IB30', 510, - 3840)
    
    call CreateItem('IB31', 520, - 3840)
    
    call CreateItem('IB32', 530, - 3840)
    
    call CreateItem('IB33', 540, - 3840)
    
    call CreateItem('IB34', 550, - 3840)
    
    call CreateItem('IB35', 560, - 3840)
    
    call CreateItem('IB36', 570, - 3840)
    
    call CreateItem('IB37', 580, - 3840)
    
    call CreateItem('IB38', 590, - 3840)
    
    call CreateItem('IB39', 600, - 3840)
    
    call CreateItem('IB3A', 610, - 3840)
    
    call CreateItem('IB3B', 620, - 3840)
    
    call CreateItem('IB3C', 630, - 3840)
    
    call CreateItem('IB3D', 640, - 3840)
    
    call CreateItem('IB3E', 650, - 3840)
    
    call CreateItem('IB3F', 660, - 3840)
    
    call CreateItem('IB3G', 670, - 3840)
    
    call CreateItem('IB3H', 680, - 3840)
    
    call CreateItem('IB3I', 690, - 3840)
    
    call CreateItem('IB3J', 700, - 3840)
    
    call CreateItem('IB3K', 710, - 3840)
    
    call CreateItem('IB3L', 720, - 3840)
    
    call CreateItem('IB3M', 730, - 3840)
    
    call CreateItem('IB3N', 740, - 3840)
    
    call CreateItem('IB3O', 750, - 3840)
    
    call CreateItem('IB3P', 760, - 3840)
    
    call CreateItem('IB3Q', 770, - 3840)
    
    call CreateItem('IB3R', 780, - 3840)
    
    call CreateItem('IB3S', 790, - 3840)
    
    call CreateItem('IB3T', 800, - 3840)
    
    call CreateItem('IB3U', 810, - 3840)
    
    call CreateItem('IB3V', 820, - 3840)
    
    call CreateItem('IB3W', 830, - 3840)
    
    call CreateItem('IB3X', 840, - 3840)
    
    call CreateItem('IB3Y', 850, - 3840)
    
    call CreateItem('IB3Z', 860, - 3840)
    
    call CreateItem('IB40', 870, - 3840)
    
    call CreateItem('IB41', 880, - 3840)
    
    call SetPlayerAbilityAvailable(Player(0), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(0), 'A00F', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(1), 'A00F', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(2), 'A00F', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(3), 'A00F', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(4), 'A00F', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A001', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A002', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A003', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A004', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A005', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A006', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A007', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A008', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A009', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00A', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00B', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00C', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00D', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00E', false) //禁用所有天赋
    
    call SetPlayerAbilityAvailable(Player(5), 'A00F', false) //禁用所有天赋
    
    call SaveInteger(udg_hs, 22, 'IC00', 1) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB00', 'IB01') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC00', 2, 'IB00') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB00', 1) //存储装备等级
    call SaveInteger(udg_hs, 'IB00', 2, 'IC00') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC01', 2) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB01', 'IB02') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC01', 2, 'IB01') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB01', 2) //存储装备等级
    call SaveInteger(udg_hs, 'IB01', 2, 'IC01') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC02', 3) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB02', 'IB03') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC02', 2, 'IB02') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB02', 3) //存储装备等级
    call SaveInteger(udg_hs, 'IB02', 2, 'IC02') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC03', 4) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB03', 'IB04') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC03', 2, 'IB03') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB03', 4) //存储装备等级
    call SaveInteger(udg_hs, 'IB03', 2, 'IC03') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC04', 5) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB04', 'IB05') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC04', 2, 'IB04') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB04', 5) //存储装备等级
    call SaveInteger(udg_hs, 'IB04', 2, 'IC04') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC05', 6) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB05', 'IB06') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC05', 2, 'IB05') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB05', 6) //存储装备等级
    call SaveInteger(udg_hs, 'IB05', 2, 'IC05') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC06', 7) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB06', 'IB07') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC06', 2, 'IB06') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB06', 7) //存储装备等级
    call SaveInteger(udg_hs, 'IB06', 2, 'IC06') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC07', 8) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB07', 'IB08') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC07', 2, 'IB07') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB07', 8) //存储装备等级
    call SaveInteger(udg_hs, 'IB07', 2, 'IC07') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC08', 9) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB08', 'IB09') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC08', 2, 'IB08') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB08', 9) //存储装备等级
    call SaveInteger(udg_hs, 'IB08', 2, 'IC08') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC09', 10) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB09', 'IB0A') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC09', 2, 'IB09') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB09', 10) //存储装备等级
    call SaveInteger(udg_hs, 'IB09', 2, 'IC09') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0A', 11) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0A', 'IB0B') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0A', 2, 'IB0A') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0A', 11) //存储装备等级
    call SaveInteger(udg_hs, 'IB0A', 2, 'IC0A') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0B', 12) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0B', 'IB0C') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0B', 2, 'IB0B') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0B', 12) //存储装备等级
    call SaveInteger(udg_hs, 'IB0B', 2, 'IC0B') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0C', 13) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0C', 'IB0D') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0C', 2, 'IB0C') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0C', 13) //存储装备等级
    call SaveInteger(udg_hs, 'IB0C', 2, 'IC0C') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0D', 14) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0D', 'IB0E') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0D', 2, 'IB0D') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0D', 14) //存储装备等级
    call SaveInteger(udg_hs, 'IB0D', 2, 'IC0D') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0E', 15) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0E', 'IB0F') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0E', 2, 'IB0E') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0E', 15) //存储装备等级
    call SaveInteger(udg_hs, 'IB0E', 2, 'IC0E') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0F', 16) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0F', 'IB0G') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0F', 2, 'IB0F') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0F', 16) //存储装备等级
    call SaveInteger(udg_hs, 'IB0F', 2, 'IC0F') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0G', 17) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0G', 'IB0H') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0G', 2, 'IB0G') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0G', 17) //存储装备等级
    call SaveInteger(udg_hs, 'IB0G', 2, 'IC0G') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0H', 18) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0H', 'IB0I') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0H', 2, 'IB0H') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0H', 18) //存储装备等级
    call SaveInteger(udg_hs, 'IB0H', 2, 'IC0H') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0I', 19) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0I', 'IB0J') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0I', 2, 'IB0I') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0I', 19) //存储装备等级
    call SaveInteger(udg_hs, 'IB0I', 2, 'IC0I') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0J', 20) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0J', 'IB0K') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0J', 2, 'IB0J') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0J', 20) //存储装备等级
    call SaveInteger(udg_hs, 'IB0J', 2, 'IC0J') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0K', 21) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0K', 'IB0L') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0K', 2, 'IB0K') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0K', 21) //存储装备等级
    call SaveInteger(udg_hs, 'IB0K', 2, 'IC0K') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0L', 22) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0L', 'IB0M') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0L', 2, 'IB0L') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0L', 22) //存储装备等级
    call SaveInteger(udg_hs, 'IB0L', 2, 'IC0L') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0M', 23) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0M', 'IB0N') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0M', 2, 'IB0M') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0M', 23) //存储装备等级
    call SaveInteger(udg_hs, 'IB0M', 2, 'IC0M') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0N', 24) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0N', 'IB0O') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0N', 2, 'IB0N') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0N', 24) //存储装备等级
    call SaveInteger(udg_hs, 'IB0N', 2, 'IC0N') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0O', 25) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0O', 'IB0P') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0O', 2, 'IB0O') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0O', 25) //存储装备等级
    call SaveInteger(udg_hs, 'IB0O', 2, 'IC0O') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0P', 26) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0P', 'IB0Q') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0P', 2, 'IB0P') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0P', 26) //存储装备等级
    call SaveInteger(udg_hs, 'IB0P', 2, 'IC0P') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0Q', 27) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0Q', 'IB0R') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0Q', 2, 'IB0Q') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0Q', 27) //存储装备等级
    call SaveInteger(udg_hs, 'IB0Q', 2, 'IC0Q') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0R', 28) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0R', 'IB0S') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0R', 2, 'IB0R') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0R', 28) //存储装备等级
    call SaveInteger(udg_hs, 'IB0R', 2, 'IC0R') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0S', 29) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0S', 'IB0T') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0S', 2, 'IB0S') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0S', 29) //存储装备等级
    call SaveInteger(udg_hs, 'IB0S', 2, 'IC0S') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0T', 30) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0T', 'IB0U') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0T', 2, 'IB0T') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0T', 30) //存储装备等级
    call SaveInteger(udg_hs, 'IB0T', 2, 'IC0T') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0U', 31) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0U', 'IB0V') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0U', 2, 'IB0U') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0U', 31) //存储装备等级
    call SaveInteger(udg_hs, 'IB0U', 2, 'IC0U') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0V', 32) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0V', 'IB0W') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0V', 2, 'IB0V') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0V', 32) //存储装备等级
    call SaveInteger(udg_hs, 'IB0V', 2, 'IC0V') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0W', 33) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0W', 'IB0X') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0W', 2, 'IB0W') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0W', 33) //存储装备等级
    call SaveInteger(udg_hs, 'IB0W', 2, 'IC0W') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0X', 34) //存储物品等级
    call SaveInteger(udg_hs, 21, 'IB0X', 'IB0Y') //存储装备的下一级
    call SaveInteger(udg_hs, 'IC0X', 2, 'IB0X') //存储物品对应装备
    call SaveInteger(udg_hs, 25, 'IB0X', 34) //存储装备等级
    call SaveInteger(udg_hs, 'IB0X', 2, 'IC0X') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0Y', 1)
    call SaveInteger(udg_hs, 21, 'IB1D', 'IB1E')
    call SaveInteger(udg_hs, 'IC0Y', 3, 'IB1D')
    call SaveInteger(udg_hs, 25, 'IB1D', 1) //存储装备等级
    call SaveInteger(udg_hs, 'IB1D', 2, 'IC0Y') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC0Z', 2)
    call SaveInteger(udg_hs, 21, 'IB1E', 'IB1F')
    call SaveInteger(udg_hs, 'IC0Z', 3, 'IB1E')
    call SaveInteger(udg_hs, 25, 'IB1E', 2) //存储装备等级
    call SaveInteger(udg_hs, 'IB1E', 2, 'IC0Z') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC10', 3)
    call SaveInteger(udg_hs, 21, 'IB1F', 'IB1G')
    call SaveInteger(udg_hs, 'IC10', 3, 'IB1F')
    call SaveInteger(udg_hs, 25, 'IB1F', 3) //存储装备等级
    call SaveInteger(udg_hs, 'IB1F', 2, 'IC10') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC11', 4)
    call SaveInteger(udg_hs, 21, 'IB1G', 'IB1H')
    call SaveInteger(udg_hs, 'IC11', 3, 'IB1G')
    call SaveInteger(udg_hs, 25, 'IB1G', 4) //存储装备等级
    call SaveInteger(udg_hs, 'IB1G', 2, 'IC11') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC12', 5)
    call SaveInteger(udg_hs, 21, 'IB1H', 'IB1I')
    call SaveInteger(udg_hs, 'IC12', 3, 'IB1H')
    call SaveInteger(udg_hs, 25, 'IB1H', 5) //存储装备等级
    call SaveInteger(udg_hs, 'IB1H', 2, 'IC12') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC13', 6)
    call SaveInteger(udg_hs, 21, 'IB1I', 'IB1J')
    call SaveInteger(udg_hs, 'IC13', 3, 'IB1I')
    call SaveInteger(udg_hs, 25, 'IB1I', 6) //存储装备等级
    call SaveInteger(udg_hs, 'IB1I', 2, 'IC13') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC14', 7)
    call SaveInteger(udg_hs, 21, 'IB1J', 'IB1K')
    call SaveInteger(udg_hs, 'IC14', 3, 'IB1J')
    call SaveInteger(udg_hs, 25, 'IB1J', 7) //存储装备等级
    call SaveInteger(udg_hs, 'IB1J', 2, 'IC14') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC15', 8)
    call SaveInteger(udg_hs, 21, 'IB1K', 'IB1L')
    call SaveInteger(udg_hs, 'IC15', 3, 'IB1K')
    call SaveInteger(udg_hs, 25, 'IB1K', 8) //存储装备等级
    call SaveInteger(udg_hs, 'IB1K', 2, 'IC15') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC16', 9)
    call SaveInteger(udg_hs, 21, 'IB1L', 'IB1M')
    call SaveInteger(udg_hs, 'IC16', 3, 'IB1L')
    call SaveInteger(udg_hs, 25, 'IB1L', 9) //存储装备等级
    call SaveInteger(udg_hs, 'IB1L', 2, 'IC16') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC17', 10)
    call SaveInteger(udg_hs, 21, 'IB1M', 'IB1N')
    call SaveInteger(udg_hs, 'IC17', 3, 'IB1M')
    call SaveInteger(udg_hs, 25, 'IB1M', 10) //存储装备等级
    call SaveInteger(udg_hs, 'IB1M', 2, 'IC17') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC18', 11)
    call SaveInteger(udg_hs, 21, 'IB1N', 'IB1O')
    call SaveInteger(udg_hs, 'IC18', 3, 'IB1N')
    call SaveInteger(udg_hs, 25, 'IB1N', 11) //存储装备等级
    call SaveInteger(udg_hs, 'IB1N', 2, 'IC18') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC19', 12)
    call SaveInteger(udg_hs, 21, 'IB1O', 'IB1P')
    call SaveInteger(udg_hs, 'IC19', 3, 'IB1O')
    call SaveInteger(udg_hs, 25, 'IB1O', 12) //存储装备等级
    call SaveInteger(udg_hs, 'IB1O', 2, 'IC19') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1A', 13)
    call SaveInteger(udg_hs, 21, 'IB1P', 'IB1Q')
    call SaveInteger(udg_hs, 'IC1A', 3, 'IB1P')
    call SaveInteger(udg_hs, 25, 'IB1P', 13) //存储装备等级
    call SaveInteger(udg_hs, 'IB1P', 2, 'IC1A') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1B', 14)
    call SaveInteger(udg_hs, 21, 'IB1Q', 'IB1R')
    call SaveInteger(udg_hs, 'IC1B', 3, 'IB1Q')
    call SaveInteger(udg_hs, 25, 'IB1Q', 14) //存储装备等级
    call SaveInteger(udg_hs, 'IB1Q', 2, 'IC1B') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1C', 15)
    call SaveInteger(udg_hs, 21, 'IB1R', 'IB1S')
    call SaveInteger(udg_hs, 'IC1C', 3, 'IB1R')
    call SaveInteger(udg_hs, 25, 'IB1R', 15) //存储装备等级
    call SaveInteger(udg_hs, 'IB1R', 2, 'IC1C') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1D', 16)
    call SaveInteger(udg_hs, 21, 'IB1S', 'IB1T')
    call SaveInteger(udg_hs, 'IC1D', 3, 'IB1S')
    call SaveInteger(udg_hs, 25, 'IB1S', 16) //存储装备等级
    call SaveInteger(udg_hs, 'IB1S', 2, 'IC1D') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1E', 17)
    call SaveInteger(udg_hs, 21, 'IB1T', 'IB1U')
    call SaveInteger(udg_hs, 'IC1E', 3, 'IB1T')
    call SaveInteger(udg_hs, 25, 'IB1T', 17) //存储装备等级
    call SaveInteger(udg_hs, 'IB1T', 2, 'IC1E') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1F', 18)
    call SaveInteger(udg_hs, 21, 'IB1U', 'IB1V')
    call SaveInteger(udg_hs, 'IC1F', 3, 'IB1U')
    call SaveInteger(udg_hs, 25, 'IB1U', 18) //存储装备等级
    call SaveInteger(udg_hs, 'IB1U', 2, 'IC1F') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1G', 19)
    call SaveInteger(udg_hs, 21, 'IB1V', 'IB1W')
    call SaveInteger(udg_hs, 'IC1G', 3, 'IB1V')
    call SaveInteger(udg_hs, 25, 'IB1V', 19) //存储装备等级
    call SaveInteger(udg_hs, 'IB1V', 2, 'IC1G') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1H', 20)
    call SaveInteger(udg_hs, 21, 'IB1W', 'IB1X')
    call SaveInteger(udg_hs, 'IC1H', 3, 'IB1W')
    call SaveInteger(udg_hs, 25, 'IB1W', 20) //存储装备等级
    call SaveInteger(udg_hs, 'IB1W', 2, 'IC1H') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1I', 21)
    call SaveInteger(udg_hs, 21, 'IB1X', 'IB1Y')
    call SaveInteger(udg_hs, 'IC1I', 3, 'IB1X')
    call SaveInteger(udg_hs, 25, 'IB1X', 21) //存储装备等级
    call SaveInteger(udg_hs, 'IB1X', 2, 'IC1I') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1J', 22)
    call SaveInteger(udg_hs, 21, 'IB1Y', 'IB1Z')
    call SaveInteger(udg_hs, 'IC1J', 3, 'IB1Y')
    call SaveInteger(udg_hs, 25, 'IB1Y', 22) //存储装备等级
    call SaveInteger(udg_hs, 'IB1Y', 2, 'IC1J') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1K', 23)
    call SaveInteger(udg_hs, 21, 'IB1Z', 'IB20')
    call SaveInteger(udg_hs, 'IC1K', 3, 'IB1Z')
    call SaveInteger(udg_hs, 25, 'IB1Z', 23) //存储装备等级
    call SaveInteger(udg_hs, 'IB1Z', 2, 'IC1K') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1L', 24)
    call SaveInteger(udg_hs, 21, 'IB20', 'IB21')
    call SaveInteger(udg_hs, 'IC1L', 3, 'IB20')
    call SaveInteger(udg_hs, 25, 'IB20', 24) //存储装备等级
    call SaveInteger(udg_hs, 'IB20', 2, 'IC1L') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1M', 25)
    call SaveInteger(udg_hs, 21, 'IB21', 'IB22')
    call SaveInteger(udg_hs, 'IC1M', 3, 'IB21')
    call SaveInteger(udg_hs, 25, 'IB21', 25) //存储装备等级
    call SaveInteger(udg_hs, 'IB21', 2, 'IC1M') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1N', 26)
    call SaveInteger(udg_hs, 21, 'IB22', 'IB23')
    call SaveInteger(udg_hs, 'IC1N', 3, 'IB22')
    call SaveInteger(udg_hs, 25, 'IB22', 26) //存储装备等级
    call SaveInteger(udg_hs, 'IB22', 2, 'IC1N') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1O', 27)
    call SaveInteger(udg_hs, 21, 'IB23', 'IB24')
    call SaveInteger(udg_hs, 'IC1O', 3, 'IB23')
    call SaveInteger(udg_hs, 25, 'IB23', 27) //存储装备等级
    call SaveInteger(udg_hs, 'IB23', 2, 'IC1O') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1P', 28)
    call SaveInteger(udg_hs, 21, 'IB24', 'IB25')
    call SaveInteger(udg_hs, 'IC1P', 3, 'IB24')
    call SaveInteger(udg_hs, 25, 'IB24', 28) //存储装备等级
    call SaveInteger(udg_hs, 'IB24', 2, 'IC1P') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1Q', 29)
    call SaveInteger(udg_hs, 21, 'IB25', 'IB26')
    call SaveInteger(udg_hs, 'IC1Q', 3, 'IB25')
    call SaveInteger(udg_hs, 25, 'IB25', 29) //存储装备等级
    call SaveInteger(udg_hs, 'IB25', 2, 'IC1Q') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1R', 30)
    call SaveInteger(udg_hs, 21, 'IB26', 'IB27')
    call SaveInteger(udg_hs, 'IC1R', 3, 'IB26')
    call SaveInteger(udg_hs, 25, 'IB26', 30) //存储装备等级
    call SaveInteger(udg_hs, 'IB26', 2, 'IC1R') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1S', 31)
    call SaveInteger(udg_hs, 21, 'IB27', 'IB28')
    call SaveInteger(udg_hs, 'IC1S', 3, 'IB27')
    call SaveInteger(udg_hs, 25, 'IB27', 31) //存储装备等级
    call SaveInteger(udg_hs, 'IB27', 2, 'IC1S') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1T', 32)
    call SaveInteger(udg_hs, 21, 'IB28', 'IB29')
    call SaveInteger(udg_hs, 'IC1T', 3, 'IB28')
    call SaveInteger(udg_hs, 25, 'IB28', 32) //存储装备等级
    call SaveInteger(udg_hs, 'IB28', 2, 'IC1T') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1U', 33)
    call SaveInteger(udg_hs, 21, 'IB29', 'IB2A')
    call SaveInteger(udg_hs, 'IC1U', 3, 'IB29')
    call SaveInteger(udg_hs, 25, 'IB29', 33) //存储装备等级
    call SaveInteger(udg_hs, 'IB29', 2, 'IC1U') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1V', 34)
    call SaveInteger(udg_hs, 21, 'IB2A', 'IB2B')
    call SaveInteger(udg_hs, 'IC1V', 3, 'IB2A')
    call SaveInteger(udg_hs, 25, 'IB2A', 34) //存储装备等级
    call SaveInteger(udg_hs, 'IB2A', 2, 'IC1V') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1W', 1)
    call SaveInteger(udg_hs, 21, 'IB0Z', 'IB10')
    call SaveInteger(udg_hs, 'IC1W', 4, 'IB0Z')
    call SaveInteger(udg_hs, 25, 'IB0Z', 1) //存储装备等级
    call SaveInteger(udg_hs, 'IB0Z', 2, 'IC1W') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1X', 2)
    call SaveInteger(udg_hs, 21, 'IB10', 'IB11')
    call SaveInteger(udg_hs, 'IC1X', 4, 'IB10')
    call SaveInteger(udg_hs, 25, 'IB10', 2) //存储装备等级
    call SaveInteger(udg_hs, 'IB10', 2, 'IC1X') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1Y', 3)
    call SaveInteger(udg_hs, 21, 'IB11', 'IB12')
    call SaveInteger(udg_hs, 'IC1Y', 4, 'IB11')
    call SaveInteger(udg_hs, 25, 'IB11', 3) //存储装备等级
    call SaveInteger(udg_hs, 'IB11', 2, 'IC1Y') //存储装备对应物品
    
    call SaveInteger(udg_hs, 22, 'IC1Z', 4)
    call SaveInteger(udg_hs, 21, 'IB12', 'IB13')
    call SaveInteger(udg_hs, 'IC1Z', 4, 'IB12')
    call SaveInteger(udg_hs, 25, 'IB12', 4) //存储装备等级
    call SaveInteger(udg_hs, 'IB12', 2, 'IC1Z') //存储装备对应物品
    
    call SetMusicVolume(PercentToInt(50, 127))
    //等级1的可购买物品强化
    //武器
    call SaveInteger(udg_hs, 'IB3U', 0, 1)
    call SaveInteger(udg_hs, 'IB3U', 1, 'IC00')
    call SaveInteger(udg_hs, 'IB3U', 2, 'IC01')
    call SaveInteger(udg_hs, 'IB3U', 3, 'IC02')
    call SaveInteger(udg_hs, 'IB3U', 4, 'IC03')
    //衣服
    call SaveInteger(udg_hs, 'IB3V', 0, 2)
    call SaveInteger(udg_hs, 'IB3V', 1, 'IC0Y')
    call SaveInteger(udg_hs, 'IB3V', 2, 'IC0Z')
    call SaveInteger(udg_hs, 'IB3V', 3, 'IC10')
    call SaveInteger(udg_hs, 'IB3V', 4, 'IC11')
    //等级4
    call SaveInteger(udg_hs, 'IB3L', 0, 'IB2D')
    call SaveInteger(udg_hs, 'IB3L', 1, 'IB2E')
    call SaveInteger(udg_hs, 'IB3M', 0, 'IB2K')
    call SaveInteger(udg_hs, 'IB3N', 0, 'IB2L')
    call SaveInteger(udg_hs, 'IB3O', 0, 'IB2M')
    call SaveInteger(udg_hs, 'IB3P', 0, 'IB2N')
    
    call SaveInteger(udg_hs, 'IB3M', 1, 'IB19')
    call SaveInteger(udg_hs, 'IB3N', 1, 'IB1A')
    call SaveInteger(udg_hs, 'IB3O', 1, 'IB1B')
    call SaveInteger(udg_hs, 'IB3P', 1, 'IB1C')
    
    
    
    //装备强化和合成初始化函数
    //暗夜蛛丝
    call itemreg('IB1H' , 1 , 'IB3W' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'IC12' , 2 , true)
    //锐利蛛尖
    call itemreg('IB04' , 1 , 'IB3X' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'IC04' , 2 , true)
    //蛇龙皮
    call itemreg('IB1M' , 1 , 'IB3Y' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'IC17' , 2 , true)
    //蛇龙尖牙
    call itemreg('IB09' , 1 , 'IB3Z' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'IC09' , 2 , true)
    //龙之利爪
    call itemreg('IB0E' , 1 , 'IB3H' , 1 , 'IB3I' , 1 , 'IB3J' , 1 , 'IB3K' , 1 , 0 , 0 , 'IC0E' , 5 , true)
    //龙之鳞甲
    call itemreg('IB1R' , 1 , 'IB3D' , 1 , 'IB3E' , 1 , 'IB3F' , 1 , 'IB3G' , 1 , 0 , 0 , 'IC1C' , 5 , true)
    //斗者项链
    call SaveInteger(udg_hs, 'IB2E', 1, 'IB2F')
    call SaveInteger(udg_hs, 'IB2E', 2, 'IB2G')
    call SaveInteger(udg_hs, 'IB2E', 3, 'IB2H')
    call SaveInteger(udg_hs, 'IB2E', 4, 'IB2I')
    call SaveInteger(udg_hs, 'IB2E', 5, 'IB2J')
    //火焰护手
    call SaveInteger(udg_hs, 'IB13', 1, 'IB14')
    call SaveInteger(udg_hs, 'IB13', 2, 'IB15')
    call SaveInteger(udg_hs, 'IB13', 3, 'IB16')
    call SaveInteger(udg_hs, 'IB13', 4, 'IB17')
    call SaveInteger(udg_hs, 'IB13', 5, 'IB18')
    
    set kx[11]='AA3A'
    
    set kx[11]='AA3B'
    
    set kx[11]='AA3C'
    
    set kx[11]='AA3D'
    
    set kx[11]='AA3E'
    
    set kx[11]='AA3F'
    
    set kx[11]='AA3G'
    
    set kx[11]='AA3H'
    
    set kx[11]='AA3I'
    
    set kx[11]='AA3J'
    
    set kx[11]='AA3K'
    
    set kx[11]='AA4A'
    
    set kx[11]='AA4B'
    
    set kx[11]='AA4C'
    
    set kx[11]='AA4D'
    
    set kx[11]='AA4E'
    
    set kx[11]='AA4F'
    
    set kx[11]='AA4G'
    
    set kx[11]='AA4H'
    
    set kx[11]='AA4I'
    
    set kx[11]='AA4J'
    
    set vx[0]=0
    set zx[0]=0
    set cx[0]=0
    set yx[0]=0
    set fx[0]=0
    set dx[0]=0
    set m[0]=GetRandomInt(- 50, 50)
    set m[6]=m[0]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[0] + StringHash(GetPlayerName(Player(0))), m[0], 4052366646 + m[0])
    
    set vx[1]=0
    set zx[1]=0
    set cx[1]=0
    set yx[1]=0
    set fx[1]=0
    set dx[1]=0
    set m[1]=GetRandomInt(- 50, 50)
    set m[6]=m[1]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[1] + StringHash(GetPlayerName(Player(1))), m[1], 4052366646 + m[1])
    
    set vx[2]=0
    set zx[2]=0
    set cx[2]=0
    set yx[2]=0
    set fx[2]=0
    set dx[2]=0
    set m[2]=GetRandomInt(- 50, 50)
    set m[6]=m[2]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[2] + StringHash(GetPlayerName(Player(2))), m[2], 4052366646 + m[2])
    
    set vx[3]=0
    set zx[3]=0
    set cx[3]=0
    set yx[3]=0
    set fx[3]=0
    set dx[3]=0
    set m[3]=GetRandomInt(- 50, 50)
    set m[6]=m[3]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[3] + StringHash(GetPlayerName(Player(3))), m[3], 4052366646 + m[3])
    
    set vx[4]=0
    set zx[4]=0
    set cx[4]=0
    set yx[4]=0
    set fx[4]=0
    set dx[4]=0
    set m[4]=GetRandomInt(- 50, 50)
    set m[6]=m[4]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[4] + StringHash(GetPlayerName(Player(4))), m[4], 4052366646 + m[4])
    
    set vx[5]=0
    set zx[5]=0
    set cx[5]=0
    set yx[5]=0
    set fx[5]=0
    set dx[5]=0
    set m[5]=GetRandomInt(- 50, 50)
    set m[6]=m[5]
    set m[7]=- 50
    loop
        exitwhen m[7] == m[6]
        set m[7]=m[7] + 1
    endloop
    call SaveInteger(udg_hs, m[5] + StringHash(GetPlayerName(Player(5))), m[5], 4052366646 + m[5])
    
    
    set lgf[0]=0
    set lgf[6]=0
    set lgf[12]=0
    
    set lgf[1]=0
    set lgf[7]=0
    set lgf[13]=0
    
    set lgf[2]=0
    set lgf[8]=0
    set lgf[14]=0
    
    set lgf[3]=0
    set lgf[9]=0
    set lgf[15]=0
    
    set lgf[4]=0
    set lgf[10]=0
    set lgf[16]=0
    
    set lgf[5]=0
    set lgf[11]=0
    set lgf[17]=0
    
    set cl[1]='IB2Y'
    
    set cl[2]='IB2Z'
    
    set cl[3]='IB30'
    
    set cl[4]='IB31'
    
    set cl[5]='IB39'
    
    set cl[6]='IB3A'
    
    set cl[7]='IB3C'
    
    set cl[8]='IB3D'
    
    set cl[9]='IB3E'
    
    set cl[10]='IB3F'
    
    set cl[11]='IB3G'
    
    set cl[12]='IB3H'
    
    set cl[13]='IB3I'
    
    set cl[14]='IB3J'
    
    set cl[15]='IB3K'
    
    set cl[16]='IB3L'
    
    set cl[17]='IB3M'
    
    set cl[18]='IB3N'
    
    set cl[19]='IB3O'
    
    set cl[20]='IB3P'
    
    set cl[21]='IB3Q'
    
    set cl[22]='IB3R'
    
    set cl[23]='IB3S'
    
    set cl[24]='IB3T'
    
    set cl[25]='IB3U'
    
    set cl[26]='IB3V'
    
    set cl[27]='IB3W'
    
    set cl[28]='IB3X'
    
    set cl[29]='IB3Y'
    
    set cl[30]='IB3Z'
    
    set cl[31]='IB40'
    
    set cl[32]='IB41'
    
    //call SaveInteger(udg_hs,30,1,'IBB0')
    set cl[33]='IBB0'
    
    //call SaveInteger(udg_hs,30,2,'IBB1')
    set cl[34]='IBB1'
    
    //call SaveInteger(udg_hs,30,3,'IBB2')
    set cl[35]='IBB2'
    
    //call SaveInteger(udg_hs,30,4,'IBB3')
    set cl[36]='IBB3'
    
    //call SaveInteger(udg_hs,30,5,'IBB4')
    set cl[37]='IBB4'
    
    //call SaveInteger(udg_hs,30,6,'IBB5')
    set cl[38]='IBB5'
    
    call zhan() //天赋技能初始化随机
    set ttt=null
    endfunction 
    function csh__init takes nothing returns nothing
        call LUAcreateunit() //lua初始化，内容在上面
        call input() //输入触发
        call xzyx() //选择英雄初始化
        call fuhuo() //复活英雄
        call time0() //注册0秒事件
        call chuguai() //注册出怪事件
        call choicelv() //创建对话框触发
        call getitem() //创建获得物品触发
        call list() //注册菜单触发
        call ajidi() //注册攻击基地
        call kj() //注册科技同步
        call bgj() //注册被攻击事件
        call death() //注册死亡事件
        call skill() //注册发动技能效果事件
        call sywp() //注册任意单位使用物品
        call lvup() //注册英雄升级事件
    endfunction

//library csh ends
//===========================================================================
// 
// 屠杀野猪捡奶酪V2.0
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Fri Jun 22 20:52:50 2018
//   Map Author: 张耀畅
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
endfunction
//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//TESH.scrollpos=0
//TESH.alwaysfold=0
 
//导入其他J文件
//导入完毕
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 6
    call SetPlayerStartLocation(Player(6), 2)
    call ForcePlayerStartLocation(Player(6), 2)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_COMPUTER)
    // Player 10
    call SetPlayerStartLocation(Player(10), 3)
    call ForcePlayerStartLocation(Player(10), 3)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_005
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerTeam(Player(6), 0)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    // Force: TRIGSTR_006
    call SetPlayerTeam(Player(10), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 10240.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 10240.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 10240.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 10240.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 10240.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 10240.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 10240.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 10240.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("CityScapeDay")
    call SetAmbientNightSound("CityScapeNight")
    call SetMapMusic("Music", true, 0)
    call InitBlizzard()

call ExecuteFunc("csh__init")

    call InitGlobals()
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("屠杀野猪捡奶酪V2.0")
    call SetMapDescription("此图为纪念屠杀野猪捡奶酪V1.0")
    call SetPlayers(4)
    call SetTeams(4)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 0.0, - 576.0)
    call DefineStartLocation(1, 0.0, - 576.0)
    call DefineStartLocation(2, 0.0, - 576.0)
    call DefineStartLocation(3, 0.0, - 576.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

