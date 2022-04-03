pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
#include animation.lua
#include attract.lua 
#include entities.lua 
#include game_over.lua 
#include inventory.lua
#include items.lua 
#include main.lua 
#include playing.lua 
#include spells.lua 
#include utils.lua 

-------------------------------------------------------------------------
function _init()
    main_init()
end

-------------------------------------------------------------------------
function _update60()
    main_update(1/60);
end

-------------------------------------------------------------------------
function _draw()
    cls();
    main_draw();
end

__gfx__
00000000007770700077700000777070007770000077707000000070000000700000007000000070000000700000000000000000333555550000000000000000
00000000007783bb00778070007783bb00778070007878bb007773bb000003bb000003bb000003bb000003bb0000000000000000636656560000000000000000
0070070000067030000673bb00067030000673bb00067030007878300077703000777030000000300000003000070b0000000000353556330000000000000000
00077000002520400025203000252040002520307025204070067040007878400078784000777040007770400000300000000000656366360000000000000000
00077000007256700772504000725670007250400772567070252047700670407006704000787840008780400077740000000000653553560000000000000000
00700700072220400722267007222040007226700022204007025047702520477025204770067040006760400057504000000000656656360000000000000000
00000000007220400022204000722040002720400022204000222040722250477222504770252047625252406267620400000000656553560000000000000000
00000000022220400222204002222040022220400222204022222240222222402222224027225247772522467725226600000000555555550000000000000000
00000000000000000000000000000000000000000777777007777770707000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009009777000000000044444407007700777777777707000000000000000000000000000000000000000000000000000000000000000000000
0000000000097770099a9a7700000000044444407777777775577557707000000000000000000000000000000000000000000000000000000000000000000000
00000000009a9a77988899aa00000000044444407007700775577557707007070000000000000000000000000000000000000000000000000000000000000000
00000000098889aa09989a7a00000000000a70007777777777777777070000700000000000000000000000000000000000000000000000000000000000000000
0000000000998aaa0099aaa000000000044aa4407007700707777770707770770000000000000000000000000000000000000000000000000000000000000000
000000000009aaa09000000000000000044444400777777006777760070007000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000006666660007770000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000666060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000006fc060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000006ff060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055566550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055544040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001100000000000000c77000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaa000000000000cc67700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000fb0c000000000000c67700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000001160400000000000ccc6700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a1f40000000000000c7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000011a04000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111104000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0d0d0d0d0d0d0d0d000d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000000000d0000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000000000d0000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000000000d0000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000000000d0000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000d0d0d0d0000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000000000000000000000000d000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000000000000000000000000d000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000026140241402214022140201401f1401e1401d1301c1301b1301b1301a1201a12019120191201812018120171201712016110151101511414114131141311412114101140f1140d114101051010510105
000100001c05018050130500f0430d0340b0350a02509015080150701500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
0001000019051190511a0511b0511c0511d0511f05122051280512d0511b0511b0511b0511d0512005124051270512c051330511705118051190511a0511d0512105123051280512d0513105135051380513a051
0010000012150151501a1000010013100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
00100000241300000000000000002413000000000002213000000000000000000000221300000000000000002113000000000000000022130000001d1001d1300000000000201000000000000000000000000000
001000000511004100051100010005110041000511004100051100410005110041000511004100051100410005110041000511004100051100410005110041000511004100051100410005110041000511004100
00100000181001810022120181002212024120181001810029110261001810018100171001f100171001c1001c1001c1001e1001e1002110018100181001810018100221301f1002213024130171002713029130
__music__
03 04050644

