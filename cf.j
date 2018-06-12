
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
        set u=CreateUnit(GetOwningPlayer(u),'o000',ux,uy,GetUnitFacing(u))//创建幻影
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
    //call BJDebugMsg(GetUnitName(u)+"    "+R2S(jl))
    if c1<c then
        if IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_WALKABILITY) and false== IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_BUILDABILITY) then
        //X坐标停下来了
        else
            call SetUnitX(u,ux+jl*Cos(a))
        endif

        if IsTerrainPathable(ux,uy+jl*Sin(a),PATHING_TYPE_WALKABILITY) and false== IsTerrainPathable(ux+jl*Cos(a),uy,PATHING_TYPE_BUILDABILITY)then
        //Y坐标停下来了
        else
            call SetUnitY(u,uy+jl*Sin(a))
        endif
        if ty then
            if c1>c/2 then//超过一半上升，未超过下降
                call SetUnitFlyHeight(u,(c-c1)*gd,0)
                call BJDebugMsg(GetUnitName(u)+"    "+I2S(c1))
            else
                call SetUnitFlyHeight(u,c1*gd,0)
                call BJDebugMsg(GetUnitName(u)+"    "+I2S(c1))
            endif
        endif
        set c1=c1+1
        call SaveInteger(z_h,h,4,c1)
    else
        call PauseUnit(u,false)
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
    call BJDebugMsg(R2S(xjl)+R2S(jl))
    if ty then
        call UnitAddAbility(u,'Arav')
        call UnitRemoveAbility(u,'Arav')
        call SaveBoolean(z_h,h,7,ty)
        call SaveReal(z_h,h,6,400/c)//每次跳跃高度

    endif

    if yhy then
        call PauseUnit(u,true)
        set t= CreateTimer()
        set h=GetHandleId(t)
        call SaveUnitHandle(z_h,h,0,u)//单位
        call SaveInteger(z_h,h,1,R2I(s1/0.04))//幻影数量
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

endlibrary

