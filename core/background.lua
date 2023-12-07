background=class:extend({
    shades={
        0b0000000000000000,
        0b1000000000000000,
        0b1000000000100000,
        0b1010000000100000,
        0b1010000010100000,
        0b1010010010100000,
        0b1010010010100001,
        0b1010010110100001,
        0b1010010110100101,
        0b1110010110100101,
        0b1110010110110101,
        0b1111010110110101,
        0b1111010111110101,
        0b1111110111110101,
        0b1111110111110111,
        0b1111111111110111
    },
    gradsteps={0,42,93,127},
    gradpal={0,1,2,3},
    update=function(_ENV)
        i=2
        i2=1
        
        gradient={}
        gradient[1]={0b1111111111111111,0}
        
        while i<129 do
         if i2<#gradsteps then
          substep=i-gradsteps[i2]
          incr=16/(gradsteps[i2+1]-gradsteps[i2])
          curr_shade=flr(incr*substep)+1
          gradient[i]={shades[curr_shade],i2*17-1}
         else
          gradient[i]={0b1111111111111111,(#gradsteps-1)*16}
         end
         i+=1
         if i==gradsteps[i2+1] then i2+=1 end
        end
    end,
    draw=function(_ENV)
        for i=1,#gradpal do
        pal(i-1, gradpal[i])
        end
        for y=0,127 do
        fillp(gradient[y+1][1])
        line(0,y,127,y,gradient[y+1][2])
        end
        fillp()
    end
})