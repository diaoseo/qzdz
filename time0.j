library libtime0

function sys_cg takes nothing returns nothing
    local integer li1 = -1
    local unit unitt
    local integer loopli=0
        loop
            exitwhen li1==2
            set unitt=CreateUnit(Player(11),LoadInteger(udg_hs,7,b),LoadReal(udg_hs,1,77)+li1*1536,LoadReal(udg_hs,2,77),270)
            call IssueNeutralPointOrderById(LoadPlayerHandle(udg_hs,0,StringHash("出怪玩家")),unitt,851983,LoadReal(udg_hs,4,77),LoadReal(udg_hs,5,77))
            set loopli=0
            loop
                exitwhen loopli==6
                call UnitShareVision(unitt,Player(loopli),true)
                set loopli=loopli+1
            endloop
            
            set li1=li1+1
        endloop
    set g=g-1
    set unitt=null
endfunction


function time1s takes nothing returns nothing
    set i=i+1
    if g>0 then
        call sys_cg()
    endif
endfunction

function xzndjsq takes nothing returns nothing
    if LoadBoolean(udg_hs,0,StringHash("已选择难度")) then//判断是否已选择难度
    else
    call DialogDisplay(Player(0),LoadDialogHandle(udg_hs,0,StringHash("选择难度对话框")),false)//取消显示对话框
    call DialogDestroy(LoadDialogHandle(udg_hs,0,StringHash("选择难度对话框")))//删除对话框
    call SetPlayerTechResearched(Player(11),'RA00',1)//默认难度
    //在这里设置默认难度
    //以下测试模式使用，实际需要在选择难度后再启动计时器
    call SaveTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口"),CreateTimerDialog(LoadTimerHandle(udg_hs,0,StringHash("出怪计时器"))))//保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs,0,StringHash("出怪计时器")),jsqjg,true,null)//启动计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")),true)//显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs,0,StringHash("出怪计时器窗口")),"第"+I2S(b+1)+"波")//设置计时器窗口标题
    //测试模式代码到此
    endif
endfunction

function time0_1 takes nothing returns nothing
    local timer lti=CreateTimer()
    local integer array li
    local dialog dhk
    local button an
    local string array str
    call TimerStart(lti,1,true, function time1s)//启动难度选择时限计时器



    set lti=null
    set dhk=DialogCreate()
    call DialogSetMessage(dhk,"选择难度")
    set li[0]=0
    set li[1]='1'
    set li[2]='2'
    set li[3]='3'
    set li[4]='4'
    set li[5]='5'
    call SaveDialogHandle(udg_hs,0,StringHash("选择难度对话框"),dhk)
    //创建对话框
    loop
        exitwhen li[0]==5
        set li[0]=li[0]+1
        set an=DialogAddButton(dhk,msgys("按下对应的数字选择难度( "+msgys(I2S(li[0]))+msgys(" )")),li[li[0]])
        call SaveInteger(udg_hs,0,H2I(an),li[0])
    endloop
    set an=null
    call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash("对话框")),dhk)
    call DialogDisplay(Player(0),dhk,true)//显示对话框给某个玩家，请及时修改
    set dhk=null
    call TimerStart(CreateTimer(),10,false,function xzndjsq)
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
        exitwhen li[0]==6//6个玩家
        set li[0]=li[0]+1
        set dhk=DialogCreate()
        call DialogSetMessage(dhk,"作弊菜单")
        call SaveDialogHandle(udg_hs,H2I(Player(li[0]-1)),StringHash("作弊对话框"),dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash(I2S(li[0])+"对话框")),dhk)
        set li[1]=0
        loop
            exitwhen li[1]==6//6个按钮
            set li[1]=li[1]+1
            set an=DialogAddButton(dhk,str[li[1]],0)
            call SaveInteger(udg_hs,0,H2I(an),li[1])
        endloop
        
        
    endloop

endfunction

function time0 takes nothing returns nothing
    local trigger tr=CreateTrigger()
    //逝去0秒
    call TriggerRegisterTimerEvent(tr,0,false)
    call TriggerAddAction(tr,function time0_1)
    set tr = null
endfunction

endlibrary
