cartdata("xmas_nigth_rush_f")
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

function language()
	return dget(0) == 0 and 1 or dget(0)
end
function high_score() return dget(1) end
function high_distance() return dget(2) end
function high_coins() return dget(3) end
function total_coins() return {dget(4),dget(5)} end
function total_distance() return {dget(6),dget(7)} end
function total_score() return {dget(8),dget(9)} end
function current_coins() return {dget(10),dget(11)} end
			
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

	back={"back", "voltar"},
	menu={"main menu", "menu"},
	play_again={"play again", "jogar novamente"},

	new_high_score={"new high score","novo recorde"},
	game_over={"game over","valeu natalina"},
	achievement_unlocked={"ACHIEVEMENT UNLOCKED","CONQUISTA DESBLOQUEADA"}
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
	
    while #numberString < (limit or 5) do
        numberString = "0" .. numberString
    end

    return numberString
end

function rndb(min, max)
	return flr(rnd(max - min + 1)) + min
end

function pad(str,len,char)
	char=char or "."
	if (#str==len) return str
	return pad(str, len-1)..char
end