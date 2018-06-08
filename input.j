library libinput requires libgy libhg

function input_1 takes nothing returns nothing
    //输入触发
    local string s1=GetEventPlayerChatString()//获取输入的字符串
    local integer len= StringLength(s1)//不知道有什么用
    local string s2=SubString(s1,1,3)//截取输入的字符串
    local player p1=GetTriggerPlayer()//获取触发玩家
    local integer tempi=S2I(SubString(s1,1,30))
    if s2=="hg" then//判断输入
        call hg(LoadUnitHandle(udg_hs,H2I(p1),StringHash("英雄")))//调用回城函数
    endif

    call SetPlayerAbilityAvailable(p1,tempi,true)//测试添加技能
    call SetPlayerAbilityAvailable(p1,1093677105,false)
    call SetPlayerAbilityAvailable(p1,1093677105,true)
    call BJDebugMsg(GetObjectName(tempi))
endfunction

function input takes nothing returns nothing
    local trigger tr
        set tr=CreateTrigger()
        //创建输入触发
        call SaveTriggerHandle(udg_hs,0,StringHash("输入"),tr)
        call TriggerAddAction(tr,function input_1)
        set tr=null
endfunction

endlibrary
