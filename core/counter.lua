function counterh(x, y, label, value, sprite)
    if(sprite) then
        spr(sprite, x, y+1)
        x += 10
    end
    prints(value,x,y, 7)
    prints(label[language()],x,y+5, 6)
end
function counterv(y, label, value, s1, s2, s3)
	local cs=64-(26)/2
    if(s1) then
        spr(s1, cs, y+1)
        spr(s2 or s1, cs+9, y+1)
        spr(s3 or s1, cs+18, y+1)
        y+=10
    end
    printc(value,y+1, 7, true)
    printc(label[language()],y+6, 6, true)
end