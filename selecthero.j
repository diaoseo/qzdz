library libselecthero requires libgy

function temptime takes nothing returns nothing//计时器清空双击
    local player lp = LoadPlayerHandle(udg_hs,H2I(GetExpiredTimer()),1)
    call RemoveSavedHandle(udg_hs,H2I(lp),999)
    call DestroyTimer(GetExpiredTimer())
endfunction

function xzyx1 takes nothing returns nothing
    local timer tti
    local integer li1=0
    local integer li2
    local unit u1
    if GetOwningPlayer(GetTriggerUnit())==Player(15) then//判断选择的英雄是否玩家16
        if HaveSavedHandle(udg_hs,H2I(GetTriggerPlayer()),1002) then//判断玩家是否已选英雄
            call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10,msgys("你已经选择了英雄!"))
        else
            if LoadUnitHandle(udg_hs,H2I(GetTriggerPlayer()),999)==GetTriggerUnit() then//判断玩家当前选择是同一个英雄
                call SetUnitOwner(GetTriggerUnit(),GetTriggerPlayer(),true)//改变单位所有者
                call SaveUnitHandle(udg_hs,H2I(GetTriggerPlayer()),1002,GetTriggerUnit())//记录玩家英雄
                //开始设置多面板数据
                set li2=GetPlayerId(GetTriggerPlayer())
                call MultiboardSetItemValue(multiitem[li2*7],"最强王者")//荣誉
                call MultiboardSetItemValue(multiitem[li2*7+1],GetPlayerName(GetTriggerPlayer()))//玩家名
                call MultiboardSetItemValue(multiitem[li2*7+2],GetUnitName(GetTriggerUnit()))//英雄
                call MultiboardSetItemValue(multiitem[li2*7+3],"最强输出")//称号
                call MultiboardSetItemValue(multiitem[li2*7+4],"普通")//进阶
                call MultiboardSetItemValue(multiitem[li2*7+5],"88888888")//结晶
                call MultiboardSetItemValue(multiitem[li2*7+6],"屠杀野猪捡奶酪V2.0")//备用
                //结束设置多面板数据
                set li2=LoadInteger(udg_hs,0,1001)//同下
                call SaveInteger(udg_hs,0,1001,li2+1)//记录已选择英雄的人数
                call SetUnitX(GetTriggerUnit(),LoadReal(udg_hs,4,77))//设置坐标
                call SetUnitY(GetTriggerUnit(),LoadReal(udg_hs,5,77)+128)//同上
                set yx[GetPlayerId(GetTriggerPlayer())]=LoadReal(udg_hs,30,GetUnitTypeId(GetTriggerUnit()))//设置英雄系数
                call SetPlayerAbilityAvailable(GetTriggerPlayer(),jn[20*GetPlayerId(GetTriggerPlayer())+1],true)//开局获得一个天赋点
                call SaveBoolean(udg_hs,GetHandleId(GetTriggerPlayer()),jn[20*GetPlayerId(GetTriggerPlayer())+1],true)//开启该技能
                call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,false)//禁用下一页
                call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,true)//启用下一页
                set jn[20*GetPlayerId(GetTriggerPlayer())+20]=1
                if GetUnitTypeId(GetTriggerUnit()) == 'HA0G'then//神代魔术师
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(),jn[20*GetPlayerId(GetTriggerPlayer())+2],true)//开局获得一个天赋点
                    call SaveBoolean(udg_hs,GetHandleId(GetTriggerPlayer()),jn[20*GetPlayerId(GetTriggerPlayer())+2],true)//开启该技能
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(),jn[20*GetPlayerId(GetTriggerPlayer())+3],true)//开局获得一个天赋点
                    call SaveBoolean(udg_hs,GetHandleId(GetTriggerPlayer()),jn[20*GetPlayerId(GetTriggerPlayer())+3],true)//开启该技能
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,false)//禁用下一页
                    call SetPlayerAbilityAvailable(GetTriggerPlayer(),1093677105,true)//启用下一页
                    set jn[20*GetPlayerId(GetTriggerPlayer())+20]=3
                endif
                set jn[20*GetPlayerId(GetTriggerPlayer())+19]=0//用来限制购买的天赋
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,300),GetTriggerUnit(),EVENT_UNIT_HERO_LEVEL)//注册英雄升级事件
                //set yx[GetPlayerId(GetTriggerPlayer())]=LoadReal(udg_hs,31,GetUnitTypeId(GetTriggerUnit()))//设置法强系数
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,1003),GetTriggerUnit(),EVENT_UNIT_DEATH)//注册复活英雄事件
                call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,msgys(GetPlayerName(GetTriggerPlayer())+" 选择了 "+GetObjectName(GetUnitTypeId(GetTriggerUnit()))))//发送消息
                call SetUnitInvulnerable(GetTriggerUnit(),false)//取消无敌
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,1004),GetTriggerUnit(),EVENT_UNIT_PICKUP_ITEM)//注册单位获得物品事件
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,1005),GetTriggerUnit(),EVENT_UNIT_DROP_ITEM)//注册单位丢弃物品事件
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,99),GetTriggerUnit(),EVENT_UNIT_SPELL_EFFECT)//注册发动技能效果事件
                set u1=CreateUnit(Player(15),'HB00',LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77),LoadReal(udg_hs,6,77))//创建菜单英雄
                call TriggerRegisterPlayerUnitEvent(LoadTriggerHandle(udg_hs,0,1007),GetTriggerPlayer(),EVENT_PLAYER_UNIT_SELECTED,null)//再次注册选择单位触发
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,1008),u1,EVENT_UNIT_RESEARCH_FINISH)//注册科技共享触发
                call SetUnitOwner(u1,GetTriggerPlayer(),true)//改变单位所有者
                call SuspendHeroXP(u1,true)//禁止菜单英雄获得经验
                call SetUnitInvulnerable(u1,true)//设置无敌
                call SetUnitFlyHeight(u1,10000,0)//设置飞行高度
                if GetTriggerPlayer()==GetLocalPlayer() then//判断本地玩家，异步
                    call SetCameraPosition(LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77)+128)//异步镜头
                    call SetUnitFlyHeight(u1,0,0)//异步高度
                endif
                set u1=CreateUnit(GetTriggerPlayer(),'hCZZ',LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77)+256,LoadReal(udg_hs,6,77))//创建宠物
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,1006),u1,EVENT_UNIT_PICKUP_ITEM)//注册单位获得物品事件
                call SaveUnitHandle(udg_hs,GetHandleId(GetTriggerPlayer()),49,u1)//存储宠物
                call SetUnitInvulnerable(u1,true)//设置无敌
                call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,102),u1,EVENT_UNIT_SPELL_EFFECT)//注册宠物发动技能效果事件
                set u1=null
                if GetUnitTypeId(GetTriggerUnit())=='HA07' then//注册召唤事件
                    call TriggerRegisterUnitEvent(LoadTriggerHandle(udg_hs,0,101),GetTriggerUnit(),EVENT_UNIT_SUMMON)
                endif
                if li2+1==LoadInteger(udg_hs,0,1009) then//判断所有人都选了英雄
                    call DisableTrigger(GetTriggeringTrigger())//关闭触发
                    call DestroyTrigger(GetTriggeringTrigger())//删除触发
                    loop
                        exitwhen li1==18
                        if GetOwningPlayer(LoadUnitHandle(udg_hs,8,li1))==Player(15) then//判断单位是否被选取
                            call RemoveUnit(LoadUnitHandle(udg_hs,8,li1))//没有被选取的会直接删除
                        endif
                        set li1=li1+1
                    endloop
                    call FlushChildHashtable(udg_hs,8)//清空哈希表
                    call RemoveSavedInteger(udg_hs,0,1001)

                    call RemoveSavedHandle(udg_hs,0,1010)
                endif
            else
                call SaveUnitHandle(udg_hs,H2I(GetTriggerPlayer()),999,GetTriggerUnit())//存储临时选择
                call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,10,"你选择了  【"+msgys(GetObjectName(GetUnitTypeId(GetTriggerUnit())))+"】  确认请双击！")//信息
                set tti=CreateTimer()//创建双击计时器
                call TimerStart(tti,0.5,false,function temptime)//计时器回调和启动
                call SavePlayerHandle(udg_hs,H2I(tti),1,GetTriggerPlayer())//保存玩家handle到计时器
                set tti=null
            endif
        endif
    endif

endfunction

function xzyx takes nothing returns nothing
    local integer li=0
    local trigger tr=CreateTrigger()
    call SaveTriggerHandle(udg_hs,0,1010,tr)
    loop
        exitwhen li==6
            if ((GetPlayerSlotState(Player(li)) == PLAYER_SLOT_STATE_PLAYING) and (GetPlayerController(Player(li)) != MAP_CONTROL_COMPUTER )) then
                call TriggerRegisterPlayerUnitEvent(tr,Player(li),EVENT_PLAYER_UNIT_SELECTED,null)
                call SaveInteger(udg_hs,0,1009,LoadInteger(udg_hs,0,1009)+1)
                call TriggerRegisterPlayerChatEvent(LoadTriggerHandle(udg_hs,0,1011),Player(li),"-",false)
            endif
            set li=li+1
    endloop
    call TriggerAddAction(tr,function xzyx1)
    set tr=null
endfunction
endlibrary
