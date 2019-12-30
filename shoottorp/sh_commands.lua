nut.command.add("settypingimm", {
	desc = "Remove someone's damage immunity/slower bleed when typing",
    syntax = "<string name>",
    adminOnly = true,
    onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])

		if(!IsValid(target)) then return "No target" end        
        if(target == client) then
            return "You cannot toggle it on yourself!"
        end

		local setTo = true
		if(target:getNutData("typeImm")) then
			setTo = nil
		end

        target:setNutData("typeImm", setTo)
		target:saveNutData()
		
		local on = "disabled"
		if(setTo == nil) then
			on = "enabled"
		end

        client:notify(on.." "..target:Name().."'s ability to be automatically immune from shots while typing.")
    end
})

nut.command.add("togglenightvision", {
	desc = "Toggles nightvision if you have it, type specifies type if you have FLIR",
	syntax = "[number type]",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local res = client:GetArmorResists()
		if(res["nv"] and res["nv"] != 0) then
			net.Start("PlayerSetNV")
			net.Send(client)
			if(arguments[1] and (tonumber(arguments[1]) <= res["nv"])) then
				net.Start("SetNVType")
				net.WriteInt(tonumber(arguments[1]), 3)
				net.Send(client)
			end
		end
	end
})
--resets the stamina timer of whoever called this, 
--wont reset their actual stm value or brth status
--[[
nut.command.add("staminatimerreset", {
	desc = "Recreates your stamina timer, use if it breaks or your runspeed doesnt fix after healing or something",
	--syntax = "[only useifstaminatimerbugged]",
	onRun = function(client, arguments)
		
		
		--will this work? for some reason it still breaks idk
		local ratio = 1
		local ply = client
		local character = ply:getChar()
		
		local res = ply:GetArmorResists()
		
		if(!res["norat"]) then
			local baserat = nut.config.get("movespeedRatio", 0.4)
			if(IsValid(ply) and ply:getChar() and (ply:getChar():getFaction() == FACTION_MONO or res["imprat"])) then baserat = baserat + 0.2 end						
			ratio = (ply:Health()/ply:GetMaxHealth()) + baserat
			if(ratio > 1) then
				ratio = 1
			end
		end
		local ms = res["spd"] or 1

		--tfa speed
		local sumwep = ply:GetActiveWeapon()
		local speedmult = 1
		if(IsValid(sumwep) and sumwep.IsTFAWeapon) then
			sumwep.IronSightsProgress = sumwep.IronSightsProgress or 0
			speedmult = Lerp(sumwep.IronSightsProgress, sumwep:GetStat("MoveSpeed"), sumwep:GetStat("IronSightsMoveSpeed"))
		end

		--it doesnt matter which way this is done in right?
		local runSpeed = (nut.config.get("runSpeed") + (character:getAttrib("qkn", 0)))*ratio*ms*speedmult--*character:getSpdAdd())

		if (client:WaterLevel() > 1) then
			runSpeed = runSpeed * 0.775
		end

		client:SetRunSpeed(runSpeed)

		nut.plugin.list["stamina"]:InitStam(client, true) 
	end
})]]

nut.command.add("setnightvision", {
	desc = "Set your nightvision type if you have nightvision on currently",
	syntax = "<number type>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local res = client:GetArmorResists()
		if(res["nv"] and res["nv"] != 0) then
			if(arguments[1] and (tonumber(arguments[1]) <= res["nv"])) then
				net.Start("SetNVType")
				net.WriteInt(tonumber(arguments[1]), 3)
				net.Send(client)
			end
		end
	end
})

nut.command.add("resetstatuses", {
	desc = "makes someone whos broken their legs be able to run again and also stop bleeding lmao",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		local target 
		if(arguments[1]) then
			target = nut.util.findPlayer(arguments[1])
		else
			target = client
		end
		if(!IsValid(target)) then return "No target" end

		local char = target:getChar()
		if(!char) then return "No char" end

		char:setData("leghit", nil, nil, player.GetAll())
		char:setData("bleed", nil, nil, nil, player.GetAll())
		if(timer.Exists("bleedtime"..char:getID())) then
			timer.Remove("bleedtime"..char:getID())
		end

		return "reset statuses for "..target:Name()
	end
})

nut.command.add("plyrevive", {
	desc = "Revive a downed player completely",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end
		if(!arguments or !arguments[1]) then return "No target" end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end
		if(client:SteamID() != "STEAM_0:0:23875518" and target:getChar():getData("activerun")) then return "You cant revive someone in a run, blame blood for this smh" end

		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(target)
		
		target:setRagdolled(false)
		target:setNetVar("neardeath", nil)
		target:setNetVar("startdown", nil)
		target:setNetVar("canrevive", nil)
		target:setNetVar("canscirevive", nil)
		target:setNetVar("canplatrevive", nil)
		target:SetHealth(target:GetMaxHealth())
		target:setAction()
		target:SetNoTarget(false) --so npcs stop attacking
		target:RemoveAllDecals()
	end
})

nut.command.add("plyslay", {
	desc = "Slay a player",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end

		target:Kill()
	end
})

nut.command.add("acd", {
	desc = "Used to respawn when downed once the timer is up.",
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		if(client:getNetVar("canresp")) then
			hook.Run("OnDownedFinish", client, client:getNetVar("lastatk"))
			client:Kill()
		end
	end
})


nut.command.add("devutilhealth", {
	desc = "Utility function to get the health of who/what you're looking at",
    adminOnly = true,
    onRun = function(client, arguments)

        local tr = client:GetEyeTrace()
		if(tr.Entity) then
			if(tr.Entity.Health) then
				return tr.Entity:Health()
			end
		end
	end
})

nut.command.add("chargetcurarmor", {
	desc = "Get the current armor levels for the target",
    adminOnly = true,
	syntax = "<string name>",
    onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])

		if(!IsValid(target)) then return "No target" end    
		local char = target:getChar()
		if(char) then
			local str = "Armor for "..target:Name()..": "
			local lvls = target:GetArmorLevels()
			for k,v in pairs(lvls) do
				str = str..k.."="..v.level..","..tostring(v.durability or 1).." "
			end
			return str
		end
	end
})

nut.command.add("chargetcurresists", {
	desc = "Get the current resists for the target",
    adminOnly = true,
	syntax = "<string name>",
    onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])

		if(!IsValid(target)) then return "No target" end    
		local char = target:getChar()
		if(char) then
			local str = "Armor for "..target:Name()..": "
			local lvls = target:GetArmorResists()
			for k,v in pairs(lvls) do
				str = str..k.."="..v.." "
			end
			return str
		end
	end
})