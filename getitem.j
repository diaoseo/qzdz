library libgetitem requires libmsg


function getitem_2 takes nothing returns nothing//宠物获得物品
    local unit u=LoadUnitHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),1002)//读取英雄
    local item litem=GetManipulatedItem()//获取被操作物品
    local integer ti = GetItemTypeId(litem)//获取被操作物品类型
    local integer ti1=LoadInteger(udg_hs,10,ti)//读取坐标
    local real x = LoadReal(udg_hs,4,ti1)//坐标X
    local real y = LoadReal(udg_hs,5,ti1)//坐标Y
    local real face = LoadReal(udg_hs,6,ti1)//坐标面向角度
    local unit u1 = GetTriggerUnit()//触发单位
    local integer lv=GetItemLevel(litem)//物品等级
    local integer array li

    if GetItemType(litem)==ITEM_TYPE_POWERUP then//判断能量提升
        if lv==1 and GetUnitState(u,UNIT_STATE_LIFE)>0.405 then//判断等级开启传送
            call UnitAddItem(u1,litem)//转移物品
            return//退出
        endif
        if lv==2 or lv==3 or lv==4 then//2级武器,3级衣服,4级护手
            set li[0]=0//初始化循环
            set li[1]=LoadInteger(udg_hs,22,ti)//读取强化书等级
            set li[2]=LoadInteger(udg_hs,ti,lv)//读取强化书对应武器类型
            loop//遍历物品栏
                exitwhen li[0]==6
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[2]then//判断有无对应装备
                    set li[3]=GetItemTypeId(UnitItemInSlot(u1,li[0]))//读取对应装备
                    call RemoveSavedInteger(udg_hs,GetHandleId(UnitItemInSlot(u1,li[0])),GetItemLevel(UnitItemInSlot(u1,li[0])))//清除即将移除的物品绑定哈希表
                    call RemoveItem(UnitItemInSlot(u1,li[0]))//删除旧装备
                    set litem=CreateItem(LoadInteger(udg_hs,21,li[3]),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))//创建新装备
                    call UnitAddItem(u1,litem)//添加给单位
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备已升级成"+GetItemName(litem))//发送辣鸡消息
                    set litem=null
                    set u1=null
                    call RemoveItem(GetManipulatedItem())//能量提升直排
                    return//退出
                endif
                set li[0]=li[0]+1
            endloop
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备强化失败，请检查你的装备")
            call RemoveItem(GetManipulatedItem())//能量提升直排
            set litem=null
            set u1=null
            return
        endif
        if lv==7 then
            set lgf[GetPlayerId(GetOwningPlayer(u1))]=1
            set lgf[GetPlayerId(GetOwningPlayer(u1))+12]=ti+738131968
        endif
        if lv==8 and GetUnitState(u,UNIT_STATE_LIFE)>0.405 then
            call UnitAddItem(u,CreateItem(1229008944+GetPlayerId(GetOwningPlayer(u)),GetUnitX(u),GetUnitY(u)))
        endif
        call RemoveItem(GetManipulatedItem())//能量提升直排
    endif

    if GetItemType(litem)==ITEM_TYPE_PURCHASABLE then//判断是否材料，类型为可购买
        if lv==1 then//一级新手装备，直接给予英雄真强化书
            call UnitAddItem(u,litem)//转移物品
            /*
            //宠物不能升级装备，宠物的升级装备交给英雄
            set li[0]=0//初始化循环
            set li[1]=LoadInteger(udg_hs,GetItemTypeId(litem),0)//读取是武器还是衣服
            set li[2]=0//判断装备的内置等级
            loop
                if GetItemType(UnitItemInSlot(u1,li[0]))== ITEM_TYPE_PERMANENT and GetItemLevel(UnitItemInSlot(u1,li[0]))== li[1] then
                    set li[2]=LoadInteger(udg_hs,25,GetItemTypeId(UnitItemInSlot(u1,li[0])))//获取装备内置等级
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
            call RemoveItem(litem)
            if li[2]>0 and li[2]<5 then
                //在这里判读穷逼有没有足够的金币，没有就拒绝强化
                call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,ti,li[2]),GetUnitX(u1),GetUnitY(u1)))
            else
                call DisplayTimedTextToPlayer(GetOwningPlayer(u1),0,0,10,msg(1)+"你没有合适的装备能升级")//发送辣鸡消息
            endif
            */
        endif
        if lv==2 then//二级属于真材实料，需要判断玩家是否材料齐全
            //目前如果玩家拾取到未注册的可购买类物品会崩溃，原因是死循环，因为未注册无法获取需要几个材料
            set li[0]=LoadInteger(udg_hs,ti,0)//获取物品合成需要几个材料
            set li[1]=0//初始化主循环
            set li[2]=0//初始化子循环
            set li[3]=0//初始化玩家拥有材料种类数量
            set li[4]=0//初始化合成循环
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1,li[2]))==LoadInteger(udg_hs,ti,li[1]+1) then//判断单位是否有所需材料
                        call SaveItemHandle(udg_hs,9999,li[3],UnitItemInSlot(u1,li[2]))//保存判断到的材料
                        set li[3]=li[3]+1//记录材料种类数量
                        set li[2]=5
                        if li[1]==0 then
                            set li[5]=GetItemTypeId(UnitItemInSlot(u1,li[2]))
                        endif
                    endif
                    exitwhen li[2]==5
                    set li[2]=li[2]+1
                endloop
                set li[1]=li[1]+1
                set li[2]=0//恢复循环数
                exitwhen li[1]==li[0]//循环所需材料次数
            endloop
            if li[0]==li[3] then//玩家已拥有足够的材料
                set litem=LoadItemHandle(udg_hs,9999,0)//读取主线材料
                set li[5]=GetItemTypeId(litem)//读取主线材料ID
                set li[6]=LoadInteger(udg_hs,25,li[5])//读取升级对应的等级
                set li[7]=((li[6]+4)/5)*100//读取升级所需经验
                set li[8]=GetHandleId(litem)
                set li[9]=GetItemLevel(litem)
                set li[10]=LoadInteger(udg_hs,li[8],li[9])+1
                set li[11]=0//判读是否具备升级条件
                if GetItemType(litem)==ITEM_TYPE_PERMANENT  and li[6]<16 and ModuloInteger(li[6],5)==0 and (li[9]==2 or li[9]==1) then//只有武器和衣服需要判断经验来合成
                    if  li[7]<=li[10] then//判断经验是否足够
                    else
                    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,"材料已齐全，装备经验不足")
                    set li[11]=1//拒绝升级
                    call BJDebugMsg(I2S(li[7])+"   "+I2S(li[10]))
                    endif
                endif
                if li[11]==0 then
                    if LoadBoolean(udg_hs,ti,10) then//判断是合成还是强化，区别在强化的循环
                        loop//删除多余物品
                            set li[4]=li[4]+1
                            call RemoveItem(LoadItemHandle(udg_hs,9999,li[4]))
                            exitwhen li[4]==li[0]
                        endloop
                        //进入强化阶段
                        call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,li[5],20),GetUnitX(u1),GetUnitY(u1)))
                    else
                        loop//删除多余物品
                            call RemoveItem(LoadItemHandle(udg_hs,9999,li[4]))
                            exitwhen li[4]==li[0]
                            set li[4]=li[4]+1
                        endloop
                        //进入合成阶段
                        call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,li[5],20),GetUnitX(u1),GetUnitY(u1)))
                    endif
                endif

            endif
            call FlushChildHashtable(udg_hs,9999)//清空哈希表
        endif
        if lv==3 then//三级五行强化
            set li[0]=0//初始化循环
            set li[1]=0
            loop
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))=='IB13' or GetItemTypeId(UnitItemInSlot(u1,li[0]))=='IB2E' then
                    set li[1]=GetItemTypeId(UnitItemInSlot(u1,li[0]))
                    set li[3]=li[0]
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
            if li[1]!=0 then
                set li[4]=GetRandomInt(1,5)
                call RemoveItem(UnitItemInSlot(u1,li[3]))
                call RemoveItem(litem)
                set litem = CreateItem(LoadInteger(udg_hs,li[1],li[4]),GetUnitX(u1),GetUnitY(u1))
                call UnitAddItem(u1,litem)
            endif

        endif
        if lv==4 then//四级也是直接给
            set li[1]=LoadInteger(udg_hs,GetItemTypeId(litem),0)
            set li[0]=0//初始化循环
            set li[2]=LoadInteger(udg_hs,GetItemTypeId(litem),1)
            loop
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[1] then
                    call RemoveItem(UnitItemInSlot(u1,li[0]))
                    call RemoveItem(litem)
                    call UnitAddItem(u1,CreateItem(li[2],GetUnitX(u1),GetUnitY(u1)))
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
        endif
        if lv==5 then//五级只有一个辣鸡
            set li[0]='IB3Q'
            set li[1]='IB3R'
            set li[2]='IB3S'
            set li[3]='IB3T'
            set li[4]=0
            set li[5]=0
            set li[6]=0
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1,li[5]))==li[li[4]] then
                        set li[6]=li[6]+1
                        call SaveItemHandle(udg_hs,10086,li[6],UnitItemInSlot(u1,li[5]))
                        set li[5]=5
                    endif
                    exitwhen li[5]==5
                    set li[5]=li[5]+1
                endloop
                exitwhen li[4]==3
                set li[4]=li[4]+1
                set li[5]=0
            endloop
            if li[6]==4 then
                set li[5]=0
                loop
                    exitwhen li[5]==4
                    set li[5]=li[5]+1
                    call RemoveItem(LoadItemHandle(udg_hs,10086,li[5]))
                endloop
                call UnitAddItem(u1,CreateItem('IB2D',GetUnitX(u1),GetUnitY(u1)))
            endif
        endif
    endif

    if GetItemType(litem)==ITEM_TYPE_CHARGED then//判断是否可充物品
        set li[0]=0
        loop
            if GetItemTypeId(UnitItemInSlot(u1,li[0]))==GetItemTypeId(litem) and litem!=UnitItemInSlot(u1,li[0]) then
                call SetItemCharges(UnitItemInSlot(u1,li[0]),GetItemCharges(UnitItemInSlot(u1,li[0]))+GetItemCharges(litem))//可充物品自动叠加
                call RemoveItem(litem)//移除已叠加物品
                set li[0]=5
            endif
            exitwhen li[0]==5
            set li[0]=li[0]+1
        endloop
    endif

    set litem=null
    set u=null
    set u1=null
endfunction

function getitem_1 takes nothing returns nothing//英雄获得物品
    local item litem=GetManipulatedItem()//获取被操作物品
    local integer ti = GetItemTypeId(litem)//获取被操作物品类型
    local integer ti1=LoadInteger(udg_hs,10,ti)//读取坐标
    local real x = LoadReal(udg_hs,4,ti1)//坐标X
    local real y = LoadReal(udg_hs,5,ti1)//坐标Y
    local real face = LoadReal(udg_hs,6,ti1)//坐标面向角度
    local unit u1 = GetTriggerUnit()//触发单位
    local integer lv=GetItemLevel(litem)//物品等级
    local integer array li
    local unit u2

    if GetItemType(litem)==ITEM_TYPE_POWERUP then//判断能量提升
        if lv==1 then//判断等级开启传送
            call SetUnitPosition(u1,x,y)//传送
            call SetUnitFacing(u1,face)//设置面向角度
            if GetOwningPlayer(GetTriggerUnit())==GetLocalPlayer() then//异步
                call SetCameraPosition(x,y)
                call ClearSelection()
                call SelectUnit(GetTriggerUnit(),true)
            endif
            call RemoveItem(litem)//能量提升直排
            set u1=null
            set litem=null
            return//退出
        endif
        if lv==2 or lv==3 or lv==4 then//2级武器,3级衣服
            set li[0]=0//初始化循环
            set li[1]=LoadInteger(udg_hs,22,ti)//读取强化书等级
            set li[2]=LoadInteger(udg_hs,ti,lv)//读取强化书对应武器类型
            loop//遍历物品栏
                exitwhen li[0]==6
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[2]then//判断有无对应装备
                    set li[3]=GetItemTypeId(UnitItemInSlot(u1,li[0]))//读取对应装备
                    call RemoveSavedInteger(udg_hs,GetHandleId(UnitItemInSlot(u1,li[0])),GetItemLevel(UnitItemInSlot(u1,li[0])))//清除即将移除的物品绑定哈希表
                    call RemoveSavedHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),GetItemLevel(UnitItemInSlot(u1,li[0])))//清除物品绑定玩家
                    call RemoveItem(UnitItemInSlot(u1,li[0]))//删除旧装备
                    set litem=CreateItem(LoadInteger(udg_hs,21,li[3]),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))//创建新装备
                    call UnitAddItem(u1,litem)//添加给单位
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备已升级成"+GetItemName(litem))//发送辣鸡消息
                    set litem=null
                    set u1=null
                    call RemoveItem(GetManipulatedItem())//能量提升直排
                    return//退出
                endif
                set li[0]=li[0]+1
            endloop
            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"装备强化失败，请检查你的装备")
            call RemoveItem(GetManipulatedItem())//能量提升直排
            set litem=null
            set u1=null
            return
        endif
        if lv==7 then//切换刷怪类型，后续判断是否够钱
            set lgf[GetPlayerId(GetOwningPlayer(u1))]=1
            set lgf[GetPlayerId(GetOwningPlayer(u1))+12]=ti+738131968
        endif
        if lv==8 then//转生
            if ti=='I001' then//进入转生房
                call UnitAddItem(u1,CreateItem(1229008944+GetPlayerId(GetOwningPlayer(u1)),GetUnitX(u1),GetUnitY(u1)))
            else
                if ti=='I002' then//进入转生
                    set li[0]=GetPlayerId(GetOwningPlayer(u1))
                    if true then//足够的钱
                        if zx[li[0]]<=0.6 and GetHeroLevel(u1)>=li[0]*1000 then//足够的等级，或者可以转生
                            if li[0]>3 then
                                call UnitAddItem(u1,CreateItem('IA0='+GetPlayerId(GetOwningPlayer(u1)),GetUnitX(u1),GetUnitY(u1)))//给予进入转生房的物品
                                if HaveSavedInteger (udg_hs,GetHandleId(GetOwningPlayer(u1)),51) then
                                else
                                    set u2=CreateUnit(Player(11),'UB10'+R2I(zx[li[0]]*10),LoadReal(udg_hs,1,li[0]+7),LoadReal(udg_hs,2,li[0]+7),LoadReal(udg_hs,3,li[0]+7))//创建转生BOSS
                                    call SaveInteger (udg_hs,GetHandleId(GetOwningPlayer(u1)),51,li[0])
                                    call SaveInteger(udg_hs,GetHandleId(u2),51,li[0])
                                endif
                            else
                                call UnitAddItem(u1,CreateItem('IA06'+GetPlayerId(GetOwningPlayer(u1)),GetUnitX(u1),GetUnitY(u1)))//给予进入转生房的物品
                                if HaveSavedInteger (udg_hs,GetHandleId(GetOwningPlayer(u1)),51) then
                                else
                                    set u2=CreateUnit(Player(11),'UB10'+R2I(zx[li[0]]*10),LoadReal(udg_hs,1,li[0]+7),LoadReal(udg_hs,2,li[0]+7),LoadReal(udg_hs,3,li[0]+7))//创建转生BOSS
                                    call SaveInteger (udg_hs,GetHandleId(GetOwningPlayer(u1)),51,li[0])
                                    call SaveInteger(udg_hs,GetHandleId(u2),51,li[0])
                                endif
                            endif
                        endif
                    endif
                else
                    if ti=='I003' or ti=='I004' then//修神或入魔
                        if true then//足够的钱
                            if zx[li[0]]==0.7 and GetHeroLevel(u1)>=li[0]*1000 then//足够的等级和转生
                                if li[0]>3 then
                                    call UnitAddItem(u1,CreateItem('IA0='+GetPlayerId(GetOwningPlayer(u1)),GetUnitX(u1),GetUnitY(u1)))//给予进入转生房的物品
                                    if HaveSavedInteger(udg_hs,GetHandleId(GetOwningPlayer(u1)),51) then
                                    else
                                        set u2=CreateUnit(Player(11),ti+202506499,LoadReal(udg_hs,1,li[0]+7),LoadReal(udg_hs,2,li[0]+7),LoadReal(udg_hs,3,li[0]+7))//创建转生BOSS
                                        call SaveInteger(udg_hs,GetHandleId(u2),51,li[0])
                                        call SaveInteger(udg_hs,GetHandleId(u2),52,ti-'I003')
                                        call SaveInteger(udg_hs,GetHandleId(GetOwningPlayer(u1)),51,li[0])
                                        
                                    endif
                                else
                                    call UnitAddItem(u1,CreateItem('IA06'+GetPlayerId(GetOwningPlayer(u1)),GetUnitX(u1),GetUnitY(u1)))//给予进入转生房的物品
                                    if HaveSavedInteger(udg_hs,GetHandleId(GetOwningPlayer(u1)),51) then
                                    else
                                        set u2=CreateUnit(Player(11),ti+202506499,LoadReal(udg_hs,1,li[0]+7),LoadReal(udg_hs,2,li[0]+7),LoadReal(udg_hs,3,li[0]+7))//创建转生BOSS
                                        call SaveInteger(udg_hs,GetHandleId(u2),52,ti-'I003')
                                        call SaveInteger(udg_hs,GetHandleId(u2),51,li[0])
                                        call SaveInteger(udg_hs,GetHandleId(GetOwningPlayer(u1)),51,li[0])
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
        call RemoveItem(GetManipulatedItem())//能量提升直排
    endif

    if GetItemType(litem)==ITEM_TYPE_PERMANENT then//判断永久物品
        if lv>0 and lv<6 then//一级武器，二级衣服，三级手套，四级护符，五级项链
            set li[0]=0
            loop
                exitwhen li[0]==6
                if GetItemLevel(UnitItemInSlot(u1,li[0]))==lv and UnitItemInSlot(u1,li[0])!=litem and ITEM_TYPE_PERMANENT == GetItemType(UnitItemInSlot(u1,li[0])) then//只能携带一件同类装备
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,10,msg(1)+"你身上已有同类物品")
                    call UnitRemoveItem(u1,litem)//丢掉捡到的物品
                    set litem=UnitItemInSlot(u1,li[0])//记录匹配的物品
                    call UnitRemoveItem(u1,litem)//丢掉匹配的物品
                    call UnitAddItem(u1,litem)//在捡起丢掉的物品
                    set litem=null
                    set u1=null
                    return
                endif
                set li[0]=li[0]+1
            endloop
            if (lv<3 and LoadInteger(udg_hs,25,ti)<16 and LoadInteger(udg_hs,25,ti)>0 ) or (lv==3 and LoadInteger(udg_hs,25,ti)<6 and LoadInteger(udg_hs,25,ti)>0 ) then//小于15级的武器和衣服才绑定
                call SaveItemHandle(udg_hs,GetHandleId(GetOwningPlayer(u1)),lv,litem)//物品绑定玩家
            endif
        endif
    endif

    if GetItemType(litem)==ITEM_TYPE_PURCHASABLE then//判断是否材料，类型为可购买
        if lv==1 then//一级新手装备，直接给予英雄真强化书
            set li[0]=0//初始化循环
            set li[1]=LoadInteger(udg_hs,GetItemTypeId(litem),0)//读取是武器还是衣服
            set li[2]=0//判断装备的内置等级
            loop
                if GetItemType(UnitItemInSlot(u1,li[0]))== ITEM_TYPE_PERMANENT and GetItemLevel(UnitItemInSlot(u1,li[0]))== li[1] then
                    set li[2]=LoadInteger(udg_hs,25,GetItemTypeId(UnitItemInSlot(u1,li[0])))//获取装备内置等级
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
            call RemoveItem(litem)
            if li[2]>0 and li[2]<5 then
                //在这里判读穷逼有没有足够的金币，没有就拒绝强化
                call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,ti,li[2]),GetUnitX(u1),GetUnitY(u1)))
            else
                call DisplayTimedTextToPlayer(GetOwningPlayer(u1),0,0,10,msg(1)+"你没有合适的装备能升级")//发送辣鸡消息
            endif
        endif
        if lv==2 then//二级属于真材实料，需要判断玩家是否材料齐全
            //目前如果玩家拾取到未注册的可购买类物品会崩溃，原因是死循环，因为未注册无法获取需要几个材料
            set li[0]=LoadInteger(udg_hs,ti,0)//获取物品合成需要几个材料
            set li[1]=0//初始化主循环
            set li[2]=0//初始化子循环
            set li[3]=0//初始化玩家拥有材料种类数量
            set li[4]=0//初始化合成循环
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1,li[2]))==LoadInteger(udg_hs,ti,li[1]+1) then//判断单位是否有所需材料
                        call SaveItemHandle(udg_hs,9999,li[3],UnitItemInSlot(u1,li[2]))//保存判断到的材料
                        set li[3]=li[3]+1//记录材料种类数量
                        set li[2]=5
                        if li[1]==0 then
                            set li[5]=GetItemTypeId(UnitItemInSlot(u1,li[2]))
                        endif
                    endif
                    exitwhen li[2]==5
                    set li[2]=li[2]+1
                endloop
                set li[1]=li[1]+1
                set li[2]=0//恢复循环数
                exitwhen li[1]==li[0]//循环所需材料次数
            endloop
            if li[0]==li[3] then//玩家已拥有足够的材料
                set litem=LoadItemHandle(udg_hs,9999,0)//读取主线材料
                set li[5]=GetItemTypeId(litem)//读取主线材料ID
                set li[6]=LoadInteger(udg_hs,25,li[5])//读取升级对应的等级
                set li[7]=((li[6]+4)/5)*100//读取升级所需经验
                set li[8]=GetHandleId(litem)
                set li[9]=GetItemLevel(litem)
                set li[10]=LoadInteger(udg_hs,li[8],li[9])+1
                set li[11]=0//判读是否具备升级条件
                if GetItemType(litem)==ITEM_TYPE_PERMANENT  and li[6]<16 and ModuloInteger(li[6],5)==0 and (li[9]==2 or li[9]==1) then//只有武器和衣服需要判断经验来合成
                    if  li[7]<=li[10] then//判断经验是否足够
                    else
                    call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()),0,0,"材料已齐全，装备经验不足")
                    set li[11]=1//拒绝升级
                    call BJDebugMsg(I2S(li[7])+"   "+I2S(li[10]))
                    endif
                endif
                if li[11]==0 then
                    if LoadBoolean(udg_hs,ti,10) then//判断是合成还是强化，区别在强化的循环
                        loop//删除多余物品
                            set li[4]=li[4]+1
                            call RemoveItem(LoadItemHandle(udg_hs,9999,li[4]))
                            exitwhen li[4]==li[0]
                        endloop
                        //进入强化阶段
                        call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,li[5],20),GetUnitX(u1),GetUnitY(u1)))
                    else
                        loop//删除多余物品
                            call RemoveItem(LoadItemHandle(udg_hs,9999,li[4]))
                            exitwhen li[4]==li[0]
                            set li[4]=li[4]+1
                        endloop
                        //进入合成阶段
                        call UnitAddItem(u1,CreateItem(LoadInteger(udg_hs,li[5],20),GetUnitX(u1),GetUnitY(u1)))
                    endif
                endif

            endif
            call FlushChildHashtable(udg_hs,9999)//清空哈希表
        endif
        if lv==3 then//三级五行强化
            set li[0]=0//初始化循环
            set li[1]=0
            loop
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))=='IB13' or GetItemTypeId(UnitItemInSlot(u1,li[0]))=='IB2E' then
                    set li[1]=GetItemTypeId(UnitItemInSlot(u1,li[0]))
                    set li[3]=li[0]
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
            if li[1]!=0 then
                set li[4]=GetRandomInt(1,5)
                call RemoveItem(UnitItemInSlot(u1,li[3]))
                call RemoveItem(litem)
                set litem = CreateItem(LoadInteger(udg_hs,li[1],li[4]),GetUnitX(u1),GetUnitY(u1))
                call UnitAddItem(u1,litem)
            endif

        endif
        if lv==4 then//四级也是直接给
            set li[1]=LoadInteger(udg_hs,GetItemTypeId(litem),0)
            set li[0]=0//初始化循环
            set li[2]=LoadInteger(udg_hs,GetItemTypeId(litem),1)
            loop
                if GetItemTypeId(UnitItemInSlot(u1,li[0]))==li[1] then
                    call RemoveItem(UnitItemInSlot(u1,li[0]))
                    call RemoveItem(litem)
                    call UnitAddItem(u1,CreateItem(li[2],GetUnitX(u1),GetUnitY(u1)))
                    set li[0]=5
                endif
                exitwhen li[0]==5
                set li[0]=li[0]+1
            endloop
        endif
        if lv==5 then//五级只有一个辣鸡
            set li[0]='IB3Q'
            set li[1]='IB3R'
            set li[2]='IB3S'
            set li[3]='IB3T'
            set li[4]=0
            set li[5]=0
            set li[6]=0
            loop
                loop
                    if GetItemTypeId(UnitItemInSlot(u1,li[5]))==li[li[4]] then
                        set li[6]=li[6]+1
                        call SaveItemHandle(udg_hs,10086,li[6],UnitItemInSlot(u1,li[5]))
                        set li[5]=5
                    endif
                    exitwhen li[5]==5
                    set li[5]=li[5]+1
                endloop
                exitwhen li[4]==3
                set li[4]=li[4]+1
                set li[5]=0
            endloop
            if li[6]==4 then
                set li[5]=0
                loop
                    exitwhen li[5]==4
                    set li[5]=li[5]+1
                    call RemoveItem(LoadItemHandle(udg_hs,10086,li[5]))
                endloop
                call UnitAddItem(u1,CreateItem('IB2D',GetUnitX(u1),GetUnitY(u1)))
            endif
        endif
    endif

    if GetItemType(litem)==ITEM_TYPE_CHARGED then//判断是否可充物品
        set li[0]=0
        loop
            if GetItemTypeId(UnitItemInSlot(u1,li[0]))==GetItemTypeId(litem) and litem!=UnitItemInSlot(u1,li[0]) then
                call SetItemCharges(UnitItemInSlot(u1,li[0]),GetItemCharges(UnitItemInSlot(u1,li[0]))+GetItemCharges(litem))//可充物品自动叠加
                call RemoveItem(litem)//移除已叠加物品
                set li[0]=5
            endif
            exitwhen li[0]==5
            set li[0]=li[0]+1
        endloop
    endif

    set litem=null
    set u1=null
    set u2=null
endfunction

function dropitem takes nothing returns nothing//丢弃物品触发
    if GetItemType(GetManipulatedItem())==ITEM_TYPE_PERMANENT then//判断丢弃了永久物品
        call RemoveSavedHandle(udg_hs,GetHandleId(GetOwningPlayer(GetTriggerUnit())),GetItemLevel(GetManipulatedItem()))//清除单位的绑定
    endif
endfunction


function getitem takes nothing returns nothing
    local trigger tr =CreateTrigger()
    call TriggerAddAction(tr,function getitem_1)
    call SaveTriggerHandle(udg_hs,0,1004,tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function getitem_2)
    call SaveTriggerHandle(udg_hs,0,1006,tr)
    set tr=CreateTrigger()
    call TriggerAddAction(tr,function dropitem)
    call SaveTriggerHandle(udg_hs,0,1005,tr)
    set tr=null    
endfunction

endlibrary
