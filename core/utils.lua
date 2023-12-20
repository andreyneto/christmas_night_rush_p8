cartdata("xmas_nigth_rush_b")
global=_ENV
noop=function()end

languages={
	{"EN",11},
	{"BR",9},
}

language=dget(0) == 0 and 1 or dget(0)

strings={
	achievements={"achievements", "conquistas"},
	language={"language", "idioma"},
	leaderboard={"leaderboard", "placar"},
	start_game={"start game", "comecar"},
	
	score={"SCORE", "PONTOS"},
	coins={"COINS", "MOEDAS"},
	distance={"DISTANCE", "DISTANCIA"},
}

function log(str, override)
	printh(time()..": "..str, "log", override)
end

function printc(str,y,clr,s)
	local x=64-(#str*4)/2
	if(s) then prints(str,x,y,clr) else print(str,x,y,clr) end
end

function prints(str,x,y,clr)
	print(str,x+1,y+1,0)
	print(str,x,y,clr)
end

function tostr(number)
	local integerPart = flr(number)
	local decimalPart = (number - integerPart) * 10
	local integerString = flr(number).."."
	local decimalString = flr(decimalPart)
	return integerString .. decimalString
end

function fill_number(number, limit)
    local numberString = "" .. number
	
    while #numberString < (limit or 4) do
        numberString = "0" .. numberString
    end

    return numberString
end

function rndb(min, max)
	return flr(rnd(max - min + 1)) + min
end
--printo
function printo(tt,px,py,cr,oc,ty)
	tt=tostr(tt)
	tl=#tt
   
	for i=1,#tt do
	 if ord(tt,i)>128 then
	  tl+=1
	 end
	end
   
	if px==c then
	 px=64-tl*2
	end
   
	--type nill (outline)
	if ty==nil then
	 for x=-1,1 do
		 for y=-1,1 do
		  print(tt,px+x,py+y,max(oc,0))
		 end
		end
   
	   --type zero (noline)
	   elseif ty==0 then
   
	   --type one (lazyline)
	   elseif ty==1 then
		for x=-1,1 do
		 for y=-1,2 do
		  print(tt,px+x,py+y,max(oc,0))
		 end
		end
   
	   --type two (sharpline)
	   elseif ty==2 then
		for i=-1,1 do
		 print(tt,px,py+i,max(oc,0))
		 print(tt,px+i,py,max(oc,0))
		end
   
	   --type three (crazyline)
	   elseif ty==3 then
		for x=-1,1 do
		 for y=-1,1 do
		  print(tt,px+x,py+y,max(oc,0))
		 end
		end
		for i=-2,2 do
		 print(tt,px,py+i,max(oc,0))
		 print(tt,px+i,py,max(oc,0))
		end
	   end
	print(tt,px,py,cr)
   end