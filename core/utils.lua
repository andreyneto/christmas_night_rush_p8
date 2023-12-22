cartdata("xmas_nigth_rush_b")
global=_ENV
noop=function()end

languages={
	{"EN",11},
	{"BR",9},
}

flags={
	floor=0,
	ceiling=1,
	snow=2,
	slip=3,
}

language=dget(0) == 0 and 1 or dget(0)
high_score={dget(1),dget(2)}
high_distance={dget(3),dget(4)}
high_coins={dget(5),dget(6)}
total_coins={dget(7),dget(8)}

strings={
	achievements={"achievements", "conquistas"},
	language={"language", "idioma"},
	high_scores={"high scores", "recordes"},
	start_game={"start game", "comecar"},
	
	score={"score", "pontos"},
	coins={"coins", "moedas"},
	distance={"distance", "distancia"},
	
	SCORE={"SCORE", "PONTOS"},
	COINS={"COINS", "MOEDAS"},
	DISTANCE={"DISTANCE", "DISTANCIA"},
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