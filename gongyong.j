library libgy
    function jz_i2s takes integer inputi returns string
    //进制转换
    local integer tempi=inputi
    local string lr
    local string array lx
    local integer imin =1
    local integer imax =2
    local integer li1
    local string temps = "123456789ABCDEF0"
    loop
	    exitwhen imin>imax
	    set li1=ModuloInteger(tempi,16)
		    if (li1==0) then
			    set li1=16
    		endif
	    	set lx[imin]=SubString(temps, li1-1, li1)
    	set tempi=tempi/16	
	    set imin=imin+1
    endloop
    set lr = lx[2]+lx[1]
    return lr
    endfunction

    function msgys takes string xgstr returns string//附上随机颜色
        return "|cFF"+jz_i2s(GetRandomInt(0,255))+jz_i2s(GetRandomInt(0,255))+jz_i2s(GetRandomInt(0,255))+xgstr+"|r"
    endfunction

    function H2I takes handle h returns integer
        return GetHandleId(h)
    endfunction
endlibrary
