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
//导入完毕
library csh initializer init requires libselecthero libinput libfuhuo libtime0 libchuguai libyg libbgj
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
    real jsqjg=5//默认计时器间隔
endglobals

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
    local itemname={'传送到坐标1','传送到坐标2','传送到坐标3','传送到坐标4','传送到坐标5','传送到坐标6','传送到坐标7','传送到坐标8','传送到坐标9','传送到坐标10','传送到坐标11','传送到坐标12','圣兽岛','传送到坐标14','传送到坐标15','传送到坐标16','圣兽魂谷','传送到坐标18','传送到坐标19','传送到坐标20','龙渊泽','传送到坐标22','传送到坐标23','传送到坐标24','熔岩穴','传送到坐标26','传送到坐标27','传送到坐标28','暗夜洞穴','雪域宫','蛇龙巢穴','哀嚎洞穴','传送到坐标33','怒焰谷','秘境','传送到坐标36','传送到坐标37','传送到坐标38','传送到坐标39','将魂-赵云','将魂-吕布','将魂-黄忠','将魂-诸葛亮','将魂-黄月英','传送到坐标45','传送到坐标46','传送到坐标47','传送到坐标48','传送到坐标49','传送到坐标50','传送到坐标51','传送到坐标52','传送到坐标53','传送到坐标54','传送到坐标55','传送到坐标56','传送到坐标57','传送到坐标58','传送到坐标59','传送到坐标60','传送到坐标61','传送到坐标62','传送到坐标63','传送到坐标64','传送到坐标65','传送到坐标66','传送到坐标67','传送到坐标68','传送到坐标69','传送到坐标70','传送到坐标71','传送到坐标72','传送到坐标73','传送到坐标74','传送到坐标75','传送到坐标76','传送到坐标77','传送到坐标78'}
    for zb=1,78 do
    local ad=slk.item.ches:new(change(uid+zb))
    ad.name=autoys(zb,0,itemname[zb])
    ad.class='PowerUp'
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=1
    ad.Tip=autoys(zb,0,itemname[zb])
    ad.Ubertip=autoys(zb,0,'传送到'..itemname[zb])

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
    ad.file=jbmods[x]
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
    local uid=806111
    for x=1,17 do
    local ad=obj[x]:new(change(uid+x))
    ad.Name=hname[x]--名字
    ad.baneCount=1--称谓数量
    ad.Propernames=hcw[x]--称谓
    ad.special=0--编辑器分类，为了更好管理
    ad.campaign=0--同上
    ad.race='human'--统一人族
    ad.abilList='AInv,A000'--技能后期再输入
    ad.heroAbilList=''--英雄技能
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
    local npcfm={'IB00,IB0A,IB14,IC00,IC01','IA0C,IA0G,IA0K,IA0O,IA0S,IA0T,IA0U,IA0V,IA0X,IA0W','IA13,IA14,IA15,IA16,IA17','IA0Y','','','',''}
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
    local iname={'初云短泉剑+1','初云短泉剑+2','初云短泉剑+Max','锐利妖金剑+1','锐利妖金剑+2','锐利妖金剑+Max','蛇龙破羽剑+1','蛇龙破羽剑+2','蛇龙破羽剑+Max','龙威妖韫剑','初云宝砂衣+1','初云宝砂衣+2','初云宝砂衣+Max','蛛丝纯骨甲+1','蛛丝纯骨甲+2','蛛丝纯骨甲+Max','蛇龙冥魄甲+1','蛇龙冥魄甲+2','蛇龙冥魄甲+Max','龙鳞幽火甲','龙威妖韫剑-金-初级','龙威妖韫剑-木-初级','龙威妖韫剑-水-初级','龙威妖韫剑-火-初级','龙威妖韫剑-土-初级','龙威妖韫剑-金-高级','龙威妖韫剑-木-高级','龙威妖韫剑-水-高级','龙威妖韫剑-火-高级','龙威妖韫剑-土-高级','龙鳞幽火甲-金-初级','龙鳞幽火甲-木-初级','龙鳞幽火甲-水-初级','龙鳞幽火甲-火-初级','龙鳞幽火甲-土-初级','龙鳞幽火甲-金-高级','龙鳞幽火甲-木-高级','龙鳞幽火甲-水-高级','龙鳞幽火甲-火-高级','龙鳞幽火甲-土-高级','疾行之靴','黯淡的斗者之心','斗者之心','青龙护符','白虎护符','玄武护符','朱雀护符','青龙护符-附魂','白虎护符-附魂','玄武护符-附魂','朱雀护符-附魂','怒焰护手','斗者宝石','斗者宝石-金-初级','斗者宝石-木-初级','斗者宝石-水-初级','斗者宝石-火-初级','斗者宝石-土-初级','斗者宝石-金-高级','斗者宝石-木-高级','斗者宝石-水-高级','斗者宝石-火-高级','斗者宝石-土-高级','女娲石','崆峒印','昆仑镜','东皇钟','昊天塔','炼妖壶','无字天书','神农鼎','伏羲琴','1级恢复药水','2级恢复药水','3级恢复药水','4级恢复药水','指天广鬼神剑','焚天玄魔神剑','轩辕古冰神剑','噬骨冥泪神甲','血蚀魅精神甲','灭魂歧帝神甲','幸运护符','竞技场刷新符','宝箱盒','一级宝箱','二级宝箱','三级宝箱','四级宝箱','五级宝箱','斗魂卷轴','暗夜蛛丝','锐利蛛尖','蜘蛛之血','蛇龙皮','蛇龙尖牙','蛇龙胆','黯淡的斗者意志','绚丽的斗者意志','龙之鳞甲1','龙之鳞甲2','龙之鳞甲3','龙之鳞甲4','龙之利爪1','龙之利爪2','龙之利爪3','龙之利爪4','日落山泉','青龙魂','白虎魂','玄武魂','朱雀魂','将魂之魄-赵云','将魂之魄-吕布','将魂之魄-诸葛亮','将魂之魄-黄月英','将魂之魄-黄忠','斗者之心碎片1','斗者之心碎片2','斗者之心碎片3','斗者之心碎片4'}
    local iart={'ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_46.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_85.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_79.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_45.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_81.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_76.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_92.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_93.tga','ReplaceableTextures\\CommandButtons\\BTNA_71.tga','ReplaceableTextures\\CommandButtons\\BTNA_61.tga','ReplaceableTextures\\CommandButtons\\BTNA_54.tga','ReplaceableTextures\\CommandButtons\\BTNA_88.tga','ReplaceableTextures\\CommandButtons\\BTNA_73.tga','ReplaceableTextures\\CommandButtons\\BTNA_70.tga','ReplaceableTextures\\CommandButtons\\BTNA_64.tga','ReplaceableTextures\\CommandButtons\\BTNA_88.tga','ReplaceableTextures\\CommandButtons\\BTNA_73.tga','ReplaceableTextures\\CommandButtons\\BTNA_70.tga','ReplaceableTextures\\CommandButtons\\BTNA_64.tga','ReplaceableTextures\\CommandButtons\\BTNA_67.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_55.tga','ReplaceableTextures\\CommandButtons\\BTNA_49.tga','ReplaceableTextures\\CommandButtons\\BTNA_51.tga','ReplaceableTextures\\CommandButtons\\BTNA_59.tga','ReplaceableTextures\\CommandButtons\\BTNBoneChimes.blp','ReplaceableTextures\\CommandButtons\\BTNControlMagic.blp','ReplaceableTextures\\CommandButtons\\BTNA_66.tga','ReplaceableTextures\\CommandButtons\\BTNA_57.tga','ReplaceableTextures\\CommandButtons\\BTNCallToArms.blp','ReplaceableTextures\\CommandButtons\\BTNA_44.tga','ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall.blp','ReplaceableTextures\\CommandButtons\\BTNPotionGreen.tga','ReplaceableTextures\\CommandButtons\\BTNPotionPurple.tga','ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp','ReplaceableTextures\\CommandButtons\\BTNA_53.tga','ReplaceableTextures\\CommandButtons\\BTNA_68.tga','ReplaceableTextures\\CommandButtons\\BTNA_84.tga','ReplaceableTextures\\CommandButtons\\BTNA_47.tga','ReplaceableTextures\\CommandButtons\\BTNA_83.tga','ReplaceableTextures\\CommandButtons\\BTNA_65.tga','ReplaceableTextures\\CommandButtons\\BTNA_52.tga','ReplaceableTextures\\CommandButtons\\BTNA_74.tga','ReplaceableTextures\\CommandButtons\\BTNUrnOfKelThuzad.blp','ReplaceableTextures\\CommandButtons\\BTNA_40.tga','ReplaceableTextures\\CommandButtons\\BTNA_42.tga','ReplaceableTextures\\CommandButtons\\BTNA_41.tga','ReplaceableTextures\\CommandButtons\\BTNA_48.tga','ReplaceableTextures\\CommandButtons\\BTNA_43.tga','ReplaceableTextures\\CommandButtons\\BTNA_56.tga','ReplaceableTextures\\CommandButtons\\BTNA_60.tga','ReplaceableTextures\\CommandButtons\\BTNA_86.tga','ReplaceableTextures\\CommandButtons\\BTNA_82.tga','ReplaceableTextures\\CommandButtons\\BTNA_78.tga','ReplaceableTextures\\CommandButtons\\BTNA_77.tga','ReplaceableTextures\\CommandButtons\\BTNA_80.tga','ReplaceableTextures\\CommandButtons\\BTNA_62.tga','ReplaceableTextures\\CommandButtons\\BTNA_75.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_91.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_90.tga','ReplaceableTextures\\CommandButtons\\BTNA_58.tga','ReplaceableTextures\\CommandButtons\\BTNA_87.tga','ReplaceableTextures\\CommandButtons\\BTNA_72.tga','ReplaceableTextures\\CommandButtons\\BTNA_69.tga','ReplaceableTextures\\CommandButtons\\BTNA_63.tga','ReplaceableTextures\\CommandButtons\\BTNA_50.tga','ReplaceableTextures\\CommandButtons\\BTNA_50.tga','ReplaceableTextures\\CommandButtons\\BTNA_50.tga','ReplaceableTextures\\CommandButtons\\BTNA_50.tga','ReplaceableTextures\\CommandButtons\\BTNA_50.tga','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp','ReplaceableTextures\\CommandButtons\\BTNMoonStone.blp'}
    local iutip={'新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可以通过杀怪使武器升级（杀怪100）','新手武器，+攻击力；可用材料锐利蛛尖升级为锐利妖金剑','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可通过杀怪或者使用蜘蛛之血获得武器经验（需200装备经验升级）','凡器，+攻击力，+全属性，可用材料蛇龙尖牙升级为蛇龙破羽剑','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可通过杀怪或者使用蛇龙胆获得武器经验（需300装备经验升级）','仙具，+攻击力，+攻速，+全属性；可用材料龙之利爪1-4升级为龙威妖韫剑','天具，+攻击力，+攻速，+全属性；攻击时有几率释放龙威镇压敌人造成伤害；可以镶嵌一个宝石','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可以通过杀怪使防具升级（杀怪100）','新手防具，+生命值；可用材料暗夜蛛丝升级为蛛丝纯骨甲','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可通过杀怪或者使用蜘蛛之血获得防具经验（需200装备经验升级）','凡器，+生命值，+护甲；可用材料蛇龙皮升级为蛇龙冥魄甲','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可通过杀怪或者使用蛇龙胆获得防具经验（需300装备经验升级）','仙具，+生命值，+护甲，+全属性；可用材料龙之鳞甲1-4升级为龙鳞幽火甲','天具，+生命值，+护甲，+全属性；被攻击时有10%几率闪避物理攻击；可以镶嵌一个宝石','天具，+攻击力，+攻速，+全属性，+敏捷；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了初级宝石-金','天具，+攻击力，+攻速，+全属性，提高500码内友军10%攻击力；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了初级宝石-木','天具，+攻击力，+攻速，+全属性，+智力，+法术等级；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了初级宝石-水','天具，+攻击力，+攻速，+全属性，+攻击力；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了初级宝石-火','天具，+攻击力，+攻速，+全属性+力量；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了初级宝石-土','天具，+攻击力，+攻速，+全属性，+敏捷；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了高级宝石-金','天具，+攻击力，+攻速，+全属性，提高500码内友军30%攻击力；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了高级宝石-木','天具，+攻击力，+攻速，+全属性，+智力，+法术等级；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了高级宝石-水','天具，+攻击力，+攻速，+全属性，+攻击力；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了高级宝石-火','天具，+攻击力，+攻速，+全属性+力量；攻击时有几率释放龙威镇压敌人造成伤害；镶嵌了高级宝石-土','天具，+生命值，+护甲，+全属性，+敏捷；被攻击时有10%几率闪避物理攻击；镶嵌了初级宝石-金','天具，+生命值，+护甲，+全属性，提高500码内友军10%攻击力；被攻击时有10%几率闪避物理攻击；镶嵌了初级宝石-木','天具，+生命值，+护甲，+全属性，+智力，+法术等级；被攻击时有10%几率闪避物理攻击；镶嵌了初级宝石-土','天具，+生命值，+护甲，+全属性，+攻击力；被攻击时有10%几率闪避物理攻击；镶嵌了初级宝石-火','天具，+生命值，+护甲，+全属性，+力量；被攻击时有10%几率闪避物理攻击；镶嵌了初级宝石-土','天具，+生命值，+护甲，+全属性，+敏捷；被攻击时有10%几率闪避物理攻击；镶嵌了高级宝石-金','天具，+生命值，+护甲，+全属性，提高500码内友军30%攻击力；被攻击时有10%几率闪避物理攻击；镶嵌了高级宝石-木','天具，+生命值，+护甲，+全属性，+智力，+法术等级；被攻击时有10%几率闪避物理攻击；镶嵌了高级宝石-水','天具，+生命值，+护甲，+全属性，+攻击力；被攻击时有10%几率闪避物理攻击；镶嵌了高级宝石-火','天具，+生命值，+护甲，+全属性，+力量；被攻击时有10%几率闪避物理攻击；镶嵌了高级宝石-土','鞋子，+移动速度100，+护甲','凡器，+生命值，+全属性；相传有一种泉水可以洗涤掉暗淡之光','仙具，+生命值，+全属性，+生命恢复，减少死亡复活时间；相传有一种泉水可以洗涤掉暗淡之光','护符，+全属性+攻击力+生命值','护符，+敏捷+攻击速度+吸血','护符，+力量+护甲+生命值','护符，+智力+法术等级；被动技能：周围600码的敌人受到朱雀火焰灼烧；','附魂护符，+全属性+攻击力+生命值','附魂护符，+敏捷+攻击速度+吸血','附魂护符，+力量+护甲+生命值','附魂护符，+智力+法术等级；被动技能：周围600码的敌人受到朱雀火焰灼烧；','护手，+攻击力，+全属性；攻击时有10%几率造成致命一击，伤害为：','宝石，可通过杀怪获得随机属性（金木水火土）','初级宝石，+生命值，+敏捷；此宝石可镶嵌到天具上','初级宝石，提高500码内友军10%攻击力；此宝石可镶嵌到天具上','初级宝石，+智力，+法术等级；此宝石可镶嵌到天具上','初级宝石，+攻击力，+全属性；此宝石可镶嵌到天具上','初级宝石，+护甲值，+力量；此宝石可镶嵌到天具上','高级宝石，+生命值，+敏捷；此宝石可镶嵌到天具上','高级宝石，提高500码内友军30%攻击力；此宝石可镶嵌到天具上','高级宝石，+智力，+法术等级；此宝石可镶嵌到天具上','高级宝石，+攻击力，+全属性；此宝石可镶嵌到天具上','高级宝石，+护甲值，+力量；此宝石可镶嵌到天具上','宝器，+全属性，+生命值；无限复活','宝器，+全属性，+攻击力；群体变羊术持续3秒','宝器，+20%物理闪避，+攻击力； 驱除召唤和分身，CD60秒','宝器，+全属性；周围每秒减生命值各1%；能召唤圣泉（圣泉周围300码的友军获得每秒回血）','宝器，+全属性，+生命值；带天神下凡技能持续10秒，CD60秒','宝器，+全属性；单体减攻速及攻击并且造成每秒伤害 持续10秒,CD60秒','宝器，+全属性，+护甲，+生命值；抵抗眩晕效果。','宝器，+全属性，+生命值；被动效果每秒回血1%','宝器，+全属性，远程英雄攻击力提升100%；40%几率造成自身XX倍伤害','恢复自身5000生命值','恢复自身20000生命值','恢复自身100000生命值','恢复自身50%生命值','神器，+攻击力；攻击一次全属性+10','神器，+攻击力；攻击一次全属性+20','神器，+攻击力；攻击一次全属性+30','神器，+护甲；减免所有伤害30%','神器，+护甲；减免所有伤害40%','神器，+护甲；减免所有伤害50%','欧洲人附体，提升物品掉率20%','刷新竞技场所有关卡','获得1-3级宝箱的概率为72%，获得4-5级宝箱的概率为28%','一级宝箱，开出随机宝器的几率为80%','二级宝箱，开出随机宝器的几率为85%','三级宝箱，开出随机宝器的几率为90%','四级宝箱，70%几率开出随机宝器，15%几率开出1级神器，10%几率获得2级神器，5%几率获得3级神器；','五级宝箱：55%几率开出随机宝器，20%几率开出1级神器，15%几率获得2级神器，10%几率获得3级神器；','获得一个额外的斗魂点但不能超出上限。','暗夜蛛丝+初云宝砂衣max=蛛丝纯骨甲','锐利蛛尖+初云短泉剑max=锐利妖金剑','提升蛛丝纯骨甲与锐利妖金剑的装备经验30点。','蛇龙皮+蛛丝纯骨甲max=蛇龙冥魄甲','蛇龙尖牙+锐利妖金剑max=蛇龙破羽剑','提升蛇龙冥魄甲与蛇龙破羽剑的装备经验50点。','可以使斗者意志技能的经验值增加100点','可以使斗者意志技能的经验值增加500点','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之鳞甲+蛇龙冥破甲MAX=龙鳞幽火甲','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','四个龙之利爪+蛇龙破羽剑MAX=龙威妖韫剑','可以将黯淡的斗者之心洗涤为斗者之心','可以将魂魄附在护符上，增强属性；青龙魂+青龙护符=青龙护符-附魂','可以将魂魄附在护符上，增强属性；白虎魂+白虎护符=白虎护符-附魂','可以将魂魄附在护符上，增强属性；玄武魂+玄武护符=玄武护符-附魂','可以将魂魄附在护符上，增强属性；朱雀魂+朱雀护符=朱雀护符-附魂','使用后，斗者会吸收掉将魂之魄，提升自我实力以及将魂研究员可解锁改将魂的建造','使用后，斗者会吸收掉将魂之魄，提升自我实力以及将魂研究员可解锁改将魂的建造','使用后，斗者会吸收掉将魂之魄，提升自我实力以及将魂研究员可解锁改将魂的建造','使用后，斗者会吸收掉将魂之魄，提升自我实力以及将魂研究员可解锁改将魂的建造','使用后，斗者会吸收掉将魂之魄，提升自我实力以及将魂研究员可解锁改将魂的建造','集齐四个碎片可以合成黯淡的斗者之心','集齐四个碎片可以合成黯淡的斗者之心','集齐四个碎片可以合成黯淡的斗者之心','集齐四个碎片可以合成黯淡的斗者之心'}
    local itype={'Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Purchasable','Purchasable','Purchasable','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Permanent','Purchasable','Purchasable','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Charged','Charged','Charged','Charged','PowerUp','PowerUp','PowerUp','PowerUp','PowerUp','PowerUp','Purchasable','PowerUp','PowerUp','Charged','Charged','Charged','Charged','Charged','PowerUp','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Campaign','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable','Purchasable'}
    local izdsy={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    local isycs={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    local ilv={1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    uid=854063
    for x=1,121 do
    local ad=slk.item.ches:new(change(uid+x))
    ad.Name=autoys(x,0,iname[x])
    ad.Art=iart[x]
    ad.class=itype[x]
    ad.Ubertip=autoys(x,0,iutip[x])
    ad.usable=izdsy[x]
    ad.uses=isycs[x]
    ad.Level=ilv[x]
    if isycs[x]>0 then ad.perishable=1 end 
    ?>
    call CreateItem('<?=ad.get_id()?>',<?=(-58+x)*10?>,-3840)
    <?
    end
    
    uid=855359

    for x=1,6 do
        local aid=466561
        for y=0,14 do

    ?>



    call SetPlayerAbilityAvailable(Player(<?=x-1?>),'<?=change(aid+y)?>',false)//禁用所有天赋


    <?end end
    


    for x=1,9 do 
    local ad=slk.item.ches:new(change(uid+x))
    ad.name=autoys(x,0,tostring(x)..'级装备强化')
    ad.class='PowerUp'
    ad.Powerup=1
    ad.uses=1
    ad.perishable=1
    ad.usable=1
    ad.Level=2
    
    
    ?>
    call SaveInteger(udg_hs,22,'<?=ad.get_id()?>',<?=x?>)
    call SaveInteger(udg_hs,21,'<?=change(854063+x)?>','<?=change(854064+x)?>')
    call SaveInteger(udg_hs,21,'<?=change(854073+x)?>','<?=change(854074+x)?>')
    call SaveInteger(udg_hs,'<?=ad.get_id()?>',100,'<?=change(854063+x)?>')
    call SaveInteger(udg_hs,'<?=ad.get_id()?>',101,'<?=change(854073+x)?>')

    call CreateItem('<?=ad.get_id()?>',<?=512*(-4+x)?>,-1024)

    <?end?>

    call SetMusicVolume(PercentToInt(50,127))

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
    endfunction
endlibrary