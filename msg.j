

library libmsg

function msg takes integer v returns string
    if v==1 then
        return "|cffff0000【信息】|r"
    endif
    return ""
endfunction

endlibrary
