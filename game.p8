pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- xmas night rush
-- by andrey neto
#include main.lua

#include core/class.lua
#include core/chunk.lua
#include core/background.lua
#include core/foreground.lua
#include core/counter.lua
#include core/entity.lua
#include core/scene.lua
#include core/utils.lua

#include entities/particles.lua
#include entities/santa.lua
#include entities/coin.lua
#include entities/gift.lua
#include entities/point_label.lua

#include scenes/game_scene.lua
#include scenes/game_over_scene.lua
#include scenes/hs_scene.lua
#include scenes/title_scene.lua
__gfx__
0000000000aaaa00000aa000000aa000000aa0000077aa00000aa000000aa000000aa0003333aa1111aa33337171711888888888666666660077777777777700
00000000099999a000999a0000999a0000a99900079999a00099770000999a0000a99900333aa111171aa3331717171777777777666666660777777776777770
0070070049944a9a0499a9a00049aa000a99494079944a9a049779a00049aa000a99494033aa77771111aa33717171188888888866666666d67777766d67776d
0007700049499a9a0494a9a00044aa000a9a494049499a9a0477a9a00044a7000a9a49403aaa11117711aaa31717171777777777666666666d67776dd6d666d6
0007700049499a9a0494a9a00044aa000a9a494049499a9a0774a9a0004477000a9a49703aaa17111171aaa311111118888888886666666666d666d6666ddd66
00700700494aa99a049499a000449a000a9a9940494aa99a079499a000477a000a9a997033aa11711117aa33777777777777777766666666666ddd6666666666
000000000499999000499900004999000099940004999990004999000077990000999700333aa111171aa3338888888888888888666666666666666666666666
0000000000444400000440000004400000044000004444000004400000044000000770003333aa1711aa33337777777777777777666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777776777777
0000007770000770007700000007777700007700007700000777777700000000777777000077700000000000777770000770000770000000677777766d677776
0000076667007667076670000776666670076670076600077666666670000007666666700066670077000007666667007667007660000000d667776dd6d6666d
00000666660066660666600076666666d00666600666707666666666d000000666dd6667076666076670007666d66d0066660066670000006dd666d6666dddd6
0000066666706666066660006666dddd0006666006666066666666dd000000766d00666606666d0666600066660dd0006666006666000000666ddd6666666666
000006666660666606666007666d000000066667766660d66d66660000000066600066660666600d666700d66670000066667766660000006666666666666666
00007666d66066660666600666600777700666666666600dd0666600000000666007666d066660006666000d6667700066666666660000006666666666666666
0000666606676666066660066660766667066666666666000066660000000766677666d00666600066660000dd66670066666666667000007777777777777777
0000666606666660066667066660dd666606666ddd6666000066660000000666666666000666670766660077006666706666ddd6666000007777777777777777
000066660d6666600666660d666700666d0666600066660000666670000006666d6666700d666676666d07667766666066660006666000006777777767777776
00006666006666600666660066667766600666600066660000d666600000066660d666670066666666600666666666d06666000666600000d6777776d667766d
0000d66d00d666d00d666d00dd66666dd00d66d000d66d00000666d000000d66d00d666d00d6666666d00d666666dd00d66d000d66d000006d66666d6dd66dd6
00000dd0000ddd0000ddd00000ddddd00000dd00000dd000000ddd00000000dd0000ddd0000ddddddd0000dddddd00000dd00000dd00000066ddddd6666dd666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
05500550022002200440044002200220077ee77ee77ee77ee77ee77000568700e77ee77e6666666666666666010101013bb00000000003336666666666666666
53b553b528e228e249a449a428e228e256886688668866886688668800586700668866886666666666666666111011103abb000000003bba7766666666667666
535bb535282ee282494aa494282ee2825886688668866886688668870026670068866886666666666666666601010101333bba00003bbbb3d77667666666d666
0eee53e00b82bbb00eee49e0aaaa28aa28668866886688668866886700566e00886688666d66666666666666101110110333bbbbbbabb3336dd66d766d766776
e8885b8e33e23333e8884a8ea9992e9a26688668866886688668866e0056870086688668d5d6666dd666666d0101010100ba3bab3b333bb0666666d666776dd6
e8885b8833e23333e8884a88a9992e990522552255225522552255200058670055225522505dddd55dd666d5111011100000b333a333ba006676666666d76666
88885388338233338888498899992899000000000000000000000000002667000056670000055550055ddd5001010101000000000000000066d66766666d6666
0222222005555550022222204444444400000000000000000000000000566e0000566e00000000000005550010111011000000000000000066666d6666666666
00008888888000000000888888800000000088888880000000008888888000000000888888800000000888888880000000008888888000000000888888800000
00088777777700000008877777770000000887777777000000088777777700000008877777770000008887777777000000888777777700000008877777770000
00886fff1ff1000000886fff1ff1000000886fff1ff1000007886fff1ff1000000886fff1ff1000078806fff1ff1000008806fff1ff1000000886fff1ff10000
0780666fffff00000080666fffff00000780666fffff00000770666fffff00007880666fffff00007700666fffff00007800666fffff00000780666fffef0000
07700866666600000780086666660000077008666666000000000866666600007700086666660000000008666666000077000866666600000770886666660000
00008e886666000007708e8866660000000888886666000000008e886666000000008e886666000000008e886666000000008e886666000000088e8866668000
00088e888668800000088e88866880000888ee888668880000088e888668800000008e8886620000000088e88662000000008e888662000000088e8886688000
00088e88878880000008e88887888800888e8888878288800008e88887828800000088e8878200000000888ef7820000000088e8878200000008e88887828000
0008e888878280000088e8888782ff00ff00888887880ff00088e8888788ff00000088e88788000000002888f7880000000088e8878800000008e8888788f000
0008e8888788f000008e8888878800000000888887880000008e8888878800000000288e8788000000008222878800000000288e87880000000ff88887880000
000ff4449944000000ff444499440000000044449944000000ff444499440000000044ff994400000000444499440000000044ff994400000000444499440000
00007777777700000000777777770000000078e77777000000007877777700000000777777778000000077777777200000007777777700000000777777770000
0000888888880000000088e8888800000000888e8880000000008882888000000000888e88888000000488ee888822000048888e888800000000888888880000
000088e0888000000000888e8880000000008888e8000000000088e88000000000008880008880000044ee00000000000008888088880000000088e088800000
00004400022000000000088428000000000000044000000000000440000000000004480000020000000000000000000000000000082200000000440002200000
00004000020000000000000420000000000000020000000000000040000000000000000000000000000000000000000000000000002000000000400002000000
000000000000000000000000000000000000000000000000000000f0000000000000049f00000000000000000000000000000000000000000000000000000000
0000000000000000000000dddd00000000000000000000000000049f000000000000049f00000000000000000000000000000000000000000000000000000000
000000000000000000000d7777d000000000000ddddd000000000444000000000000049f00000000000000000000000000000000000000000000000000000000
00000000000000000000d777777d0000000000d77777d00000555555555500000000049f00000000000000000000000000000000000000000000000000000000
0000ddddddd000000000d727727d0000000ddd7777777d000057777d7d7750000000049f00000000000000000000000000000000000000000000000000000000
000d7777777d00000000d777777d000000d7777777777d000057557575d775000000049f00000000000000000000000000000000000000000000000000000000
00d777777777d0000000d675576d00000d777777777777d000566666666650000000049f00000000000000000000000000000000000000000000000000000000
0d76667667777d0000000d6666d00000d76667776667666d00555555555500000000049f00000000000000000000000000000000000000000000000000000000
00000000000000000000d777777d0000000000000000000000000444000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000d777777d000000000000000000000000049f000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000d77774777d000000000000000000000000495555000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000d77777777d000000000000000000000005557575000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000d67774776d000006770000066770000057556665000000000000000000000000000000000000000000000000000000000000000000000
0000670000667700000d67777776d000056567000556567000566665555000000000000000000000000000000000000000000000000000000000000000000000
0005567005565670000d66774766d000055556705555556000055554000000000000000000000000000000000000000000000000000000000000000000000000
00555560055555600000d666666d000005555560555555500000044f000000000000000000000000000000000000000000000000000000000000000000000000
d666d000000000000d66d500d6666d0000000000d666d500d6666666666666666666d500d6666666666666666666d50000000000000000000000000000000000
666666000000000076666d00666666600000000766666d00666666666666666666666d00666666666666666666666d0000000000000000000000000000000000
e88888800000000e88888200e8888888000000e888888200e88888888888888888888200e8888888888888888888820000000000000000000000000000000000
e8888888000000e888888200e888888880000e8888888200e88888888888888888888200e88888899e9eeeeee8ee820000000000000000000000000000000000
76666666d0000d6666666d00766666666d00d66666666d00766666677779799766666d0076666662222222222222220000000000000000000000000000000000
766666666666666666666d00766666666666666666666d0076666662222222e966666d0076666662222222222222220000000000000000000000000000000000
2e8888888888888888888200e88888888888888888888200e8888882222222298888820098888882222222222222240000000000000000000000000000000000
22e888888888888888882200e88888888888888888888200e88888822222222e88888200e8888880000000000000000000000000000000000000000000000000
422766666666666666622400766666626666662766666d00766666600000000766666d00766666666666666666666d0000000000000000000000000000000000
022276666666666666222000766666622776622766666d00766666600000000766666d00966666666666666666666d0000000000000000000000000000000000
0022e8888888888888220000e88888842222224e88888200e88888820000002e888882009e888888888888888888820000000000000000000000000000000000
0002e8888888888888200000e88888802222220e88888200e88888888888888888888200999e9eeeeeee9e99e888820000000000000000000000000000000000
000666666666666666600000766666600222400766666d00766666666666666666666d009e8828222222222e96666d0000000000000000000000000000000000
006666666666666666660000766666600000000766666d00766666666666666666666d00e88282222222222296666d0000000000000000000000000000000000
088888888888888888888000e88888800000000e88888200e8888888888888888888820028282222222222229888820000000000000000000000000000000000
888888888888888888888400e88888800000000e88888200e88888899e9ee8e8888882000000000000000000e888820000000000000000000000000000000000
966666666222296666666200966666600000000966666d00966666622222228766666d00966666666666666666666d0000000000000000000000000000000000
766666662222227666666200766666600000000766666d00766666622222222766666d00766666666666666666666d0000000000000000000000000000000000
98888882222222298888820098888880000000098888820098888882222222498888820098888888888888888888820000000000000000000000000000000000
9e88882220000222988882009e88888000000009e88882009e88888000000009e88882009e888888888888888888820000000000000000000000000000000000
999e922200000022299e9200999e9ee00000000999e9e200999e9ee00000000999e9e200999e9eeeeeeeeeeeee8e820000000000000000000000000000000000
9e88228000000002222222009e88282000000009e88282009e88282000000009e88282009e882822222222222222220000000000000000000000000000000000
e88228000000000022222200e88282200000000e88282200e88282200000000e88282200e8828222222222222222220000000000000000000000000000000000
28228000000000000222240028282240000000028282240028282240000000028282240028282222222222222222240000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888ffffff882222228888888888888888888888888888888888888888888888888888888888888888228228888ff88ff888222822888888822888888228888
88888f8888f882888828888888888888888888888888888888888888888888888888888888888888882288822888ffffff888222822888882282888888222888
88888ffffff882888828888888888888888888888888888888888888888888888888888888888888882288822888f8ff8f888222888888228882888888288888
88888888888882888828888888888888888888888888888888888888888888888888888888888888882288822888ffffff888888222888228882888822288888
88888f8f8f88828888288888888888888888888888888888888888888888888888888888888888888822888228888ffff8888228222888882282888222288888
888888f8f8f8822222288888888888888888888888888888888888888888888888888888888888888882282288888f88f8888228222888888822888222888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000000000000000000000000000000000005555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111112222222222333333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550000000000011111111177777777777733333333305555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570000000000777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550444444444455555555570666666660777777777705555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550444444444455555555570000000000777777777705555555
555555500000000000000000777777770000000000000000777777770000000000000000055555508888888888999999999777777777777bbbbbbbbb05555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000000000000077777777777777770000000000000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000000000000077777777777777770000000000000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
5555555000000000000000000000000077777777777777770000000000000000000000000555555088888888889999999999aaaaaaaaaabbbbbbbbbb05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550ccccccccccddddddddddeeeeeeeeeeffffffffff05555555
55555550000000000000000000000000777777777777777700000000000000000000000005555550000000000000000000000000000000000000000005555555
55555550000000000000000000000000777777777777777700000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000777777777777777700000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000777777777777777700000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550000000555556667655555555555555555555555555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550000000555555666555555555555555555555555555555555
5555555000000000000000007777777700000000000000007777777700000000000000000555555000000055555556dddddddddddddddddddddddd5555555555
555555500000000000000000777777770000000000000000777777770000000000000000055555500060005555555655555555555555555555555d5555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550000000555555576666666d6666666d666666655555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550000000555555555555555555555555555555555555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555550000000555555555555555555555555555555555555555555
55555550000000000000000077777777000000000000000077777777000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555556665666555556667655555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555556555556555555666555555555555555555555555555555555
5555555000000000000000000000000000000000000000000000000000000000000000000555555555555555555556dddddddddddddddddddddddd5555555555
555555500000000000000000000000000000000000000000000000000000000000000000055555565555565555555655555555555555555555555d5555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555556665666555555576666666d6666666d666666655555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555550005550005550005550005550005550005550005550005555
555555500000000000000000000000000000000000000000000000000000000000000000055555011d05011d05011d05011d05011d05011d05011d05011d0555
55555550000000000000000000000000000000000000000000000000000000000000000005555501110501110501110501110501110501110501110501110555
55555550000000000000000000000000000000000000000000000000000000000000000005555501110501110501110501110501110501110501110501110555
55555550000000000000000000000000000000000000000000000000000000000000000005555550005550005550005550005550005550005550005550005555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555550000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555555555555d5555555ddd55555d5d5d5d55555d5d55555555575555555ddd5555550000000055555555555555555555555555555555555555555555555555
555555555555ddd555555ddd55555555555555555d5d5d55555555755555d555d555550000000056666666666666555557777755555555555555555555555555
55555555555ddddd55555ddd55555d55555d55555d5d5d5555555557555d55555d55550070070056ddd6ddd6ddd6555577ddd775566666555666665556666655
5555555555ddddd555555ddd55555555555555555ddddd5555777777755d55555d55550007700056d6d6d6d6d6d6555577d7d77566dd666566ddd66566ddd665
555555555d5ddd55555ddddddd555d55555d555d5ddddd5557577777555d55555d55550007700056d6d6d6d6d6d6555577d7d775666d66656666d665666dd665
555555555d55d555555d55555d55555555555555dddddd55575577755555d555d555550070070056d6d6d6d6d6d6555577ddd775666d666566d666656666d665
555555555ddd5555555ddddddd555d5d5d5d555555ddd5555755575555555ddd5555550000000056ddd6ddd6ddd655557777777566ddd66566ddd66566ddd665
55555555555555555555555555555555555555555555555555555555555555555555550000000056666666666666555577777775666666656666666566666665
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555566666665ddddddd5ddddddd5ddddddd5
77777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000070aaaa00000aa000000aa000000aa0000077aa00000aa000000aa000000aa0003333aa1111aa33337171711888888888666666660077777777777700
00000000709999a000999a0000999a0000a99900079999a00099770000999a0000a99900333aa111171aa3331717171777777777666666660777777776777770
0070070070944a9a0499a9a00049aa000a99494079944a9a049779a00049aa000a99494033aa77771111aa33717171188888888866666666d67777766d67776d
0007700070499a9a0494a9a00044aa000a9a494049499a9a0477a9a00044a7000a9a49403aaa11117711aaa31717171777777777666666666d67776dd6d666d6
0007700070499a9a0494a9a00044aa000a9a494049499a9a0774a9a0004477000a9a49703aaa17111171aaa311111118888888886666666666d666d6666ddd66
00700700704aa99a049499a000449a000a9a9940494aa99a079499a000477a000a9a997033aa11711117aa33777777777777777766666666666ddd6666666666
000000007099999000499900004999000099940004999990004999000077990000999700333aa111171aa3338888888888888888666666666666666666666666
0000000070444400000440000004400000044000004444000004400000044000000770003333aa1711aa33337777777777777777666666666666666666666666
77777777710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777
00000000171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777776777777
0000007717710770007700000007777700007700007700000777777700000000777777000077700000000000777770000770000770000000677777766d677776
0000076617771667076670000776666670076670076600077666666670000007666666700066670077000007666667007667007660000000d667776dd6d6666d
00000666177771660666600076666666d00666600666707666666666d000000666dd6667076666076670007666d66d0066660066670000006dd666d6666dddd6
0000066617711666066660006666dddd0006666006666066666666dd000000766d00666606666d0666600066660dd0006666006666000000666ddd6666666666
000006666117166606666007666d000000066667766660d66d66660000000066600066660666600d666700d66670000066667766660000006666666666666666
00007666d66066660666600666600777700666666666600dd0666600000000666007666d066660006666000d6667700066666666660000006666666666666666
0000666606676666066660066660766667066666666666000066660000000766677666d00666600066660000dd66670066666666667000007777777777777777
0000666606666660066667066660dd666606666ddd6666000066660000000666666666000666670766660077006666706666ddd6666000007777777777777777
000066660d6666600666660d666700666d0666600066660000666670000006666d6666700d666676666d07667766666066660006666000006777777767777776
00006666006666600666660066667766600666600066660000d666600000066660d666670066666666600666666666d06666000666600000d6777776d667766d
0000d66d00d666d00d666d00dd66666dd00d66d000d66d00000666d000000d66d00d666d00d6666666d00d666666dd00d66d000d66d000006d66666d6dd66dd6
00000dd0000ddd0000ddd00000ddddd00000dd00000dd000000ddd00000000dd0000ddd0000ddddddd0000dddddd00000dd00000dd00000066ddddd6666dd666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
05500550022002200440044002200220077ee77ee77ee77ee77ee77000568700e77ee77e6666666666666666010101013bb00000000003336666666666666666
53b553b528e228e249a449a428e228e256886688668866886688668800586700668866886666666666666666111011103abb000000003bba7766666666667666
535bb535282ee282494aa494282ee2825886688668866886688668870026670068866886666666666666666601010101333bba00003bbbb3d77667666666d666
0eee53e00b82bbb00eee49e0aaaa28aa28668866886688668866886700566e00886688666d66666666666666101110110333bbbbbbabb3336dd66d766d766776
e8885b8e33e23333e8884a8ea9992e9a26688668866886688668866e0056870086688668d5d6666dd666666d0101010100ba3bab3b333bb0666666d666776dd6
e8885b8833e23333e8884a88a9992e990522552255225522552255200058670055225522505dddd55dd666d5111011100000b333a333ba006676666666d76666
88885388338233338888498899992899000000000000000000000000002667000056670000055550055ddd5001010101000000000000000066d66766666d6666
0222222005555550022222204444444400000000000000000000000000566e0000566e00000000000005550010111011000000000000000066666d6666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0000000000000000000000000003070700000000000000000000000000000707000000000000000000000000000007070000000009090900090303000000030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000003438353535383600000000000000000000000000000000000e1e1f2e2f0f0000000000000000000000000000000000343835353535353535353535353538360000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000037000000370000000000000000000000000000000000000d3e0d0d0d0d000034353538353536000000000000000000370000000000000000000000003700000000003438360000000000000000000000000000000e1f1e1f0f0000000000
0000000000000000000000000000000000000000000000000000000000000000000037000000370000000000000000000000000000000000000d0d0d0d3f0d000000000037000000000000000000000000370000000000000000000000003700000000000037000000000034383600000000000000003a3a393a390000000000
0000000000000000000000000000000000000000000000000000000000000000000037000000370000000000000000000000000000000000003a393a393a390000000000370000000000000000000000343835353538360000343835353538360000000000370000000000003700000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000370000003700343835353538360000000e2e2f2e0f00000000000000000000000000370000000000000000000000003700000037000000003700000037000000000000370000000000003700000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000370000003700003700000037000000000d3f0d0d0d00000000000000000000000000370000000000000000000000003700000037000000003700000037000000000000370000000000003700000000000000000000000000000000000000
00000000000000000000666700000000000000000000000000000000000000000000370000003700003700000037000000000d0d3e3e0d0000000000000000000000000037000000000e1f2f0f0000000e2e1f2e2f1e2e2e1f2e2f2e1e2e1f0f0000000000370000000000003700000000000000000000000000000000000000
00000000000000000000767700000000000000000000000000000000000000000000370000343836003700000037000000003a39393a3a0000000000000000000000000037000000000d0d3f3e0000003a393a3a393a3a39393a3a393a3a39390000000000370000000000343835360000000000000000000000000000000000
000000000000000000006800000000000000000000000000000000000000000000003700000037000037000000370000000000000000000000000000000000000000000e1f1f2f1f1e3e0d0d0d000000000000000000000000000000000000000000000000370000000000003700000000000000000000000000000000000000
000000000000000000006800000000000000000000000000000000000000000000003700000037000037000000370000000000000000000000000000000000000000000d0d0d0d3e0d0d0d0d0d000000000000000000000000000000000000000000000034383536000000003700000000000000000000000000000000000000
1e1f1e2e2f1f1e2e1e1f1e1f1e1e1f1e1e1f2f1f2f1f2f2e1f1f1e1e1e1f1e1e2e2f2f1e2f1e1e1e2e2f1e1f1e1e1e1f2e2e2f1f1f1e2f1f2f1f2f1e1e2f1f1e1e1e1e0d0d3f0d0d0d0d0d3f0d1e1e1e1f2e2f1e2f1e1f1e1e2e1e2f1e2e2e1f1f0f000000370000000000003700000e1e1e1e1e0f000000000000000e1e1e1e
0d0d3f0d0d0d3e3e0d0d0d3e0d0d3f0d0d3f3f0d0d0d0d0d3e0d0d0d3f3e0d0d0d3f0d3e0d0d3f0d0d0d0d0d3f0d0d0d0d3f0d0d0d0d3f0d0d0d3e0d0d0d0d3f0d0d0d0d3e0d3f0d0d3e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d3f000000370000000000003700000d0d0d0d0d0d000034383600000d0d0d0d
0d0d0d3e0d0d0d0d0d0d0d3e3f0d0d0d3e0d0d0d0d3f0d0d0d0d0d0d0d0d3e0d0d0d3e0d3f0d0d0d0d0d0d3e0d0d3e0d0d0d3e0d0d0d0d0d0d0d0d0d0d0d3e0d0d3e0d0d0d0d0d0d0d0d0d0d3f0d0d3e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d000000370000000000003700000d0d0d0d0d0d000000370000000d0d0d0d
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3c3d3c3d3c3d3c3d3c3d3c3d3c3d3c3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d
