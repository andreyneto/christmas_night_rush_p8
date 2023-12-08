global=_ENV
noop=function()end

function log(str, override)
	printh(str, "log", override)
end

function printc(str,y,clr)
	local x=64-(#str*4)/2
	print(str,x,y,clr)
end

function prints(str,x,y,clr)
	print(str,x+1,y+1,0)
	print(str,x,y,clr)
end

function pad(str,len,char)
	str=tostr(str)
	char=char or "0"
	if (#str==len) return str
	return char..pad(str, len-1)
end