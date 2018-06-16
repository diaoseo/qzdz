library libhg

function hg takes unit hghero returns nothing
    //回城动作
    local real x=LoadReal(udg_hs,4,77)
    local real y=LoadReal(udg_hs,5,77)+128
    call SetUnitPosition(hghero,x,y)//传送
    set lgf[GetPlayerId(GetOwningPlayer(hghero))]=0//关闭练功房
    if GetOwningPlayer(hghero)==GetLocalPlayer() then//异步
        call SetCameraPosition(x,y)
        call ClearSelection()
        call SelectUnit(hghero,true)
    endif
endfunction

endlibrary
