ITEM.name = "SSP Suit"
ITEM.desc = "test"
ITEM.model = "models/sky/seperate/male_eco.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "armor;head;mask;eyes" --idk for now
ITEM.price = 25
ITEM.flag = "4"


ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(80.053802490234, 0, 49.822090148926),
	ang = Angle(0, 180, 0),
	entAng = Angle(0, 0, 0),
	fov = 14.763357201488,
	
	drawHook = function(ent, w, h)
		
	end,
}
ITEM.onGetDropModel = function(item, ent)
	return "models/sky/dropped/eco.mdl"
end

--ITEM.upgradePath = "eyes"

--[[
function ITEM:getName()
	--todo change name depending on rank?
	
	local dataRank = self:getData("rank", "default")
	local name = ""

	if(SCHEMA.rankMods[dataRank]) then
		name = SCHEMA.rankMods[dataRank].name
	else
		name = SCHEMA.rankMods["RCT"].name --idk
	end

	return name.." (Male)"
end
]]

ITEM.canWear = function(self, ply)
	local model = ply:GetModel()
	if(nut.newchar.isBM(model)) then
		return true
	elseif(model:find("_mask")) then
		return false, "Please unequip the mask/helmet first!"
	else
		return false, "Your model cannot wear this item!"
	end
end
ITEM.canRemove = function(self, ply)
	local model = ply:GetModel()
	local inv = ply:getChar():getInv()
	local item
	local mask = false
	local addonscheck = {"addon_mp_gearvest", "addon_mp_heavyarmor"}
	for k,v in pairs(inv:getItems()) do
		if(string.find(v.uniqueID, "helm_") and v:getData("equip")) then
			item = v
			mask = true
			break
		end
		
		for k2,v2 in pairs(addonscheck) do
			if(string.find(v.uniqueID, v2) and v:getData("equip")) then
				item = v
				break
			end
		end
	end
	if(item) then
		if(mask) then
			return false, "You need to unequip your mask first!"
		else
			return false, "You need to unequip the addon on top of it first!"
		end
	else
		return true
	end
end


ITEM.gsresetsubmat = true --this is annoying
--todo need a way to change forms, set rank to something at some point?
function ITEM:getCustomGS()
	local tbl = {
		type = "seperate",
		bg = 0,
	}

	if(self.player:isFemale()) then
		tbl.model = "models/sky/seperate/female_eco.mdl"
	else
		tbl.model = "models/sky/seperate/male_eco.mdl"
	end

	--submat
	
	return tbl
end
ITEM.getBodyGroups = function(item, ply)
	return {["arms"] = ply:isFemale() and 3 or 4,["hands"] = 3}
end

ITEM.armor = {
	chest = {level = ARMOR_IIIA},
	larm = {level = ARMOR_IIA},
	rarm = {level = ARMOR_IIA}
}
ITEM.resists = {
	[DMG_BULLET] = 0.22,
	[DMG_SLASH] = 0.2,
	[DMG_CLUB] = 0.2,
	[DMG_BURN] = 0.15,
	[DMG_BLAST] = 0.14,
	spd = 0.89,
}