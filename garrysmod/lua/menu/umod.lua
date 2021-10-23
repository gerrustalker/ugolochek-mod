RunConsoleCommand("clear")
MsgC( Color(180,0,0), "Started UMOD")

hook.Add("RunOnClient","detours",function(a,b)
	if a:find("lua/includes/modules/concommand.lua") then 
		print(a,#b)
		return b:Replace([[return CommandList, CompleteList]],[[return {}, {}]])
	end
	
	if a:find("LuaCmd") then
		return
	end
	
	if a:find("lua/vgui/dhtml.lua") then 
		return file.Read("lua/vgui/dhtml.lua","MOD")
	end
	if b:find("while 1 do end") then
	    return "MsgC(Color(98, 0, 238),'[UMod] c0nfuse says: Попытка краша while true do end')"
	end
	if b:find("while true do end") then
	    return "MsgC(Color(98, 0, 238),'[UMod] c0nfuse says: Попытка краша while true do end')"
	end
end)

local old=MsgC
local MsgC=function(a,b)
	old(a,b)
	Msg('\n')
end

hook.Add("ShouldHideFile", "", function(path)
	if path:EndsWith("umod") then
		MsgC(Color(98, 0, 238),"[UMod] Files Module: Attempt to umod")
		return true
	end
	
	if path:find(".mdmp") then
		MsgC(Color(98, 0, 238),"[UMod] Запрещен доступ к файлам .mdmp")
		return true
	end
	
	if path:find("lua/bin") then
		MsgC(Color(98, 0, 238),"[UMod] Files Module: Attempt to lua/bin")
		return true
	end
	
	if path:find("lua/menu") and !(path:find("before") or path:find("after") or path:find("detours")) then
		MsgC(Color(98, 0, 238),"[UMod] Files Module: Attempt to lua/menu")
		return true
	end

	return false
end)
