cartdata("xmas_nigth_rush_b")
global=_ENV
noop=function()end

languages={
	{"EN",158},
	{"BR",142},
}

language=dget(0) == 0 and 1 or dget(0)

strings={
	achievements={"achievements", "conquistas"},
	language={"language", "idioma"},
	leaderboard={"leaderboard", "placar"},
	start_game={"start game", "comecar"},
	
	score={"SCORE", "PONTOS"},
	coins={"COINS", "MOEDAS"},
}

function log(str, override)
	printh(str, "log", override)
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
	
    while #numberString < (limit or 5) do
        numberString = "0" .. numberString
    end

    return numberString
end