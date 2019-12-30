PLUGIN.name = "sky's edits"
PLUGIN.author = "sky"
PLUGIN.desc = "assorted hooks and other things"


nut.util.include("sh_commands.lua")
--[[
hook.Add("PhysgunPickup", "StopDoorMoving", function (client, entity)
	if(entity:GetClass():lower() == "func_door" or entity:GetClass():lower() == "func_door_rotating" or entity:GetClass():lower() == "prop_door_rotating") then return false end    
end)

hook.Add("GetPlayerIcon", "meeeicon", function(client)
    --todo
end)
]]

function PLUGIN:StartCommand(ply, cmd)
	if(ply:GetMoveType() != MOVETYPE_NOCLIP and ply:getNetVar("brth", false) and cmd:KeyDown(IN_JUMP)) then
		cmd:RemoveKey(IN_JUMP)
	end
end

hook.Add("CanProperty", "nobonemanip", function (ply, prop, ent)
	--persist has always been wonky for me, and since even recently its caused the server to break, and i prefer permaprops instead, im just preventing anyone from doing it
	if(prop == "persist") then return false end
	if(prop == "drive") then return false end
	if(prop == "bonemanipulate") then return false end
	if(!ply:IsAdmin() && prop == "editentity") then return false end --uh prob dont let randos do that
end)

local fems = { 
	["models/sky/stalker/neo.mdl"] = true,
	["models/sky/stalker/quiet.mdl"] = true,
}

hook.Add("CustomFemaleModel", "customSrpModel", function(model, ply, char)
	if(fems[model]) then return true end

	if(char and char:getData("cFemale")) then
		return char:getData("cFemale")
	end

	if(IsValid(ply) and ply:getChar() and ply:getChar():getData("cFemale")) then
		return ply:getChar():getData("cFemale")
	end

	if(string.find(model,"metroll/f")) then
		return true
	end
	
	return nil
end)
	
hook.Add("PluginShouldLoad", "disablePlugins", function(id)
	--dont need these
--[[	if(id == "recognition") then
		return false
	end
	]]
end)




--weight
nut.config.add("weightEnabled", false, "Enable weight system.", nil, {
	category = "Characters"
})
nut.config.add("weightMax", 15, "Max weight players can hold.", nil, {
	form = "Int",
	data = {min = 1, max = 100},
	category = "Characters"
})

--this could probably be done a bunch better, but a bunch of my stuff can be at first
hook.Add("CanItemBeTransfered", "weightWorkings", function(item, curInv, target)
	if(!nut.config.get("weightEnabled")) then return end
	print("ejfpojadopfspdfo")
	if(target:getID() != 0 and !target.vars.isTempStorage and target:getReceiver()) then
		local items = target:getItems()
		local weight = 0
		print("target isnt 0 and istempstorage")
		for k,v in pairs(items) do
			local itemWeight = (v.getWeight and v:getWeight()) or v:getData("weight") or v.weight or 1
			
			if(itemWeight) then
				weight = weight + itemWeight
			end
		end
		
		local itemWeight = (item.getWeight and item:getWeight()) or item:getData("weight") or item.weight or 1
		print("weight "..itemWeight.." "..weight)
		if(itemWeight == 0) then
			return --this doesnt have any weight so its ok
		end
		print("ok")
		if(weight + itemWeight > (target.vars.maxWeight or nut.config.get("weightMax", 15))) then
			print("i swear if its here")
			nut.util.notify("You cannot fit this!", target:getReceiver())
			return false
		end
		print("good")
		target.vars.weight = weight+itemWeight --so can access somewhere else

		if(SERVER) then
			net.Start("SendWeightToClient")
			net.WriteFloat(weight+itemWeight)
			net.WriteFloat(target.vars.maxWeight or 0)
			net.Send(target:getReceiver())
		end
	end
	print("wtf")
	if(curInv:getID() != 0 and !curInv.vars.isTempStorage and curInv:getReceiver()) then
		--first, make sure the inv is up to date on weight
		local items = curInv:getItems()
		local weight = 0
		print("curinv isnt 0 and istempstorage")
		for k,v in pairs(items) do
			if(v.id == item.id) then continue end --dont count

			local itemWeight = (v.getWeight and v:getWeight()) or v:getData("weight") or v.weight or 1
			if(itemWeight) then
				weight = weight + itemWeight
			end
		end

		curInv.vars.weight = weight --so can access somewhere else

		local itemWeight = (item.getWeight and item:getWeight()) or item:getData("weight") or item.weight or 1
		
		print("weight "..itemWeight.." "..weight)
		if(itemWeight == 0) then
			return --this doesnt have any weight so its ok
		end
		print("ok")

		if(weight + itemWeight > (curInv.vars.maxWeight or nut.config.get("weightMax", 15))) then
			print("or here")
			nut.util.notify("You cannot fit this!", curInv:getReceiver())
			return false
		end
		print("good")
		
		if(SERVER) then
			net.Start("SendWeightToClient")
			net.WriteFloat(weight)
			net.WriteFloat(curInv.vars.maxWeight or 0)
			net.Send(curInv:getReceiver())
		end
	end
end)

--found out you can switch characters while in a vehicle or sitting and youd be in the same spot
function SCHEMA:CanPlayerUseChar(client, char)
	if(!client) then return end
	if(client:InVehicle()) then
		return false, "You cannot switch characters while in a vehicle or sitting!"
	end
	if(client:getNetVar("restricted")) then
		return false, "You cannot switch characters while tied!"
	end
end

if(SERVER) then
	hook.Add("CharacterLoaded", "GetWeight", function(id)
		if(!nut.config.get("weightEnabled")) then return end
		local char = nut.char.loaded[id]
		if(char and char:getInv()) then
			net.Start("SendWeightToClient")
			if(char:getInv().vars.weight) then
				net.WriteFloat(char:getInv().vars.weight)
			else
				local items = char:getInv():getItems()
				local weight = 0
				for k,v in pairs(items) do
					local itemWeight = (v.getWeight and v:getWeight()) or v:getData("weight") or v.weight or 1
					if(itemWeight) then
						weight = weight + itemWeight
					end
				end

				char:getInv().vars.weight = weight
				net.WriteFloat(weight)
			end
			net.WriteFloat(char:getInv().vars.maxWeight or 0)
			net.Send(char:getPlayer())
		end
	end)

	hook.Add("OnReloaded", "GetWeightReload", function()
	--	if(!ITSTIMETOSTOP) then
		if(!nut.config.get("weightEnabled")) then return end
		for k,v in pairs(player.GetAll()) do
				local char = v:getChar()
				if(char) then
					net.Start("SendWeightToClient")
					local items = char:getInv():getItems()
					local weight = 0
					for k,v in pairs(items) do
						local itemWeight = (v.getWeight and v:getWeight()) or v:getData("weight") or v.weight or 1
						if(itemWeight) then
							weight = weight + itemWeight
						end
					end
					char:getInv().vars.weight = weight
					net.WriteFloat(weight)
					net.WriteFloat(char:getInv().vars.maxWeight or 0)
					net.Send(v)
				end
			end
	--	end
	end)

	--hook i made
	hook.Add("OnRemoveItem", "syncWeight", function(inv)
		if(!nut.config.get("weightEnabled")) then return end
		net.Start("SendWeightToClient")
		local items = inv:getItems()
		local weight = 0
		for k,v in pairs(items) do
			local itemWeight = (v.getWeight and v:getWeight()) or v:getData("weight") or v.weight or 1
			if(itemWeight) then
				weight = weight + itemWeight
			end
		end

		inv.vars.weight = weight
		net.WriteFloat(weight)
		net.WriteFloat(inv.vars.maxWeight or 0)
		net.Send(inv:getReceiver())
		
	end)

    --honestly if they spam space its their fault their stamina is gone
hook.Add("KeyRelease", "JumpStam", function(client, key)
    if(key == IN_JUMP and client:GetMoveType() != MOVETYPE_NOCLIP and client:getChar()) then
		client:restoreStamina(-15)
		local stm = client:getLocalVar("stm", 0)
		if(stm == 0) then
			--client:SetRunSpeed(nut.config.get("walkSpeed"))
			client:setNetVar("brth", true)
			client:ConCommand("-speed")
		end
	end
end)

hook.Add("PlayerInitialSpawn", "fukoffmusic", function(ply)
	local annoying = ents.FindByName("music")
	if(#annoying > 0) then
		annoying[1]:SetKeyValue("RefireTime", 99999999)
		annoying[1]:Fire("Disable") --i dont know if killing it stops the timer so here
        annoying[1]:Fire("Kill")
    else
        
	end
	if(game.GetMap() == "rp_stalker_redux") then --afaik this is the only map this does it on and is why this is here
		annoying = ents.FindByClass("trigger_soundscape")
		for k,v in pairs(annoying) do
			if(IsValid(v)) then
				v:Fire("Kill")
			end
		end
		local val = ents.GetMapCreatedEntity(1733) --this should be thunder?
		if(IsValid(val)) then
			val:SetKeyValue("RefireTime", 99999999)
			val:Fire("Disable") --i dont know if killing it stops the timer so here
			val:Fire("Kill")
		end
	end
end)

hook.Add("InitPostEntity", "DisableTFAStuff", function()
	timer.Simple(2, function()
    local cmenu = GetConVar("sv_tfa_cmenu")
	cmenu:SetInt(0) --lets try this instead?
	end)
   -- local bull = GetConVar("sv_tfa_bullet_penetration")
	--bull:SetBool(false) --these dont work well with shoottorp, probably should mvoe it in there
end)

hook.Add("PlayerSpray", "DisablePlayerSpray", function(ply)
	return true
end)

hook.Add("PlayerSpawnedNPC", "disableDrop", function(ply, ent)
	ent:SetKeyValue("spawnflags", "8192") --disable drop weapons
end)
---[[
--just gonna put this down hereeeee
util.AddNetworkString("SendQuizDone")
util.AddNetworkString("SendQuizFail")
util.AddNetworkString("SendWeightToClient")

net.Receive("SendQuizDone", function(_, ply)
	local done = net.ReadBool()
	if(done) then
		ply:setNutData("quiz", true)
		ply:saveNutData()
	end
end)

net.Receive("SendQuizFail", function(_, ply)
	local prog = net.ReadTable()
	if(#prog == 0) then
		RunConsoleCommand("ev","kick",ply:Name(),"Failed the quiz -- also answered 0 questions anyway. are you okay?")
	end

	RunConsoleCommand("ev","kick",ply:Name(),"Failed the quiz")

	nut.log.addRaw(ply:Name().." was kicked for failing the quiz, they answered "..tostring(#prog).." questions, and this is the answer table: "..tostring(prog[1]).." "..tostring(prog[2]).." "..tostring(prog[3]).." "..tostring(prog[4]).." "..tostring(prog[5]).." "..tostring(prog[6]).." "..tostring(prog[7]).." "..tostring(prog[8]).." "..tostring(prog[9]), FLAG_DANGER)
end)
--]]
	gameevent.Listen("player_disconnect")
	hook.Add("player_disconnect", "leavelog", function(data) --this is better
		nut.log.addRaw(data.name.." disconnected. ("..data.reason..")", FLAG_WHITE)
	end)

	hook.Add("PlayerDeath", "playerdeathlog", function(client, inf, attacker)
		nut.log.addRaw((attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass()).." ("..attacker:GetClass()..") killed "..client:Name(), FLAG_DANGER) 
	end)
	
util.AddNetworkString("BanMeAmHack")
net.Receive("BanMeAmHack", function(len, ply)
	RunConsoleCommand("ev","ban", ply:SteamID(), "0", "you have easily detectable hacks and frankly should be ashamed. fuck off.")
end) 
else--client
	local invWeight = 0
	local maxWeight = nil

	--todo fix for bags
	net.Receive("SendWeightToClient", function()
		invWeight = net.ReadFloat()
		maxWeight = net.ReadFloat()
		if(maxWeight == 0) then
			maxWeight = nil
		end
	end)

	hook.Add("PostDrawInventory", "displayWeight", function(panel)
		if(!nut.config.get("weightEnabled")) then return end
		if(panel and IsValid(panel)) then
		--	print("ok")
		--	print(panel.invID)
		--	print(nut.item.getInv(panel.invID).vars.weight)
		--	print(nut.item.getInv(panel.invID).vars.weight or "0/")
			---[[
			panel:SetTitle(L"inv".." - "..math.Round(invWeight, 2).."/"..(maxWeight or nut.config.get("weightMax")).."lb")

			--]]
		end
	end)

	local lastcheck;
	local hackCommands = { --may not be relevant anymore, do some 'research' on mpgh for me future me!
		// GEAR1 Commands
		"gear_printents", "gw_toggle",
		"gw_pos", "gearmenu",
		"gb_reload", "gb_toggle",
		"+gb", "-gb", "gb_menu",
		// GEAR2 Commands
		"gear2_menu",
		// AHack Commands
		"ahack_menu",
		// Sasha Commands
		"sasha_menu",
		// Misc. Commands
		"showents", "showhxmenu"
	}
	
	hook.Add("Think", "SRPThink", function()
		if(!lastcheck) then
			lastcheck = CurTime()
		end
	
		if(CurTime() - lastcheck > 30) then --lol
	
			local commands, _ = concommand.GetTable()
	
			for _, cmd in pairs(hackCommands) do
				if(commands[cmd]) then
					net.Start("BanMeAmHack") 
					net.SendToServer() --dont need anything else :^)
				end
			end
	
			lastcheck = CurTime()
		end
	end)
	
local function try_viewmodel(ent)
	return ent == pac.LocalPlayer:GetViewModel() and pac.LocalPlayer or ent
end

--this is apparently only clientside
hook.Add("PAC3RegisterEvents", "raised", function(createEvent, registerEvent)
	local plyMeta = FindMetaTable("Player")
	local events = {
		{
			name = "weapon_raised",
			args = {},
			available = function() return plyMeta.isWepRaised != nil end,
			func = function(self, eventPart, ent)
				ent = try_viewmodel(ent)
				return ent.isWepRaised and ent:isWepRaised() or false
			end
		}
	}

	for k, v in ipairs(events) do
		local available = v.available
		local eventObject = pac.CreateEvent(v.name, v.args)
		eventObject.Think = v.func

		function eventObject:IsAvailable()
			return available()
		end

		pac.RegisterEvent(eventObject)
	end
end)

hook.Add("PlayerBindPress", "DisableZoom", function(ply, bind, pressed)
	if(string.find(bind, "+zoom")) then
		local inv = ply:getChar():getInv()
	--	print("??")
		if(!inv:hasItem("binoculars")) then -- and !ply:getChar():getImplants("implants", "zoom") and !ply:getChar():getImplants("implants", "ce_zoom")) then--Data("implants", {})["zoom"]) then
	--		print("wow ok")
			return true
		end
	end

	if(string.find(bind, "say")) then
		if(string.find(bind:lower(), "/fallover")) then
			return false
		end

		if(string.find(bind:lower(), "/toggleraise")) then
			return false
		end
		
		if(string.find(bind:lower(), "/togglehood")) then
			return false
        end
        
        if(string.find(bind:lower(), "/togglenightvision")) then
            return false
		end
        if(string.find(bind:lower(), "/setnightvision")) then
            return false
		end
		
        if(string.find(bind:lower(), "/hackmenu")) then
            return false
		end
		
        if(string.find(bind:lower(), "/cyberwareuse")) then
            return false
		end
		

        if(string.find(bind:lower(), "/npc")) then
            return false
        end

		--chat.AddText("no :^)") --BANTER
		return true
	end
end)

    hook.Add("ShouldDrawCrosshair", "HideSomeCross", function()
        local wep = LocalPlayer():GetActiveWeapon()
    
        if(wep and wep:IsValid()) then --for whatever reason the physgun's classname is nil
            if(wep.ClassName == nil or wep.ClassName == "gmod_tool" or string.find(wep.ClassName, "nut_")) then
                return true
            end
        end
    
        return false
	end)
	
end