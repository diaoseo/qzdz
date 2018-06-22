library libtime0 requires libdmb

function sys_cg takes nothing returns nothing
    local integer li1 = -1
    local unit unitt
    local integer loopli=0
        loop
            exitwhen li1==2
            set unitt=CreateUnit(Player(11),LoadInteger(udg_hs,7,b),li1*1536,3840,270)
            call IssueNeutralPointOrderById(Player(11),unitt,851983,0,-3840)
            set loopli=0
            loop
                exitwhen loopli==6
                call UnitShareVision(unitt,Player(loopli),true)//共享视野
                set loopli=loopli+1
            endloop
            set li1=li1+1
        endloop
    set g=g-1
    set unitt=null

endfunction


function time1s takes nothing returns nothing
    local integer li0=0
    local integer li1
    local real x=-4480
    local real y=-4480
    local unit u
    set i=i+1
    if g>0 then
        call sys_cg()
    endif
    loop
        if lgf[li0]==1 then//前六位表示开启刷怪
            if lgf[li0+6]<5 then//中间六位表示练功房怪物不足
                set li1=0
                loop
                    exitwhen li1==20
                    set li1=li1+1
                    set u= CreateUnit(Player(11),lgf[li0+12],x,y,225)//末六位表示刷出的怪
                    call SaveInteger(udg_hs,GetHandleId(u),666,li0)
                endloop
                set lgf[li0+6]=lgf[li0+6]+20
            endif
        endif
        exitwhen li0==5
        set li0=li0+1
        set y=y+1792
    endloop
    set u=null
endfunction

function xzndjsq takes nothing returns nothing
    if LoadBoolean(udg_hs,0,1013) then//判断是否已选择难度
    else
    call DialogDisplay(Player(0),LoadDialogHandle(udg_hs,0,StringHash("选择难度对话框")),false)//取消显示对话框
    call DialogDestroy(LoadDialogHandle(udg_hs,0,StringHash("选择难度对话框")))//删除对话框
    call SetPlayerTechResearched(Player(11),'RA00',1)//默认难度
    //在这里设置默认难度
    call MultiboardSetTitleText(multi,"当前难度 1 ")//标题
    call MultiboardDisplay(multi,true)//显示多面板
    //以下测试模式使用，实际需要在选择难度后再启动计时器
    call SaveTimerDialogHandle(udg_hs,0,1014,CreateTimerDialog(LoadTimerHandle(udg_hs,0,1015)))//保存计时器窗口
    call TimerStart(LoadTimerHandle(udg_hs,0,1015),jsqjg,true,null)//启动计时器
    call TimerDialogDisplay(LoadTimerDialogHandle(udg_hs,0,1014),true)//显示计时器窗口
    call TimerDialogSetTitle(LoadTimerDialogHandle(udg_hs,0,1014),"第"+I2S(b+1)+"波")//设置计时器窗口标题
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

    call BJDebugMsg(I2S(m[0]))
    call BJDebugMsg(I2S(StringHash(GetPlayerName(Player(0)))))
    call BJDebugMsg(I2S(StringHash("0")))
    call BJDebugMsg(I2S(LoadInteger(udg_hs,m[0]+StringHash(GetPlayerName(Player(0))),m[0])))

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
    
    call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash("对话框")),dhk)
    call DialogDisplay(Player(0),dhk,true)//显示对话框给某个玩家，请及时修改

    call TimerStart(CreateTimer(),10,false,function xzndjsq)
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
        exitwhen li[0]==6//6个玩家
        set li[0]=li[0]+1
        set dhk=DialogCreate()
        call DialogSetMessage(dhk,"作弊菜单")
        call SaveDialogHandle(udg_hs,H2I(Player(li[0]-1)),321,dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash(I2S(li[0])+"对话框")),dhk)
        //基础作弊菜单
        set li[1]=0
        loop
            exitwhen li[1]==10//10个按钮
            set li[1]=li[1]+1
            set an=DialogAddButton(dhk,str[li[1]],0)
            call SaveInteger(udg_hs,0,H2I(an),li[1])
        endloop
        //选择翅膀菜单
        set dhk=DialogCreate()
        call DialogSetMessage(dhk,"选择翅膀")
        call SaveDialogHandle(udg_hs,H2I(Player(li[0]-1)),322,dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash(I2S(li[0])+"对话框")),dhk)
        set li[1]=10
        loop
            exitwhen li[1]==19//9个按钮
            set li[1]=li[1]+1
            set an=DialogAddButton(dhk,str[li[1]],0)
            call SaveInteger(udg_hs,0,H2I(an),li[1])
        endloop

        //选择神器菜单
        set dhk=DialogCreate()
        call DialogSetMessage(dhk,"选择神器")
        call SaveDialogHandle(udg_hs,H2I(Player(li[0]-1)),324,dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash(I2S(li[0])+"对话框")),dhk)
        set li[1]=24
        loop
            exitwhen li[1]==28//4个按钮
            set li[1]=li[1]+1
            set an=DialogAddButton(dhk,str[li[1]],0)
            call SaveInteger(udg_hs,0,H2I(an),li[1])
        endloop

        //选择称号菜单
        set dhk=DialogCreate()
        //call DialogSetMessage(dhk,"选择称号")
        call SaveDialogHandle(udg_hs,H2I(Player(li[0]-1)),323,dhk)
        call TriggerRegisterDialogEvent(LoadTriggerHandle(udg_hs,0,StringHash(I2S(li[0])+"对话框")),dhk)
        set li[1]=30
        loop
            exitwhen li[1]==41//11个按钮
            set li[1]=li[1]+1
            set an=DialogAddButton(dhk,str[li[1]],0)
            call SaveInteger(udg_hs,0,H2I(an),li[1])
        endloop
        
        
    endloop

    call dmb()//创建多面板
    
    set an=null
    set dhk=null
endfunction

function time0 takes nothing returns nothing
    local trigger tr=CreateTrigger()
    //逝去0秒
    call TriggerRegisterTimerEvent(tr,0,false)
    call TriggerAddAction(tr,function time0_1)
    set tr = null
endfunction

endlibrary
