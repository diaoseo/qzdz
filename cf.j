
library libcf

globals

    private hashtable z_h=InitHashtable()

endglobals






private function hy3 takes nothing returns nothing
    local unit u=LoadUnitHandle(z_h,GetHandleId(GetExpiredTimer()),0)
    call SetUnitTimeScale(u,0)
    call FlushChildHashtable(z_h,GetHandleId(GetExpiredTimer()))
    call DestroyTimer(GetExpiredTimer())
    set u=null
endfunction


private function hy2 takes nothing returns nothing
    local unit u=LoadUnitHandle(z_h,GetHandleId(GetExpiredTimer()),0)
    local real sj=LoadReal(z_h,GetHandleId(GetExpiredTimer()),1)
    local timer t=CreateTimer()
    call SetUnitTimeScale(u,1)
    call TimerStart(t,sj,false,function hy3)
    call SaveUnitHandle(z_h,GetHandleId(t),0,u)
    call FlushChildHashtable(z_h,GetHandleId(GetExpiredTimer()))
    call DestroyTimer(GetExpiredTimer())
    set u=null
    set t=null
endfunction

private function hy1 takes nothing returns nothing//幻影回调
    local integer h=GetHandleId(GetExpiredTimer())//计时器
    local unit u=LoadUnitHandle(z_h,h,0)//设置幻影的单位
    local integer li=LoadInteger(z_h,h,1)//透明度
    if li==20 then//20级的透明度
        call RemoveUnit(u)//移除单位
        call DestroyTimer(GetExpiredTimer())//删除到期计时器
        call FlushChildHashtable(z_h,h)//清理哈希表
    else
        set li=li+1
        call SetUnitVertexColor(u,255,255,255,R2I((255/20)*li))//设置透明度
        call SaveInteger(z_h,h,1,li)//保存当前透明度层次
    endif
    set u=null 
endfunction

private function cf_3 takes nothing returns nothing//创建幻影
    local integer h=GetHandleId(GetExpiredTimer())//计时器ID
    local unit u=LoadUnitHandle(z_h,h,0)//冲的单位
    local real ux=GetUnitX(u)//冲的X
    local real uy=GetUnitY(u)//冲的Y
    local integer c=LoadInteger(z_h,h,1)//刷新次数
    local integer c1=LoadInteger(z_h,h,2) //已刷新次数
    local timer t=CreateTimer()//新计时器
    local integer h1=GetHandleId(t)
    local real gd=GetUnitFlyHeight(u)//获取幻影本体高度
    local real sj=LoadReal(z_h,h,5)
    if c1<c then
        set u=CreateUnit(GetOwningPlayer(u),LoadInteger(z_h,h,99),ux,uy,GetUnitFacing(u))//创建幻影
        call SetUnitFlyHeight(u,gd,0)//设置幻影的高度
        call SetUnitVertexColor(u,255,255,255,0)//设置幻影初始透明度
        call UnitAddAbility(u,'Arav')//添加风暴之鸦
        call UnitRemoveAbility(u,'Arav')//删除风暴之鸦
        call SaveUnitHandle(z_h,h1,0,u)//保存单位
        call TimerStart(t,0.04,true,function hy1)
        call SetUnitAnimationByIndex(u,3)
        call SetUnitTimeScale(u,10)
        set t=CreateTimer()
        call SaveUnitHandle(z_h,GetHandleId(t),0,u)
        call SaveReal(z_h,GetHandleId(t),1,sj)
        call TimerStart(t,sj*0.1*c1,true,function hy2)
        set c1=c1+1
        call SaveInteger(z_h,h,2,c1)
    else
        call FlushChildHashtable(z_h,h)
        call DestroyTimer(GetExpiredTimer())
    endif
    set u=null
    set t=null
endfunction

private function cf_1 takes nothing returns nothing//有碰撞
    local integer h=GetHandleId(GetExpiredTimer())//计时器ID
    local unit u=LoadUnitHandle(z_h,h,0)//冲的单位
    local real ux=GetUnitX(u)//冲的X
    local real uy=GetUnitY(u)//冲的Y
    local real a=LoadReal(z_h,h,1)//角度
    local real jl=LoadReal(z_h,h,2)//每次刷新距离
    local integer c=LoadInteger(z_h,h,3)//刷新次数
    local integer c1=LoadInteger(z_h,h,4) //已刷新次数
    local boolean ty=LoadBoolean(z_h,h,7)//是否跳跃
    local real gd=LoadReal(z_h,h,6)
    if c1<c then
        if IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_WALKABILITY) and  IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_BUILDABILITY) then
        call BJDebugMsg("出事了？")
        else
            call SetUnitX(u,ux+jl*Cos(a))
        endif

        if IsTerrainPathable(ux,uy+jl*Sin(a),PATHING_TYPE_WALKABILITY) and IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_BUILDABILITY)then
        //Y坐标停下来了
        else
            call SetUnitY(u,uy+jl*Sin(a))
        endif
        if ty then
            if c1>c/2 then//超过一半上升，未超过下降
                call SetUnitFlyHeight(u,(c-c1)*gd,0)
            else
                call SetUnitFlyHeight(u,c1*gd,0)
            endif
        endif
        set c1=c1+1
        call SaveInteger(z_h,h,4,c1)
    else
        //call PauseUnit(u,false)
        call DestroyTimer(GetExpiredTimer())
        call FlushChildHashtable(z_h,h)
    endif
    set u=null
endfunction

public function cf takes unit u,real x,real y,real s1, real s2,boolean yhy,boolean ty returns nothing//向目标坐标冲锋
//                          单位    目标X,Y     时间        间隔    有无幻影    跳跃
    local timer t=CreateTimer()
    local real ux=GetUnitX(u)
    local real uy=GetUnitY(u)
    local real jl=SquareRoot((x-ux)*(x-ux)+(y-uy)*(y-uy))//两坐标间距离
    local real c=s1/s2//刷新次数
    local real xjl=jl/c//每次距离
    local integer h=GetHandleId(t)//计时器ID
    call SaveUnitHandle(z_h,h,0,u)//单位
    call SaveReal(z_h,h,1,Atan2(y-uy,x-ux))// 角度
    call SaveReal(z_h,h,2,xjl)//每次距离
    call SaveInteger(z_h,h,3,R2I(c))//刷新次数
    call TimerStart(t,s2,true,function cf_1)//冲锋
    call SetUnitAnimationByIndex(u,3)
    if ty then
        call UnitAddAbility(u,'Arav')
        call UnitRemoveAbility(u,'Arav')
        call SaveBoolean(z_h,h,7,ty)
        call SaveReal(z_h,h,6,400/c)//每次跳跃高度

    endif

    if yhy then
        //call PauseUnit(u,true)

        set t= CreateTimer()
        set h=GetHandleId(t)
        call SaveUnitHandle(z_h,h,0,u)//单位
        call SaveInteger(z_h,h,1,R2I(s1/0.04))//幻影数量
        if LoadInteger(udg_hs,0,105)==1 then
            call SaveInteger(z_h,h,99,'n004')
        else
            call SaveInteger(z_h,h,99,'n005')
        endif
        call TimerStart(t,0.04,true,function cf_3)
        call SaveReal(z_h,h,5,s2)
    endif

    set t=null
endfunction


public function cf1 takes unit u1,unit u2 returns nothing//原地击退
    local real u1x=GetUnitX(u1)
    local real u1y=GetUnitY(u1)
    local real u2x=GetUnitX(u2)
    local real u2y=GetUnitY(u2)
    local real jl=800-SquareRoot((u1x-u2x)*(u1x-u2x)+(u1y-u2y)*(u1y-u2y))//距离
    local real a=Atan2(u1y-u2y,u1x-u2x)//角度
    local real s=jl/400//用时
    local real c=s/0.04//次数
    local real xjl=jl/c//每次距离
    local timer t=CreateTimer()
    local integer h=GetHandleId(t)
    call SaveUnitHandle(z_h,h,0,u1)
    call SaveReal(z_h,h,1,a)
    call SaveReal(z_h,h,2,xjl)
    call SaveInteger(z_h,h,3,R2I(c))
    call TimerStart(t,0.04,true,function cf_1)
    set t=null
endfunction

public function cf2 takes unit u1,unit u2 returns nothing//原地聚拢
    local real u1x=GetUnitX(u1)
    local real u1y=GetUnitY(u1)
    local real u2x=GetUnitX(u2)
    local real u2y=GetUnitY(u2)
    local real jl=SquareRoot((u1x-u2x)*(u1x-u2x)+(u1y-u2y)*(u1y-u2y))//距离
    local real a=Atan2(u2y-u1y,u2x-u1x)//角度
    local real s=jl/800//用时
    local real c=s/0.04//次数
    local real xjl=jl/c//每次距离
    local timer t=CreateTimer()
    local integer h=GetHandleId(t)
    call SaveUnitHandle(z_h,h,0,u1)
    call SaveReal(z_h,h,1,a)
    call SaveReal(z_h,h,2,xjl)
    call SaveInteger(z_h,h,3,R2I(c))
    call TimerStart(t,0.04,true,function cf_1)
    set t=null
endfunction



function cfsh_1 takes nothing returns nothing
    local trigger tr=GetTriggeringTrigger()
    local integer li=GetHandleId(tr)
    local unit u= LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(LoadUnitHandle(udg_hs,li,0))),StringHash("英雄"))
    local real s=LoadReal(udg_hs,li,1)
    local unit u2=GetTriggerUnit()
    if GetUnitState(u2,UNIT_STATE_LIFE)>0 and IsUnitOwnedByPlayer(u2,Player(11)) then
        call UnitDamageTarget(u,u2,s, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_METAL_LIGHT_CHOP )//给予伤害
        call BJDebugMsg(R2S(s))
    endif
    
    set tr=null
    set u=null
    set u2=null
endfunction


function shpx takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local integer li=GetHandleId(t)
    local trigger tr=LoadTriggerHandle(udg_hs,li,0)
    call FlushChildHashtable(udg_hs,GetHandleId(tr))
    call FlushChildHashtable(udg_hs,li)
    call DestroyTrigger(tr)
    call DestroyTimer(t)
    set t=null
    set tr=null
endfunction

public function cftimer_1 takes nothing returns nothing
    local timer t=GetExpiredTimer()
    local timer t2
    local real array r
    local integer array li
    local unit u
    local player p1
    local unit u1
    local trigger tr
    set li[0]=GetHandleId(t)
    set u=LoadUnitHandle(udg_hs,li[0],0)
    set p1=GetOwningPlayer(u)
    set r[1]=GetUnitX(u)
    set r[2]=GetUnitY(u)
    set r[3]=LoadReal(udg_hs,li[0],1)
    set r[4]=LoadReal(udg_hs,li[0],2)
    set r[5]=(180/3.14159)*Atan2(r[4]-r[2],r[3]-r[1])
    set li[1]=-4
    set li[2]=LoadInteger(udg_hs,li[0],3)+1
    set li[3]=LoadInteger(udg_hs,li[0],4)
    set r[8]=LoadReal(udg_hs,li[0],5)
    loop
        set r[6]=GetUnitX(u) + 600*Cos((r[5]+15*li[1])*3.14159/180)
        set r[7]=GetUnitY(u) + 600*Sin((r[5]+15*li[1])*3.14159/180)
        set u1=CreateUnit(p1,'n003',r[1],r[2],r[5]+15*li[1])
        call SetUnitPathing(u1,false)
        call AddSpecialEffectTarget("Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl",u1,"sprite")
        call UnitApplyTimedLife(u1,'BHwe',0.5)
        set tr=CreateTrigger()
        call TriggerAddAction(tr,function cfsh_1)
        call SaveUnitHandle(udg_hs,GetHandleId(tr),0,u1)
        call SaveReal(udg_hs,GetHandleId(tr),1,r[8])
        call TriggerRegisterUnitInRange(tr,u1,64,null)
        set t2=CreateTimer()
        call SaveTriggerHandle(udg_hs,GetHandleId(t2),0,tr)
        call TimerStart(t2,0.5,false,function shpx)
        call cf(u1,r[6],r[7],0.5,0.025,false,false)
        exitwhen li[1]==4
        set li[1]=li[1]+1
    endloop
    if li[2]==li[3] then
        call FlushChildHashtable(udg_hs,li[0])
        call DestroyTimer(GetExpiredTimer())
    else
        call SaveInteger(udg_hs,li[0],3,li[2])
    endif
    set tr=null
    set u=null
    set t=null
    set p1=null
    set u1=null
    set t2=null
endfunction

endlibrary

