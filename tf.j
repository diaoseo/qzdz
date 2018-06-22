
library libtf

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
        loop//初始化数组
            exitwhen jn[0]==14
            set jn[0]=jn[0]+1
            set jn[180+jn[0]]=jn[200+jn[0]]
        endloop
        set jn[0]=0
        loop//重新随机数组
            exitwhen jn[0]==14//14个技能
            set jn[0]=jn[0]+1//记录循环次数
            set jn[178]=GetRandomInt(1,15-jn[0])//获取一个随机数
            set jn[20*jn[179]+jn[0]]=jn[180+jn[178]]//重新分配数组
            set jn[177]=0//初始化重新入栈的数组
            loop//处理栈
                exitwhen jn[177]==15-jn[0]-jn[178]
                set jn[180+jn[178]+jn[177]]=jn[180+jn[178]+jn[177]+1]
                set jn[177]=jn[177]+1
            endloop
        endloop
        exitwhen jn[179]==5
        set jn[179]=jn[179]+1
    endloop

endfunction

endlibrary