globals
//globals from libbgj:
constant boolean LIBRARY_libbgj=true
//endglobals from libbgj
//globals from libchuguai:
constant boolean LIBRARY_libchuguai=true
//endglobals from libchuguai
//globals from libdeath:
constant boolean LIBRARY_libdeath=true
//endglobals from libdeath
//globals from libgy:
constant boolean LIBRARY_libgy=true
//endglobals from libgy
//globals from libhg:
constant boolean LIBRARY_libhg=true
//endglobals from libhg
//globals from libkj:
constant boolean LIBRARY_libkj=true
//endglobals from libkj
//globals from libmsg:
constant boolean LIBRARY_libmsg=true
//endglobals from libmsg
//globals from libtime0:
constant boolean LIBRARY_libtime0=true
//endglobals from libtime0
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
real jsqjg=5
//endglobals from csh
    // User-defined
hashtable udg_hs= null

trigger l__library_init

//JASSHelper struct globals:

endglobals


//library libbgj:
function bgj_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetAttacker())), StringHash("英雄"))
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
        set g=3 //出怪数量
        if ModuloInteger(b, 7) == 0 then
            call cboss()
        endif
        call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口")), "第" + I2S(b + 1) + "波敌人来袭") //修改计时器窗口显示标题
    endif
    if b == 35 then
        call DestroyTimerDialog(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口"))) //出怪完毕，删除计时器窗口
        call DestroyTimer(GetExpiredTimer()) //删除计时器
    endif
endfunction
function chuguai takes nothing returns nothing
    local trigger tr= CreateTrigger()
    call TriggerRegisterTimerExpireEvent(tr, LoadTimerHandle(udg_hs, 0, StringHash("出怪计时器")))
    call TriggerAddAction(tr, function chuguai_1)
    //出怪计时器
    set tr=null
endfunction

//library libchuguai ends
//library libdeath:
function death_1 takes nothing returns nothing
    local unit u1=GetKillingUnit()
    local unit u2=GetTriggerUnit()
    local player p1=GetOwningPlayer(u1)
    local integer array li
    local item it
    set li[0]=GetHandleId(u1)
    set li[1]=GetHandleId(p1)
    if HaveSavedHandle(udg_hs, li[1], 1) then //检测是否绑定有物品
        set it=LoadItemHandle(udg_hs, li[1], 1) //读取绑定的物品
        set li[9]=GetHandleId(it) //读取绑定物品的handle
        set li[10]=LoadInteger(udg_hs, li[9], GetItemLevel(it)) + 1 //读取经验和经验+1
        set li[11]=LoadInteger(udg_hs, 25, GetItemTypeId(it)) //读取升级对应的等级
        set li[12]=LoadInteger(udg_hs, GetItemTypeId(it), 2) //读取升级等级对应的强化石
        set li[13]=( li[11] + 5 ) / 5 //设置升级所需经验
        if li[10] == li[13] * 100 then //判断升级经验是否足够
            if ModuloInteger(li[11], 5) != 5 then //判断是否需要材料
                call UnitAddItem(u1, CreateItem(li[12], GetUnitX(u1), GetUnitY(u1))) //给予强化石
            endif
        else //经验不足
            call SaveInteger(udg_hs, li[9], GetItemLevel(it), li[10]) //记录经验
            call BJDebugMsg(I2S(li[10]))
        endif
    endif
    if HaveSavedHandle(udg_hs, li[1], 2) then //检测是否绑定有物品
        set it=LoadItemHandle(udg_hs, li[1], 2) //读取绑定的物品
        set li[19]=GetHandleId(it) //读取绑定物品的handle
        set li[20]=LoadInteger(udg_hs, li[19], GetItemLevel(it)) + 1 //读取经验和经验+1
        set li[21]=LoadInteger(udg_hs, 25, GetItemTypeId(it)) //读取升级对应的等级
        set li[22]=LoadInteger(udg_hs, GetItemTypeId(it), 2) //读取升级等级对应的强化石
        set li[23]=( li[21] + 5 ) / 5 //设置升级所需经验
        if li[20] == li[23] * 100 then //判断升级经验是否足够
            if ModuloInteger(li[21], 5) != 5 then //判断是否需要材料
                call UnitAddItem(u1, CreateItem(li[22], GetUnitX(u1), GetUnitY(u1))) //给予强化石
            endif
        else //经验不足
            call SaveInteger(udg_hs, li[19], GetItemLevel(it), li[20]) //记录经验
        endif
    endif
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
    call SaveTriggerHandle(udg_hs, 0, StringHash("科技"), tr)
    set tr=null
endfunction

//library libkj ends
//library libmsg:
function msg takes integer v returns string
    if v == 1 then
        return "|cffff0000【信息】|r"
    endif
    return ""
endfunction

//library libmsg ends
//library libtime0:
function sys_cg takes nothing returns nothing
    local integer li1= - 1
    local unit unitt
    local integer loopli=0
        loop
            exitwhen li1 == 2
            set unitt=CreateUnit(Player(11), LoadInteger(udg_hs, 7, b), LoadReal(udg_hs, 1, 77) + li1 * 1536, LoadReal(udg_hs, 2, 77), 270)
            call IssueNeutralPointOrderById(LoadPlayerHandle(udg_hs, 0, StringHash("出怪玩家")), unitt, 851983, LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77))
            set loopli=0
            loop
                exitwhen loopli == 6
                call UnitShareVision(unitt, Player(loopli), true)
                set loopli=loopli + 1
            endloop
            
            set li1=li1 + 1
        endloop
    set g=g - 1
    set unitt=null
endfunction
function time1s takes nothing returns nothing
    set i=i + 1
    if g > 0 then
        call sys_cg()
    endif
endfunction
function xzndjsq takes nothing returns nothing
    if LoadBoolean(udg_hs, 0, StringHash("已选择难度")) then //判断是否已选择难度
    else
    call DialogDisplay(Player(0), LoadDialogHandle(udg_hs, 0, StringHash("选择难度对话框")), false) //取消显示对话框
    call DialogDestroy(LoadDialogHandle(udg_hs, 0, StringHash("选择难度对话框"))) //删除对话框
    call SetPlayerTechResearched(Player(11), 'RA00', 1) //默认难度
    //在这里设置默认难度
    //以下测试模式使用，实际需要在选择难度后再启动计时器
    call SaveTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口"), CreateTimerDialog(LoadTimerHandle(udg_hs, 0, StringHash("出怪计时器")))) //保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs, 0, StringHash("出怪计时器")), jsqjg, true, null) //启动计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口")), true) //显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口")), "第" + I2S(b + 1) + "波") //设置计时器窗口标题
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
    set an=null
    call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash("对话框")), dhk)
    call DialogDisplay(Player(0), dhk, true) //显示对话框给某个玩家，请及时修改
    set dhk=null
    call TimerStart(CreateTimer(), 10, false, function xzndjsq)
    //以下创建作弊菜单
    set str[1]="开启F3回城(再次点击关闭)"
    set str[2]="镜头升高"
    set str[3]="镜头降低"
    set str[4]="背景音量+"
    set str[5]="背景音量-"
    set str[6]="返回"
    set li[0]=0
    set li[1]=0
    loop
        exitwhen li[0] == 6 //6个玩家
        set li[0]=li[0] + 1
        set dhk=DialogCreate()
        call DialogSetMessage(dhk, "作弊菜单")
        call SaveDialogHandle(udg_hs, H2I(Player(li[0] - 1)), StringHash("作弊对话框"), dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs, 0, StringHash(I2S(li[0]) + "对话框")), dhk)
        set li[1]=0
        loop
            exitwhen li[1] == 6 //6个按钮
            set li[1]=li[1] + 1
            set an=DialogAddButton(dhk, str[li[1]], 0)
            call SaveInteger(udg_hs, 0, H2I(an), li[1])
        endloop
        
        
    endloop
endfunction
function time0 takes nothing returns nothing
    local trigger tr=CreateTrigger()
    //逝去0秒
    call TriggerRegisterTimerEvent(tr, 0, false)
    call TriggerAddAction(tr, function time0_1)
    set tr=null
endfunction

//library libtime0 ends
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
    call SaveBoolean(udg_hs, 0, StringHash("已选择难度"), true) //确认已选择难度
    call SetPlayerTechResearched(Player(11), 'RA00', li) //设置难度
    //在这里设置难度
    //以下是启动出怪计时器
    call SaveTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口"), CreateTimerDialog(LoadTimerHandle(udg_hs, 0, StringHash("出怪计时器")))) //保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs, 0, StringHash("出怪计时器")), jsqjg, true, null) //启动出怪计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口")), true) //显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs, 0, StringHash("出怪计时器窗口")), "第" + I2S(b + 1) + "波") //修改计时器窗口标题
    call DestroyTrigger(GetTriggeringTrigger()) //删除触发
endfunction

function playcd_1 takes nothing returns nothing
    local button an=GetClickedButton()
    local integer li=LoadInteger(udg_hs, 0, H2I(an))
    local player p1=Player(0)
    local real x=LoadReal(udg_hs, 4, 77)
    local real y=LoadReal(udg_hs, 5, 77)
    local unit u1
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    if li == 1 then //第一个按钮
        if LoadBoolean(udg_hs, H2I(p1), StringHash("开启回城")) then //判断已开启回城
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), false) //关闭一键回城
            call RemoveUnit(LoadUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"))) //移除回城单位
        else
            call SaveBoolean(udg_hs, H2I(p1), StringHash("开启回城"), true) //开启一键回城
            set u1=CreateUnit(Player(15), 'HB01', x, y, 90) //创建回城单位
            call SaveUnitHandle(udg_hs, H2I(p1), StringHash("回城英雄"), u1) //记录回城单位
            call SetUnitOwner(u1, p1, true) //改变单位所属
            call SetUnitInvulnerable(u1, true) //设置无敌
            call SetUnitFlyHeight(u1, 10000, 0) //设置高度
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
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x < 100 then
            set x=x + 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
        endif
    endif
    if li == 5 then //第五个按钮
        set x=LoadReal(udg_hs, GetHandleId(p1), StringHash("音量"))
        if x > 1 then
            set x=x - 10
            call SaveReal(udg_hs, GetHandleId(p1), StringHash("音量"), x)
        endif
        if GetLocalPlayer() == p1 then //国际惯例
            call SetMusicVolume(PercentToInt(x, 127))
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
    local unit lu1=LoadUnitHandle(udg_hs, H2I(ti1), StringHash("复活的英雄"))
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
    set lti=CreateTimer()
    call TimerStart(lti, 5, false, function fuhuo_2)
    call SaveUnitHandle(udg_hs, H2I(lti), StringHash("复活的英雄"), GetTriggerUnit())
    set lti=null
endfunction
function fuhuo takes nothing returns nothing
    local trigger tr
    set tr=CreateTrigger()
    //创建英雄死亡触发
    call SaveTriggerHandle(udg_hs, 0, StringHash("复活英雄"), tr)
    call TriggerAddAction(tr, function fuhuo_1)
    set tr=null
endfunction

//library libfuhuo ends
//library libgetitem:
function getitem_2 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), StringHash("英雄"))
    local item litem=GetManipulatedItem()
    local integer ti= GetItemTypeId(litem)
    local integer lv=GetItemLevel(litem)
    if GetItemType(litem) == ITEM_TYPE_POWERUP then //判断能量提升
        call UnitAddItem(u, litem) //转移物品
    endif
    set litem=null
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
        if lv == 2 or lv == 3 then //2级武器,3级衣服
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
        call RemoveItem(GetManipulatedItem()) //能量提升直排
    endif
    if GetItemType(litem) == ITEM_TYPE_PERMANENT then //判断永久物品
        if lv > 0 and lv < 6 then //一级武器，二级衣服，三级手套，四级护符，五级项链
            set li[0]=0
            loop
                exitwhen li[0] == 6
                if GetItemLevel(UnitItemInSlot(u1, li[0])) == lv and UnitItemInSlot(u1, li[0]) != litem then //只能携带一件同类装备
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10, msg(1) + "你身上已有同类物品")
                    call UnitRemoveItem(u1, litem)
                    set litem=null
                    set u1=null
                    return
                endif
                set li[0]=li[0] + 1
            endloop
            if lv < 3 and LoadInteger(udg_hs, 25, ti) < 15 then //小于15级的武器和衣服才绑定
                call SaveItemHandle(udg_hs, GetHandleId(GetOwningPlayer(u1)), lv, litem) //物品绑定玩家
            endif
        endif
    endif
    if GetItemType(litem) == ITEM_TYPE_PURCHASABLE then
        if lv == 1 then
            set li[0]=GetItemLevel(UnitItemInSlot(u1, 0))
            call RemoveItem(litem)
            call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, ti, li[0]), GetUnitX(u1), GetUnitY(u1)))
        endif
        if lv == 2 then
            //目前如果玩家拾取到未注册的可购买类物品会崩溃，原因是死循环，因为未注册无法获取需要几个材料
            set li[0]=LoadInteger(udg_hs, ti, 0) //获取物品合成需要几个材料
            set li[1]=0 //初始化主循环
            set li[2]=0 //初始化子循环
            set li[3]=0 //初始化玩家拥有材料种类数量
            set li[4]=0 //初始化合成循环
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1, li[2])) == LoadInteger(udg_hs, ti, li[1] + 1) then //判断单位是否有所需材料
                        call SaveItemHandle(udg_hs, StringHash("材料"), li[3], UnitItemInSlot(u1, li[2])) //保存判断到的材料
                        set li[3]=li[3] + 1 //记录材料种类数量
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
                set litem=LoadItemHandle(udg_hs, StringHash("材料"), 0) //读取主线材料
                set li[5]=GetItemTypeId(litem) //读取主线材料ID
                set li[6]=LoadInteger(udg_hs, 25, li[5]) //读取升级对应的等级
                set li[7]=( li[6] / 5 ) * 100 //读取升级所需经验
                set li[8]=GetHandleId(litem)
                set li[9]=GetItemLevel(litem)
                set li[10]=LoadInteger(udg_hs, li[8], li[9])
                set li[11]=0 //判读是否具备升级条件
                if GetItemType(litem) == ITEM_TYPE_PERMANENT and li[6] < 16 and ModuloInteger(li[6], 5) == 0 then
                    if li[7] == li[10] then
                    else
                    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "材料已齐全，装备经验不足")
                    set li[11]=1 //拒绝升级
                    endif
                endif
                if li[11] == 0 then
                    if LoadBoolean(udg_hs, ti, 10) then //判断是合成还是强化，区别在强化的循环
                        loop //删除多余物品
                            set li[4]=li[4] + 1
                            call RemoveItem(LoadItemHandle(udg_hs, StringHash("材料"), li[4]))
                            exitwhen li[4] == li[0]
                        endloop
                        //进入强化阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    else
                        loop //删除多余物品
                            call RemoveItem(LoadItemHandle(udg_hs, StringHash("材料"), li[4]))
                            exitwhen li[4] == li[0]
                            set li[4]=li[4] + 1
                        endloop
                        //进入合成阶段
                        call UnitAddItem(u1, CreateItem(LoadInteger(udg_hs, li[5], 20), GetUnitX(u1), GetUnitY(u1)))
                    endif
                endif
            endif
            call FlushChildHashtable(udg_hs, StringHash("材料")) //清空哈希表
        endif
    endif
    set litem=null
    set u1=null
endfunction
function dropitem takes nothing returns nothing
    if GetItemType(GetManipulatedItem()) == ITEM_TYPE_PERMANENT then //判断丢弃了永久物品
        call RemoveSavedHandle(udg_hs, GetHandleId(GetOwningPlayer(GetTriggerUnit())), GetItemLevel(GetManipulatedItem())) //清除单位的绑定
    endif
endfunction
function getitem takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function getitem_1)
    call SaveTriggerHandle(udg_hs, 0, StringHash("获得物品触发"), tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function getitem_2)
    call SaveTriggerHandle(udg_hs, 0, StringHash("宠物获得物品触发"), tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr, function dropitem)
    call SaveTriggerHandle(udg_hs, 0, StringHash("丢弃物品触发"), tr)
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
        call hg(LoadUnitHandle(udg_hs, H2I(p1), StringHash("英雄"))) //调用回城函数
    endif
    call SetPlayerAbilityAvailable(p1, tempi, true) //测试添加技能
    call SetPlayerAbilityAvailable(p1, 1093677105, false)
    call SetPlayerAbilityAvailable(p1, 1093677105, true)
    call BJDebugMsg(GetObjectName(tempi))
endfunction
function input takes nothing returns nothing
    local trigger tr
        set tr=CreateTrigger()
        //创建输入触发
        call SaveTriggerHandle(udg_hs, 0, StringHash("输入"), tr)
        call TriggerAddAction(tr, function input_1)
        set tr=null
endfunction

//library libinput ends
//library liblist:
function list_2 takes nothing returns nothing
    local player p1=LoadPlayerHandle(udg_hs, 0, H2I(GetExpiredTimer()))
    call SaveBoolean(udg_hs, H2I(p1), StringHash("双击"), false)
    set p1=null
endfunction
function list_1 takes nothing returns nothing
    local unit u1=GetTriggerUnit()
    local integer li=GetUnitTypeId(u1)
    local player p1=GetOwningPlayer(u1)
    local boolean bool=LoadBoolean(udg_hs, H2I(p1), StringHash("双击"))
    local timer t1
    local dialog dhk=LoadDialogHandle(udg_hs, H2I(p1), StringHash("作弊对话框"))
    if li == 'HB00' then
        if bool then
            call SaveBoolean(udg_hs, H2I(p1), StringHash("双击"), false) //保存正在双击
            if GetLocalPlayer() == p1 then //异步
                call ClearSelection()
            endif
            call DialogDisplay(p1, dhk, true) //显示对话框
        else
            set t1=CreateTimer() //启动计时器
            call TimerStart(t1, 0.5, false, function list_2) //设置计时器回调函数
            call SavePlayerHandle(udg_hs, 0, H2I(t1), p1) //保存handle
            call SaveBoolean(udg_hs, H2I(p1), StringHash("双击"), true) ///确认已单击
            if GetLocalPlayer() == p1 then //异步
                //call ClearSelection()//清空玩家选择，往后可能取消这个选项，作为宠物使用，条件也需要修改
            endif
        endif
    endif
    if li == 'HB01' then
        call hg(LoadUnitHandle(udg_hs, H2I(p1), StringHash("英雄"))) //回城函数
    endif
    set u1=null
    set p1=null
    set t1=null
endfunction
function list takes nothing returns nothing
    local trigger tr=CreateTrigger()
    call SaveTriggerHandle(udg_hs, 0, StringHash("菜单触发"), tr)
    call TriggerAddAction(tr, function list_1)
    set tr=null
endfunction

//library liblist ends
//library libselecthero:
function temptime takes nothing returns nothing
    local player lp= LoadPlayerHandle(udg_hs, H2I(GetExpiredTimer()), 1)
    call RemoveSavedHandle(udg_hs, H2I(lp), StringHash("当前选择"))
    call DestroyTimer(GetExpiredTimer())
endfunction
function xzyx1 takes nothing returns nothing
    local timer tti
    local integer li1=0
    local integer li2
    local unit u1
    if GetOwningPlayer(GetTriggerUnit()) == Player(15) then //判断选择的英雄是否玩家16
        if HaveSavedHandle(udg_hs, H2I(GetTriggerPlayer()), StringHash("英雄")) then //判断玩家是否已选英雄
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, msgys("你已经选择了英雄!"))
        else
            if LoadUnitHandle(udg_hs, H2I(GetTriggerPlayer()), StringHash("当前选择")) == GetTriggerUnit() then //判断玩家当前选择是同一个英雄
                call SetUnitOwner(GetTriggerUnit(), GetTriggerPlayer(), true) //改变单位所有者
                call SaveUnitHandle(udg_hs, H2I(GetTriggerPlayer()), StringHash("英雄"), GetTriggerUnit()) //记录玩家英雄
                set li2=LoadInteger(udg_hs, 0, StringHash("已选择数量")) //同下
                call SaveInteger(udg_hs, 0, StringHash("已选择数量"), li2 + 1) //记录已选择英雄的人数
                call SetUnitX(GetTriggerUnit(), LoadReal(udg_hs, 4, 77)) //设置坐标
                call SetUnitY(GetTriggerUnit(), LoadReal(udg_hs, 5, 77) + 128) //同上
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("复活英雄")), GetTriggerUnit(), EVENT_UNIT_DEATH) //注册复活英雄事件
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, msgys(GetPlayerName(GetTriggerPlayer()) + " 选择了 " + GetObjectName(GetUnitTypeId(GetTriggerUnit())))) //发送消息
                call SetUnitInvulnerable(GetTriggerUnit(), false) //取消无敌
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("获得物品触发")), GetTriggerUnit(), EVENT_UNIT_PICKUP_ITEM) //注册单位获得物品事件
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("丢弃物品触发")), GetTriggerUnit(), EVENT_UNIT_DROP_ITEM) //注册单位丢弃物品事件
                set u1=CreateUnit(Player(15), 'HB00', LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77), LoadReal(udg_hs, 6, 77)) //创建菜单英雄
                call TriggerRegisterPlayerUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("菜单触发")), GetTriggerPlayer(), EVENT_PLAYER_UNIT_SELECTED, null) //再次注册选择单位触发
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("科技")), u1, EVENT_UNIT_RESEARCH_FINISH) //注册科技共享触发
                call SetUnitOwner(u1, GetTriggerPlayer(), true) //改变单位所有者
                call SetUnitInvulnerable(u1, true) //设置无敌
                call SetUnitFlyHeight(u1, 10000, 0) //设置飞行高度
                if GetTriggerPlayer() == GetLocalPlayer() then //判断本地玩家，异步
                    call SetCameraPosition(LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77) + 128) //异步镜头
                    call SetUnitFlyHeight(u1, 0, 0) //异步高度
                endif
                set u1=CreateUnit(GetTriggerPlayer(), 'hCZZ', LoadReal(udg_hs, 4, 77), LoadReal(udg_hs, 5, 77) + 256, LoadReal(udg_hs, 6, 77)) //创建宠物
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs, 0, StringHash("宠物获得物品触发")), u1, EVENT_UNIT_PICKUP_ITEM) //注册单位获得物品事件
                call SetUnitInvulnerable(u1, true) //设置无敌
                set u1=null
                if li2 + 1 == LoadInteger(udg_hs, 0, StringHash("游戏人数")) then //判断所有人都选了英雄
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
                endif
            else
                call SaveUnitHandle(udg_hs, H2I(GetTriggerPlayer()), StringHash("当前选择"), GetTriggerUnit()) //存储临时选择
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, msgys("你选择了 " + GetObjectName(GetUnitTypeId(GetTriggerUnit())) + " 确认请双击！")) //信息
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
    call SaveTriggerHandle(udg_hs, 0, StringHash("选择英雄触发"), tr)
    loop
        exitwhen li == 6
            if ( ( GetPlayerSlotState(Player(li)) == PLAYER_SLOT_STATE_PLAYING ) and ( GetPlayerController(Player(li)) != MAP_CONTROL_COMPUTER ) ) then
                call TriggerRegisterPlayerUnitEvent(tr, Player(li), EVENT_PLAYER_UNIT_SELECTED, null)
                call SaveInteger(udg_hs, 0, StringHash("游戏人数"), LoadInteger(udg_hs, 0, StringHash("游戏人数")) + 1)
                call TriggerRegisterPlayerChatEvent(LoadTriggerHandle(udg_hs, 0, StringHash("输入")), Player(li), "-", false)
            endif
            set li=li + 1
    endloop
    call TriggerAddAction(tr, function xzyx1)
    set tr=null
endfunction

//library libselecthero ends
//library libyg:
function bossfh takes nothing returns nothing
    local integer li=LoadInteger(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("复活boss"))
    local trigger t=LoadTriggerHandle(udg_hs, GetHandleId(GetExpiredTimer()), 0)
    local integer zb=LoadInteger(udg_hs, 11, li)
    local real x=LoadReal(udg_hs, 1, zb)
    local real y=LoadReal(udg_hs, 2, zb)
    local real f=LoadReal(udg_hs, 3, zb)
    local unit u1=CreateUnit(Player(11), li, x, y, f)
    call RemoveUnit(LoadUnitHandle(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("单位"))) //移除死亡单位
    call TriggerRegisterUnitEvent(t, u1, EVENT_UNIT_DEATH) //添加事件到触发器
    call FlushChildHashtable(udg_hs, GetHandleId(GetExpiredTimer())) //清除哈希表
    call DestroyTimer(GetExpiredTimer()) //清除计时器
    set u1=null
    set t=null
endfunction
function yg takes nothing returns nothing
    local timer t=CreateTimer()
    local trigger tr=CreateTrigger()
    call TriggerAddAction(tr, function yg) //新触发添加动作
    call DestroyTrigger(GetTriggeringTrigger()) //删除触发触发
    call SaveInteger(udg_hs, GetHandleId(t), StringHash("复活boss"), GetUnitTypeId(GetTriggerUnit())) //保存死亡的类型
    call SaveUnitHandle(udg_hs, GetHandleId(t), StringHash("单位"), GetTriggerUnit()) //保存死亡的单位
    call TimerStart(t, 10, false, function bossfh) //启动计时器
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, msg(1) + GetUnitName(GetTriggerUnit()) + "已被击杀，10秒后复活") //发消息
    call SaveTriggerHandle(udg_hs, GetHandleId(t), 0, tr) //保存触发器
    set t=null
    set tr=null
endfunction
function xgfh takes nothing returns nothing
    local integer li=LoadInteger(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("复活boss"))
    local trigger t=LoadTriggerHandle(udg_hs, GetHandleId(GetExpiredTimer()), 0)
    local integer zb=LoadInteger(udg_hs, 11, li)
    local real x=LoadReal(udg_hs, 1, zb)
    local real y=LoadReal(udg_hs, 2, zb)
    local unit u1=CreateUnit(Player(11), li, x + GetRandomReal(- 640, 640), y + GetRandomReal(- 640, 640), GetRandomReal(0, 360))
    call RemoveUnit(LoadUnitHandle(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("单位"))) //移除死亡单位
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
    call SaveInteger(udg_hs, GetHandleId(t), StringHash("复活boss"), GetUnitTypeId(GetTriggerUnit())) //保存死亡的类型
    call SaveUnitHandle(udg_hs, GetHandleId(t), StringHash("单位"), GetTriggerUnit()) //保存死亡的单位
    call TimerStart(t, 10, false, function xgfh) //启动计时器
    call TriggerAddAction(tr, function xg) //新触发添加动作
    call SaveTriggerHandle(udg_hs, GetHandleId(t), 0, tr) //保存触发器
    set t=null
    set tr=null
endfunction
function zs_1 takes nothing returns nothing
    local unit u=LoadUnitHandle(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("转生"))
    local player p=LoadPlayerHandle(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("玩家"))
    local integer i1=LoadInteger(udg_hs, GetHandleId(p), StringHash("进阶场"))
    local integer l__i=GetUnitTypeId(u)
    local real x=LoadReal(udg_hs, 1, i1)
    local real y=LoadReal(udg_hs, 2, i1)
    local real f=LoadReal(udg_hs, 3, i1)
    local trigger t=LoadTriggerHandle(udg_hs, GetHandleId(GetExpiredTimer()), StringHash("触发"))
    call RemoveUnit(u) //移除死亡单位
    call BJDebugMsg(I2S(l__i))
    call BJDebugMsg(I2S('UB15'))
    if l__i < 'UB15' then //判断是有下一转
        set u=CreateUnit(Player(11), l__i + 1, x, y, f) //创建下一转
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH) //注册触发
        //在此处增加隐藏
    else
    endif
    call FlushChildHashtable(udg_hs, GetHandleId(GetExpiredTimer())) //清除哈希表
    call DestroyTimer(GetExpiredTimer()) //清除计时器
    set u=null
    set p=null
    set t=null
endfunction
function zs takes nothing returns nothing
    local timer t=CreateTimer()
    local integer l__i=GetUnitTypeId(GetTriggerUnit())
    local trigger tr=GetTriggeringTrigger()
    call DestroyTrigger(tr) //删除触发
    call SaveUnitHandle(udg_hs, GetHandleId(t), StringHash("转生"), GetTriggerUnit()) //保存死亡单位
    call SavePlayerHandle(udg_hs, GetHandleId(t), StringHash("玩家"), GetOwningPlayer(GetKillingUnit())) //保存玩家
    set tr=CreateTrigger() //新建触发
    call TriggerAddAction(tr, function zs) //添加动作
    call SaveTriggerHandle(udg_hs, GetHandleId(t), StringHash("触发"), tr) //保存触发
    call TimerStart(t, 10, false, function zs_1)
    call BJDebugMsg("6666")
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
    //初始化函数
    set udg_hs=InitHashtable()
    
        call SaveReal(udg_hs, 1, 1, - 4480)
        call SaveReal(udg_hs, 2, 1, - 4480)
        call SaveReal(udg_hs, 3, 1, 225)
        call SaveReal(udg_hs, 4, 1, - 4992)
        call SaveReal(udg_hs, 5, 1, - 4992)
        call SaveReal(udg_hs, 6, 1, 45)
        call SaveInteger(udg_hs, 10, 'IA00', 1)
        call CreateItem('IA00', - 1216, 1280)
    
        call SaveReal(udg_hs, 1, 2, - 4480)
        call SaveReal(udg_hs, 2, 2, - 2688)
        call SaveReal(udg_hs, 3, 2, 225)
        call SaveReal(udg_hs, 4, 2, - 4992)
        call SaveReal(udg_hs, 5, 2, - 3200)
        call SaveReal(udg_hs, 6, 2, 45)
        call SaveInteger(udg_hs, 10, 'IA01', 2)
        call CreateItem('IA01', - 1184, 1280)
    
        call SaveReal(udg_hs, 1, 3, - 4480)
        call SaveReal(udg_hs, 2, 3, - 896)
        call SaveReal(udg_hs, 3, 3, 225)
        call SaveReal(udg_hs, 4, 3, - 4992)
        call SaveReal(udg_hs, 5, 3, - 1408)
        call SaveReal(udg_hs, 6, 3, 45)
        call SaveInteger(udg_hs, 10, 'IA02', 3)
        call CreateItem('IA02', - 1152, 1280)
    
        call SaveReal(udg_hs, 1, 4, - 4480)
        call SaveReal(udg_hs, 2, 4, 896)
        call SaveReal(udg_hs, 3, 4, 225)
        call SaveReal(udg_hs, 4, 4, - 4992)
        call SaveReal(udg_hs, 5, 4, 384)
        call SaveReal(udg_hs, 6, 4, 45)
        call SaveInteger(udg_hs, 10, 'IA03', 4)
        call CreateItem('IA03', - 1120, 1280)
    
        call SaveReal(udg_hs, 1, 5, - 4480)
        call SaveReal(udg_hs, 2, 5, 2688)
        call SaveReal(udg_hs, 3, 5, 225)
        call SaveReal(udg_hs, 4, 5, - 4992)
        call SaveReal(udg_hs, 5, 5, 2176)
        call SaveReal(udg_hs, 6, 5, 45)
        call SaveInteger(udg_hs, 10, 'IA04', 5)
        call CreateItem('IA04', - 1088, 1280)
    
        call SaveReal(udg_hs, 1, 6, - 4480)
        call SaveReal(udg_hs, 2, 6, 4480)
        call SaveReal(udg_hs, 3, 6, 225)
        call SaveReal(udg_hs, 4, 6, - 4992)
        call SaveReal(udg_hs, 5, 6, 3968)
        call SaveReal(udg_hs, 6, 6, 45)
        call SaveInteger(udg_hs, 10, 'IA05', 6)
        call CreateItem('IA05', - 1056, 1280)
    
        call SaveReal(udg_hs, 1, 7, 4992)
        call SaveReal(udg_hs, 2, 7, - 4480)
        call SaveReal(udg_hs, 3, 7, 180)
        call SaveReal(udg_hs, 4, 7, 3968)
        call SaveReal(udg_hs, 5, 7, - 4480)
        call SaveReal(udg_hs, 6, 7, 0)
        call SaveInteger(udg_hs, 10, 'IA06', 7)
        call CreateItem('IA06', - 1024, 1280)
    
        call SaveReal(udg_hs, 1, 8, 4992)
        call SaveReal(udg_hs, 2, 8, - 2688)
        call SaveReal(udg_hs, 3, 8, 180)
        call SaveReal(udg_hs, 4, 8, 3968)
        call SaveReal(udg_hs, 5, 8, - 2688)
        call SaveReal(udg_hs, 6, 8, 0)
        call SaveInteger(udg_hs, 10, 'IA07', 8)
        call CreateItem('IA07', - 992, 1280)
    
        call SaveReal(udg_hs, 1, 9, 4992)
        call SaveReal(udg_hs, 2, 9, - 896)
        call SaveReal(udg_hs, 3, 9, 180)
        call SaveReal(udg_hs, 4, 9, 3968)
        call SaveReal(udg_hs, 5, 9, - 896)
        call SaveReal(udg_hs, 6, 9, 0)
        call SaveInteger(udg_hs, 10, 'IA08', 9)
        call CreateItem('IA08', - 960, 1280)
    
        call SaveReal(udg_hs, 1, 10, 4992)
        call SaveReal(udg_hs, 2, 10, 896)
        call SaveReal(udg_hs, 3, 10, 180)
        call SaveReal(udg_hs, 4, 10, 3968)
        call SaveReal(udg_hs, 5, 10, 896)
        call SaveReal(udg_hs, 6, 10, 0)
        call SaveInteger(udg_hs, 10, 'IA09', 10)
        call CreateItem('IA09', - 928, 1280)
    
        call SaveReal(udg_hs, 1, 11, 4992)
        call SaveReal(udg_hs, 2, 11, 2688)
        call SaveReal(udg_hs, 3, 11, 180)
        call SaveReal(udg_hs, 4, 11, 3968)
        call SaveReal(udg_hs, 5, 11, 2688)
        call SaveReal(udg_hs, 6, 11, 0)
        call SaveInteger(udg_hs, 10, 'IA0A', 11)
        call CreateItem('IA0A', - 896, 1280)
    
        call SaveReal(udg_hs, 1, 12, 4992)
        call SaveReal(udg_hs, 2, 12, 4480)
        call SaveReal(udg_hs, 3, 12, 180)
        call SaveReal(udg_hs, 4, 12, 3968)
        call SaveReal(udg_hs, 5, 12, 4480)
        call SaveReal(udg_hs, 6, 12, 0)
        call SaveInteger(udg_hs, 10, 'IA0B', 12)
        call CreateItem('IA0B', - 864, 1280)
    
        call SaveReal(udg_hs, 1, 13, - 9216)
        call SaveReal(udg_hs, 2, 13, 9216)
        call SaveReal(udg_hs, 3, 13, 315)
        call SaveReal(udg_hs, 4, 13, - 7936)
        call SaveReal(udg_hs, 5, 13, 7936)
        call SaveReal(udg_hs, 6, 13, 0)
        call SaveInteger(udg_hs, 10, 'IA0C', 13)
        call CreateItem('IA0C', - 832, 1280)
    
        call SaveReal(udg_hs, 1, 14, - 6656)
        call SaveReal(udg_hs, 2, 14, 9216)
        call SaveReal(udg_hs, 3, 14, 225)
        call SaveReal(udg_hs, 4, 14, - 7936)
        call SaveReal(udg_hs, 5, 14, 7936)
        call SaveReal(udg_hs, 6, 14, 0)
        call SaveInteger(udg_hs, 10, 'IA0D', 14)
        call CreateItem('IA0D', - 800, 1280)
    
        call SaveReal(udg_hs, 1, 15, - 6656)
        call SaveReal(udg_hs, 2, 15, 6656)
        call SaveReal(udg_hs, 3, 15, 135)
        call SaveReal(udg_hs, 4, 15, - 7936)
        call SaveReal(udg_hs, 5, 15, 7936)
        call SaveReal(udg_hs, 6, 15, 0)
        call SaveInteger(udg_hs, 10, 'IA0E', 15)
        call CreateItem('IA0E', - 768, 1280)
    
        call SaveReal(udg_hs, 1, 16, - 9216)
        call SaveReal(udg_hs, 2, 16, 6656)
        call SaveReal(udg_hs, 3, 16, 45)
        call SaveReal(udg_hs, 4, 16, - 7936)
        call SaveReal(udg_hs, 5, 16, 7936)
        call SaveReal(udg_hs, 6, 16, 0)
        call SaveInteger(udg_hs, 10, 'IA0F', 16)
        call CreateItem('IA0F', - 736, 1280)
    
        call SaveReal(udg_hs, 1, 17, 6656)
        call SaveReal(udg_hs, 2, 17, 9216)
        call SaveReal(udg_hs, 3, 17, 315)
        call SaveReal(udg_hs, 4, 17, 7936)
        call SaveReal(udg_hs, 5, 17, 7936)
        call SaveReal(udg_hs, 6, 17, 0)
        call SaveInteger(udg_hs, 10, 'IA0G', 17)
        call CreateItem('IA0G', - 704, 1280)
    
        call SaveReal(udg_hs, 1, 18, 9216)
        call SaveReal(udg_hs, 2, 18, 9216)
        call SaveReal(udg_hs, 3, 18, 225)
        call SaveReal(udg_hs, 4, 18, 7936)
        call SaveReal(udg_hs, 5, 18, 7936)
        call SaveReal(udg_hs, 6, 18, 0)
        call SaveInteger(udg_hs, 10, 'IA0H', 18)
        call CreateItem('IA0H', - 672, 1280)
    
        call SaveReal(udg_hs, 1, 19, 9216)
        call SaveReal(udg_hs, 2, 19, 6656)
        call SaveReal(udg_hs, 3, 19, 135)
        call SaveReal(udg_hs, 4, 19, 7936)
        call SaveReal(udg_hs, 5, 19, 7936)
        call SaveReal(udg_hs, 6, 19, 0)
        call SaveInteger(udg_hs, 10, 'IA0I', 19)
        call CreateItem('IA0I', - 640, 1280)
    
        call SaveReal(udg_hs, 1, 20, 6656)
        call SaveReal(udg_hs, 2, 20, 6656)
        call SaveReal(udg_hs, 3, 20, 45)
        call SaveReal(udg_hs, 4, 20, 7936)
        call SaveReal(udg_hs, 5, 20, 7936)
        call SaveReal(udg_hs, 6, 20, 0)
        call SaveInteger(udg_hs, 10, 'IA0J', 20)
        call CreateItem('IA0J', - 608, 1280)
    
        call SaveReal(udg_hs, 1, 21, 6656)
        call SaveReal(udg_hs, 2, 21, - 6656)
        call SaveReal(udg_hs, 3, 21, 315)
        call SaveReal(udg_hs, 4, 21, 7936)
        call SaveReal(udg_hs, 5, 21, - 7936)
        call SaveReal(udg_hs, 6, 21, 0)
        call SaveInteger(udg_hs, 10, 'IA0K', 21)
        call CreateItem('IA0K', - 576, 1280)
    
        call SaveReal(udg_hs, 1, 22, 9216)
        call SaveReal(udg_hs, 2, 22, - 6656)
        call SaveReal(udg_hs, 3, 22, 225)
        call SaveReal(udg_hs, 4, 22, 7936)
        call SaveReal(udg_hs, 5, 22, - 7936)
        call SaveReal(udg_hs, 6, 22, 0)
        call SaveInteger(udg_hs, 10, 'IA0L', 22)
        call CreateItem('IA0L', - 544, 1280)
    
        call SaveReal(udg_hs, 1, 23, 9216)
        call SaveReal(udg_hs, 2, 23, - 9216)
        call SaveReal(udg_hs, 3, 23, 135)
        call SaveReal(udg_hs, 4, 23, 7936)
        call SaveReal(udg_hs, 5, 23, - 7936)
        call SaveReal(udg_hs, 6, 23, 0)
        call SaveInteger(udg_hs, 10, 'IA0M', 23)
        call CreateItem('IA0M', - 512, 1280)
    
        call SaveReal(udg_hs, 1, 24, 6656)
        call SaveReal(udg_hs, 2, 24, - 9216)
        call SaveReal(udg_hs, 3, 24, 45)
        call SaveReal(udg_hs, 4, 24, 7936)
        call SaveReal(udg_hs, 5, 24, - 7936)
        call SaveReal(udg_hs, 6, 24, 0)
        call SaveInteger(udg_hs, 10, 'IA0N', 24)
        call CreateItem('IA0N', - 480, 1280)
    
        call SaveReal(udg_hs, 1, 25, - 9216)
        call SaveReal(udg_hs, 2, 25, - 6656)
        call SaveReal(udg_hs, 3, 25, 315)
        call SaveReal(udg_hs, 4, 25, - 7936)
        call SaveReal(udg_hs, 5, 25, - 7936)
        call SaveReal(udg_hs, 6, 25, 0)
        call SaveInteger(udg_hs, 10, 'IA0O', 25)
        call CreateItem('IA0O', - 448, 1280)
    
        call SaveReal(udg_hs, 1, 26, - 6656)
        call SaveReal(udg_hs, 2, 26, - 6656)
        call SaveReal(udg_hs, 3, 26, 225)
        call SaveReal(udg_hs, 4, 26, - 7936)
        call SaveReal(udg_hs, 5, 26, - 7936)
        call SaveReal(udg_hs, 6, 26, 0)
        call SaveInteger(udg_hs, 10, 'IA0P', 26)
        call CreateItem('IA0P', - 416, 1280)
    
        call SaveReal(udg_hs, 1, 27, - 6656)
        call SaveReal(udg_hs, 2, 27, - 9216)
        call SaveReal(udg_hs, 3, 27, 135)
        call SaveReal(udg_hs, 4, 27, - 7936)
        call SaveReal(udg_hs, 5, 27, - 7936)
        call SaveReal(udg_hs, 6, 27, 0)
        call SaveInteger(udg_hs, 10, 'IA0Q', 27)
        call CreateItem('IA0Q', - 384, 1280)
    
        call SaveReal(udg_hs, 1, 28, - 9216)
        call SaveReal(udg_hs, 2, 28, - 9216)
        call SaveReal(udg_hs, 3, 28, 45)
        call SaveReal(udg_hs, 4, 28, - 7936)
        call SaveReal(udg_hs, 5, 28, - 7936)
        call SaveReal(udg_hs, 6, 28, 0)
        call SaveInteger(udg_hs, 10, 'IA0R', 28)
        call CreateItem('IA0R', - 352, 1280)
    
        call SaveReal(udg_hs, 1, 29, - 7552)
        call SaveReal(udg_hs, 2, 29, - 4480)
        call SaveReal(udg_hs, 3, 29, 0)
        call SaveReal(udg_hs, 4, 29, - 6528)
        call SaveReal(udg_hs, 5, 29, - 4480)
        call SaveReal(udg_hs, 6, 29, 180)
        call SaveInteger(udg_hs, 10, 'IA0S', 29)
        call CreateItem('IA0S', - 320, 1280)
    
        call SaveReal(udg_hs, 1, 30, - 7552)
        call SaveReal(udg_hs, 2, 30, - 2688)
        call SaveReal(udg_hs, 3, 30, 0)
        call SaveReal(udg_hs, 4, 30, - 6528)
        call SaveReal(udg_hs, 5, 30, - 2688)
        call SaveReal(udg_hs, 6, 30, 180)
        call SaveInteger(udg_hs, 10, 'IA0T', 30)
        call CreateItem('IA0T', - 288, 1280)
    
        call SaveReal(udg_hs, 1, 31, - 7552)
        call SaveReal(udg_hs, 2, 31, - 896)
        call SaveReal(udg_hs, 3, 31, 0)
        call SaveReal(udg_hs, 4, 31, - 6528)
        call SaveReal(udg_hs, 5, 31, - 896)
        call SaveReal(udg_hs, 6, 31, 180)
        call SaveInteger(udg_hs, 10, 'IA0U', 31)
        call CreateItem('IA0U', - 256, 1280)
    
        call SaveReal(udg_hs, 1, 32, - 7552)
        call SaveReal(udg_hs, 2, 32, 896)
        call SaveReal(udg_hs, 3, 32, 0)
        call SaveReal(udg_hs, 4, 32, - 6528)
        call SaveReal(udg_hs, 5, 32, 896)
        call SaveReal(udg_hs, 6, 32, 180)
        call SaveInteger(udg_hs, 10, 'IA0V', 32)
        call CreateItem('IA0V', - 224, 1280)
    
        call SaveReal(udg_hs, 1, 33, - 7040)
        call SaveReal(udg_hs, 2, 33, 2688)
        call SaveReal(udg_hs, 3, 33, 0)
        call SaveReal(udg_hs, 4, 33, - 6528)
        call SaveReal(udg_hs, 5, 33, 2688)
        call SaveReal(udg_hs, 6, 33, 180)
        call SaveInteger(udg_hs, 10, 'IA0W', 33)
        call CreateItem('IA0W', - 192, 1280)
    
        call SaveReal(udg_hs, 1, 34, - 7552)
        call SaveReal(udg_hs, 2, 34, 4480)
        call SaveReal(udg_hs, 3, 34, 0)
        call SaveReal(udg_hs, 4, 34, - 6528)
        call SaveReal(udg_hs, 5, 34, 4480)
        call SaveReal(udg_hs, 6, 34, 180)
        call SaveInteger(udg_hs, 10, 'IA0X', 34)
        call CreateItem('IA0X', - 160, 1280)
    
        call SaveReal(udg_hs, 1, 35, - 9344)
        call SaveReal(udg_hs, 2, 35, - 4480)
        call SaveReal(udg_hs, 3, 35, 0)
        call SaveReal(udg_hs, 4, 35, - 8320)
        call SaveReal(udg_hs, 5, 35, - 4480)
        call SaveReal(udg_hs, 6, 35, 180)
        call SaveInteger(udg_hs, 10, 'IA0Y', 35)
        call CreateItem('IA0Y', - 128, 1280)
    
        call SaveReal(udg_hs, 1, 36, - 9344)
        call SaveReal(udg_hs, 2, 36, - 2688)
        call SaveReal(udg_hs, 3, 36, 0)
        call SaveReal(udg_hs, 4, 36, - 8320)
        call SaveReal(udg_hs, 5, 36, - 2688)
        call SaveReal(udg_hs, 6, 36, 180)
        call SaveInteger(udg_hs, 10, 'IA0Z', 36)
        call CreateItem('IA0Z', - 96, 1280)
    
        call SaveReal(udg_hs, 1, 37, - 9344)
        call SaveReal(udg_hs, 2, 37, - 896)
        call SaveReal(udg_hs, 3, 37, 0)
        call SaveReal(udg_hs, 4, 37, - 8320)
        call SaveReal(udg_hs, 5, 37, - 896)
        call SaveReal(udg_hs, 6, 37, 180)
        call SaveInteger(udg_hs, 10, 'IA10', 37)
        call CreateItem('IA10', - 64, 1280)
    
        call SaveReal(udg_hs, 1, 38, - 9344)
        call SaveReal(udg_hs, 2, 38, 896)
        call SaveReal(udg_hs, 3, 38, 0)
        call SaveReal(udg_hs, 4, 38, - 8320)
        call SaveReal(udg_hs, 5, 38, 896)
        call SaveReal(udg_hs, 6, 38, 180)
        call SaveInteger(udg_hs, 10, 'IA11', 38)
        call CreateItem('IA11', - 32, 1280)
    
        call SaveReal(udg_hs, 1, 39, - 8832)
        call SaveReal(udg_hs, 2, 39, 2688)
        call SaveReal(udg_hs, 3, 39, 0)
        call SaveReal(udg_hs, 4, 39, - 8320)
        call SaveReal(udg_hs, 5, 39, 2688)
        call SaveReal(udg_hs, 6, 39, 180)
        call SaveInteger(udg_hs, 10, 'IA12', 39)
        call CreateItem('IA12', 0, 1280)
    
        call SaveReal(udg_hs, 1, 40, - 9344)
        call SaveReal(udg_hs, 2, 40, 4480)
        call SaveReal(udg_hs, 3, 40, 0)
        call SaveReal(udg_hs, 4, 40, - 8320)
        call SaveReal(udg_hs, 5, 40, 4480)
        call SaveReal(udg_hs, 6, 40, 180)
        call SaveInteger(udg_hs, 10, 'IA13', 40)
        call CreateItem('IA13', 32, 1280)
    
        call SaveReal(udg_hs, 1, 41, - 4480)
        call SaveReal(udg_hs, 2, 41, 7552)
        call SaveReal(udg_hs, 3, 41, 270)
        call SaveReal(udg_hs, 4, 41, - 4480)
        call SaveReal(udg_hs, 5, 41, 6528)
        call SaveReal(udg_hs, 6, 41, 90)
        call SaveInteger(udg_hs, 10, 'IA14', 41)
        call CreateItem('IA14', 64, 1280)
    
        call SaveReal(udg_hs, 1, 42, - 2688)
        call SaveReal(udg_hs, 2, 42, 7552)
        call SaveReal(udg_hs, 3, 42, 270)
        call SaveReal(udg_hs, 4, 42, - 2688)
        call SaveReal(udg_hs, 5, 42, 6528)
        call SaveReal(udg_hs, 6, 42, 90)
        call SaveInteger(udg_hs, 10, 'IA15', 42)
        call CreateItem('IA15', 96, 1280)
    
        call SaveReal(udg_hs, 1, 43, - 896)
        call SaveReal(udg_hs, 2, 43, 7552)
        call SaveReal(udg_hs, 3, 43, 270)
        call SaveReal(udg_hs, 4, 43, - 896)
        call SaveReal(udg_hs, 5, 43, 6528)
        call SaveReal(udg_hs, 6, 43, 90)
        call SaveInteger(udg_hs, 10, 'IA16', 43)
        call CreateItem('IA16', 128, 1280)
    
        call SaveReal(udg_hs, 1, 44, 896)
        call SaveReal(udg_hs, 2, 44, 7552)
        call SaveReal(udg_hs, 3, 44, 270)
        call SaveReal(udg_hs, 4, 44, 896)
        call SaveReal(udg_hs, 5, 44, 6528)
        call SaveReal(udg_hs, 6, 44, 90)
        call SaveInteger(udg_hs, 10, 'IA17', 44)
        call CreateItem('IA17', 160, 1280)
    
        call SaveReal(udg_hs, 1, 45, 2688)
        call SaveReal(udg_hs, 2, 45, 7552)
        call SaveReal(udg_hs, 3, 45, 270)
        call SaveReal(udg_hs, 4, 45, 2688)
        call SaveReal(udg_hs, 5, 45, 6528)
        call SaveReal(udg_hs, 6, 45, 90)
        call SaveInteger(udg_hs, 10, 'IA18', 45)
        call CreateItem('IA18', 192, 1280)
    
        call SaveReal(udg_hs, 1, 46, 4480)
        call SaveReal(udg_hs, 2, 46, 7552)
        call SaveReal(udg_hs, 3, 46, 270)
        call SaveReal(udg_hs, 4, 46, 4480)
        call SaveReal(udg_hs, 5, 46, 6528)
        call SaveReal(udg_hs, 6, 46, 90)
        call SaveInteger(udg_hs, 10, 'IA19', 46)
        call CreateItem('IA19', 224, 1280)
    
        call SaveReal(udg_hs, 1, 47, - 4480)
        call SaveReal(udg_hs, 2, 47, 9344)
        call SaveReal(udg_hs, 3, 47, 270)
        call SaveReal(udg_hs, 4, 47, - 4480)
        call SaveReal(udg_hs, 5, 47, 8320)
        call SaveReal(udg_hs, 6, 47, 90)
        call SaveInteger(udg_hs, 10, 'IA1A', 47)
        call CreateItem('IA1A', 256, 1280)
    
        call SaveReal(udg_hs, 1, 48, - 2688)
        call SaveReal(udg_hs, 2, 48, 9344)
        call SaveReal(udg_hs, 3, 48, 270)
        call SaveReal(udg_hs, 4, 48, - 2688)
        call SaveReal(udg_hs, 5, 48, 8320)
        call SaveReal(udg_hs, 6, 48, 90)
        call SaveInteger(udg_hs, 10, 'IA1B', 48)
        call CreateItem('IA1B', 288, 1280)
    
        call SaveReal(udg_hs, 1, 49, - 896)
        call SaveReal(udg_hs, 2, 49, 9344)
        call SaveReal(udg_hs, 3, 49, 270)
        call SaveReal(udg_hs, 4, 49, - 896)
        call SaveReal(udg_hs, 5, 49, 8320)
        call SaveReal(udg_hs, 6, 49, 90)
        call SaveInteger(udg_hs, 10, 'IA1C', 49)
        call CreateItem('IA1C', 320, 1280)
    
        call SaveReal(udg_hs, 1, 50, 896)
        call SaveReal(udg_hs, 2, 50, 9344)
        call SaveReal(udg_hs, 3, 50, 270)
        call SaveReal(udg_hs, 4, 50, 896)
        call SaveReal(udg_hs, 5, 50, 8320)
        call SaveReal(udg_hs, 6, 50, 90)
        call SaveInteger(udg_hs, 10, 'IA1D', 50)
        call CreateItem('IA1D', 352, 1280)
    
        call SaveReal(udg_hs, 1, 51, 2688)
        call SaveReal(udg_hs, 2, 51, 9344)
        call SaveReal(udg_hs, 3, 51, 270)
        call SaveReal(udg_hs, 4, 51, 2688)
        call SaveReal(udg_hs, 5, 51, 8320)
        call SaveReal(udg_hs, 6, 51, 90)
        call SaveInteger(udg_hs, 10, 'IA1E', 51)
        call CreateItem('IA1E', 384, 1280)
    
        call SaveReal(udg_hs, 1, 52, 4480)
        call SaveReal(udg_hs, 2, 52, 9344)
        call SaveReal(udg_hs, 3, 52, 270)
        call SaveReal(udg_hs, 4, 52, 4480)
        call SaveReal(udg_hs, 5, 52, 8320)
        call SaveReal(udg_hs, 6, 52, 90)
        call SaveInteger(udg_hs, 10, 'IA1F', 52)
        call CreateItem('IA1F', 416, 1280)
    
        call SaveReal(udg_hs, 1, 53, 7552)
        call SaveReal(udg_hs, 2, 53, 4480)
        call SaveReal(udg_hs, 3, 53, 180)
        call SaveReal(udg_hs, 4, 53, 6528)
        call SaveReal(udg_hs, 5, 53, 4480)
        call SaveReal(udg_hs, 6, 53, 0)
        call SaveInteger(udg_hs, 10, 'IA1G', 53)
        call CreateItem('IA1G', 448, 1280)
    
        call SaveReal(udg_hs, 1, 54, 7552)
        call SaveReal(udg_hs, 2, 54, 2688)
        call SaveReal(udg_hs, 3, 54, 180)
        call SaveReal(udg_hs, 4, 54, 6528)
        call SaveReal(udg_hs, 5, 54, 2688)
        call SaveReal(udg_hs, 6, 54, 0)
        call SaveInteger(udg_hs, 10, 'IA1H', 54)
        call CreateItem('IA1H', 480, 1280)
    
        call SaveReal(udg_hs, 1, 55, 7552)
        call SaveReal(udg_hs, 2, 55, 896)
        call SaveReal(udg_hs, 3, 55, 180)
        call SaveReal(udg_hs, 4, 55, 6528)
        call SaveReal(udg_hs, 5, 55, 896)
        call SaveReal(udg_hs, 6, 55, 0)
        call SaveInteger(udg_hs, 10, 'IA1I', 55)
        call CreateItem('IA1I', 512, 1280)
    
        call SaveReal(udg_hs, 1, 56, 7552)
        call SaveReal(udg_hs, 2, 56, - 896)
        call SaveReal(udg_hs, 3, 56, 180)
        call SaveReal(udg_hs, 4, 56, 6528)
        call SaveReal(udg_hs, 5, 56, - 896)
        call SaveReal(udg_hs, 6, 56, 0)
        call SaveInteger(udg_hs, 10, 'IA1J', 56)
        call CreateItem('IA1J', 544, 1280)
    
        call SaveReal(udg_hs, 1, 57, 7552)
        call SaveReal(udg_hs, 2, 57, - 2688)
        call SaveReal(udg_hs, 3, 57, 180)
        call SaveReal(udg_hs, 4, 57, 6528)
        call SaveReal(udg_hs, 5, 57, - 2688)
        call SaveReal(udg_hs, 6, 57, 0)
        call SaveInteger(udg_hs, 10, 'IA1K', 57)
        call CreateItem('IA1K', 576, 1280)
    
        call SaveReal(udg_hs, 1, 58, 7552)
        call SaveReal(udg_hs, 2, 58, - 4480)
        call SaveReal(udg_hs, 3, 58, 180)
        call SaveReal(udg_hs, 4, 58, 6528)
        call SaveReal(udg_hs, 5, 58, - 4480)
        call SaveReal(udg_hs, 6, 58, 0)
        call SaveInteger(udg_hs, 10, 'IA1L', 58)
        call CreateItem('IA1L', 608, 1280)
    
        call SaveReal(udg_hs, 1, 59, 9344)
        call SaveReal(udg_hs, 2, 59, 4480)
        call SaveReal(udg_hs, 3, 59, 180)
        call SaveReal(udg_hs, 4, 59, 8320)
        call SaveReal(udg_hs, 5, 59, 4480)
        call SaveReal(udg_hs, 6, 59, 0)
        call SaveInteger(udg_hs, 10, 'IA1M', 59)
        call CreateItem('IA1M', 640, 1280)
    
        call SaveReal(udg_hs, 1, 60, 9344)
        call SaveReal(udg_hs, 2, 60, 2688)
        call SaveReal(udg_hs, 3, 60, 180)
        call SaveReal(udg_hs, 4, 60, 8320)
        call SaveReal(udg_hs, 5, 60, 2688)
        call SaveReal(udg_hs, 6, 60, 0)
        call SaveInteger(udg_hs, 10, 'IA1N', 60)
        call CreateItem('IA1N', 672, 1280)
    
        call SaveReal(udg_hs, 1, 61, 9344)
        call SaveReal(udg_hs, 2, 61, 896)
        call SaveReal(udg_hs, 3, 61, 180)
        call SaveReal(udg_hs, 4, 61, 8320)
        call SaveReal(udg_hs, 5, 61, 896)
        call SaveReal(udg_hs, 6, 61, 0)
        call SaveInteger(udg_hs, 10, 'IA1O', 61)
        call CreateItem('IA1O', 704, 1280)
    
        call SaveReal(udg_hs, 1, 62, 9344)
        call SaveReal(udg_hs, 2, 62, - 896)
        call SaveReal(udg_hs, 3, 62, 180)
        call SaveReal(udg_hs, 4, 62, 8320)
        call SaveReal(udg_hs, 5, 62, - 896)
        call SaveReal(udg_hs, 6, 62, 0)
        call SaveInteger(udg_hs, 10, 'IA1P', 62)
        call CreateItem('IA1P', 736, 1280)
    
        call SaveReal(udg_hs, 1, 63, 9344)
        call SaveReal(udg_hs, 2, 63, - 2688)
        call SaveReal(udg_hs, 3, 63, 180)
        call SaveReal(udg_hs, 4, 63, 8320)
        call SaveReal(udg_hs, 5, 63, - 2688)
        call SaveReal(udg_hs, 6, 63, 0)
        call SaveInteger(udg_hs, 10, 'IA1Q', 63)
        call CreateItem('IA1Q', 768, 1280)
    
        call SaveReal(udg_hs, 1, 64, 9344)
        call SaveReal(udg_hs, 2, 64, - 4480)
        call SaveReal(udg_hs, 3, 64, 180)
        call SaveReal(udg_hs, 4, 64, 8320)
        call SaveReal(udg_hs, 5, 64, - 4480)
        call SaveReal(udg_hs, 6, 64, 0)
        call SaveInteger(udg_hs, 10, 'IA1R', 64)
        call CreateItem('IA1R', 800, 1280)
    
        call SaveReal(udg_hs, 1, 65, 4480)
        call SaveReal(udg_hs, 2, 65, - 7552)
        call SaveReal(udg_hs, 3, 65, 90)
        call SaveReal(udg_hs, 4, 65, 4480)
        call SaveReal(udg_hs, 5, 65, - 6528)
        call SaveReal(udg_hs, 6, 65, 270)
        call SaveInteger(udg_hs, 10, 'IA1S', 65)
        call CreateItem('IA1S', 832, 1280)
    
        call SaveReal(udg_hs, 1, 66, 2688)
        call SaveReal(udg_hs, 2, 66, - 7552)
        call SaveReal(udg_hs, 3, 66, 90)
        call SaveReal(udg_hs, 4, 66, 2688)
        call SaveReal(udg_hs, 5, 66, - 6528)
        call SaveReal(udg_hs, 6, 66, 270)
        call SaveInteger(udg_hs, 10, 'IA1T', 66)
        call CreateItem('IA1T', 864, 1280)
    
        call SaveReal(udg_hs, 1, 67, 896)
        call SaveReal(udg_hs, 2, 67, - 7552)
        call SaveReal(udg_hs, 3, 67, 90)
        call SaveReal(udg_hs, 4, 67, 896)
        call SaveReal(udg_hs, 5, 67, - 6528)
        call SaveReal(udg_hs, 6, 67, 270)
        call SaveInteger(udg_hs, 10, 'IA1U', 67)
        call CreateItem('IA1U', 896, 1280)
    
        call SaveReal(udg_hs, 1, 68, - 896)
        call SaveReal(udg_hs, 2, 68, - 7552)
        call SaveReal(udg_hs, 3, 68, 90)
        call SaveReal(udg_hs, 4, 68, - 896)
        call SaveReal(udg_hs, 5, 68, - 6528)
        call SaveReal(udg_hs, 6, 68, 270)
        call SaveInteger(udg_hs, 10, 'IA1V', 68)
        call CreateItem('IA1V', 928, 1280)
    
        call SaveReal(udg_hs, 1, 69, - 2688)
        call SaveReal(udg_hs, 2, 69, - 7552)
        call SaveReal(udg_hs, 3, 69, 90)
        call SaveReal(udg_hs, 4, 69, - 2688)
        call SaveReal(udg_hs, 5, 69, - 6528)
        call SaveReal(udg_hs, 6, 69, 270)
        call SaveInteger(udg_hs, 10, 'IA1W', 69)
        call CreateItem('IA1W', 960, 1280)
    
        call SaveReal(udg_hs, 1, 70, - 4480)
        call SaveReal(udg_hs, 2, 70, - 7552)
        call SaveReal(udg_hs, 3, 70, 90)
        call SaveReal(udg_hs, 4, 70, - 4480)
        call SaveReal(udg_hs, 5, 70, - 6528)
        call SaveReal(udg_hs, 6, 70, 270)
        call SaveInteger(udg_hs, 10, 'IA1X', 70)
        call CreateItem('IA1X', 992, 1280)
    
        call SaveReal(udg_hs, 1, 71, 4480)
        call SaveReal(udg_hs, 2, 71, - 9344)
        call SaveReal(udg_hs, 3, 71, 90)
        call SaveReal(udg_hs, 4, 71, 4480)
        call SaveReal(udg_hs, 5, 71, - 8320)
        call SaveReal(udg_hs, 6, 71, 270)
        call SaveInteger(udg_hs, 10, 'IA1Y', 71)
        call CreateItem('IA1Y', 1024, 1280)
    
        call SaveReal(udg_hs, 1, 72, 2688)
        call SaveReal(udg_hs, 2, 72, - 9344)
        call SaveReal(udg_hs, 3, 72, 90)
        call SaveReal(udg_hs, 4, 72, 2688)
        call SaveReal(udg_hs, 5, 72, - 8320)
        call SaveReal(udg_hs, 6, 72, 270)
        call SaveInteger(udg_hs, 10, 'IA1Z', 72)
        call CreateItem('IA1Z', 1056, 1280)
    
        call SaveReal(udg_hs, 1, 73, 896)
        call SaveReal(udg_hs, 2, 73, - 9344)
        call SaveReal(udg_hs, 3, 73, 90)
        call SaveReal(udg_hs, 4, 73, 896)
        call SaveReal(udg_hs, 5, 73, - 8320)
        call SaveReal(udg_hs, 6, 73, 270)
        call SaveInteger(udg_hs, 10, 'IA20', 73)
        call CreateItem('IA20', 1088, 1280)
    
        call SaveReal(udg_hs, 1, 74, - 896)
        call SaveReal(udg_hs, 2, 74, - 9344)
        call SaveReal(udg_hs, 3, 74, 90)
        call SaveReal(udg_hs, 4, 74, - 896)
        call SaveReal(udg_hs, 5, 74, - 8320)
        call SaveReal(udg_hs, 6, 74, 270)
        call SaveInteger(udg_hs, 10, 'IA21', 74)
        call CreateItem('IA21', 1120, 1280)
    
        call SaveReal(udg_hs, 1, 75, - 2688)
        call SaveReal(udg_hs, 2, 75, - 9344)
        call SaveReal(udg_hs, 3, 75, 90)
        call SaveReal(udg_hs, 4, 75, - 2688)
        call SaveReal(udg_hs, 5, 75, - 8320)
        call SaveReal(udg_hs, 6, 75, 270)
        call SaveInteger(udg_hs, 10, 'IA22', 75)
        call CreateItem('IA22', 1152, 1280)
    
        call SaveReal(udg_hs, 1, 76, - 4480)
        call SaveReal(udg_hs, 2, 76, - 9344)
        call SaveReal(udg_hs, 3, 76, 90)
        call SaveReal(udg_hs, 4, 76, - 4480)
        call SaveReal(udg_hs, 5, 76, - 8320)
        call SaveReal(udg_hs, 6, 76, 270)
        call SaveInteger(udg_hs, 10, 'IA23', 76)
        call CreateItem('IA23', 1184, 1280)
    
        call SaveReal(udg_hs, 1, 77, 0)
        call SaveReal(udg_hs, 2, 77, 3840)
        call SaveReal(udg_hs, 3, 77, 270)
        call SaveReal(udg_hs, 4, 77, 0)
        call SaveReal(udg_hs, 5, 77, - 3840)
        call SaveReal(udg_hs, 6, 77, 90)
        call SaveInteger(udg_hs, 10, 'IA24', 77)
        call CreateItem('IA24', 1216, 1280)
    
        call SaveReal(udg_hs, 1, 78, - 2560)
        call SaveReal(udg_hs, 2, 78, 0)
        call SaveReal(udg_hs, 3, 78, 270)
        call SaveReal(udg_hs, 4, 78, - 2560)
        call SaveReal(udg_hs, 5, 78, 0)
        call SaveReal(udg_hs, 6, 78, 270)
        call SaveInteger(udg_hs, 10, 'IA25', 78)
        call CreateItem('IA25', 1248, 1280)
    
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
    set unitt=CreateUnit(Player(15), 'HA00', - 1280, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 1, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA01', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA01', - 768, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 2, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA02', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA02', - 256, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 3, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA03', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA03', 256, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 4, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA04', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA04', 768, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 5, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA05', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA05', 1280, 0, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 6, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA06', 1) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA06', - 1280, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 7, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA07', 2) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA07', - 768, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 8, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA08', 3) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA08', - 256, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 9, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA09', 4) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA09', 256, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 10, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0A', 5) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0A', 768, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 11, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0B', 11) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0B', 1280, - 512, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 12, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0C', 12) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0C', - 1280, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 13, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0D', 13) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0D', - 768, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 14, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0E', 21) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0E', - 256, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 15, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0F', 22) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0F', 256, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 16, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    call SaveInteger(udg_hs, 9, 'HA0G', 23) //最后用权限来代替
    set unitt=CreateUnit(Player(15), 'HA0G', 768, - 1024, 270) //创建可选择英雄
    call SetUnitInvulnerable(unitt, true) //设置无敌
    call SaveUnitHandle(udg_hs, 8, 17, unitt) //保存到哈希表
    set loopli=0
    loop
        exitwhen loopli == 6
        call UnitShareVision(unitt, Player(loopli), true) //共享视野
        set loopli=loopli + 1
    endloop
    
    set unitt=null
    call SaveTimerHandle(udg_hs, 0, StringHash("出怪计时器"), CreateTimer()) //保存出怪计时器
    call SavePlayerHandle(udg_hs, 0, StringHash("出怪玩家"), Player(11)) //保存出怪玩家，不过好像没啥用了
    
    set unitt=CreateUnit(Player(6), 'hC00', 0, - 3840, 90) //创建基地
    call SaveUnitHandle(udg_hs, 0, StringHash("基地"), unitt)
    
    set unitt=CreateUnit(Player(6), 'hC01', 253, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC02', - 256, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC03', 768, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC04', - 768, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC05', 1280, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC06', - 1280, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC07', 1792, - 4608, 90) //创建npc
    call SetUnitInvulnerable(unitt, true) //设置无敌
    
    set unitt=CreateUnit(Player(6), 'hC08', - 1792, - 4608, 90) //创建npc
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
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(0)), StringHash("进阶场"), 7) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, - 4480, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(0))
    call SaveReal(udg_hs, GetHandleId(Player(0)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 48) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', - 2688, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(1)), StringHash("进阶场"), 8) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, - 2688, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(1))
    call SaveReal(udg_hs, GetHandleId(Player(1)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 49) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', - 896, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(2)), StringHash("进阶场"), 9) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, - 896, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(2))
    call SaveReal(udg_hs, GetHandleId(Player(2)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 50) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 896, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(3)), StringHash("进阶场"), 10) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, 896, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(3))
    call SaveReal(udg_hs, GetHandleId(Player(3)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 51) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 2688, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(4)), StringHash("进阶场"), 11) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, 2688, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(4))
    call SaveReal(udg_hs, GetHandleId(Player(4)), StringHash("音量"), 50)
    
    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs, 16, StringHash("竞技场"), 52) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB0V', 4480, 9344, 270) //创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    
    set ttt=CreateTrigger()
    call SaveInteger(udg_hs, GetHandleId(Player(5)), StringHash("进阶场"), 12) //保存坐标
    set unitt=CreateUnit(Player(11), 'UB10', 4992, 4480, 180) //创建单位
    call TriggerAddAction(ttt, function zs)
    call TriggerRegisterUnitEvent(ttt, unitt, EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs, GetHandleId(unitt), StringHash("玩家"), Player(5))
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
    
    call CreateItem('IB42', 890, - 3840)
    
    call CreateItem('IB43', 900, - 3840)
    
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
    
    call SetMusicVolume(PercentToInt(50, 127))
    //新手装备初始化
    call SaveInteger(udg_hs, 'IB3U', 1, 'IC00')
    call SaveInteger(udg_hs, 'IB3U', 2, 'IC0Y')
    call SaveInteger(udg_hs, 'IB3V', 1, 'IC01')
    call SaveInteger(udg_hs, 'IB3V', 2, 'IC0Z')
    call SaveInteger(udg_hs, 'IB3W', 1, 'IC02')
    call SaveInteger(udg_hs, 'IB3W', 2, 'IC10')
    call SaveInteger(udg_hs, 'IB3X', 1, 'IC03')
    call SaveInteger(udg_hs, 'IB3X', 2, 'IC11')
    //装备强化和合成初始化函数
    call itemreg('IB04' , 1 , 'IB3Z' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'IC04' , 2 , true)
    call itemreg('IB1R' , 1 , 'IB3D' , 1 , 'IB3E' , 1 , 'IB3F' , 1 , 'IB3G' , 1 , 0 , 0 , 'IC1C' , 5 , true)
    
    set ttt=null
    endfunction 
    function csh___init takes nothing returns nothing
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
    endfunction

//library csh ends
//===========================================================================
// 
// 屠杀野猪捡奶酪V2.0
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Sun Jun 10 10:36:44 2018
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
//*  Items
//*
//***************************************************************************
function CreateAllItems takes nothing returns nothing
    local integer itemID
    call CreateItem('IB1R', 1098.7, - 4703.1)
    call CreateItem('IB3D', 1086.0, - 4790.4)
    call CreateItem('IB3E', 1082.4, - 4871.3)
    call CreateItem('IB3F', 1073.0, - 4939.9)
    call CreateItem('IB3G', 1071.9, - 5009.9)
    call CreateItem('IC00', 745.1, - 4899.5)
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
    call CreateAllItems()
    call InitBlizzard()

call ExecuteFunc("csh___init")

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

