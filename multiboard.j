
library libdmb

function dmb takes nothing returns nothing
    local integer array li
    local string array st
    set multi=CreateMultiboard()
    call MultiboardSetColumnCount(multi,7)
    call MultiboardSetRowCount(multi,7)
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


    call MultiboardSetItemsWidth(multi,0.03)//所有项目宽度
    call MultiboardSetItemsStyle(multi,true,false)//所有项目风格
    loop
        loop
            set multiitem[li[1]*7+li[2]]=MultiboardGetItem(multi,li[1],li[2])//绑定多面板项目
            call MultiboardSetItemValueColor(multiitem[li[1]*7+li[2]],li[li[1]+7],li[li[1]+14],li[li[1]+21],255)//设置项目颜色，红，绿，蓝，透明
            if li[1]==6 then
                call MultiboardSetItemValue(multiitem[li[1]*7+li[2]],st[li[2]])
            endif
            exitwhen li[2]==6
            set li[2]=li[2]+1
        endloop
        exitwhen li[1]==6
        set li[1]=li[1]+1
        set li[2]=0
    endloop
endfunction

endlibrary
