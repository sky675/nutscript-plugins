local PLUGIN = PLUGIN
PLUGIN.name = "shoot to rp/armor levels"
PLUGIN.author = "sky"
PLUGIN.desc = "s2rp stuff+more"

--armor enums
ARMOR_NONE = 0
ARMOR_IIA = 1
ARMOR_II = 2
ARMOR_IIIA = 3
ARMOR_III = 4
ARMOR_IV = 5
ARMOR_V = 6 --unsure if thisll be used but mebi lmao

--configs
nut.config.add("shootToRP", true, "Whether S2RP is on. No other features will work if this is off.", nil, {
    category = "Shoot to RP"    
})
nut.config.add("downing", true, "Turns on the downing system.", nil, {
    category = "Shoot to RP"
})
nut.config.add("movespeedRatio", 0.4, "The percentage of health needed to be missing (1 == 100% of health, 0 == 0%) in order to start slowing players' speed. Requires downing to be on.", nil, {
	form = "Float",
	data = {min = 0, max = 1},
	category = "Shoot to RP"
})
--[[nut.config.add("permadeath", false, "DO NOT TICK THIS THIS IS OLD CODE JUST USE PK INSTEAD im too lazy to remove the references to this tbh When a player dies with downing on, they cant respawn and must make a new character. HEAVILY RECOMMEND NORMAL PK OVER THIS", nil, {
    category = "IGNORE DONT TICK THIS"
})]]
nut.config.add("shootMessages", false, "If on, chat messages are sent to the attacker and victim describing the type of bullet, range, direction, and tells you if you are protected from it or not.", nil, {
	category = "Shoot to RP"
})
nut.config.add("downedRespawnTimer", 60, "The downed respawn length.", nil, {
	form = "Int",
	data = {min = 5, max = 600},
	category = "Shoot to RP"
})

nut.util.include("sh_commands.lua")
nut.util.include("sh_upgradepaths.lua")
nut.util.include("sh_upgrade_config.lua")
nut.util.include("sh_config.lua")
--[[
if(SERVER) then
nut.log.AddType("playerDmg", function(client, ...)
    local arg = {...}
    return string.format("%s (%s) attacked %s (%s) with %s! [%s/%s]", arg[1], arg[2], client:Name(), client:SteamName(), arg[3], arg[4], arg[5])
end)

nut.log.AddType("playerDown", function(client, ...)
    local arg = {...}
    return string.format("%s (%s) downed %s (%s)!", arg[1], arg[2], client:Name(), client:SteamName())
end)
end
]]
function PLUGIN:InitializedItems()--Plugins()
    --do
		for id, data in pairs(self.itemconfig) do
            local ITEM = nut.item.register(id, data.base, nil, nil, true)
            ITEM.name = data.name
			ITEM.desc = data.desc
			local mdl = data.model
			ITEM.onGetDropModel = function(item, ent)
				return mdl
			end
			ITEM.model = data.model
			ITEM.skin = data.skin or 0
			ITEM.price = data.price or 0
			ITEM.width = data.width
			ITEM.height = data.height
			ITEM.noBusiness = data.noBusiness
			if(data.flag) then
				ITEM.flag = data.flag
			end
			local other = ""
			if(data.gsonly) then
				other = " ("..data.gsonly..")"
			end
			ITEM.category = "Clothing"..other
			ITEM.permit = data.permit

			if(data.scrapGive) then
				ITEM.destroyval = {
					[data.scrapType or "comp_scrap_cloth"] = data.scrapGive
				} --for scrap clothing crafting
			end
			if(data.destroyval) then
				ITEM.destroyval = data.destroyval --in case i wanna add more
			end

			--this is from something im not releasing due to it needing a mod of a core ns function
			if(EZADDDESTROYFUNC) then
				ITEM = EZADDDESTROYFUNC(ITEM) --gotta do it this way i think
			end

			ITEM.outfitCategory = data.outfitCategory
			
			if(data.gsonly) then
				if(data.gsonly == "female") then
					ITEM.canWear = function(self, ply)
						local model = ply:GetModel()
						if(nut.newchar.isBM(model) and ply:isFemale()) then
							if(!data.addons) then return true end

							local inv = ply:getChar():getInv()
							local item
							for k,v in pairs(inv:getItems()) do
								if(string.find(v.uniqueID, "addon") and v:getData("equip")) then
									item = v
									break
								end
							end
							if(item) then
								return false, "You have an addon equipped, you must unequip it first!"
							end
							
							return true
						else
							return false, "Your model cannot wear this item!"
						end
					end
				else
					ITEM.canWear = function(self, ply)
						local model = ply:GetModel()
						if(nut.newchar.isBM(model) and !ply:isFemale()) then
							if(!data.addons) then return true end
							
							local inv = ply:getChar():getInv()
							local item
							for k,v in pairs(inv:getItems()) do
								if(string.find(v.uniqueID, "addon") and v:getData("equip")) then
									item = v
									break
								end
							end
							if(item) then
								return false, "You have an addon equipped, you must unequip it first!"
							end

							return true
						else
							return false, "Your model cannot wear this item!"
						end
					end
				end
			end
			if(data.addons) then --table to prevent unequipping with items with these names equipped
				local addonscheck = data.addons
				ITEM.canRemove = function(self, ply)
					local inv = ply:getChar():getInv()
					local item
					for k,v in pairs(inv:getItems()) do
						for k2,v2 in pairs(addonscheck) do
							if(string.find(v.uniqueID, v2) and v:getData("equip")) then
								item = v
								break
							end
						end
					end
					if(item) then
						return false, "You need to unequip an item on top of this first!"
					else
						return true
					end
				end
			end

			if(data.hooks) then
				for k,v in pairs(data.hooks) do
					ITEM:hook(k, v)
				end
			end
			if(data.posthooks) then
				for k,v in pairs(data.posthooks) do
					ITEM:postHook(k, v)
				end
			end

			if(data.base == "base_suit") then
				--i messed up the armor so instead of changing it ill fix it here
				if(data.armor) then
				local armors = {}
				for k,v in pairs(data.armor) do
					armors[k] = {level = v}
				end
				ITEM.armor = armors
				end
				ITEM.resists = data.resists

				ITEM.pacData = data.pacData or {}
				ITEM.pacF = data.pacF
				ITEM.pacM = data.pacM
				ITEM.newSkin = data.newSkin
				ITEM.bodyGroups = data.bodyGroups 
				ITEM.replacements = data.replacements
				ITEM.onGetReplacement = data.onGetReplacement
				ITEM.getBodyGroups = data.getBodyGroups
				
				ITEM.upgradePath = data.upgradePath


				if(data.gs) then
					ITEM.gs = data.gs
					--[[
					local gstype, gsbg = data.gs.type, data.gs.bg
					ITEM:postHook("Equip", function(item, result, data)
						if(result == false) then return end --just in case
						nut.newchar.setBody(item.player, gstype, gsbg)
					end)
					ITEM:postHook("EquipUn", function(item, result, data)
						if(!result) then return end --just in case
						nut.newchar.setBody(item.player, gstype, 0)
					end)
					ITEM:hook("drop", function(item)
						if(item:getData("equip")) then
							nut.newchar.setBody(item.player, gstype, 0)
						end
					end)
					function ITEM:onLoadout()
						if(self:getData("equip")) then
							nut.newchar.setBody(self.player, gstype, gsbg)
						end
					end
						]]
				end
			end
			if(data.base == "base_pacoutfit") then
				ITEM.pacData = data.pacData or {}
				ITEM.pacF = data.pacF
				ITEM.pacM = data.pacM
			end
			if(data.base == "base_outfit") then
				ITEM.newSkin = data.newSkin
				ITEM.bodyGroups = data.bodyGroups 
				ITEM.replacements = data.replacements
				ITEM.onGetReplacement = data.onGetReplacement
				ITEM.getBodyGroups = data.getBodyGroups
				if(data.gs) then
					ITEM.gs = data.gs
				end
			end

			if(data.gs) then
				local gsbg = data.gs.bg
				local gsskin = data.gs.skin or 0
				if(data.gs.type == "top" and data.gsonly == "female") then
					ITEM.model = data.gs.model or "models/sky/torsos/female_citizen1.mdl"
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(33.581039428711, 0, 49.281421661377),
						ang = Angle(0, 180, 0),
						entAng = Angle(0, 0, 0),
						fov = 35.148176754126,
						
						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				elseif(data.gs.type == "top") then
					ITEM.model = data.gs.model or "models/sky/torsos/male_citizen1.mdl"
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(80.053802490234, 0, 49.822090148926),
						ang = Angle(0, 180, 0),
						entAng = Angle(0, 0, 0),
						fov = 14.763357201488,
						
						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				elseif(data.gs.type == "bot") then
					ITEM.model = data.gs.model or (data.gsonly == "female" and "models/sky/legs/female_citizen1.mdl" or "models/sky/legs/male_citizen1.mdl")
					
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(-57.587574005127, 0, 21.754777908325),
						ang = Angle(0, -0, 0),
						entAng = Angle(0, 0, 0),
						fov = 29.916595845406,

						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				end

				if(data.gs.type == "top" and !string.find(id, "_sec")) then
					ITEM.upgradePath = "gstop"
				elseif(data.gs.type == "bot" and !string.find(id, "_sec")) then
					ITEM.upgradePath = "gsbot"
				end
			end

        end
        for id, data in pairs(self.upgradesList) do
            local ITEM = nut.item.register(id, "base_suit_up", nil, nil, true)
            ITEM.name = data.name
            ITEM.desc = data.desc
            ITEM.price = data.price or 0
			ITEM.upgrades = data.upgrades
			if(data.flag) then
				ITEM.flag = data.flag
			end
        end
    --end
end


local blank = {
    ["chest"] = {level = ARMOR_NONE},
    ["head"] = {level = ARMOR_NONE},
    ["larm"] = {level = ARMOR_NONE},
    ["rarm"] = {level = ARMOR_NONE},
    ["lleg"] = {level = ARMOR_NONE},
    ["rleg"] = {level = ARMOR_NONE}
}
local blankres = {
	[DMG_BULLET] = 0, --bullet
	[DMG_SLASH] = 0, --seems to be the dmg type used by melee
	--other possible ones?
	--[DMG_CLUB] = 0, --this is for the crowbar, should be same as slash tbh
	--[DMG_BURN] = 0, --burn dmg obvi
	--[DMG_FALL] = 0, --would reduce fall damage, implants?
	--[DMG_BLAST] = 0, --blast/explosive damage obvi
	--[DMG_SHOCK] = 0, --electric
	--[DMG_POISON] = 0, --poison dmg?
	--[DMG_RADIATION] = 0, --????
	--[DMG_ACID] = 0, --????? probably better to use poison or rad
	--see https://wiki.garrysmod.com/page/Enums/DMG

	--[[other values that may be used but are not needed 
	(technically none of these are needed if you check if they exist):
	nospr = completely removes ability to sprint if it exists
	spd = movespeed multiplier (0-1)
	spr = lower == quicker stamina depletion, 1 == no effect (0-1)
	nv = 1 is normal nv, 2 is flir
	hud = existing == on
	imprat = existing == you get +0.2 movespeed ratio until you start slowing down, ex: at 0.4 u start slowing at 60%, with this its 40%
	]]
}
--if i add them later:
--22 should be on all levels
--30 carbine should start at 3 and be up
--3006 should start at 4 and be up
--792x57 should start at 4 and be up

--if a ammotype is here, that armor level will protect from it
--[[local ammoProtect = { none = {[""]=true},
IIA = {["sky9x18"]=true,["buckshot"]=true,["skyball"]=true},
II = {["sky9x18"]=true,["buckshot"]=true,["skyball"]=true},
IIIA = {["sky9x18"]=true,["sky44"]=true,["buckshot"]=true,["skyball"]=true},
III = {["sky9x18"]=true,["sky44"]=true,["buckshot"]=true,["sky545"]=true,
    ["sky9x39"]=true,["skyball"]=true,["skyarrow"]=true},
IV = {["sky9x18"]=true,["sky44"]=true,["buckshot"]=true,["sky545"]=true,
	["sky9x39"]=true,["sky762x54"]=true,["skyball"]=true,["skyarrow"]=true},
}]]


---[[ --old one
--i added in 23mm at 5 becuz idk what else lol
	--this is the old srp 2.0 protection table, some of these ammo types dont exist rn
local ammoProtect = { [ARMOR_NONE] = {[""]=true},
[ARMOR_IIA] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["sky22lr"]=true,},
[ARMOR_II] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
	["sky22lr"]=true,},
[ARMOR_IIIA] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
    ["buckshot"]=true,["sky22lr"]=true,},
[ARMOR_III] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
    ["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,["sky762x39"]=true,
    ["sky762x51"]=true,["sky556"]=true,["sky46"]=true,["sky545"]=true,
    ["sky50ae"]=true,["sky9x39"]=true,["sky22lr"]=true,},
[ARMOR_IV] = {["sky9x18"]=true,["sky9x19"]=true,["sky9x39"]=true,["sky45acp"]=true,
    ["357"]=true,["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,
    ["sky762x39"]=true,["sky762x51"]=true,["sky556"]=true,["sky46"]=true,
	["sky545"]=true,["sky50ae"]=true,["sky57"]=true,["sky762x54"]=true,
	["sky22lr"]=true,},
[ARMOR_V] = {["sky9x18"]=true,["sky9x19"]=true,["sky9x39"]=true,["sky45acp"]=true,
    ["357"]=true,["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,
    ["sky762x39"]=true,["sky762x51"]=true,["sky556"]=true,["sky46"]=true,
    ["sky545"]=true,["sky50ae"]=true,["sky57"]=true,["sky762x54"]=true,
	["sky338"]=true,["sky23mm"]=true,["sky22lr"]=true,}
}
--]]


local stringtoenum = {
	none = ARMOR_NONE,
	IIA = ARMOR_IIA,
	II = ARMOR_II,
	IIIA = ARMOR_IIIA,
	III = ARMOR_III,
	IV = ARMOR_IV,
	V = ARMOR_V,
}

function PLUGIN:StringToArmorEnum(string)
	if(stringtoenum[string]) then
		return stringtoenum[string]
	end
	return ARMOR_NONE
end

--some of these are redundant
--i wish there were more ins2 tfa pistols on the workshop :( those are the only ones that arent garbage
local pistolClasses = {
    ["tfa_ins2_glock17_sky"] = true, 
    ["tfa_ins2_mp443_sky"] = true, 
    ["tfa_ins2_pm_sky"] = true, 
    ["tfa_ins2_m1911_sky"] = true, 
    ["tfa_ins2_beretta_px4_sky"] = true, 
    ["tfa_ins2_cz75_sky"] = true, 
    ["tfa_ins2_deagle_sky"] = true, 
    ["tfa_ins2_knw_sky"] = true, 
    ["tfa_ins2_m9_sky"] = true, 
    ["tfa_ins2_neomilso_sky"] = true, 
    ["tfa_ins2_neotachi_sky"] = true, 
    ["tfa_ins2_pistolx_sky"] = true, 
    ["tfa_ins2_tiggusp_sky"] = true, 
}

function PLUGIN:IsCharProtected(levels, part, ammo, wep, durability)
    if(levels) then
        if(levels[part] and (durability or 1) != 0) then
            if(ammoProtect[levels[part].level]) then
				if(string.find(wep, "tt33")) then
					if(levels[part].level == ARMOR_NONE or levels[part].level == "IIA" or levels[part].level == "II") then
						return false
					else
						return true
					end
				end
				if(string.find(wep, "ppsh")) then --ugly but lazy
					if(levels[part].level == ARMOR_NONE or levels[part].level == "IIA" or levels[part].level == "II" or levels[part].level == "IIIA") then
						return false
					else
						return true
					end
                end
				if(ammoProtect[levels[part].level][ammo]) then
                    if(levels[part].level == "IIA") then
                        if(pistolClasses[wep]) then
                            return true
                        else
                            return false
                        end
                    end
                    return true
                else
                    return false
                end
            end
        end
    end
    return false            
end

hook.Add("OnHealPlayer", "stopheart", function(ply, heal)
	if(SERVER) then
	if(ply:Health() > 30) then
		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(ply)
	end
	end
end)

do
	local playerMeta = FindMetaTable("Player")
	


    function playerMeta:GetArmorItem() --DONT USE THIS USE BELOW INSTEAD
        if(self:getChar()) then
            local inv = self:getChar():getInv()
			for k,v in pairs(inv:getItems()) do
				local item = nut.item.instances[v.id]
                if(item.base == "base_suit" and item:getData("equip")) then
                    return item
                end
            end
        end
        return nil
    end
	function playerMeta:GetArmorItems()
		local items = {}
        if(self:getChar()) then
            local inv = self:getChar():getInv()
			for k,item in pairs(inv:getItems()) do
                if(item.base == "base_suit" and item:getData("equip")) then
                    items[item.id] = item
                end
            end
        end
        return (table.Count(items) != 0 and items) or nil
    end

    function playerMeta:GetArmorLevels()
        local suit = self:GetArmorItems()
		if(suit) then
			local levels = {}
			for k,v in pairs(suit) do
				levels.durability = v:getData("durability")
				local armor = v:GetArmor()
				for k2,v2 in pairs(armor) do
					local r
					if(type(v2.level) == "string") then --backwards compatibility!
						r = PLUGIN:StringToArmorEnum(v2.level)
					else
						r = v2.level
					end
					if(!levels[k2] or levels[k2].level < r) then
						local ee = v2
						ee["orig"] = v.id
						levels[k2] = ee
					end
				end
			end

            return levels
        end
        return blank
    end
    
    function playerMeta:GetArmorResists()
		local suit = self:GetArmorItems()
		local def --no reason to copy it needlessly
		--local impres = self:getImplantRes() or {}
		if(suit) then
			local levels = {}
			for k,v in pairs(suit) do
				local armor = v.GetResists and v:GetResists() --???
				if(!armor) then print("wtf is this "..k.." "..tostring(v)) continue end

				for k2,v2 in pairs(armor) do --might need special ones?
					if(k2 == "spd") then
						levels[k2] = (levels[k2] or 1)*v2
					elseif(k2 == "nv" or k2 == "hud") then
						if(!levels[k2] or levels[k2] < v2) then --this should never be false but ya
							levels[k2] = v2
						end
					else
						levels[k2] = (levels[k2] or 0) + v2
					end
				end
			end
			
			--this should let me be able to modify the table? idk
			--so just do that, dont return a value
			hook.Run("CustomArmorResists", self, levels)

			--doing implants
			--[[for k2,v2 in pairs(impres) do --might need special ones?
				if(k2 == "spd") then
					levels[k2] = (levels[k2] or 1)*v2
				elseif(k2 == "nv" or k2 == "hud") then
					if(!levels[k2] or levels[k2] < v2) then --this should never be false but ya
						levels[k2] = v2
					end
				elseif(!istable(v2)) then
					levels[k2] = (levels[k2] or 0) + v2
				end
			end]]
				
			return levels
		else
			--this should let me be able to modify the table? idk
			--so just do that, dont return a value
			def = table.Copy(blankres)
			hook.Run("CustomArmorResists", self, def)
		end
		--if(impres) then return impres end
        return def
    end
    
    function playerMeta:GetArmorUpgrades()
        local suit = self:GetArmorItems()
		if(suit) then
			local var = {}
			for k,v in pairs(suit) do
				var[v.uniqueID] = v:GetUpgrades()
			end
			
            return var
        end
        return {}
    end

	function playerMeta:SetArmorDurability(part, newdur)
		local suit = self:GetArmorLevels()

		local duradead = false
		if(type(part) == "table") then
			local items = self:getChar():getInv():getItems()

			for k,v in pairs(part) do --this is probably kinda bad but watever
				if(v == 0) then
					duradead = true
				end
				
				local item = items[suit[k].orig]
				if(item) then
					--[[local armor = item:GetArmor()
					if(armor[k]) then
						armor[k].durability = v
					end]]
				
					item:setData("durability", v)
				end
			end
		elseif(part) then
			local orig = suit[part].orig
			if(orig) then 
			local item = self:getChar():getInv():getItems()[orig]

			if(item) then
				--[[local armor = item:GetArmor()
				if(armor[part]) then
					armor[part].durability = newdur
				end]]
			
				item:setData("durability", newdur)
			end
			end

		else --ugh
			local items = self:GetArmorItems()
			if(items) then
				for k,v in pairs(items) do --ughhhhhhhhhhh
					v:setData("durability", newdur)
					break
				end
			end
		end

        if((duradead or newdur == 0) and SERVER) then
            self:notify("At least one of your armor parts broke!")
        end
    end
end

hook.Add("StartCommand", "removespr", function(ply, cmd)
	if(SERVER and ply:getChar() and ply:getChar():getVar("jumpprep") and cmd:KeyDown(IN_JUMP)) then
		local old = ply:GetJumpPower()
		ply:SetJumpPower(300)
		timer.Simple(0, function() --next frame should be ok right?
			ply:getChar():setVar("jumpprep")
			ply:SetJumpPower(old)
		end)
	end
	
	if(ply:GetMoveType() != MOVETYPE_NOCLIP and (ply:getNetVar("brth") or (ply:getChar() and (ply:getChar():getData("leghit") or nut.traits.hasTrait(ply, "big_cripple")))) and cmd:KeyDown(IN_SPEED)) then
		if(staminatest) then
			print("pls stop")
		end
		--its not like anyone used shift+alt anyway
		cmd:RemoveKey(IN_SPEED)
	end
end)

--idea from tfa base :)
hook.Add("SetupMove", "slowhpply", function(ply, moved, commandd)
	local hp = ply:Health()
	if(!ply:getChar()) then return end --no reason then lmao

	local res = ply:GetArmorResists()

	if(hp >= 100) then
		local ms = res["spd"] or 1

		if(nut.traits.hasTrait(ply, "big_cripple")) then
			ms = ms*0.75
		end

		if(ply:getNetVar("restricted")) then --slow the restricted player
			ms = ms*0.5
		end
		
		local spd = moved:GetMaxClientSpeed()
		if(prone and prone.config and ply:IsProne()) then
			spd = prone.config.MoveSpeed
		end
		
		moved:SetMaxClientSpeed(spd*ms)
		commandd:SetForwardMove(commandd:GetForwardMove()*ms)
		commandd:SetSideMove(commandd:GetSideMove()*ms)

		return 
	end

	local ratio = 1
	
					
	if(!res["norat"]) then
		local baserat = nut.config.get("movespeedRatio", 0.4)
		if(IsValid(ply) and ply:getChar() and (ply:getChar():getFaction() == FACTION_MONO or res["imprat"])) then baserat = baserat + 0.2 end						
		ratio = (ply:Health()/ply:GetMaxHealth()) + baserat
		if(ratio > 1) then
			ratio = 1
		end
	end
	local ms = res["spd"] or 1
	
	if(nut.traits.hasTrait(ply, "big_cripple")) then
		ms = ms*0.75
	end

	if(ply:getNetVar("restricted")) then --slow the restricted player
		ms = ms*0.5
	end

	local spd = moved:GetMaxClientSpeed()
	if(prone and prone.config and ply:IsProne()) then
		spd = prone.config.MoveSpeed
	end

	moved:SetMaxClientSpeed(spd*ratio*ms)
	commandd:SetForwardMove(commandd:GetForwardMove()*ratio*ms)
	commandd:SetSideMove(commandd:GetSideMove()*ratio*ms)
end)

if(SERVER) then
    util.AddNetworkString("PlayerGetDmg")
    --entity (target)
    --entity (attacker)
    --entity (weapon)
    --int(4) (hitgroup)
    --int(32) (distance)
    --bool (protected)
	
	util.AddNetworkString("UpdateNVType")
	util.AddNetworkString("SetNVType")
    util.AddNetworkString("PlayerSetNV")
	util.AddNetworkString("PlayerOffNV")
	
    util.AddNetworkString("PlayerSetHud")
	util.AddNetworkString("PlayerOffHud")
	
	util.AddNetworkString("toggleHeartbeat")
	--bool (on/off)
	
    local deathSounds = {
        Sound("vo/npc/male01/pain07.wav"),
        Sound("vo/npc/male01/pain08.wav"),
        Sound("vo/npc/male01/pain09.wav")
	}

	--trying to slim this down a bit, dmginfo shoooould take changes here?-it does
	function PLUGIN:DownPlayer(ply, dmginfo, hg)
		
		--local dw = nut.config.get("downing", false)
		--if(dw) then
			local atk = dmginfo:GetAttacker()
			--downing
			if(dmginfo:GetDamage() >= (ply:Health()-1)) then --should get near death
				local pk = false --nut.config.get("permadeath", false)

				--hmm
				if(!pk && nut.config.get("pkActive", false)) then
					
					return
				end

				local olddmg = dmginfo:GetDamage()
				--dmginfo:SetMaxDamage(ply:Health()-1)
				dmginfo:SetDamage(0)--ply:Health()-1) --this is mildly annoying but watever

				ply:setNetVar("neardeath", true)

				local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
				
				if (ply:isFemale() and !deathSound:find("female")) then
					deathSound = deathSound:gsub("male", "female")
				end
				net.Start("toggleHeartbeat")
				net.WriteBool(false)
				net.Send(ply)

				ply:SetNoTarget(true) --so npcs stop attacking

				hook.Run("OnDown", ply, dmginfo) --wow! integration!

				ply:EmitSound(deathSound)

				local n1 = (atk.Name and atk:Name()) or "An entity"
				local n2 = (atk.SteamName and atk:SteamName()) or atk:GetClass()
				local n3 = ply:Name()
				local n4 = ply:SteamName()
				nut.log.addRaw(n1.." ("..n2..") downed "..n3.." ("..n4..")!", FLAG_DANGER)
				--nut.log.addRaw((atk.Name and atk:Name()) or "An entity".." ("..(atk.SteamName and atk:SteamName()) or atk:GetClass()..") downed "..ply:Name().." ("..ply:SteamName()..")!", FLAG_DANGER)
				if(!IsValid(ply.nutRagdoll)) then
					ply:setRagdolled(true, nil)
				else
					--get rid of the existing waking up timer
					if(timer.Exists("nutUnRagdoll"..ply:SteamID())) then
						timer.Remove("nutUnRagdoll"..ply:SteamID())
					end
				end
				ply:ExitVehicle() --yes
---[[
				if(!hg or hg != HITGROUP_HEAD) then
					ply:setNetVar("canrevive", true)
					if((ply:Health()-olddmg) < -55) then
						ply:setNetVar("canscirevive", true)
					end
				end
				if(ply:getNetVar("canrevive") and (ply:Health()-olddmg) < -25) then
					ply:setNetVar("canrevive", nil)
				end
				if((ply:Health()-olddmg) < -75) then
					ply:setNetVar("canplatrevive", true)
				end
				--]]
				if(atk:IsPlayer()) then--atk == ply or IsValid(dmginfo:GetInflictor())) then
				ply:setNetVar("startdown", true)
				end
				ply:setNetVar("lastatk", atk) --lives
				ply:setAction("Respawning", nut.config.get("downedRespawnTimer", 60), function()
					if(IsValid(ply) and ply:getNetVar("neardeath")) then
--[[ --pk code, bad
						if(pk) then
							local charid = ply:getChar():getID()
							local inventory = ply:getChar():getInv()
							ply:getChar():kick()
							netstream.Start("charDel", charid)
							local storage = ents.Create("sky_tempstorage")
							storage:SetPos(ply:GetPos()+Vector(0,0,12))
							storage:SetModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
							storage:Spawn()
							--storage:SetModel(k) --set model idk
							
							if (inventory) then
								storage:setNetVar("id", inventory:getID())
								storage.steamid = ply:SteamID64()

								for k,v in pairs(inventory:getItems()) do
									if(v:getData("equip")) then
										v:setData("equip", nil)
									end
								end
						
								--read only
								inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
									if (IsValid(client) and IsValid(self) and self.receivers[client]) then
									if(oldInventory:getID() != inventory:getID()) then
										return false
									end
									end
								end
								inventory.getReceiver = function(inventory)
									local receivers = {}
			
									for k, v in pairs(self.receivers) do
										if (IsValid(k)) then
											receivers[#receivers + 1] = k
										end
									end
			
									return #receivers > 0 and receivers or nil
								end
								inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
									if(storage.steamid and client:SteamID64() == storage.steamid) then
										return false
									end
									return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
								end
							end
							return
						end
						]]
						ply:setNetVar("canresp", true)
						ply:notify("You can now respawn with /acd")
					end
				end)
				return true
			end
			if(!ply:getNetVar("neardeath") and ply:Health()-dmginfo:GetDamage() <= 30) then
				net.Start("toggleHeartbeat")
				net.WriteBool(true)
				net.Send(ply)
			end

	end

    function PLUGIN:PlayerDeath(client, inflictor, attacker)
	    --nut.log.addRaw(client:Name().." ("..client:steamName()..") was killed with "..inflictor:GetName().." by "..attacker:GetName())
	
    	local dw = nut.config.get("downing", false)
	    if (dw) then
        	if(client:getChar():getData("leghit")) then
		        client:getChar():setData("leghit", nil, nil, player.GetAll())
        	end
    	end
    end
    
    local hitStrings = {
        [HITGROUP_GENERIC] = "unknown",
        [HITGROUP_HEAD] = "head",
        [HITGROUP_CHEST] = "chest",
        [HITGROUP_STOMACH] = "abdomen",
        [HITGROUP_LEFTARM] = "left arm",
        [HITGROUP_RIGHTARM] = "right arm",
        [HITGROUP_LEFTLEG] = "left leg",
        [HITGROUP_RIGHTLEG] = "right leg"
    }
    local hitToLevel = {
        "head", "chest", "chest", "larm", "rarm", "lleg", "rleg"
    }
	
	hook.Add("PlayerDisconnected", "JustWaitTheFuckingTimer", function(ply)
		local character = ply:getChar()
		if(ply:getNetVar("neardeath")) then
			if(character) then
				character:setData("pos", nil)
				character:setData("health", nil)
			end
			local pk = false --todo completely remove this shit nut.config.get("permadeath", false)

			if(!pk && nut.config.get("pkActive", false)) then
				ply:setNetVar("neardeath", nil) --just to be safe
				ply:Kill() --idk if this will allow it
			end
			
			--maybe?
			ply:setNetVar("neardeath", nil) --just to be safe
			ply:Kill()

			if(pk) then
				local charid = character:getID()
				local inventory = character:getInv()
				netstream.Start("charDel", charid)
				--todo create like a tempstorage or something, copy onto rest
				
				local storage = ents.Create("sky_tempstorage")
				storage:SetPos(ply:GetPos()+Vector(0,0,12))
				storage:SetModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
				storage:Spawn()
				--storage:SetModel(k) --set model idk
				
				if (inventory) then
					storage:setNetVar("id", inventory:getID())
					storage.steamid = ply:SteamID64()

					for k,v in pairs(inventory:getItems()) do
						if(v:getData("equip")) then
							v:setData("equip", nil)
						end
					end
			
					--read only
					inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
						if (IsValid(client) and IsValid(self) and self.receivers[client]) then
						if(oldInventory:getID() != inventory:getID()) then
							return false
						end
						end
					end
					inventory.getReceiver = function(inventory)
						local receivers = {}

						for k, v in pairs(self.receivers) do
							if (IsValid(k)) then
								receivers[#receivers + 1] = k
							end
						end

						return #receivers > 0 and receivers or nil
					end
					inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
						if(storage.steamid and client:SteamID64() == storage.steamid) then
							return false
						end
						return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
					end
				end
			end
			--todo change to evolve ban
			--RunConsoleCommand("ev","ban",ply:SteamID(),"10","Just wait the respawn timer out next time okay? It's a fucking minute.")
		else
			local char = character
			if(char) then
				char:setData("health", ply:Health())

			end
		end

			
	end)

	hook.Add("ShouldNotDeleteCharInv", "nodont", function(ply, char)
		if(ply:getNetVar("neardeath")) then
			return true
		else
			return false
		end
	end)

	local GSBG = {
		[12] = HITGROUP_HEAD,
		[6] = HITGROUP_CHEST,
		[0] = HITGROUP_STOMACH,
		[1] = HITGROUP_RIGHTLEG,
		[2] = HITGROUP_RIGHTLEG,
		[14] = HITGROUP_RIGHTLEG,
		[3] = HITGROUP_LEFTLEG,
		[4] = HITGROUP_LEFTLEG,
		[5] = HITGROUP_LEFTLEG,
		[7] = HITGROUP_RIGHTARM,
		[8] = HITGROUP_RIGHTARM,
		[13] = HITGROUP_RIGHTARM,
		[9] = HITGROUP_LEFTARM,
		[10] = HITGROUP_LEFTARM,
		[11] = HITGROUP_LEFTARM,
	}

	local function ScaleDmg(ply, hg, dmginfo)
        local on = nut.config.get("shootToRP", false)
		local atk = dmginfo:GetAttacker()
		local msgs = nut.config.get("shootMessages", true)

        if(on and atk:IsPlayer()) then
			local wep = atk:GetActiveWeapon()
            if(IsValid(ply.nutRagdoll)) then
                return
			end
			
			--shoooould disable penetration?
			if(dmginfo:GetInflictor().MainBullet) then
				dmginfo:GetInflictor().MainBullet.PenetrationCount = 99
			end

			if(msgs) then
            net.Start("PlayerGetDmg")
            net.WriteEntity(ply)
            net.WriteEntity(atk)
            net.WriteEntity(wep)
            net.WriteInt(hg, 4)
            net.WriteInt(math.Round(ply:GetPos():Distance(atk:GetPos())/52.49, 2), 32)
            end
            local levels = ply:GetArmorLevels()
			local protected
			if(wep.Primary) then
           	 protected = PLUGIN:IsCharProtected(levels, hitToLevel[hg], wep.Primary.Ammo, wep.ClassName, levels.durability)
			else
				protected = false
			end
			
			if(msgs) then
			net.WriteBool(protected)

			net.Send({ply, atk})
			end
			local pl = ply
			if(IsValid(atk)) then
            nut.log.addRaw(atk:Name().." ("..atk:steamName()..") attacked "..pl:Name().." ("..pl:steamName()..") with "..((wep and (wep.ClassName or wep:GetClass())) or "a mine or something probably").." ["..hitStrings[hg].."/"..((pl:getNetVar("typing") and "void") or tostring(protected)).."]")
			end

            if(wep.TFA_NMRIH_MELEE) then
                atk:getChar():updateAttrib("str", dmginfo:GetDamage()*0.0001)
            end

            local negx, negy = math.random(-1, 0), math.random(-1, 0)
			local ranx, rany = math.Rand(0.5, 1)*negx*(dmginfo:GetDamage()/5), math.Rand(0.5, 1)*negy*(dmginfo:GetDamage()/3)
			local viewpunchmult = 1
			if(wep.GetStat and wep:GetStat("ViewPunchMulti")) then
				viewpunchmult = wep:GetStat("ViewPunchMulti")
			end

			local ang = Angle(ranx, rany, 0.2)
			ang:Mul(viewpunchmult)

			ply:ViewPunch(ang) --idk

            --if theyre immune just dont do anything else
            if(ply:getNetVar("typing") and !ply:getNutData("typeImm")) then
                return true
			end
			
			--undamageable in safezone
			if(ply.getArea and atk.getArea) then
				local plyarea = nut.area.getArea(ply:getArea())
				local atkarea = nut.area.getArea(atk:getArea())
			if(plyarea and string.find(plyarea.name, "safezone")) then
				return true
			end
			--stop other players from attacking in safezone too
			if(atkarea and string.find(atkarea.name, "safezone")) then
				return true
			end
			end

            if(wep.Primary) then
                if(wep.Primary.Ammo == "none" or wep.Primary.Ammo == "") then
                    dmginfo:ScaleDamage(0.5) --should decrease melee dmg
                else
                    if(hg == HITGROUP_HEAD) then
                        dmginfo:ScaleDamage(7)
                    elseif(hg == HITGROUP_GENERIC) then
                        dmginfo:ScaleDamage(0.5)
                    elseif(LIMB_GROUPS[hg]) then --using limb_groups from nutscript sv_hooks
                        dmginfo:ScaleDamage(0.8)
                    else
                        dmginfo:ScaleDamage(1)
                    end
						
					local hit = hitToLevel[hg]
					--durability never really worked lol, not entirely sure why but watever
                    --base 0.1+((1-durability)*10)/20 maybe have 20 be changed so some shit can be more
					if(protected) then
                        local protscl = 0.1+(((1-(levels.durability or 1))*10)/20)
						dmginfo:ScaleDamage(protscl)
						
						if(wep.GetStat and wep:GetStat("ProcScale")) then
							dmginfo:ScaleDamage(wep:GetStat("ProcScale"))
						end
						
                        --for changing durability
                        --base 0.001 + (0.1*((1-durability)*(dmg/2))/100)
                        local duraToRem = math.max(0.0001, 0.001+(0.1*((1-(levels.durability or 1)*(dmginfo:GetDamage()/8)))/100)*1.2)
                        if(hg == HITGROUP_HEAD) then
                            duraToRem = duraToRem*100
						end
						if(wep:GetClass() == "sky_helsing") then
							if(levels[hit].level == "III") then
								duraToRem = duraToRem*100
							elseif(levels[hit].level == "IV") then
								duraToRem = durability*40
							end
						end
						if(wep.Primary.Ammo == "buckshot") then
							duraToRem = duraToRem*2
						end
						if(duraToRem < 0) then 
							ply:SetArmorDurability(hitToLevel[hg], 0)
						end
						--print("attacking: durabilty to remove "..duraToRem)
                        ply:SetArmorDurability(hitToLevel[hg], math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
					else
						if(wep.GetStat and wep:GetStat("UnprocScale")) then
							dmginfo:ScaleDamage(wep:GetStat("UnprocScale"))
						end

						if(levels[hit] and levels[hit] != ARMOR_NONE) then
                        local duraToRem = math.max(0.0001, (0.001+(0.1*((1-(levels.durability or 0.9999)*(dmginfo:GetDamage()/6)))/100))*2.5)
                        if(hg == HITGROUP_HEAD) then
                            duraToRem = duraToRem*100
                        end
						if(wep:GetClass() == "sky_helsing") then
							duraToRem = duraToRem*100
						end
						if(wep.Primary.Ammo == "buckshot") then
							duraToRem = duraToRem*2
						end
						if(duraToRem < 0) then 
							ply:SetArmorDurability(hitToLevel[hg], 0)
						end
						--print("attacking: durabilty to remove "..duraToRem)
						ply:SetArmorDurability(hitToLevel[hg], math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
						end
                    end
                end
            end
			
			if(wep.GetStat and wep:GetStat("StaminaDamage")) then
				local dmg = wep:GetStat("StaminaDamage")
				local scale = 1
				if(hg == HITGROUP_HEAD) then
					scale = 5
				elseif(LIMB_GROUPS[hg]) then --using limb_groups from nutscript sv_hooks
					scale = 0.8
				end

				nut.traits.getMod(ply, "stamcc", dmg) --seperate scale

				ply:restoreStamina(-(dmg * scale))
				
				local var = ply:getLocalVar("stm", 0)
				if(var <= 0) then
					ply:setNetVar("brth", true)
					ply:ConCommand("-speed")
					ply:setRagdolled(true, 60)--changed it to 60 like stunstick ig, old 120)
					ply:notify("Excessive non-lethal damage has knocked you unconcious.")
					return
				end
			end

			--[[
			if(ply:getChar():isSectcom()) then 
				if(atk:getChar():isSectcom()) then return end 
				print("send ppl")
				atk:getChar():setVar("wanted", true)
				atk:getChar():setVar("wantedtime", CurTime()+1200)
				local chardata = atk:getChar():getData()
				GLOBAL_WANTED = GLOBAL_WANTED or {}
				GLOBAL_WANTED[atk:getChar():getID()] = {
					["gtop"] = chardata["gtop"],
					["gbot"] = chardata["gbot"],
					["gctop"] = chardata["gctop"],
					["gcbot"] = chardata["gcbot"],
					["gtopskin"] = chardata["gtopskin"],
					["gbotskin"] = chardata["gbotskin"],
				}
				local bgs = atk:GetBodyGroups() or {}
				for k,v in pairs(bgs) do
					if(v.name == "masks") then
						GLOBAL_WANTED[atk:getChar():getID()]["masked"] = atk:GetBodygroup(v.id)
						break
					end
				end
		
				timer.Create(atk:getChar():getID().."wanted", 1200, 1, function()
					if(IsValid(atk)) then
					atk:getChar():setVar("wanted", nil)
					atk:getChar():setVar("wantedtime", nil)
					end
				end)
			end]]

            --downing!
            local dw = nut.config.get("downing", false)
            if(dw) then
                local ed = ply:getChar():getAttrib("end", 0)
                if(wep.Primary and wep.Primary.Ammo != "none" and wep.Primary.Ammo == "") then
                    dmginfo:ScaleDamage(1-(ed/30)*0.01)
                else
                    dmginfo:ScaleDamage(1-(ed/6)*0.01)
				end
				ply:getChar():updateAttrib("end", dmginfo:GetDamage()*0.00005)

				if((hg == HITGROUP_LEFTLEG or hg == HITGROUP_RIGHTLEG) and !protected and ply:Health()-dmginfo:GetDamage() < 60) then
					ply:getChar():setData("leghit", true, nil, player.GetAll())
				end
				
				return PLUGIN:DownPlayer(ply, dmginfo, hg)
                --[[
                --downing
                if(dmginfo:GetDamage() >= (ply:Health()-1)) then --should get near death
                    local olddmg = dmginfo:GetDamage()
                    dmginfo:SetDamage(ply:Health()-1)

                    ply:setNetVar("neardeath", true)

					local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
                    
                    if (ply:isFemale() and !deathSound:find("female")) then
                        deathSound = deathSound:gsub("male", "female")
                    end
					net.Start("toggleHeartbeat")
					net.WriteBool(false)
					net.Send(ply)

                    ply:EmitSound(deathSound)

                    nut.log.addRaw(atk:Name().." ("..atk:steamName()..") downed "..ply:Name().." ("..ply:steamName()..")!", FLAG_DANGER)
                    ply:setRagdolled(true, nil)

                    if(hg != HITGROUP_HEAD) then
                        ply:setNetVar("canrevive", true)
                    end
                    if(ply:getNetVar("canrevive") and (ply:Health()-olddmg) < -15) then
                        ply:setNetVar("canrevive", nil)
                    end
                    ply:setNetVar("startdown", true)
                    ply:setAction("Respawning", 300, function()
                        if(ply:getNetVar("neardeath")) then
							local pk = nut.config.get("permadeath", false)
							if(pk) then
								local charid = ply:getChar():getID()
								local inventory = ply:getChar():getInv()
								ply:getChar():kick()
								netstream.Start("charDel", charid)
								local storage = ents.Create("sky_tempstorage")
								storage:SetPos(ply:GetPos()+Vector(0,0,12))
								storage:Spawn()
								--storage:SetModel(k) --set model idk
								
								if (inventory) then
									storage:setNetVar("id", inventory:getID())
									storage.steamid = ply:SteamID64()

									for k,v in pairs(inventory:getItems()) do
										if(v:getData("equip")) then
											v:setData("equip", nil)
										end
									end
							
									--read only
									inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
										if (IsValid(client) and IsValid(self) and self.receivers[client]) then
										if(oldInventory:getID() != inventory:getID()) then
											return false
										end
										end
									end
									inventory.getReceiver = function(inventory)
										local receivers = {}
				
										for k, v in pairs(self.receivers) do
											if (IsValid(k)) then
												receivers[#receivers + 1] = k
											end
										end
				
										return #receivers > 0 and receivers or nil
									end
									inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
										if(storage.steamid and client:SteamID64() == storage.steamid) then
											return false
										end
										return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
									end
								end
								return
							end
                            ply:setNetVar("canresp", true)
                            ply:notify("You can now respawn with /acd")
                        end
                    end)
                end
				if(!ply:getNetVar("neardeath") and ply:Health()-dmginfo:GetDamage() <= 15) then
					net.Start("toggleHeartbeat")
					net.WriteBool(true)
					net.Send(ply)
				end
				]]
            else --downing is off so just ignore all damage :(
				if(!ply:InVehicle()) then
					dmginfo:ScaleDamage(0)
				end

                return true
			end 
		elseif(on) then --this is a mine?
            local dw = nut.config.get("downing", false)
			if(dw) then
				return PLUGIN:DownPlayer(ply, dmginfo, hg)
				--[[
                if(dmginfo:GetDamage() >= (ply:Health()-1)) then --should get near death
                    local olddmg = dmginfo:GetDamage()
                    dmginfo:SetDamage(ply:Health()-1)

                    ply:setNetVar("neardeath", true)

					local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
                    
                    if (ply:isFemale() and !deathSound:find("female")) then
                        deathSound = deathSound:gsub("male", "female")
                    end
					net.Start("toggleHeartbeat")
					net.WriteBool(false)
					net.Send(ply)

                    ply:EmitSound(deathSound)

                    nut.log.addRaw(atk.Name and atk:Name() or "??".." ("..atk.steamName and atk:steamName() or "???"..") downed "..ply:Name().." ("..ply:steamName()..")!", FLAG_DANGER)
                    ply:setRagdolled(true, nil)

                    ply:setNetVar("startdown", true)
                    ply:setAction("Respawning", 300, function()
                        if(ply:getNetVar("neardeath")) then
							local pk = nut.config.get("permadeath", false)
							if(pk) then
								local charid = ply:getChar():getID()
								local inventory = ply:getChar():getInv()
								ply:getChar():kick()
								netstream.Start("charDel", charid)
								local storage = ents.Create("sky_tempstorage")
								storage:SetPos(ply:GetPos()+Vector(0,0,12))
								storage:Spawn()
								--storage:SetModel(k) --set model idk
								
								if (inventory) then
									storage:setNetVar("id", inventory:getID())
									storage.steamid = ply:SteamID64()

									for k,v in pairs(inventory:getItems()) do
										if(v:getData("equip")) then
											v:setData("equip", nil)
										end
									end
							
									--read only
									inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
										if (IsValid(client) and IsValid(self) and self.receivers[client]) then
										if(oldInventory:getID() != inventory:getID()) then
											return false
										end
										end
									end
									inventory.getReceiver = function(inventory)
										local receivers = {}
				
										for k, v in pairs(self.receivers) do
											if (IsValid(k)) then
												receivers[#receivers + 1] = k
											end
										end
				
										return #receivers > 0 and receivers or nil
									end
									inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
										if(storage.steamid and client:SteamID64() == storage.steamid) then
											return false
										end
										return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
									end
								end
								return
							end
                            ply:setNetVar("canresp", true)
                            ply:notify("You can now respawn with /acd")
                        end
                    end)
				end
				if(!ply:getNetVar("neardeath") and ply:Health()-dmginfo:GetDamage() <= 15) then
					net.Start("toggleHeartbeat")
					net.WriteBool(true)
					net.Send(ply)
				end
			]]
			else
                return true
			end
        end
    end

	hook.Add("GSDamage", "WowWeirdModels", function(ply, hg, dmginfo)
		if(!GSBG[hg]) then 
			nut.log.addRaw("Something went wrong in the combat below this log! (physics bone hit doesnt exist as hg for gs models). Setting damage as generic.")
			return ScaleDmg(ply, HITGROUP_GENERIC, dmginfo)
		end
		return ScaleDmg(ply, GSBG[hg], dmginfo)
	end)

	hook.Add("ScalePlayerDamage", "ShootToRP", function(ply, hg, dmginfo)
		--[[if(nut.newchar and nut.newchar.isBM(ply:GetModel())) then --these are done above
			return
		end]]
		ScaleDmg(ply, hg, dmginfo)
	end)

    hook.Add("GetFallDamage", "BreakLegs", function(ply, speed)
        local dw = nut.config.get("downing", false)
        if (dw) then
            if(IsValid(ply) and ply:getChar()) then
				--[[if(ply:getChar().getImplants and ply:getChar():getImplants("implants", "fallprot")) then--Data("implants", {})["fallprot"]) then
					print(speed)
					if(speed > 520) then
						ply:EmitSound("player/longfall_land_01.wav", 80, math.random(97, 103))
					end
					return 
				end]]
                if(speed > 600) then --620
                    ply:getChar():setData("leghit", true, nil, player.GetAll())
                    ply:notify("It appears a leg broke from your fall.")
                end
            end
        end
    end)
    
    hook.Add("EntityTakeDamage", "disablegrendamage", function(target, dmg)
    	if(target:GetClass() == "prop_physics" and dmg:IsExplosionDamage() and dmg:GetAttacker():IsPlayer()) then
	    	return true
		end
		if(IsValid(dmg:GetAttacker()) and dmg:GetAttacker():GetClass() == "nut_item") then
			return true
		end
		
		if((target.NEXTBOT or target:IsNPC()) and dmg:GetAttacker():IsPlayer()) then
			local wep = dmg:GetAttacker():GetActiveWeapon()
			if(wep and wep.GetStat and wep:GetStat("NPCDamageMulti")) then
				dmg:ScaleDamage(wep:GetStat("NPCDamageMulti"))
			end
            if(wep.TFA_NMRIH_MELEE) then
                dmg:GetAttacker():getChar():updateAttrib("str", dmg:GetDamage()*0.0001)
			end
		end


		--nut.log.addRaw
		if(target:IsPlayer()) then
			--print(dmg:GetAttacker():GetClass().." "..dmg:GetDamageType(), dmg:IsDamageType(2))
			local res = target:GetArmorResists()
			local levels = target:GetArmorLevels()
			if(levels.durability != 0) then
			for k,v in pairs(res) do
				if(type(k) == "number" and dmg:IsDamageType(k)) then
					--print("scaled "..k)
					local scale = 1
					if(dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT) then scale = 0.8 end
					dmg:ScaleDamage((1-(res[k] or 0)) * scale * (levels.durability or 1))
				end
			end
			end

			if(dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT) then
				local negx, negy = math.random(-1, 0), math.random(-1, 0)
				local ranx, rany = math.Rand(0.3, 0.6)*negx*(dmg:GetDamage()/5), math.Rand(0.3, 0.6)*negy*(dmg:GetDamage()/3)
	
				local ang = Angle(ranx, rany, 0.1)
	
				target:ViewPunch(ang) 
				
				if(math.random(1,6) == 1) then
				if(target:GetArmorItems() != nil) then
				local duraToRem = math.max(0.0001, 0.001+(0.1*((1-(levels.durability or 1)*(dmg:GetDamage()/8)))/100))
				if(duraToRem < 0) then 
					target:SetArmorDurability(nil, 0)
				end
				--print("attacking: durabilty to remove "..duraToRem)
				target:SetArmorDurability(nil, math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
				end
				end
			end
			if(dmg:IsFallDamage()) then
				dmg:ScaleDamage(2)
			end
			if(dmg:GetAttacker():IsPlayer() and target:getNetVar("typing") and !target:getNutData("typeImm")) then
				dmg:ScaleDamage(0)
                return true
			end
		end
		--[[
		if(target:IsPlayer() and (dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT)) then
		
			dmg:ScaleDamage(1-(target:GetArmorResists()["phys"] or 0))
		end
		]]
        
		local dw = nut.config.get("downing", false)
		if (dw) then
    		if(target:getNetVar("player") and target:GetClass() == "prop_ragdoll") then
	    		local ply = target:getNetVar("player")
		    	if(ply:getNetVar("startdown")) then
			    	ply:setNetVar("startdown", nil)
				    return true
    			end

    			if(ply:getNetVar("neardeath")) then
	    			--ply:setNetVar("canrevive", nil)
		    		return true
			    end
			end
			if(target:getNetVar("player") and target:GetClass() == "prop_ragdoll") then
				return 
			end
			if(target:getNetVar("neardeath") or target:getNetVar("startdown")) then return true end
			if(target:IsPlayer() and ((!IsValid(dmg:GetInflictor()) and dmg:GetDamage() != 1) or (dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT))) then
				local ed = target:getChar():getAttrib("end", 0)
				dmg:ScaleDamage(1-(ed/30)*0.01)
				target:getChar():updateAttrib("end", dmg:GetDamage()*0.00005)

				return PLUGIN:DownPlayer(target, dmg)
		--[[
				if(dmg:GetDamage() >= (target:Health()-1)) then --should get near death
					local olddmg = dmg:GetDamage()
					dmg:SetDamage(target:Health()-1)
					nut.log.addRaw("A zombie ("..class..") downed "..target:Name().."!", FLAG_WARNING)
					target:setRagdolled(true, nil)
					target:setNetVar("neardeath", true)
					--dmg:GetAttacker():SetEnemy(nil)
					--if(hitgroup != HITGROUP_HEAD) then
					--target:setNetVar("canrevive", true)
					local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
                    
                    if (ply:isFemale() and !deathSound:find("female")) then
                        deathSound = deathSound:gsub("male", "female")
                    end
					net.Start("toggleHeartbeat")
					net.WriteBool(false)
					net.Send(ply)

                    ply:EmitSound(deathSound)
					--end
					if(target:getNetVar("canrevive") and (target:Health()-olddmg) < -15) then
						target:setNetVar("canrevive", nil) --if canrevive is true and the damage would leave the player below -20, just make it nil again
					end
					target:setNetVar("startdown", true)
					target:setAction("Respawning", 300, function()
						if(target:getNetVar("neardeath")) then --only kill if were still downed
							local pk = nut.config.get("permadeath", false)
							if(pk) then
								local charid = target:getChar():getID()
								local inventory = target:getChar():getInv()
								target:getChar():kick()
								netstream.Start("charDel", charid)
								local storage = ents.Create("sky_tempstorage")
								storage:SetPos(target:GetPos()+Vector(0,0,12))
								storage:Spawn()
								--storage:SetModel(k) --set model idk
								
								if (inventory) then
									storage:setNetVar("id", inventory:getID())
									storage.steamid = target:SteamID64()

									for k,v in pairs(inventory:getItems()) do
										if(v:getData("equip")) then
											v:setData("equip", nil)
										end
									end
							
									--read only
									inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
										if (IsValid(client) and IsValid(self) and self.receivers[client]) then
										if(oldInventory:getID() != inventory:getID()) then
											return false
										end
										end
									end
									inventory.getReceiver = function(inventory)
										local receivers = {}
				
										for k, v in pairs(self.receivers) do
											if (IsValid(k)) then
												receivers[#receivers + 1] = k
											end
										end
				
										return #receivers > 0 and receivers or nil
									end
									inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
										if(storage.steamid and client:SteamID64() == storage.steamid) then
											return false
										end
										return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
									end
								end
								return
							end
							target:setNetVar("canresp", true)
							target:notify("You can now respawn with /acd.")
						end
					end)
				end
				]]
				 
			end
			if(target:IsPlayer() and (!dmg:GetAttacker() or !dmg:GetAttacker():IsNPC()) and !IsValid(dmg:GetInflictor().Owner)) then--(string.find(class, "gas_zone"))) then
				--local ed = target:getChar():getAttrib("end", 0)
				--dmg:ScaleDamage(1-(ed/30)*0.01)
				return PLUGIN:DownPlayer(target, dmg)
				--[[
				if(dmg:GetDamage() >= (target:Health()-1)) then --should get near death
					local olddmg = dmg:GetDamage()
					dmg:SetDamage(target:Health()-1)
					nut.log.addRaw("A zombie ("..class..") downed "..target:Name().."!", FLAG_WARNING)
					target:setRagdolled(true, nil)
					target:setNetVar("neardeath", true)
					--dmg:GetAttacker():SetEnemy(nil)
					--if(hitgroup != HITGROUP_HEAD) then
					--target:setNetVar("canrevive", true)
					local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
                    
                    if (ply:isFemale() and !deathSound:find("female")) then
                        deathSound = deathSound:gsub("male", "female")
                    end
					net.Start("toggleHeartbeat")
					net.WriteBool(false)
					net.Send(ply)

                    ply:EmitSound(deathSound)
					--end
					if(target:getNetVar("canrevive") and (target:Health()-olddmg) < -15) then
						target:setNetVar("canrevive", nil) --if canrevive is true and the damage would leave the player below -20, just make it nil again
					end
					target:setNetVar("startdown", true)
					target:setAction("Respawning", 300, function()
						if(target:getNetVar("neardeath")) then --only kill if were still downed
							local pk = nut.config.get("permadeath", false)
							if(pk) then
								local charid = target:getChar():getID()
								local inventory = target:getChar():getInv()
								target:getChar():kick()
								netstream.Start("charDel", charid)
								local storage = ents.Create("sky_tempstorage")
								storage:SetPos(target:GetPos()+Vector(0,0,12))
								storage:Spawn()
								--storage:SetModel(k) --set model idk
								
								if (inventory) then
									storage:setNetVar("id", inventory:getID())
									storage.steamid = target:SteamID64()

									for k,v in pairs(inventory:getItems()) do
										if(v:getData("equip")) then
											v:setData("equip", nil)
										end
									end
							
									--read only
									inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
										if (IsValid(client) and IsValid(self) and self.receivers[client]) then
										if(oldInventory:getID() != inventory:getID()) then
											return false
										end
										end
									end
									inventory.getReceiver = function(inventory)
										local receivers = {}
				
										for k, v in pairs(self.receivers) do
											if (IsValid(k)) then
												receivers[#receivers + 1] = k
											end
										end
				
										return #receivers > 0 and receivers or nil
									end
									inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
										if(storage.steamid and client:SteamID64() == storage.steamid) then
											return false
										end
										return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
									end
								end
								return
							end
							target:setNetVar("canresp", true)
							target:notify("You can now respawn with /acd.")
						end
					end)
				end
				]]
			end
--[[
			if(!ply:getNetVar("neardeath") and ply:Health()-dmginfo:GetDamage() <= 15) then
				net.Start("toggleHeartbeat")
				net.WriteBool(true)
				net.Send(ply)
			end
			]]
		else
			return false
		end
	end)
	
	--apparently setting notarget in post player death npcs can shoot and it breaks everything cool
	hook.Add("PlayerSpawn", "resetdown", function(ply)
		ply:SetNoTarget(false)
	end)

    hook.Add("PostPlayerDeath", "downedreset", function(ply)
		local dw = nut.config.get("downing", false)
		if (!dw) then return end
	    if(!IsValid(ply)) then return end

		

        if(ply:getChar()) then
			--if they somehow die some other way reset their hp
			ply:getChar():setData("health", nil)

			ply:setNetVar("neardeath", nil)
			ply:setNetVar("startdown", nil)
			ply:setNetVar("canrevive", nil)
			ply:setNetVar("canresp", nil)
		    ply:setNetVar("canscirevive", nil) 
		    ply:setNetVar("canplatrevive", nil) 
			--ply:SetNoTarget(false) --so npcs stop attacking
			ply:getChar():setData("leghit", nil, nil, player.GetAll())
			ply:getChar():setVar("wanted")
			ply:getChar():setVar("wantedtime")
			
			local dd = ents.FindByClass("npc_vj_sec_normal_neut")
			for k,v in pairs(dd) do
				if(v:GetEnemy() == ply) then
					self:ResetEnemy(false)
				end
				if(v:Disposition(ply) == D_HT) then
					v:AddEntityRelationship(ply, D_LI, 100)
					v:ClearEnemyMemory()
				end
			end
    	end
    end)

    hook.Add("PlayerLoadedChar", "downedswitch", function(ply, char, lastChar)
		local dw = nut.config.get("downing", false)
		if(lastChar) then
		net.Start("PlayerOffNV")
		net.Send(ply)
		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(ply)
		end

		local res = ply:GetArmorResists()

		net.Start("PlayerSetHud")
		net.WriteBool(res.hud or false) --idk wat will happen if it sends nil
		net.Send(ply)

        if (!dw) then return end
    
        if(lastChar) then
            ply:setNetVar("neardeath", nil)
			ply:setNetVar("startdown", nil)
            ply:setNetVar("canrevive", nil)
            ply:setNetVar("canresp", nil)
            ply:setNetVar("canscirevive", nil)
		    ply:setNetVar("canplatrevive", nil) 
			ply:SetNoTarget(false) --so npcs stop attacking
        end
	end)

	hook.Add("PrePlayerLoadedChar", "setHealthSwitch", function(ply, char, curChar)
		if(curChar) then

		--	print(char:getName().." "..curChar and curChar:getName() or "none".." "..ply:Health())
			curChar:setData("health", ply:Health())
		end
	end)
	
	hook.Add("PostPlayerLoadout", "getHealth", function(ply)
		if(ply:getChar():getData("health")) then
			ply:SetHealth(ply:getChar():getData("health"))

			if(ply:Health() <= 30) then
				net.Start("toggleHeartbeat")
				net.WriteBool(true)
				net.Send(ply)
			end
		end
	end)

	--[[
	netstream.Hook("lootplayer", function(client, target)
		if (IsValid(target) and target:IsPlayer() and target:getNetVar("neardeath")) then
			nut.plugin.list["tying"]:SearchPlayer(client, target)
		end
	end)
	]]
else
    local ammoStrings = {
        ["sky545"] = "a 5.45x39mm round",
        ["sky556"] = "a 5.56x45mm round",
        ["sky762x25"] = "a 7.62x25mm round",
        ["sky762x38"] = "a 7.62x38mm round",
        ["sky762x39"] = "a 7.62x39mm round",
        ["sky762x51"] = "a 7.62x51mm NATO round",
        ["sky762x54"] = "a 7.62x54mmR round",
        ["sky338"] = "a .338 Magnum round",
        ["sky9x18"] = "a 9x18mm round",
        ["sky9x19"] = "a 9x19mm round",
        ["sky9x39"] = "a 9x39mm round",
        ["sky45acp"] = "a .45 ACP round",
        ["sky22lr"] = "a .22 LR round",
        ["sky50ae"] = "a .50 AE round",
        ["sky57"] = "a 5.7x28mm round",
        ["sky44"] = "a .44 Magnum round",
        ["sky23mm"] = "a 23mm Barricade round",
        ["buckshot"] = "a 12 Gauge buckshot pellet",
		["357"] = "a .357 Magnum round",
		["skygp25"] = "a GP-25 grenade explosion",
		["skym203"] = "a M-203 grenade explosion",
		["grenade"] = "a grenade explosion",
		["gren"] = "something with no Primary??? (grenade more than likely)",
		["ar2"] = "a 6mm pulse round",
		["skyar3"] = "a 6mm pulse round",
    }
    local hitStrings = {
        [HITGROUP_GENERIC] = "an unknown place",
        [HITGROUP_HEAD] = "the head",
        [HITGROUP_CHEST] = "the chest",
        [HITGROUP_STOMACH] = "the abdomen",
        [HITGROUP_LEFTARM] = "the left arm",
        [HITGROUP_RIGHTARM] = "the right arm",
        [HITGROUP_LEFTLEG] = "the left leg",
        [HITGROUP_RIGHTLEG] = "the right leg"
	}

	zHeartBeatPatch = zHeartBeatPatch or nil
	
	net.Receive("toggleHeartbeat", function()
		local bool = net.ReadBool()
		--print("helllooo hb "..tostring(bool))
		if(!bool) then
			if(zHeartBeatPatch) then
				--print("ok")
				zHeartBeatPatch:Stop()
			end
		else
			if(zHeartBeatPatch) then --kill it and make a new one
				zHeartBeatPatch:Stop()
			end
			zHeartBeatPatch = CreateSound(game.GetWorld(), "player/heartbeatloop.wav")
			if(zHeartBeatPatch) then
				zHeartBeatPatch:SetSoundLevel(0)
				zHeartBeatPatch:Play()
			else
				ErrorNoHalt("could not create soundpatch for heartbeat sound!")
			end
		end
	end)

	hook.Add("Tick", "heartbeatcheck", function()
		if(!IsValid(LocalPlayer())) then return end --loading errors

		local hp = LocalPlayer():Health()
		if(LocalPlayer():getChar() and zHeartBeatPatch and zHeartBeatPatch:IsPlaying()) then
			if(hp > 25) then
				zHeartBeatPatch:Stop()
			end
		end
	end)
	
	--moved to s2rp
	hook.Add("CanOpenBagPanel", "dontopenequip", function(item)
	--thisll work for now, bags will only be through that anyway
if(item.base == "base_suit" and !item:getData("equip")) then return false end
end)

--same deal
netstream.Hook("closeBag", function(id)
if(id and nut.gui["inv"..id]) then
	nut.gui["inv"..id]:Remove()
end
end)
	--[[
	--loot
	nut.playerInteract.addFunc("lootply", {
		name = "Loot downed player",
		callback = function(target)
			netstream.Start("lootplayer", target:getNetVar("player"))
		end,
		canSee = function(target) --could remove neardeath tbh idk
			return IsValid(target) and target:getNetVar("player") and target:getNetVar("player"):getNetVar("neardeath")
		end
	})
	]]

    local rad2deg = (180/math.pi)
	net.Receive("UpdateNVType", function() --add function on things that would support this?
		NV_NIGHTTYPE = res["nv"]
	end)
	net.Receive("SetNVType", function() --add function on things that would support this?
		local type = net.ReadInt(3)
		NV_NIGHTTYPE = type
	end)
    net.Receive("PlayerSetNV", function()
		local res = LocalPlayer():GetArmorResists()
        if(res["nv"] != 0) then
            if(!NV_Status) then
                NV_Status = true
                --if(NV_NIGHTTYPE != 1) then
                    NV_NIGHTTYPE = 1--res["nv"]
                --end
                hook.Add("RenderScreenspaceEffects", "NV_FX", NV_FX)
                surface.PlaySound(Sound("items/nvg_on.wav"))
            else
                NV_Status = false
                NV_NIGHTTYPE = 0
                hook.Remove("RenderScreenspaceEffects", "NV_FX")
                surface.PlaySound(Sound("items/nvg_off.wav"))
            end
        end
    end)
    net.Receive("PlayerOffNV", function()
            if(NV_Status) then
                NV_Status = false
                NV_NIGHTTYPE = 0
                hook.Remove("RenderScreenspaceEffects", "NV_FX")
            end
	end)
	
	net.Receive("PlayerSetHud", function()
		QHUD_ON = net.ReadBool()
	end)
	net.Receive("PlayerOffHud", function()
		if(QHUD_ON) then
			QHUD_ON = false
		end
	end)

    net.Receive("PlayerGetDmg", function()
	    local target = net.ReadEntity()
    	local attacker = net.ReadEntity()
	    local wep = net.ReadEntity()
    	local hitgroup = net.ReadInt(4)
	    local dist = net.ReadInt(32)
    	local prot = net.ReadBool()
	    local protection = ""
        
		local ammo = ""
		if(wep.Secondary and wep.Secondary.Ammo != "") then
			ammo = wep.Secondary.Ammo
        elseif(wep.Primary) then
            ammo = wep.Primary.Ammo
        else
            ammo = "gren"
        end

        --typing immunity
    	if(target:getNetVar("typing") and !target:getNutData("typeImm")) then
			if(target == LocalPlayer()) then
				
		    	chat.AddText("You were hit, but you were typing. Hit by "..(ammoStrings[ammo] or "an unknown round").." in "..(hitStrings[hitgroup] or "an unknown place")..".")
    		else
	    		chat.AddText("You hit someone, but they are typing. Hit them with "..(ammoStrings[ammo] or "an unknown round").." in "..(hitStrings[hitgroup] or "an unknown place")..".")
            end
            
		    return
    	end
        
        local pos = target:WorldToLocal(attacker:GetPos())
        local bear = rad2deg*-math.atan2(pos.y, pos.x)

        if(wep.ClassName == "weapon_frag") then
            if(target == LocalPlayer()) then
                chat.AddText("You were hit by the blast of a grenade!")
            else
                chat.AddText("You hit someone with the blast of a grenade!")
            end
    
            return
        end

        if(attacker:InVehicle()) then
            if(target == LocalPlayer()) then
                chat.AddText("You were hit with a vehicle weapon or something else weird. In "..hitStrings[hitgroup]..".")
            else
                chat.AddText("You hit someone with a vehicle weapon or something else weird. In "..hitStrings[hitgroup]..".")
            end
    
            return
        end
        
        if(wep.ClassName == "nut_hands") then
            if(target == LocalPlayer()) then
                chat.AddText("You were punched!")
            else
                chat.AddText("You punched someone!")
            end
        
            return --no need for the rest
        end
        
    	if(ammo and ammo == "none") then
	    	if(target == LocalPlayer()) then
		    	chat.AddText("You were hit with a(n) "..wep.PrintName.."!")
    		else
	    		chat.AddText("You someone with a(n) "..wep.PrintName.."!")
		    end

    		return
        end
        
    	if(target == LocalPlayer()) then --incoming damage
	    	if(!prot) then
    			protection = "You are not protected from the bullet."
	    	else
		    	protection = "Your armor protects you from the bullet."
    		end

    		chat.AddText("You were hit by "..(ammoStrings[ammo] or "an unknown round").." in "..(hitStrings[hitgroup] or "an unknown place").." from "..dist.." meters away! "..protection.." Bearing: "..math.Round(bear, 0))
	    else --confirmation
		    if(!prot) then
			    protection = "They do not appear to be protected from the bullet."
    		else
	    		protection = "They appear to be protected from the bullet."
    		end

    		chat.AddText("You hit someone with "..(ammoStrings[ammo] or "an unknown round").." in "..(hitStrings[hitgroup] or "an unknown place").." from "..dist.." meters away! "..protection)
	    end
    end)

    hook.Add("ScalePlayerDamage", "ShootToRP", function(ply, hitgroup, dmginfo)
	    local on = nut.config.get("shootToRP", false)

    	if (on) then --should only continue if the target is a player and is not ragdolled
	    	if(ply:IsPlayer() and dmginfo:GetAttacker():IsPlayer() and !IsValid(ply.nutRagdoll)) then
		    	timer.Create("STRPClearDecals", 0.01, 1, function()
			    	ply:RemoveAllDecals()
    			end)
	    		return true
    		end
		end
		
    end)

    hook.Add("PlayerBindPress", "DisableRun", function(ply, bind, pressed)
	    if(string.find(bind, "+speed") and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:getChar()) then
            local model = ply:GetModel()
            --[[local suit = ply:GetArmorItem()
            local upgrades
            local run = true
            if(suit) then
                if(string.find(suit.uniqueID, "exo") or string.find(suit.uniqueID, "pas12me") or string.find(suit.uniqueID, "pas10me")) then
                    upgrades = suit:GetUpgrades()
                    if(upgrades and upgrades["suit_exo_run"]) then
                        run = false
                    end
                end
			end]]
			local run = true --if uncommenting above comment remove this line
		    if((string.find(model, "_exo") or string.find(model, "exo_")) and run) then
    			return true
			end
			
			local res = ply:GetArmorResists()
			if(res["nospr"]) then
				return true
			end
        
		    --[[local dw = nut.config.get("downing", false)
    		if (dw) then
	    	    if(ply:getChar() and ply:getChar():getData("leghit")) then
		    	    return true
        		end
	    	end]]
        end
    end)
    

end