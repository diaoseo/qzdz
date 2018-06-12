 <?
local slk = require 'slk'
local s='123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0'
local y
local changeu = function (value)--生成单位，首字母小写
    local z = value
    local res=''
    local y
            for n = 0,3 do
                y=math.floor((z%36)+0.5)
                z=math.floor(z/36)
                if y==0 then y=36 end
                    if n==3 then
                        res=string.lower(string.sub(s,y,y))..res
                    else
                        res=string.sub(s,y,y)..res
                    end
            end
    return res
end

local change = function (value)--生成物编一切除单位，首字母大写
local z = value
local res=''
local y
    for n = 0,3 do
        y=math.floor((z%36)+0.5)
        z=math.floor(z/36)
        if y==0 then y=36 end
        res=string.sub(s,y,y)..res
    end
return res
end

local sj=function(x)--随机颜色代码
local lst=''
math.randomseed(x)
for i=1,3 do
lst=lst..string.sub(string.format("%#x",tostring(math.random(16,255))),3)
end
return lst
end

local autoys=function(x,v,s)
if v==1 then return '|cfff00000'..s..'|r' end
if v==2 then return '|cff0000ff'..s..'|r' end
if v==3 then return '|c000eeeee'..s..'|r' end
if v==4 then return '|c77700077'..s..'|r' end
if v==5 then return '|cffffff00'..s..'|r' end
if v==6 then return '|cfff77700'..s..'|r' end
if v==7 then return '|c000eee00'..s..'|r' end
if v==8 then return '|cfff222ff'..s..'|r' end
if v==9 then return '|c88888888'..s..'|r' end
if v==10 then return '|c777dddff'..s..'|r' end
if v==11 then return '|c00077766'..s..'|r' end
if v==12 then return '|c44400000'..s..'|r' end
return'|cff'..sj(x)..s..'|r'
end

?>

//导入其他J文件
#include "gongyong.j"
#include "selecthero.j"
#include "input.j"
#include "fuhuo.j"
#include "time0.j"
#include "chuguai.j"
#include "choicelv.j"
#include "getitem.j"
#include "list.j"
#include "hg.j"
#include "ajidi.j"
#include "msg.j"
#include "yg.j"
#include "kj.j"
#include "beigongji.j"
#include "death.j"
#include "skill.j"
#include "cf.j"

//导入完毕
library csh initializer init requires libselecthero libinput libfuhuo libtime0 libchuguai libyg libbgj libdeath libskill
globals
//                   _ooOoo_ 
//                  o8888888o 
//                  88" . "88 
//                  (| -_- |) 
//                  O\  =  /O 
//               ____/`---'\____ 
//             .'  \\|     |//  `. 
//            /  \\|||  :  |||//  \ 
//           /  _||||| -:- |||||-  \ 
//           |   | \\\  -  /// |   | 
//           | \_|  ''\---/''  |   | 
//           \  .-\__  `-`  ___/-. / 
//         ___`. .'  /--.--\  `. . __ 
//      ."" '<  `.___\_<|>_/___.'  >'"". 
//     | | :  `- \`.;`\ _ /`;.`/ - ` : | | 
//     \  \ `-.   \_ __\ /__ _/   .-` /  / 
//======`-.____`-.___\_____/___.-`____.-'====== 
//                   `=---=' 
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
//            佛祖保佑       永无BUG 
//掩耳盗铃 佛祖并不会保佑你永无BUG 都是你自己产生的
//改图可耻
    integer i=0//游戏逝去秒数
    integer b=0//记录游戏第几波
    integer g=0//用来设置每波多少个怪
    real jsqjg=20//默认计时器间隔
endglobals

    function itemreg takes integer id1,integer n1,integer id2,integer n2,integer id3,integer n3,integer id4,integer n4,integer id5,integer n5,integer id6,integer n6,integer id7 ,integer n7,boolean bo returns nothing
    local integer array id
    set id[0]=6
    set id[1]=id1
    set id[2]=id2
    set id[3]=id3
    set id[4]=id4
    set id[5]=id5
    set id[6]=id6
    set id[7]=n1
    set id[8]=n2
    set id[9]=n3
    set id[10]=n4
    set id[11]=n5
    set id[12]=n6
    call SaveInteger(udg_hs,id1,20,id7)//第一个参数要强化的装备，第二个固定参数，第三个要给予的结果
    loop
        set id[0]=id[0]+1
        call SaveInteger(udg_hs,id[id[0]-5],0,n7)//合成所需材料数量
        call SaveInteger(udg_hs,id[id[0]-5],1,id1)//合成的主线装备
        if n1!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],1,id1)//合成的材料
        endif
        if n2!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],2,id2)//合成的材料
        endif
        if n3!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],3,id3)//合成的材料
        endif
        if n4!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],4,id4)//合成的材料
        endif
        if n5!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],5,id5)//合成的材料
        endif
        if n6!=0 then
            call SaveInteger(udg_hs,id[id[0]-5],6,id6)//合成的材料
        endif
        call SaveBoolean(udg_hs,id[id[0]-5],10,bo)//属于强化
        exitwhen id[id[0]]==0
    endloop
    endfunction

    function LUAcreateunit takes nothing returns nothing
    local unit unitt
    local integer loopli =0
    local trigger ttt
    //初始化函数
    set udg_hs=InitHashtable()
    <?
    --坐标系统
    --1bx
    --2by
    --3bf
    --4px
    --5py
    --6pf
    local bossx={-4480,-4480,-4480,-4480,-4480,-4480,4992,4992,4992,4992,4992,4992,-9216,-6656,-6656,-9216,6656,9216,9216,6656,6656,9216,9216,6656,-9216,-6656,-6656,-9216,-7552,-7552,-7552,-7552,-7040,-7552,-9344,-9344,-9344,-9344,-8832,-9344,-4480,-2688,-896,896,2688,4480,-4480,-2688,-896,896,2688,4480,7552,7552,7552,7552,7552,7552,9344,9344,9344,9344,9344,9344,4480,2688,896,-896,-2688,-4480,4480,2688,896,-896,-2688,-4480,0,-2560}
    local bossy={-4480,-2688,-896,896,2688,4480,-4480,-2688,-896,896,2688,4480,9216,9216,6656,6656,9216,9216,6656,6656,-6656,-6656,-9216,-9216,-6656,-6656,-9216,-9216,-4480,-2688,-896,896,2688,4480,-4480,-2688,-896,896,2688,4480,7552,7552,7552,7552,7552,7552,9344,9344,9344,9344,9344,9344,4480,2688,896,-896,-2688,-4480,4480,2688,896,-896,-2688,-4480,-7552,-7552,-7552,-7552,-7552,-7552,-9344,-9344,-9344,-9344,-9344,-9344,3840,0}
    local bossface={225,225,225,225,225,225,180,180,180,180,180,180,315,225,135,45,315,225,135,45,315,225,135,45,315,225,135,45,0,0,0,0,0,0,0,0,0,0,0,0,270,270,270,270,270,270,270,270,270,270,270,270,180,180,180,180,180,180,180,180,180,180,180,180,90,90,90,90,90,90,90,90,90,90,90,90,270,270}
    local playx={-4992,-4992,-4992,-4992,-4992,-4992,3968,3968,3968,3968,3968,3968,-7936,-7936,-7936,-7936,7936,7936,7936,7936,7936,7936,7936,7936,-7936,-7936,-7936,-7936,-6528,-6528,-6528,-6528,-6528,-6528,-8320,-8320,-8320,-8320,-8320,-8320,-4480,-2688,-896,896,2688,4480,-4480,-2688,-896,896,2688,4480,6528,6528,6528,6528,6528,6528,8320,8320,8320,8320,8320,8320,4480,2688,896,-896,-2688,-4480,4480,2688,896,-896,-2688,-4480,0,-2560}
    local playy={-4992,-3200,-1408,384,2176,3968,-4480,-2688,-896,896,2688,4480,7936,7936,7936,7936,7936,7936,7936,7936,-7936,-7936,-7936,-7936,-7936,-7936,-7936,-7936,-4480,-2688,-896,896,2688,4480,-4480,-2688,-896,896,2688,4480,6528,6528,6528,6528,6528,6528,8320,8320,8320,8320,8320,8320,4480,2688,896,-896,-2688,-4480,4480,2688,896,-896,-2688,-4480,-6528,-6528,-6528,-6528,-6528,-6528,-8320,-8320,-8320,-8320,-8320,-8320,-3840,0}
    local playface={45,45,45,45,45,45,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,180,180,180,180,180,180,180,180,180,180,180,180,90,90,90,90,90,90,90,90,90,90,90,90,0,0,0,0,0,0,0,0,0,0,0,0,270,270,270,270,270,270,270,270,270,270,270,270,90,270}
    --以上是坐标系统
    --以下是传送书
    local uid=852767
    local itemname={'传送到坐标1','传送到坐标2','传送到坐标3','传送到坐标4','传送到坐标5','传送到坐标6','传送到坐标7','传送到坐标8','传送到坐标9','传送到坐标10','传送到坐标11','传送到坐标12','圣兽岛','传送到坐标14','传送到坐标15','传送到坐标16','圣兽魂谷','传送到坐标18','传送到坐标19','传送到坐标20','龙渊泽','传送到坐标22','传送到坐标23','传送到坐标24','熔岩穴','传送到坐标26','传送到坐标27','传送到坐标28','暗夜洞穴','雪域宫','蛇龙巢穴','哀嚎洞穴','日轮山','怒焰谷','秘境','传送到坐标36','传送到坐标37','传送到坐标38','斗者结晶','将魂-赵云','将魂-吕布','将魂-黄忠','将魂-诸葛亮','将魂-黄月英','传送到坐标45','传送到坐标46','传送到坐标47','传送到坐标48','传送到坐标49','传送到坐标50','传送到坐标51','传送到坐标52','传送到坐标53','传送到坐标54','传送到坐标55','传送到坐标56','传送到坐标57','传送到坐标58','传送到坐标59','传送到坐标60','传送到坐标61','传送到坐标62','传送到坐标63','传送到坐标64','传送到坐标65','传送到坐标66','传送到坐标67','传送到坐标68','传送到坐标69','传送到坐标70','传送到坐标71','传送到坐标72','传送到坐标73','传送到坐标74','传送到坐标75','传送到坐标76','传送到坐标77','传送到坐标78'}
    local itemuber={'练功房，提升实力与获取经济的绝佳场所。','练功房，提升实力与获取经济的绝佳场所。','练功房，提升实力与获取经济的绝佳场所。','练功房，提升实力与获取经济的绝佳场所。','练功房，提升实力与获取经济的绝佳场所。','练功房，提升实力与获取经济的绝佳场所。','进阶房，提升斗者阶数的场所','进阶房，提升斗者阶数的场所','进阶房，提升斗者阶数的场所','进阶房，提升斗者阶数的场所','进阶房，提升斗者阶数的场所','进阶房，提升斗者阶数的场所','住着四大圣兽BOSS，可掉落对应护符','住着四大圣兽BOSS，可掉落对应护符','住着四大圣兽BOSS，可掉落对应护符','住着四大圣兽BOSS，可掉落对应护符','此地遗留着四大圣兽的魂魄，相传魂魄可以激活圣兽护符中的独特属性','此地遗留着四大圣兽的魂魄，相传魂魄可以激活圣兽护符中的独特属性','此地遗留着四大圣兽的魂魄，相传魂魄可以激活圣兽护符中的独特属性','此地遗留着四大圣兽的魂魄，相传魂魄可以激活圣兽护符中的独特属性','有四条古龙坐镇，打败会获取龙的鳞甲与龙的利爪','有四条古龙坐镇，打败会获取龙的鳞甲与龙的利爪','有四条古龙坐镇，打败会获取龙的鳞甲与龙的利爪','有四条古龙坐镇，打败会获取龙的鳞甲与龙的利爪','有着被熔岩融化变异过的四大BOSS，击败可掉落合成斗者项链的碎片','有着被熔岩融化变异过的四大BOSS，击败可掉落合成斗者项链的碎片','有着被熔岩融化变异过的四大BOSS，击败可掉落合成斗者项链的碎片','有着被熔岩融化变异过的四大BOSS，击败可掉落合成斗者项链的碎片','击杀BOSS暗夜之蛛可爆出暗夜蛛丝与锐利蛛尖以及蜘蛛之血','击杀BOSS极寒幽魂可爆出黯淡的斗者意志（80%几率）和绚丽的斗者意志（20%几率）','击杀BOSS极阴烈水龙蛇可爆出蛇龙皮与蛇龙尖牙以及蛇龙胆','击败团队BOSS哀嚎洞穴，掉落斗者结晶，全队斗者都能获得','击败日轮山泉元素，10%几率掉落日落山泉','击败怒焰裂谷BOSS，掉落装备怒焰护手','杀死秘境BOSS九天鬼虫，可以掉落任何装备（宝器与神器装备除外）','击败异世的自己，属性为自身5倍；可获得属性提升','1000级玩家且斗者6阶可进入（入了魔的不可在进入）；成为神斗士，获得属性提升并且获得技能修身之体','1000级玩家且斗者6阶可进入（入了魔的不可在进入）；成为魔斗士，获得属性提升并且获得技能修身之体','获得斗者结晶的主要场所（击杀者几率获得）','挑战将魂-赵云，击败有几率获得将魂对应属性提升并解锁对应将魂塔','挑战将魂-吕布，击败有几率获得将魂对应属性提升并解锁对应将魂塔','挑战将魂-黄忠，击败有几率获得将魂对应属性提升并解锁对应将魂塔','挑战将魂-诸葛亮，击败有几率获得将魂对应属性提升并解锁对应将魂塔','挑战将魂-黄月英，击败有几率获得将魂对应属性提升并解锁对应将魂塔','','','进入竞技场，每一关都拥有BOSS，挑战关卡BOSS成功后，获得竞技场宝箱，可开出宝器或神器','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}
    local itemart={'ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCOP.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNCoralBed.blp','ReplaceableTextures\\CommandButtons\\BTNDestroyer.blp','ReplaceableTextures\\CommandButtons\\BTNDestroyer.blp','ReplaceableTextures\\CommandButtons\\BTNDestroyer.blp','ReplaceableTextures\\CommandButtons\\BTNDestroyer.blp','ReplaceableTextures\\CommandButtons\\BTNDemonGate.blp','ReplaceableTextures\\CommandButtons\\BTNDemonGate.blp','ReplaceableTextures\\CommandButtons\\BTNDemonGate.blp','ReplaceableTextures\\CommandButtons\\BTNDemonGate.blp','ReplaceableTextures\\CommandButtons\\BTNFrostWyrm.blp','ReplaceableTextures\\CommandButtons\\BTNFrostWyrm.blp','ReplaceableTextures\\CommandButtons\\BTNFrostWyrm.blp','ReplaceableTextures\\CommandButtons\\BTNFrostWyrm.blp','ReplaceableTextures\\CommandButtons\\BTNDarkPortal.blp','ReplaceableTextures\\CommandButtons\\BTNDarkPortal.blp','ReplaceableTextures\\CommandButtons\\BTNDarkPortal.blp','ReplaceableTextures\\CommandButtons\\BTNDarkPortal.blp','ReplaceableTextures\\CommandButtons\\BTNNerubianQueen.blp','ReplaceableTextures\\CommandButtons\\BTNRune.blp','ReplaceableTextures\\CommandButtons\\BTNGreenHydra.blp','ReplaceableTextures\\CommandButtons\\BTNKobold.blp','ReplaceableTextures\\CommandButtons\\BTNSeaElemental.blp','ReplaceableTextures\\CommandButtons\\BTNBoneChimes.blp','ReplaceableTextures\\CommandButtons\\BTNNecropolis.blp','ReplaceableTextures\\CommandButtons\\BTNSpawningGrounds.blp','ReplaceableTextures\\CommandButtons\\BTNMedivh.blp','ReplaceableTextures\\CommandButtons\\BTNManaShield.blp','ReplaceableTextures\\CommandButtons\\BTNMammoth.blp','ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp','ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp','ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp','ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp','ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp','','','ReplaceableTextures\\CommandButtons\\BTNSacrificialPit.blp','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}
    for zb=1,78 do
    local ad=slk.item.ches:new(change(uid+zb))
    ad.name=autoys(zb,0,itemname[zb])
    ad.class='PowerUp'
    ad.Art=itemart[zb]
    --ad.Description=itemdes[zb]
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=1
    ad.Tip=autoys(zb,0,itemname[zb])
    ad.Ubertip=autoys(zb,0,itemuber[zb])

    ?>
        call SaveReal(udg_hs,1,<?=zb?>,<?=bossx[zb]?>)
        call SaveReal(udg_hs,2,<?=zb?>,<?=bossy[zb]?>)
        call SaveReal(udg_hs,3,<?=zb?>,<?=bossface[zb]?>)
        call SaveReal(udg_hs,4,<?=zb?>,<?=playx[zb]?>)
        call SaveReal(udg_hs,5,<?=zb?>,<?=playy[zb]?>)
        call SaveReal(udg_hs,6,<?=zb?>,<?=playface[zb]?>)
        call SaveInteger(udg_hs,10,'<?=ad.get_id()?>',<?=zb?>)
        call CreateItem('<?=ad.get_id()?>',<?=(-39+zb)*32?>,1280)
    <?
    end


    --以下创建进攻的敌人
    local dqunit={slk.unit.hfoo,slk.unit.hrif,slk.unit.ogru,slk.unit.otau,slk.unit.ugho,slk.unit.edoc,slk.unit.nmpe,slk.unit.hkni,slk.unit.hgyr,slk.unit.nnsw,slk.unit.nanm,slk.unit.emtg,slk.unit.nbds,slk.unit.nsc3,slk.unit.hspt,slk.unit.ndrh,slk.unit.okod,slk.unit.nnrg,slk.unit.ndqn,slk.unit.uabo,slk.unit.hmtt,slk.unit.nsln,slk.unit.nsth,slk.unit.otbr,slk.unit.nsqo,slk.unit.nslh,slk.unit.hdhw,slk.unit.nlrv,slk.unit.nfpu,slk.unit.nowk,slk.unit.orai,slk.unit.nogl,slk.unit.nnwl,slk.unit.oshm,slk.unit.ebal,slk.unit.ufro}
    local sh={75,100,130,170,220,290,380,490,640,830,1080,1400,1800,2300,3000,3900,5100,6600,8600,11200,15000,20000,26000,34000,44000,57000,74000,96000,125000,160000,210000,270000,350000,460000,600000,780000}
    local cool={1.600 ,1.103 ,1.020 ,0.949 ,0.887 ,0.833 ,0.785 ,0.742 ,0.704 ,0.670 ,0.639 ,0.611 ,0.585 ,0.562 ,0.540 ,0.520 ,0.501 ,0.484 ,0.468 ,0.453 ,0.439 ,0.426 ,0.414 ,0.402 ,0.391 ,0.381 ,0.371 ,0.362 ,0.353 ,0.345 ,0.337 ,0.330 ,0.322 ,0.315 ,0.309 ,0.303 }
    local hp={500,675,900,1200,1700,2200,3000,4100,5500,7400,10100,13600,18300,24700,33400,45100,60900,82200,110900,149700,202100,272900,368400,497300,671400,906400,1223600,1651900,2230100,3010600,4064300,5486800,7407100,9999600,13499500,18224000}
    local dmgup={18,25,32,42,55,72,95,122,160,207,270,350,450,575,750,975,1275,1650,2150,2800,3750,5000,6500,8500,11000,14250,18500,24000,31250,40000,52500,67500,87500,115000,150000,195000}
    local def={8,10,12,15,18,22,27,33,41,51,63,78,97,120,150,190,240,300,380,480,600,750,940,1180,1480,1850,2310,2890,3610,4510,5640,7050,8810,11010,13760,17200}
    local defup={2,2,3,3,4,5,6,8,10,12,15,19,24,30,37,47,60,75,95,120,150,187,235,295,370,462,577,722,902,1127,1410,1762,2202,2752,3440,4300}
    local uid=1412639
    local id=0
    for x=1,35 do
        local ad = slk.unit.nfbr:new(changeu(uid+x))
        ad.name='第'..tostring(x)..'次进攻'--名字
        ad.file=dqunit[x].file--模型
        ad.Art=dqunit[x].Art--图标
        ad.spd=280--移动速度
        ad.minSpd=230--最小移动速度
        ad.acquire=dqunit[x].acquire--最主动攻击范围
        ad.collision=32--大小
        ad.abilList=''--技能
        ad.dmgplus1=sh[x]--基础伤害
        ad.dmgUp1=dmgup[x]--伤害升级
        ad.sides1=1--骰子面数，不需要修改
        ad.dice1=1--骰子数量，不需要修改
        ad.cool1=cool[x]--攻击间隔
        ad.weapsOn=1--武器允许
        ad.race='undead'--种族
        ad.HP=hp[x]--HP
        ad.canFlee=0--不可逃跑
        ad.unitSound=dqunit[x].unitSound--单位声音
        ad.rangeN1=dqunit[x].rangeN1--攻击范围
        ad.Missileart=dqunit[x].Missileart--投射物图像
        ad.Missilespeed=dqunit[x].Missilespeed--投射物速率
        ad.atkType1='pierce'--攻击类型
        ad.Missilearc=dqunit[x].Missilearc--投射物弧度
        ad.weapTp1=dqunit[x].weapTp1--武器类型
        ad.def=def[x]--基础护甲
        ad.defUp=defup[x]--护甲升级
        ad.upgrades='RA00'--难度科技
        ?>
        call SaveInteger(udg_hs,7,<?=x?>,'<?=ad:get_id()?>')
        <?
    end

    local jbid={slk.unit.Ulic,slk.unit.Ogld,slk.unit.Ubal,slk.unit.Nman,slk.unit.Nklj}
    local jbname={'进攻BOSS1','进攻BOSS2','进攻BOSS3','进攻BOSS4','进攻BOSS5'}
    local jbcw={'冰雪之王','幽冥老妖','青雷魔王','玄天魔眼','天狱之王'}
    local jbtsw={'Abilities\\Weapons\\LichMissile\\LichMissile.mdl','Abilities\\Weapons\\SerpentWardMissile\\SerpentWardMissile.mdl','','','Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl'}
    local jbmods={'units\\undead\\HeroLich\\HeroLich','units\\orc\\OrcWarlockGuldan\\OrcWarlockGuldan','units\\undead\\Tichondrius\\Tichondrius','units\\demon\\Mannoroth\\Mannoroth','units\\demon\\Kiljaeden\\Kiljaeden'}
    uid=1414331
    for x=1,5 do
    local ad=jbid[x]:new(change(uid+x))
    ad.Name=jbname[x]
    ad.baneCount=1--称谓数量
    ad.Propernames=jbcw[x]--称谓
    ad.file=jbmods[x]
    ad.Missileart=jbtsw[x]
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList='AInv'--技能后期再输入
    ad.heroAbilList=''--英雄技能
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ?>
    call SaveInteger(udg_hs,13,<?=x?>,'<?=ad.get_id()?>')
    <?
    end

    --以下创建最终BOSS
    local ad=slk.unit.Otch:new('UBB5')
    ad.Name='终极BOSS'
    ad.baneCount=1--称谓数量
    ad.Propernames='萨格拉斯'--称谓
    ad.file='mods\\boss\\boss_7\\boss_7.mdx'
    ad.Missileart=''--投射物
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList='AInv'--技能后期再输入
    ad.heroAbilList=''--英雄技能
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ?>
    call SaveInteger(udg_hs,13,6,'UBB5')
    <?
    --以下创建英雄
    local htx={"ReplaceableTextures\\CommandButtons\\BTN_hero_bfcqb.tga","ReplaceableTextures\\CommandButtons\\BTNHeroMountainKing.blp","ReplaceableTextures\\CommandButtons\\BTN_hero_kn.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_dz.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_gzs.tga","ReplaceableTextures\\CommandButtons\\BTNHeroFarseer.blp","ReplaceableTextures\\CommandButtons\\BTN_hero_lbz.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_yql.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_bfz.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_hyss.tga","ReplaceableTextures\\CommandButtons\\BTNChaosGrom.blp","ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince.blp","ReplaceableTextures\\CommandButtons\\BTN_hero_saber.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_hzd.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_ywz.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_sr.tga","ReplaceableTextures\\CommandButtons\\BTN_hero_sdmss.tga"}
    local hmods={'mods\\hero\\hero_3\\hero_3.mdx','units\\human\\HeroMountainKing\\HeroMountainKing','mods\\hero\\hero_5\\hero_5.mdx','mods\\hero\\hero_6\\hero_6.mdx','mods\\hero\\hero_7\\hero_7.mdx','units\\orc\\HeroFarSeer\\HeroFarSeer','mods\\hero\\hero_9\\hero_9.mdx','mods\\hero\\hero_10\\hero_10.mdx','mods\\hero\\hero_11\\hero_11.mdx','mods\\hero\\hero_12\\hero_12.mdx','units\\demon\\ChaosHellscream\\ChaosHellscream','units\\human\\HeroBloodElf\\HeroBloodElf','mods\\hero\\hero_15\\hero_15.mdx','mods\\hero\\hero_16\\hero_16.mdx','mods\\hero\\hero_17\\hero_17.mdx','mods\\hero\\hero_18\\hero_18.mdx','mods\\hero\\hero_19\\hero_19.mdx'}
    local obj={slk.unit.Hpal,slk.unit.Hmkg,slk.unit.Otch,slk.unit.Obla,slk.unit.Hart,slk.unit.Ofar,slk.unit.Emoo,slk.unit.Nsjs,slk.unit.Oshd,slk.unit.Hvwd,slk.unit.Opgh,slk.unit.Hblm,slk.unit.Ewar,slk.unit.Ewar,slk.unit.Ewar,slk.unit.Ewrd,slk.unit.Ulic}
    local herox={-1280,-768,-256,256,768,1280,-1280,-768,-256,256,768,1280,-1280,-768,-256,256,768}
    local heroy={0,0,0,0,0,0,-512,-512,-512,-512,-512,-512,-1024,-1024,-1024,-1024,-1024}
    local hname={'暴风城骑兵','雷神之子','狂牛','盗者','诡阵术','先知','猎捕者','玉麒麟','兵符者','黑岩射手','斧王','焰火斗者','saber','JK','影舞者','狩人','神代魔术师'}
    local hcw={'凯盾','帕修斯','蛮三','阿刀','无名','萨满','卡莎','糯米','昂','黑衣麻陶','十元','唐水水','潘德拉贡','黑贞德','赤瞳','艾斯德斯','美狄亚'}
    local hstr={96,100,112,60,80,60,50,84,72,60,78,60,108,66,120,130,70}
    local hagi={56,32,44,96,40,48,108,66,72,120,90,60,90,138,210,150,110}
    local hint={48,68,44,44,80,92,42,66,72,36,48,150,72,66,90,140,240}
    local hstrp={14.4,15,18,9,12,9,7.5,12.6,10.8,9,11.7,9,14.4,9.9,18,19.5,10.5}
    local hagip={8.4,4.8,6.6,14.4,6,7.2,16.2,9.9,10.8,18,13.5,9,13.5,20.7,31.5,22.5,16.5}
    local hintp={7.2,10.2,6.6,6.6,12,13.8,6.3,9.9,10.8,5.4,7.2,22.5,10.8,9.9,13.5,21,36}
    local hspd={280,280,280,280,280,280,280,295,295,295,295,295,310,310,310,310,310}
    local hmiss={"","","","","","Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl","Abilities\\Weapons\\MoonPriestessMissile\\MoonPriestessMissile.mdl","","Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl","Abilities\\Weapons\\MoonPriestessMissile\\MoonPriestessMissile.mdl","","Abilities\\Weapons\\BloodElfMissile\\BloodElfMissile.mdl","","","","","Abilities\\Weapons\\DruidoftheTalonMissile\\DruidoftheTalonMissile.mdl"}
    local qxw={1,1,1,1,1,1,1,2,3,4,5,11,12,13,21,22,23}
    local hskill={'AInv,A01H,A01I,A000,A00G,A00H,A00I,A00J','AInv,A01H,A01I,A000,A00G,A00H,A00K,A00L','AInv,A01H,A01I,A000,A00G,A00H,A00M,A00N','AInv,A01H,A01I,A000,A00G,A00H,A00O,A00P','AInv,A01H,A01I,A000,A00G,A00H,A00Q,A00R,A00S','AInv,A01H,A01I,A000,A00G,A00H,A00T,A00U','AInv,A01H,A01I,A000,A00G,A00H,A00V,A00W','AInv,A01H,A01I,A000,A00G,A00H,A00X,A00Y','AInv,A01H,A01I,A000,A00G,A00H,A00Z,A010','AInv,A01H,A01I,A000,A00G,A00H,A011,A012','AInv,A01H,A01I,A000,A00G,A00H,A013,A014','AInv,A01H,A01I,A000,A00G,A00H,A015,A016','AInv,A01H,A01I,A000,A00G,A00H,A017,A018','AInv,A01H,A01I,A000,A00G,A00H,A019,A01A','AInv,A01H,A01I,A000,A00G,A00H,A01B,A01C','AInv,A01H,A01I,A000,A00G,A00H,A01D,A01E','AInv,A01H,A01I,A000,A00G,A00H,A01F,A01G'}
    local uid=806111
    for x=1,17 do
    local ad=obj[x]:new(change(uid+x))
    ad.Name=hname[x]--名字
    ad.baneCount=1--称谓数量
    ad.Propernames=hcw[x]--称谓
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='human'--统一人族
    ad.abilList=hskill[x]
    ad.heroAbilList=''--英雄技能，因为并没有英雄技能
    ad.upgrades=''--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ad.spd=hspd[x]--移动速度
    ad.STR=hstr[x]--力量
    ad.AGI=hagi[x]--敏捷
    ad.INT=hint[x]--智力
    ad.STRplus=hstrp[x]--力量升级
    ad.AGIplus=hagip[x]--敏捷升级
    ad.INTplus=hintp[x]--智力升级
    ad.Missileart=hmiss[x]--投射物图像
    ad.Art=htx[x]
    ad.file=hmods[x]
    --TODO模型，攻击类型，护甲类型
    ?>
    call SaveInteger(udg_hs,9,'<?=ad.get_id()?>',<?=qxw[x]?>)//最后用权限来代替
    set unitt= CreateUnit(Player(15),'<?=ad.get_id()?>',<?=herox[x]?>,<?=heroy[x]?>,270)//创建可选择英雄
    call SetUnitInvulnerable(unitt,true)//设置无敌
    call SaveUnitHandle(udg_hs,8,<?=x?>,unitt)//保存到哈希表
    set loopli=0
    loop
        exitwhen loopli==6
        call UnitShareVision(unitt,Player(loopli),true)//共享视野
        set loopli=loopli+1
    endloop

    <?
    end
    ?>
    set unitt=null
    call SaveTimerHandle(udg_hs,0,StringHash("出怪计时器"),CreateTimer())//保存出怪计时器
    call SavePlayerHandle(udg_hs,0,StringHash("出怪玩家"),Player(11))//保存出怪玩家，不过好像没啥用了

    <?
    --创建作弊菜单
    uid=807407
    local cdname={'双击打开作弊菜单','单击我回城'}
    local yjkj={'RA01',''}
    for id=1,2 do
    local ad=slk.unit.nfbr:new(change(uid+id))
    ad.name=cdname[id]
    ad.abilList=''
    ad.Propernames=cdname[id]--称谓
    ad.race='human'
    ad.movetp='fly'
    ad.unitShadow=''
    ad.file=''
    ad.unitShadow=''
    ad.Researches=yjkj[id]
    end

    local ad=slk.unit.nfbr:new(changeu(809999))--创建一个基地
    ad.name='助手'
    ad.race='human'
    ad.spd=522
    ad.abilList='AInv'
    ad.movetp='fly'
    ad.type='peon'

    local ad=slk.unit.nfbr:new(changeu(808704))--创建一个基地
    ad.name='你的基地'
    ad.race='human'
    ad.spd=0
    ad.HP=5000
    ad.upgrades='RA01'
    ?>
    set unitt= CreateUnit(Player(6),'<?=ad.get_id()?>',0,-3840,90)//创建基地
    call SaveUnitHandle(udg_hs,0,StringHash("基地"),unitt)
    <?

    uid=808704
    local npcx={253,-256,768,-768,1280,-1280,1792,-1792,}
    local npcname={'新手商店','副本','将魂','异域','荣誉殿','专属装备','翅膀','成就兑换',}
    local npcfm={'IB00,IB1D,IB2C,IB3U,IB3V,IB3W,IB3X','IA0C,IA0G,IA0K,IA0O,IA0S,IA0T,IA0U,IA0V,IA0X,IA0W','IA13,IA14,IA15,IA16,IA17','IA0Y','','','',''}
    --创建NPC
    for x=1,8 do
    local ad=slk.unit.nfbr:new(changeu(uid+x))
    ad.name=autoys(x,0,npcname[x])
    ad.race='human'
    ad.isbldg=1
    ad.spd=0
    ad.abilList='Aneu,Apit'
    ad.Sellitems=npcfm[x]
    ?>
    set unitt= CreateUnit(Player(6),'<?=ad.get_id()?>',<?=npcx[x]?>,-4608,90)//创建npc
    call SetUnitInvulnerable(unitt,true)//设置无敌
    <?end?>
    set unitt=null

    <?local ad=slk.upgrade.Rhpm:new(change(1272672))
    --创建一个难度科技RA00
    ad.Requires=''
    ad.effect1='rarm'--应用防御升级奖励
    ad.effect2='ratt'--应用攻击升级奖励
    ad.maxlevel=5
    ad.class='armor'
    ad.name={'难度1','难度2','难度3','难度4','难度5'}
    ad.Tip={'当前难度1','当前难度2','当前难度3','当前难度4','当前难度5'}

    local ad=slk.upgrade.Rhpm:new(change(1272673))
    --创建一个基地升级科技RA01
    ad.Requires=''
    ad.effect1='rarm'--应用防御升级奖励
    ad.effect2='ratt'--应用攻击升级奖励
    ad.maxlevel=50
    ad.class='armor'
    ad.timebase=0--基础时间
    ad.goldbase=0--基础黄金
    ad.lumberbase=20--基础木材
    ad.lumbermod=20--每等级增加木材    
    ad.Name={'升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地','升级基地'}
    ad.Ubertip={'提升基地等级到1级','提升基地等级到2级','提升基地等级到3级','提升基地等级到4级','提升基地等级到5级','提升基地等级到6级','提升基地等级到7级','提升基地等级到8级','提升基地等级到9级','提升基地等级到10级','提升基地等级到11级','提升基地等级到12级','提升基地等级到13级','提升基地等级到14级','提升基地等级到15级','提升基地等级到16级','提升基地等级到17级','提升基地等级到18级','提升基地等级到19级','提升基地等级到20级','提升基地等级到21级','提升基地等级到22级','提升基地等级到23级','提升基地等级到24级','提升基地等级到25级','提升基地等级到26级','提升基地等级到27级','提升基地等级到28级','提升基地等级到29级','提升基地等级到30级','提升基地等级到31级','提升基地等级到32级','提升基地等级到33级','提升基地等级到34级','提升基地等级到35级','提升基地等级到36级','提升基地等级到37级','提升基地等级到38级','提升基地等级到39级','提升基地等级到40级','提升基地等级到41级','提升基地等级到42级','提升基地等级到43级','提升基地等级到44级','提升基地等级到45级','提升基地等级到46级','提升基地等级到47级','提升基地等级到48级','提升基地等级到49级','提升基地等级到50级'}
    ad.Tip={'当前基地等级:0','当前基地等级:1','当前基地等级:2','当前基地等级:3','当前基地等级:4','当前基地等级:5','当前基地等级:6','当前基地等级:7','当前基地等级:8','当前基地等级:9','当前基地等级:10','当前基地等级:11','当前基地等级:12','当前基地等级:13','当前基地等级:14','当前基地等级:15','当前基地等级:16','当前基地等级:17','当前基地等级:18','当前基地等级:19','当前基地等级:20','当前基地等级:21','当前基地等级:22','当前基地等级:23','当前基地等级:24','当前基地等级:25','当前基地等级:26','当前基地等级:27','当前基地等级:28','当前基地等级:29','当前基地等级:30','当前基地等级:31','当前基地等级:32','当前基地等级:33','当前基地等级:34','当前基地等级:35','当前基地等级:36','当前基地等级:37','当前基地等级:38','当前基地等级:39','当前基地等级:40','当前基地等级:41','当前基地等级:42','当前基地等级:43','当前基地等级:44','当前基地等级:45','当前基地等级:46','当前基地等级:47','当前基地等级:48','当前基地等级:49'}
    ad.Art={'replaceabletextures\\commandbuttons\\btna_1.tga','replaceabletextures\\commandbuttons\\btna_2.tga','replaceabletextures\\commandbuttons\\btna_3.tga','replaceabletextures\\commandbuttons\\btna_4.tga','replaceabletextures\\commandbuttons\\btna_5.tga','replaceabletextures\\commandbuttons\\btna_6.tga','replaceabletextures\\commandbuttons\\btna_7.tga','replaceabletextures\\commandbuttons\\btna_8.tga','replaceabletextures\\commandbuttons\\btna_9.tga','replaceabletextures\\commandbuttons\\btna_10.tga','replaceabletextures\\commandbuttons\\btna_11.tga','replaceabletextures\\commandbuttons\\btna_12.tga','replaceabletextures\\commandbuttons\\btna_13.tga','replaceabletextures\\commandbuttons\\btna_14.tga','replaceabletextures\\commandbuttons\\btna_15.tga','replaceabletextures\\commandbuttons\\btna_16.tga','replaceabletextures\\commandbuttons\\btna_17.tga','replaceabletextures\\commandbuttons\\btna_18.tga','replaceabletextures\\commandbuttons\\btna_19.tga','replaceabletextures\\commandbuttons\\btna_20.tga','replaceabletextures\\commandbuttons\\btna_21.tga','replaceabletextures\\commandbuttons\\btna_22.tga','replaceabletextures\\commandbuttons\\btna_23.tga','replaceabletextures\\commandbuttons\\btna_24.tga','replaceabletextures\\commandbuttons\\btna_25.tga','replaceabletextures\\commandbuttons\\btna_26.tga','replaceabletextures\\commandbuttons\\btna_27.tga','replaceabletextures\\commandbuttons\\btna_28.tga','replaceabletextures\\commandbuttons\\btna_29.tga','replaceabletextures\\commandbuttons\\btna_30.tga','replaceabletextures\\commandbuttons\\btna_31.tga','replaceabletextures\\commandbuttons\\btna_32.tga','replaceabletextures\\commandbuttons\\btna_33.tga','replaceabletextures\\commandbuttons\\btna_34.tga','replaceabletextures\\commandbuttons\\btna_35.tga','replaceabletextures\\commandbuttons\\btna_36.tga','replaceabletextures\\commandbuttons\\btna_37.tga','replaceabletextures\\commandbuttons\\btna_38.tga','replaceabletextures\\commandbuttons\\btna_39.tga','replaceabletextures\\commandbuttons\\btna_40.tga','replaceabletextures\\commandbuttons\\btna_41.tga','replaceabletextures\\commandbuttons\\btna_42.tga','replaceabletextures\\commandbuttons\\btna_43.tga','replaceabletextures\\commandbuttons\\btna_44.tga','replaceabletextures\\commandbuttons\\btna_45.tga','replaceabletextures\\commandbuttons\\btna_46.tga','replaceabletextures\\commandbuttons\\btna_47.tga','replaceabletextures\\commandbuttons\\btna_48.tga','replaceabletextures\\commandbuttons\\btna_49.tga','replaceabletextures\\commandbuttons\\btna_50.tga'}

    --创建一堆自动繁殖的boss
    uid=1413935
    local bid={slk.unit.Ulic,slk.unit.Ogld,slk.unit.Ubal,slk.unit.Nman,slk.unit.Nklj,slk.unit.Otch,slk.unit.nsbm,slk.unit.Otch,slk.unit.Hamg,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Hamg,slk.unit.ntrd,slk.unit.Hamg,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Hamg,slk.unit.Hamg,slk.unit.Hamg,slk.unit.nsel,slk.unit.Hamg,slk.unit.ntrd,slk.unit.Hamg,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Hamg,slk.unit.Hjai,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Otch,slk.unit.Hamg,slk.unit.ndt2,slk.unit.nft2,slk.unit.nbt2,slk.unit.net2,slk.unit.ntx2}
    local bname={'暗夜洞穴BOSS ','蛇龙之巢BOSS','雪域宫BOSS','熔岩穴BOSS','熔岩穴BOSS','熔岩穴BOSS','熔岩穴BOSS','圣兽岛BOSS','圣兽岛BOSS','圣兽岛BOSS','圣兽岛BOSS','哀嚎洞穴BOSS','龙渊泽BOSS','龙渊泽BOSS','龙渊泽BOSS','龙渊泽BOSS','圣兽魂谷BOSS','圣兽魂谷BOSS','圣兽魂谷BOSS','圣兽魂谷BOSS','怒焰裂谷BOSS','将魂BOSS','将魂BOSS','将魂BOSS','将魂BOSS','将魂BOSS','秘境场BOSS',}
    local bcw={'暗夜之蛛','极阴烈水龙蛇','极寒幽魂','熔岩石头人','熔岩剑蛇','熔岩蜘蛛','熔岩火鸟','青龙','玄武','朱雀','白虎','哀嚎雷兽','红龙','黄龙','绿龙','蓝龙','青龙魂','玄武魂','朱雀魂','白虎魂','暗影地狱火','赵云','吕布','黄忠','诸葛亮','黄月英','九天鬼虫'}
    local btsw={'','','Abilities\\Weapons\\FireballMissile\\FireballMissile.mdl','','','','Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','','Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl','','','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl','','Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl','','','','','Abilities\\Weapons\\Arrow\\ArrowMissile.mdl','Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl','Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl',''}
    local bzb={29,31,30,25,26,27,28,13,14,15,16,32,21,22,23,24,17,18,19,20,34,40,41,42,43,44,35}
    local bmods={'units\\creeps\\SpiderBlue\\SpiderBlue','mods\\boss\\boss_9\\boss_9.mdx','mods\\boss\\boss_10\\boss_10.mdx','mods\\boss\\boss_11\\boss_11.mdx','mods\\boss\\boss_12\\boss_12.mdx','mods\\boss\\boss_13\\boss_13.mdx','mods\\boss\\boss_14\\boss_14.mdx','mods\\boss\\boss_15\\boss_15.mdx','Units\\Creeps\\DragonSeaTurtle\\DragonSeaTurtle','mods\\boss\\boss_17\\boss_17.mdx','mods\\boss\\boss_18\\boss_18.mdx','mods\\boss\\boss_19\\boss_19.mdx','mods\\boss\\boss_20\\boss_20.mdx','mods\\boss\\boss_21\\boss_21.mdx','mods\\boss\\boss_22\\boss_22.mdx','mods\\boss\\boss_23\\boss_23.mdx','mods\\boss\\boss_15\\boss_15.mdx','Units\\Creeps\\DragonSeaTurtle\\DragonSeaTurtle','mods\\boss\\boss_17\\boss_17.mdx','mods\\boss\\boss_18\\boss_18.mdx','mods\\boss\\boss_29\\boss_29.mdx','mods\\boss\\boss_30\\boss_30.mdx','mods\\boss\\boss_31\\boss_31.mdx','mods\\boss\\boss_32\\boss_32.mdx','mods\\boss\\boss_33\\boss_33.mdx','units\\human\\Jaina\\Jaina','mods\\boss\\boss_40\\boss_40.mdx'}
    local bsf={2,2,1.8,0.4,2.5,1,1,1,2.4,2.4,3,1,0.4,0.4,0.4,0.4,1,2.4,2.4,3,1.5,1.6,1.4,2,1.6,1.6,2.4}
    for x=1,27 do
    local ad = bid[x]:new(change(uid+x))
    ad.Name=bname[x]--名字
    ad.baneCount=1--称谓数量
    ad.Propernames=bcw[x]--称谓
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList=''--技能后期再输入
    ad.heroAbilList=''--英雄技能
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ad.file=bmods[x]--模型
    ad.modelScale=bsf[x]
    --ad.spd=hspd[x]--移动速度
    --ad.STR=hstr[x]--力量
    --ad.AGI=hagi[x]--敏捷
    --ad.INT=hint[x]--智力
    --ad.STRplus=hstrp[x]--力量升级
    --ad.AGIplus=hagip[x]--敏捷升级
    --ad.INTplus=hintp[x]--智力升级
    ad.Missileart=btsw[x]--投射物图像
    --TODO模型，攻击类型，护甲类型
    ?>


    set ttt=CreateTrigger()
    call SaveInteger(udg_hs,11,'<?=ad.get_id()?>',<?=bzb[x]?>)//保存坐标
    set unitt=CreateUnit(Player(11),'<?=ad.get_id()?>',<?=bossx[bzb[x]]?>,<?=bossy[bzb[x]]?>,<?=bossface[bzb[x]]?>)//创建单位
    call TriggerAddAction(ttt,function yg)
    call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)

    <?end


    ?>
    //暗夜洞穴
    call SaveInteger(udg_hs,'UB00',1,'IB3Y')
    call SaveInteger(udg_hs,'UB00',2,'IB3Z')
    call SaveInteger(udg_hs,'UB00',3,'IB43')
    call SaveInteger(udg_hs,'UB00',1000,3)
    //蛇龙之巢
    call SaveInteger(udg_hs,'UB01',1,'IB40')
    call SaveInteger(udg_hs,'UB01',2,'IB41')
    call SaveInteger(udg_hs,'UB01',3,'IB42')
    call SaveInteger(udg_hs,'UB01',1000,3)
    //雪域宫
    call SaveInteger(udg_hs,'UB02',1,'IB39')
    call SaveInteger(udg_hs,'UB02',2,'IB3A')
    call SaveInteger(udg_hs,'UB02',1000,2)
    //熔岩穴
    call SaveInteger(udg_hs,'UB03',1,'IB3Q')
    call SaveInteger(udg_hs,'UB03',1000,1)
    call SaveInteger(udg_hs,'UB04',1,'IB3R')
    call SaveInteger(udg_hs,'UB04',1000,1)
    call SaveInteger(udg_hs,'UB05',1,'IB3S')
    call SaveInteger(udg_hs,'UB05',1000,1)
    call SaveInteger(udg_hs,'UB06',1,'IB3T')
    call SaveInteger(udg_hs,'UB06',1000,1)
    //圣兽岛
    call SaveInteger(udg_hs,'UB07',1,'IB2K')
    call SaveInteger(udg_hs,'UB07',1000,1)
    call SaveInteger(udg_hs,'UB08',1,'IB2M')
    call SaveInteger(udg_hs,'UB08',1000,1)
    call SaveInteger(udg_hs,'UB09',1,'IB2N')
    call SaveInteger(udg_hs,'UB09',1000,1)
    call SaveInteger(udg_hs,'UB0A',1,'IB2L')
    call SaveInteger(udg_hs,'UB0A',1000,1)
    //斗者结晶的？？
    //龙渊泽
    call SaveInteger(udg_hs,'UB0C',1,'IB3D')
    call SaveInteger(udg_hs,'UB0C',2,'IB3H')
    call SaveInteger(udg_hs,'UB0C',1000,2)
    call SaveInteger(udg_hs,'UB0D',1,'IB3E')
    call SaveInteger(udg_hs,'UB0D',2,'IB3I')
    call SaveInteger(udg_hs,'UB0D',1000,2)
    call SaveInteger(udg_hs,'UB0E',1,'IB3F')
    call SaveInteger(udg_hs,'UB0E',2,'IB3J')
    call SaveInteger(udg_hs,'UB0E',1000,2)
    call SaveInteger(udg_hs,'UB0F',1,'IB3G')
    call SaveInteger(udg_hs,'UB0F',2,'IB3K')
    call SaveInteger(udg_hs,'UB0F',1000,2)
    //圣兽魂谷
    call SaveInteger(udg_hs,'UB0G',1,'IB3M')
    call SaveInteger(udg_hs,'UB0G',1000,1)
    call SaveInteger(udg_hs,'UB0H',1,'IB3O')
    call SaveInteger(udg_hs,'UB0H',1000,1)
    call SaveInteger(udg_hs,'UB0I',1,'IB3P')
    call SaveInteger(udg_hs,'UB0I',1000,1)
    call SaveInteger(udg_hs,'UB0J',1,'IB3N')
    call SaveInteger(udg_hs,'UB0J',1000,1)
    //怒焰谷
    call SaveInteger(udg_hs,'UB0K',1,'IB0Z')
    call SaveInteger(udg_hs,'UB0K',1000,1)

    <?


    --创建一个作者
    local ad=slk.unit.Hamg:new('UB0R')
    ad.Name='作者'
    ad.baneCount=1--称谓数量
    ad.Propernames='熬夜肝肝肝肝'
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList=''--技能后期再输入
    ad.heroAbilList=''--英雄技能
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ad.file='mods\\boss\\boss_50\\boss_50.mdx'--模型
    ad.modelScale=3
    --ad.spd=hspd[x]--移动速度
    --ad.STR=hstr[x]--力量
    --ad.AGI=hagi[x]--敏捷
    --ad.INT=hint[x]--智力
    --ad.STRplus=hstrp[x]--力量升级
    --ad.AGIplus=hagip[x]--敏捷升级
    --ad.INTplus=hintp[x]--智力升级
    ad.Missileart='Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl'--投射物图像

    --下面这句没有创建触发
    ?>
    set unitt=CreateUnit(Player(11),'<?=ad.get_id()?>',<?=bossx[37]?>,<?=bossy[37]?>,<?=bossface[37]?>)
    <?
    --下面创建小怪
    local xgid={slk.unit.Otch,slk.unit.nsel}
    local xgname={'斗者结晶场怪物','日轮山怪物'}
    local xgtsw={'','Abilities\\Weapons\\SeaElementalMissile\\SeaElementalMissile.mdl'}
    local xgmods={'mods\\boss\\boss_41\\boss_41.mdx','Units\\Creeps\\SeaElemental\\SeaElemental'}
    local xgzb={39,33}
    uid=1413963
    for x=1,2 do
    ad=xgid[x]:new(changeu(uid+x))
    ad.Name=xgname[x]--名字
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList=''--技能后期再输入
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ad.file=xgmods[x]--模型
    ad.modelScale=1
    --ad.spd=hspd[x]--移动速度
    --ad.STR=hstr[x]--力量
    --ad.AGI=hagi[x]--敏捷
    --ad.INT=hint[x]--智力
    --ad.STRplus=hstrp[x]--力量升级
    --ad.AGIplus=hagip[x]--敏捷升级
    --ad.INTplus=hintp[x]--智力升级
    ad.Missileart=xgtsw[x]--投射物图像
    --TODO模型，攻击类型，护甲类型 
        for y=1,10 do
    ?>
            set ttt=CreateTrigger()
            call SaveInteger(udg_hs,11,'<?=ad.get_id()?>',<?=xgzb[x]?>)//保存坐标
            set unitt=CreateUnit(Player(11),'<?=ad.get_id()?>',<?=bossx[xgzb[x]]?>+GetRandomReal(-640,640),<?=bossy[xgzb[x]]?>+GetRandomReal(-640,640),GetRandomReal(0,360))//创建单位
            call TriggerAddAction(ttt,function xg)
            call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)
    <?
        end
    end

    --以下生成私人副本
    local srid={slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Otch,slk.unit.Hamg,slk.unit.Otch}
    local srcw={'猫咪傀儡1','猫咪傀儡2','猫咪傀儡3','猫咪傀儡4','死亡之翼','麒麟1','麒麟2','麒麟3','麒麟4','麒麟5','麒麟6','神者','魔君'}
    local srname={'竞技场BOSS-1','竞技场BOSS-2','竞技场BOSS-3','竞技场BOSS-4','竞技场BOSS-5','进阶殿1阶','进阶殿2阶','进阶殿3阶','进阶殿4阶','进阶殿5阶','进阶殿6阶','修神之路BOSS','入魔之路BOSS'}
    local srtsw={'','','','','Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl','','','','','','','Abilities\\Weapons\\VoidWalkerMissile\\VoidWalkerMissile.mdl',''}
    local srmods={'mods\\boss\\boss_35\\boss_35.mdx','mods\\boss\\boss_36\\boss_36.mdx','mods\\boss\\boss_37\\boss_37.mdx','mods\\boss\\boss_38\\boss_38.mdx','mods\\boss\\boss_39\\boss_39.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_42\\boss_42.mdx','mods\\boss\\boss_48\\boss_48.mdx','mods\\boss\\boss_49\\boss_49.mdx'}
    uid=1413966
    for x=1,13 do
    ad=srid[x]:new(change(uid+x))
    ad.Name=srname[x]--名字
    ad.baneCount=1--称谓数量
    ad.Propernames=srcw[x]
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='undead'--统一不死族
    ad.abilList=''--技能后期再输入
    ad.heroAbilList=''--英雄技能
    ad.upgrades='RA00'--使用科技，后期增加
    ad.castpt=0--施法动画，影响施法动作时间
    ad.castbsw=0--同上
    ad.file=srmods[x]--模型
    ad.modelScale=1
    --ad.spd=hspd[x]--移动速度
    --ad.STR=hstr[x]--力量
    --ad.AGI=hagi[x]--敏捷
    --ad.INT=hint[x]--智力
    --ad.STRplus=hstrp[x]--力量升级
    --ad.AGIplus=hagip[x]--敏捷升级
    --ad.INTplus=hintp[x]--智力升级
    ad.Missileart=srtsw[x]--投射物图像
    --TODO模型，攻击类型，护甲类型     
    
    ?>

    call SaveInteger(udg_hs,15,<?=x?>,'<?=ad.get_id()?>')

    //call CreateUnit(Player(15),'<?=ad.get_id()?>',<?=(-6+x)*256?>,1024,270)//测试的时候用来看的


    <?end

    for x=1,6 do
    ?>


    //set ttt=CreateTrigger()//这个后面再做
    call SaveInteger(udg_hs,16,StringHash("竞技场"),<?=x+46?>)//保存坐标
    set unitt =CreateUnit(Player(11),'UB0V',<?=bossx[x+46]?>,<?=bossy[x+46]?>,<?=bossface[x+46]?>)//创建单位
    //call TriggerAddAction(ttt,function jjc)
    //call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)//偷懒
    

    set ttt=CreateTrigger()

    call SaveInteger(udg_hs,GetHandleId(Player(<?=x-1?>)),StringHash("进阶场"),<?=x+6?>)//保存坐标
    set unitt =CreateUnit(Player(11),'UB10',<?=bossx[x+6]?>,<?=bossy[x+6]?>,<?=bossface[x+6]?>)//创建单位
    call TriggerAddAction(ttt,function zs)
    call TriggerRegisterUnitEvent(ttt,unitt,EVENT_UNIT_DEATH)
    call SavePlayerHandle(udg_hs,GetHandleId(unitt),StringHash("玩家"),Player(<?=x-1?>))

    call SaveReal(udg_hs,GetHandleId(Player(<?=x-1?>)),StringHash("音量"),50)
    <?

    end


    local ad=slk.unit.nfbr:new('hC0B')
    ad.name=autoys(1,0,'练功房')
    ad.race='human'
    ad.isbldg=1
    ad.spd=0
    for x=1,6 do


    ?>
    set unitt= CreateUnit(Player(6),'hC0B',<?=playx[x]?>,<?=playy[x]?>,45)//创建练功房
    call SetUnitInvulnerable(unitt,true)//设置无敌
    <?end?>

    set unitt=null
    <?
    local iskill={'AA00,AB00,AC00','AA01,AB01,AC01','AA02,AB02,AC02','AA03,AB03,AC03','AA04,AB04,AC04','AA05,AB05,AC05','AA06,AB06,AC06','AA07,AB07,AC07','AA08,AB08,AC08','AA09,AB09,AC09','AA0A,AB0A,AC0A','AA0B,AB0B,AC0B','AA0G,AB0H,AC0C','AA0I,AB0I,AC0D','AA0O,AB0O,AC0E','AA12,AB0P,AC0F','AA13,AB0Q,AC0G','AA14,AB0R,AC0H','AA15,AB0S,AC0I','AA16,AB0T,AC0J','AA17,AB0U,AC0K','AA18,AB0V,AC0L','AA19,AB0W,AC0M','AA1A,AB0X,AC0N','AA1B,AB0Y,AC0O','AA1C,AB0Z,AC0P','AA1D,AB10,AC0Q','AA1E,AB11,AC0R','AA1F,AB12,AC0S','AA1G,AB13,AC0T','AA1H,AB14,AC0U','AA1I,AB15,AC0V','AA1J,AB16,AC0W','AA1K,AB17,AC0X','AA1L,AB18,AC0Y','AA0Q,AB0C,AC0Z,AD0F','AA0S,AB0D,AC10,AD0H','AA0U,AB0E,AC11,AD0I','AA0V,AB0F,AC12,AD0J','AA0W,AB0G,AC13,AD0K','AA0X,AB0J,AC14,AD0L','AA0Y,AB0K,AC15,AD0M','AA0Z,AB0L,AC16,AD0N','AA11,AB0M,AC17,AD0O','AA10,AB0N,AC18,AD0P','AA0J,AC19,AF0K','AA0K,AC1A,AF0L','AA0L,AC1B,AF0M','AA0M,AC1C,AF0N','AD00,AF00','AD01,AF01','AD02,AF02','AD03,AF03','AD04,AF04','AD05,AF05,AG00','AD06,AF06,AG01','AD07,AF07,AG02','AD08,AF08,AG03','AD09,AF0A,AG04','AD0A,AF0B,AG05','AD0B,AF0C,AG06','AD0C,AF0D,AG07','AD0D,AF0E,AG08','AD0E,AF0O,AG0A','AD0Q,AF0X','AD0R,AF0Y','AD0S,AF0Z','AD0T,AF10','AD0U,AF11','AD0V,AF12,AG10','AD0W,AF13,AG11','AD0X,AF14,AG12','AD0Y,AF15,AG13','AD0Z,AF16,AG14','AD10,AF17,AG15','AD11,AF18,AG16','AD12,AF19,AG17','AD13,AF1A,AG18','AD14,AF1B,AG19','AD15,AF1C,AG1A','AD16,AF1D,AG1B','AD17,AF1E,AG1C','AD18,AF1F,AG1D','AD19,AF1G,AG1E','AC1D,AF09,AG09','AC1E','AA0H,AC1F,AF0F,AG0B','AC1G,AF0Q','AC1H,AF0V','AC1I,AF0R','AA0N,AC1J,AF0S','AC1K,AF0T','AA0C,AC1L,AF0G','AA0D,AC1M,AF0H','AA0E,AC1N,AF0I','AA0F,AC1O,AF0J','AC1P,AF0U','AA0R,AC1Q','AA0P,AC1R','AC1S','AC1T,AD0G','AC1U,AF0P,AG0C','AC1V','AC1W,AF0W,AG1F','AA0T,AC1X','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}
    local iname={'初云短泉剑+1','初云短泉剑+2','初云短泉剑+3','初云短泉剑+4','初云短泉剑+Max','锐利妖金剑+1','锐利妖金剑+2','锐利妖金剑+3','锐利妖金剑+4','锐利妖金剑+Max','蛇龙破羽剑+1','蛇龙破羽剑+2','蛇龙破羽剑+3','蛇龙破羽剑+4','蛇龙破羽剑+Max','龙威妖韫剑','龙威妖韫剑+2','龙威妖韫剑+3','龙威妖韫剑+4','龙威妖韫剑+5','龙威妖韫剑+6','龙威妖韫剑+7','龙威妖韫剑+8','龙威妖韫剑+9','龙威妖韫剑+10','龙威妖韫剑+11','龙威妖韫剑+12','龙威妖韫剑+13','龙威妖韫剑+14','龙威妖韫剑+15','龙威妖韫剑+16','龙威妖韫剑+17','龙威妖韫剑+18','龙威妖韫剑+19','龙威妖韫剑+20','怒焰护手+1','怒焰护手+2','怒焰护手+3','怒焰护手+4','怒焰护手max','怒焰护手-金','怒焰护手-木','怒焰护手-水','怒焰护手-火','怒焰护手-土','青龙护符-附魂','白虎护符-附魂','玄武护符-附魂','朱雀护符-附魂','初云宝砂衣+1','初云宝砂衣+2','初云宝砂衣+3','初云宝砂衣+4','初云宝砂衣+Max','蛛丝纯骨甲+1','蛛丝纯骨甲+2','蛛丝纯骨甲+3','蛛丝纯骨甲+4','蛛丝纯骨甲+Max','蛇龙冥魄甲+1','蛇龙冥魄甲+2','蛇龙冥魄甲+3','蛇龙冥魄甲+4','蛇龙冥魄甲+Max','龙鳞幽火甲','龙鳞幽火甲+2','龙鳞幽火甲+3','龙鳞幽火甲+4','龙鳞幽火甲+5','龙鳞幽火甲+6','龙鳞幽火甲+7','龙鳞幽火甲+8','龙鳞幽火甲+9','龙鳞幽火甲+10','龙鳞幽火甲+11','龙鳞幽火甲+12','龙鳞幽火甲+13','龙鳞幽火甲+14','龙鳞幽火甲+15','龙鳞幽火甲+16','龙鳞幽火甲+17','龙鳞幽火甲+18','龙鳞幽火甲+19','龙鳞幽火甲+20','疾行之靴','黯淡的斗者项链','斗者项链','斗者项链-金','斗者项链-木','斗者项链-水','斗者项链-火','斗者项链-土','青龙护符','白虎护符','玄武护符','朱雀护符','女娲石','崆峒印','昆仑镜','东皇钟','昊天塔','炼妖壶','无字天书','神农鼎','伏羲琴','幸运护符','1级恢复药水','2级恢复药水','3级恢复药水','4级恢复药水','一级宝箱','二级宝箱','三级宝箱','四级宝箱','五级宝箱','竞技场刷新符','宝箱盒','黯淡的斗者意志','绚丽的斗者意志','斗魂卷轴','斗者宝石','龙之鳞甲1','龙之鳞甲2','龙之鳞甲3','龙之鳞甲4','龙之利爪1','龙之利爪2','龙之利爪3','龙之利爪4','日落山泉','青龙魂','白虎魂','玄武魂','朱雀魂','斗者项链碎片1','斗者项链碎片2','斗者项链碎片3','斗者项链碎片4','新手装备升到2级','新手装备升到3级','新手装备升到4级','新手装备升到5级','暗夜蛛丝','锐利蛛尖','蛇龙皮','蛇龙尖牙','蛇龙胆','蜘蛛之血',}
    local iart={'ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_88.tga','ReplaceableTextures\\CommandButtons\\BTNA_73.tga','ReplaceableTextures\\CommandButtons\\BTNA_70.tga','ReplaceableTextures\\CommandButtons\\BTNA_64.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_71.tga','ReplaceableTextures\\CommandButtons\\BTNA_61.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_88.tga','ReplaceableTextures\\CommandButtons\\BTNA_73.tga','ReplaceableTextures\\CommandButtons\\BTNA_70.tga','ReplaceableTextures\\CommandButtons\\BTNA_64.tga','ReplaceableTextures\\CommandButtons\\BTNA_49.tga','ReplaceableTextures\\CommandButtons\\BTNA_51.tga','ReplaceableTextures\\CommandButtons\\BTNA_59.tga','ReplaceableTextures\\CommandButtons\\BTNBoneChimes.blp','ReplaceableTextures\\CommandButtons\\BTNControlMagic.blp','ReplaceableTextures\\CommandButtons\\BTNA_66.tga','ReplaceableTextures\\CommandButtons\\BTNA_57.tga','ReplaceableTextures\\CommandButtons\\BTNCallToArms.blp','ReplaceableTextures\\CommandButtons\\BTNA_44.tga','ReplaceableTextures\\CommandButtons\\BTNA_52.tga','ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall.blp','ReplaceableTextures\\CommandButtons\\BTNPotionGreen.tga','ReplaceableTextures\\CommandButtons\\BTNPotionPurple.tga','ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp','ReplaceableTextures\\CommandButtons\\BTNA_40.tga','ReplaceableTextures\\CommandButtons\\BTNA_42.tga','ReplaceableTextures\\CommandButtons\\BTNA_41.tga','ReplaceableTextures\\CommandButtons\\BTNA_48.tga','ReplaceableTextures\\CommandButtons\\BTNA_43.tga','ReplaceableTextures\\CommandButtons\\BTNA_74.tga','ReplaceableTextures\\CommandButtons\\BTNUrnOfKelThuzad.blp','ReplaceableTextures\\CommandButtons\\BTNA_62.tga','ReplaceableTextures\\CommandButtons\\BTNA_75.tga','ReplaceableTextures\\CommandButtons\\BTNA_56.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_58.tga','ReplaceableTextures\\CommandButtons\\BTNA_87.tga','ReplaceableTextures\\CommandButtons\\BTNA_72.tga','ReplaceableTextures\\CommandButtons\\BTNA_69.tga','ReplaceableTextures\\CommandButtons\\BTNA_63.tga','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNRepairOn.blp','ReplaceableTextures\\CommandButtons\\BTNRepairOn.blp','ReplaceableTextures\\CommandButtons\\BTNRepairOn.blp','ReplaceableTextures\\CommandButtons\\BTNRepairOn.blp','ReplaceableTextures\\CommandButtons\\BTNA_60.tga','ReplaceableTextures\\CommandButtons\\BTNA_86.tga','ReplaceableTextures\\CommandButtons\\BTNA_78.tga','ReplaceableTextures\\CommandButtons\\BTNA_77.tga','ReplaceableTextures\\CommandButtons\\BTNA_80.tga','ReplaceableTextures\\CommandButtons\\BTNA_82.tga'}
    local iutip={'新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可用材料锐利蛛尖升级为锐利妖金剑','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可用材料蛇龙尖牙升级为蛇龙破羽剑','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可用材料龙之利爪1-4升级为龙威妖韫剑','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','附魂护符，+全属性+攻击力+生命值','附魂护符，+敏捷+攻击速度+吸血','附魂护符，+力量+护甲+生命值','附魂护符，+智力+法术等级；被动技能：周围600码的敌人受到朱雀火焰灼烧；','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可用材料暗夜蛛丝升级为蛛丝纯骨甲','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可用材料蛇龙皮升级为蛇龙冥魄甲','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可用材料龙之鳞甲1-4升级为龙鳞幽火甲','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击','鞋子，+移动速度100，+护甲','凡器，+生命值，+全属性；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','护符，+全属性+攻击力+生命值','护符，+敏捷+攻击速度+吸血','护符，+力量+护甲+生命值','护符，+智力+法术等级；被动技能：周围600码的敌人受到朱雀火焰灼烧；','宝器，+全属性，+生命值；无限复活','宝器，+全属性，+攻击力；群体变羊术持续3秒','宝器，+20%物理闪避，+攻击力； 驱除召唤和分身，CD60秒','宝器，+全属性；周围每秒减生命值各1%；能召唤圣泉（圣泉周围300码的友军获得每秒回血）','宝器，+全属性，+生命值；带天神下凡技能持续10秒，CD60秒','宝器，+全属性；单体减攻速及攻击并且造成每秒伤害 持续10秒,CD60秒','宝器，+全属性，+护甲，+生命值；抵抗眩晕效果。','宝器，+全属性，+生命值；被动效果每秒回血1%','宝器，+全属性，远程英雄攻击力提升100%；40%几率造成自身XX倍伤害','欧洲人附体，提升物品掉率20%','恢复自身5000生命值','恢复自身20000生命值','恢复自身100000生命值','恢复自身50%生命值','一级宝箱，开出随机宝器的几率为80%','二级宝箱，开出随机宝器的几率为85%','三级宝箱，开出随机宝器的几率为90%','四级宝箱，70%几率开出随机宝器，15%几率开出1级神器，10%几率获得2级神器，5%几率获得3级神器；','五级宝箱：55%几率开出随机宝器，20%几率开出1级神器，15%几率获得2级神器，10%几率获得3级神器；','刷新竞技场所有关卡','获得1-3级宝箱的概率为72%，获得4-5级宝箱的概率为28%','可以使斗者意志技能的经验值增加100点','可以使斗者意志技能的经验值增加500点','获得一个额外的斗魂点但不能超出上限。','宝石，可通过杀怪获得随机属性（金木水火土）','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','可以将黯淡的斗者之心洗涤为斗者之心','可以将魂魄附在护符上，增强属性；青龙魂+青龙护符=青龙护符-附魂','可以将魂魄附在护符上，增强属性；白虎魂+白虎护符=白虎护符-附魂','可以将魂魄附在护符上，增强属性；玄武魂+玄武护符=玄武护符-附魂','可以将魂魄附在护符上，增强属性；朱雀魂+朱雀护符=朱雀护符-附魂','集齐四个碎片可以合成黯淡的斗者项链','集齐四个碎片可以合成黯淡的斗者项链','集齐四个碎片可以合成黯淡的斗者项链','集齐四个碎片可以合成黯淡的斗者项链','','','','','暗夜蛛丝+初云宝砂衣max=蛛丝纯骨甲','锐利蛛尖+初云短泉剑max=锐利妖金剑','蛇龙皮+蛛丝纯骨甲max=蛇龙冥魄甲','蛇龙尖牙+锐利妖金剑max=蛇龙破羽剑','提升蛇龙冥魄甲与蛇龙破羽剑的装备经验50点。','提升蛛丝纯骨甲与锐利妖金剑的装备经验30点。'}
    local itype={'Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Artifact','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Artifact','Artifact','Artifact','Artifact','Artifact','Artifact','Artifact','Artifact','Artifact','Artifact','Charged','Charged','Charged','Charged','Charged','Charged','Charged','Charged','Charged','PowerUp','PowerUp','PowerUp','PowerUp','PowerUp','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Charged','Charged'}
    local izdsy={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
    local isycs={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
    local ilv={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3,3,3,4,4,4,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,5,5,5,5,5,5,5,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,2,2,2,2,1,1}
    uid=854063
    for x=1,148 do
    local ad=slk.item.ches:new(change(uid+x))
    ad.Name=autoys(x,0,iname[x])
    ad.Art=iart[x]
    ad.class=itype[x]
    ad.Ubertip=autoys(x,0,iutip[x])
    ad.abilList=iskill[x]
    ad.stockRegen=0
    ad.usable=izdsy[x]--主动使用
    ad.uses=isycs[x]--使用次数
    ad.Level=ilv[x]
    if isycs[x]>0 then ad.perishable=1 end--使用完回消失 
    ?>
    call CreateItem('<?=ad.get_id()?>',<?=(-58+x)*10?>,-3840)
    <?
    end
    
    for x=1,6 do
        local aid=466561
        for y=0,14 do
    ?>
    call SetPlayerAbilityAvailable(Player(<?=x-1?>),'<?=change(aid+y)?>',false)//禁用所有天赋
    <?end end
    
    uid=855359

    for x=1,34 do 
    uid=uid+1
    local ad=slk.item.ches:new(change(uid))
    ad.name=autoys(x,0,tostring(x)..'级武器强化')
    ad.class='PowerUp'
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=2
    
    ?>
    call SaveInteger(udg_hs,22,'<?=ad.get_id()?>',<?=x?>)//存储物品等级
    call SaveInteger(udg_hs,21,'<?=change(854063+x)?>','<?=change(854064+x)?>')//存储装备的下一级
    call SaveInteger(udg_hs,'<?=ad.get_id()?>',2,'<?=change(854063+x)?>')//存储物品对应装备
    call SaveInteger(udg_hs,25,'<?=change(854063+x)?>',<?=x?>)//存储装备等级
    call SaveInteger(udg_hs,'<?=change(854063+x)?>',2,'<?=ad.get_id()?>')//存储装备对应物品
    <?end

    for x=1,34 do
    uid=uid+1
    local ad=slk.item.ches:new(change(uid))
    ad.name=autoys(x,0,tostring(x)..'级衣服强化')
    ad.class='PowerUp'
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=3
    ?>
    call SaveInteger(udg_hs,22,'<?=ad.get_id()?>',<?=x?>)
    call SaveInteger(udg_hs,21,'<?=change(854112+x)?>','<?=change(854113+x)?>')
    call SaveInteger(udg_hs,'<?=ad.get_id()?>',3,'<?=change(854112+x)?>')
    call SaveInteger(udg_hs,25,'<?=change(854112+x)?>',<?=x?>)//存储装备等级
    call SaveInteger(udg_hs,'<?=change(854112+x)?>',2,'<?=ad.get_id()?>')//存储装备对应物品
    <?end
    for x=1,4 do
    uid=uid+1
    local ad=slk.item.ches:new(change(uid))
    ad.name=autoys(x,0,tostring(x)..'级手套强化')
    ad.class='PowerUp'
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=4
    ?>
    call SaveInteger(udg_hs,22,'<?=ad.get_id()?>',<?=x?>)
    call SaveInteger(udg_hs,21,'<?=change(854098+x)?>','<?=change(854099+x)?>')
    call SaveInteger(udg_hs,'<?=ad.get_id()?>',4,'<?=change(854098+x)?>')
    call SaveInteger(udg_hs,25,'<?=change(854098+x)?>',<?=x?>)//存储装备等级
    call SaveInteger(udg_hs,'<?=change(854098+x)?>',2,'<?=ad.get_id()?>')//存储装备对应物品
    <?
    end
    ?>

    call SetMusicVolume(PercentToInt(50,127))


    //新手装备初始化
    call SaveInteger(udg_hs,'IB3U',1,'IC00')
    call SaveInteger(udg_hs,'IB3U',2,'IC0Y')
    call SaveInteger(udg_hs,'IB3V',1,'IC01')
    call SaveInteger(udg_hs,'IB3V',2,'IC0Z')
    call SaveInteger(udg_hs,'IB3W',1,'IC02')
    call SaveInteger(udg_hs,'IB3W',2,'IC10')
    call SaveInteger(udg_hs,'IB3X',1,'IC03')
    call SaveInteger(udg_hs,'IB3X',2,'IC11')
    //装备强化和合成初始化函数
    call itemreg('IB04',1,'IB3Z',1,0,0,0,0,0,0,0,0,'IC04',2,true)

    call itemreg('IB1R',1,'IB3D',1,'IB3E',1,'IB3F',1,'IB3G',1,0,0,'IC1C',5,true)

    <?
    --技能
    --攻击力
    local agjlid={479520,479521,479522,479523,479524,479525,479526,479527,479528,479529,479530,479531,479536,479538,479544,479558,479559,479560,479561,479562,479563,479564,479565,479566,479567,479568,479569,479570,479571,479572,479573,479574,479575,479576,479577,479546,479548,479550,479551,479552,479553,479554,479555,479557,479556,479539,479540,479541,479542,479537,479543,479532,479533,479534,479535,479547,479545,479549}
    local agjl={75,100,125,175,250,400,500,650,800,1000,2000,2500,3500,4500,6000,125000,160000,225000,300000,390000,420000,470000,550000,620000,720000,830000,950000,1070000,1200000,1400000,1800000,2400000,3200000,4200000,5500000,15000,20000,25000,35000,45000,50000,50000,50000,65000,50000,5000,5000,5000,5000,4000,5000,2500,2500,2500,2500,15000,8000,20000}
    for x=1,58 do
    local ad=slk.ability.AItg:new(change(agjlid[x]))
    ad.DataA1=agjl[x]
    end

    --攻击速度
    local agjsdid={480816,480817,480818,480819,480820,480821,480822,480823,480824,480825,480826,480827,480833,480834,480840,480841,480842,480843,480844,480845,480846,480847,480848,480849,480850,480851,480852,480853,480854,480855,480856,480857,480858,480859,480860,480828,480829,480830,480831,480832,480835,480836,480837,480838,480839}
    local agjsd={0.1,0.12,0.15,0.2,0.25,0.3,0.4,0.5,0.6,0.8,0.9,1,1.1,1.2,1.3,2.5,2.5,2.5,2.5,2.5,3,3,3,3,3,3.5,3.5,3.5,3.5,3.5,4,4,4,4,4,1,1,1,1,1,1.2,1.2,1.2,1.2,1.2}
    for x=1,45 do
    local ad=slk.ability.AIsx:new(change(agjsdid[x]))
    ad.DataA1=agjsd[x]
    end

    --全属性
    local aqsxid={482112,482113,482114,482115,482116,482117,482118,482119,482120,482121,482122,482123,482124,482125,482126,482127,482128,482129,482130,482131,482132,482133,482134,482135,482136,482137,482138,482139,482140,482141,482142,482143,482144,482145,482146,482147,482148,482149,482150,482151,482152,482153,482154,482155,482156,482157,482158,482159,482160,482161,482162,482163,482164,482165,482166,482167,482168,482169,482170,482171,482172,482173,482174,482175,482176,482177,482178,482179,482180,482181}
    local aql={10,15,20,25,30,25,35,45,70,100,200,300,400,500,600,12000,16000,20000,24000,30000,40000,45000,50000,55000,60000,70000,80000,95000,110000,125000,160000,200000,250000,300000,400000,2000,2500,3500,4500,6000,8000,12000,8000,8000,16000,2500,4500,6500,2500,10,150,1000,1500,2000,1500,1500,3500,1500,2500,3500,1500,2000,1500,0,9000,1500,2500,1000,1500,500}
    local aqm={10,15,20,25,30,25,35,45,70,100,200,300,400,500,600,12000,16000,20000,24000,30000,40000,45000,50000,55000,60000,70000,80000,95000,110000,125000,160000,200000,250000,300000,400000,2000,2500,3500,4500,6000,16000,12000,8000,8000,8000,6500,4500,2500,2500,10,150,1000,3500,2000,1500,1500,1500,3500,2500,1500,1500,2000,1500,6000,1500,1500,2500,1000,1500,500}
    local aqz={10,15,20,25,30,25,35,45,70,100,200,300,400,500,600,12000,16000,20000,24000,30000,40000,45000,50000,55000,60000,70000,80000,95000,110000,125000,160000,200000,250000,300000,400000,2000,2500,3500,4500,6000,8000,12000,16000,8000,8000,2500,4500,2500,6500,10,150,1000,1500,2000,3500,1500,1500,1500,2500,1500,3500,2000,1500,0,1500,1500,2500,10000,1500,500}
    for x=1,70 do
    local ad=slk.ability.AIx1:new(change(aqsxid[x]))
    ad.DataA1=aqm[x]--敏捷
    ad.DataB1=aqz[x]
    ad.DataC1=aql[x]
    end


    --护甲
    local ahjid={483423,483425,483426,483427,483428,483429,483430,483431,483432,483433,483408,483409,483410,483411,483412,483413,483414,483415,483416,483417,483418,483419,483420,483421,483422,483434,483435,483436,483437,483438,483439,483440,483441,483442,483443,483444,483445,483446,483447,483448,483449,483450,483451,483452,483453,483424}
    local ahj={800,1100,1400,1800,2300,2500,2500,2500,2500,2500,8,10,12,15,20,25,35,45,55,70,100,130,160,200,240,3000,4000,5500,7000,9000,10000,11000,12000,13000,15000,18000,20000,22000,25000,27500,34000,42000,50000,63000,75000,900}
    for x=1,46 do
    local ad=slk.ability.AId1:new(change(ahjid[x]))
    ad.DataA1=ahj[x]
    end

    --生命最大值
    local asmmaxid={486020,486021,486022,486023,486000,486001,486002,486003,486004,486005,486006,486007,486008,486010,486011,486012,486013,486014,486024,486033,486034,486035,486036,486037,486038,486039,486040,486041,486042,486043,486044,486045,486046,486047,486048,486049,486050,486051,486052,486009,486015,486026,486031,486027,486028,486029,486016,486017,486018,486019,486030,486025,486032}
    local asmmax={75000,75000,75000,75000,800,1200,1800,2400,3000,4000,5000,6000,8000,10000,22000,30000,40000,50000,75000,1600000,2100000,2700000,3500000,4500000,5300000,6200000,7200000,8300000,9400000,10600000,12000000,14000000,16000000,18500000,24000000,32000000,42000000,55000000,75000000,8000,50000,150000,200000,150000,150000,150000,50000,50000,50000,50000,150000,100000,200000}
    for x=1,53 do
    local ad=slk.ability.AIlz:new(change(asmmaxid[x]))
    ad.DataA1=asmmax[x]
    end


    --生命恢复固定值
    local asmhfid={487296,487297,487298,487299,487300,487301,487302,487303,487304,487306,487305,487307,487308}
    local asmhf={10,15,20,30,40,50,65,80,100,125,100,300,1500}
    for x=1,13 do
    local ad=slk.ability.AIel:new(change(asmhfid[x]))
    ad.DataA1=asmhf[x]
    end

    --生命恢复百分比
    local avsmhfid={487332,487333,487334,487335,487336,487337,487338,487339,487340,487341,487342,487343,487344,487345,487346,487347}
    local avsmhf={0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.03,0.03,0.03,0.03,0.03,0.03}
    for x=1,16 do
    local ad=slk.ability.ACnr:new(change(avsmhfid[x]))
    ad.DataA1=avsmhf[x]
    ad.targs1='ground,vulnerable,air,invulnerable,organic,self'
    end


    local zhid={slk.unit.nqb4,slk.unit.osw3,slk.unit.ngz4,slk.unit.nqb4,slk.unit.osw3,slk.unit.ngz4}
    local zhname={'野猪','幽魂之狼','熊','亢奋的野猪','亢奋的幽魂之狼','亢奋的熊'}
    local zhaib={'A01M','A01N','A01O','A01L,A01M','A01L,A01N','A01L,A01O'}
    for x=1,6 do
    local ad=slk.unit.nfbr:new(changeu(1086047+x))
    ad.name=zhname[x]--名字
    ad.file=zhid[x].file--模型
    ad.Art=zhid[x].Art--图标
    ad.spd=300--移动速度
    ad.minSpd=250--最小移动速度
    ad.acquire=zhid[x].acquire--最主动攻击范围
    ad.collision=32--大小
    ad.abilList=zhaib[x] --技能
    --ad.dmgplus1=sh[x]--基础伤害
    --ad.dmgUp1=dmgup[x]--伤害升级后期再设置
    ad.sides1=1--骰子面数，不需要修改
    ad.dice1=1--骰子数量，不需要修改
    --ad.cool1=cool[x]--攻击间隔
    --if x>3 then ad.cool1=cool[x]/2 end--攻击间隔,攻击间隔也是后面设置
    ad.weapsOn=1--武器允许
    ad.race='human'--种族
    --ad.HP=hp[x]--HP
    ad.canFlee=0--不可逃跑
    ad.unitSound=zhid[x].unitSound--单位声音
    ad.rangeN1=zhid[x].rangeN1--攻击范围
    ad.Missileart=zhid[x].Missileart--投射物图像
    ad.Missilespeed=zhid[x].Missilespeed--投射物速率
    ad.atkType1='pierce'--攻击类型
    ad.Missilearc=zhid[x].Missilearc--投射物弧度
    ad.weapTp1=zhid[x].weapTp1--武器类型
    --ad.def=def[x]--基础护甲
    --ad.defUp=defup[x]--护甲升级
    --ad.upgrades='RA00'--难度科技
    end

    ?>
    set ttt=null
    endfunction 

    private function init takes nothing returns nothing
        call LUAcreateunit()//lua初始化，内容在上面
        call input()//输入触发
        call xzyx()//选择英雄初始化
        call fuhuo()//复活英雄
        call time0()//注册0秒事件
        call chuguai()//注册出怪事件
        call choicelv()//创建对话框触发
        call getitem()//创建获得物品触发
        call list()//注册菜单触发
        call ajidi()//注册攻击基地
        call kj()//注册科技同步
        call bgj()//注册被攻击事件
        call death()//注册死亡事件
        call skill()//注册发动技能效果事件
    endfunction
endlibrary