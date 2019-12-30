AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.Base = "sky_depot_base"
ENT.PrintName = "depot trash" --name in spawn menu
ENT.Category = "HL2RP" --category in spawn menu
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE


ENT.name = "Dumpster" --name displayed when looking at it
ENT.desc = "A dumpster filled with various garbage." --desc under it
ENT.model = "models/props_junk/trashdumpster01a.mdl" --model given to it
--ENT.mat = "models/props_pipes/destroyedpipes01a" --optional to overwrite material, wont work with all mats, usually only works with mats in models/, unsure of the actual part of the material that makes it work
ENT.action = "Searching..." --the text shown when using it
ENT.timeUse = 3.5 --how long the use timer is in seconds
ENT.cooldownTime = 80 --the time in seconds between uses
ENT.stock = 12 --the amount of uses it has with no scaling
ENT.lowstock = 6 --when the uses get this amount, it adds onto the desc "It looks like this is starting to get empty."
ENT.vlowstock = 3 --when it gets to this amount, it instead adds onto it "It looks like this is almost empty"
--theres a special one for only 1 left, vlowstock will take priority over lowstock, and 1 will take priority over both
ENT.selfregen = 1200 --optional, comment out/remove to not use, the time it takes in seconds for a single charge to come back without it having to be on fullcd
ENT.fullCd = 1800 --the time for when the depot goes on full cd when it runs out of stock, after it elapses, it will be full stock again
ENT.loottable = {
	--the loot table, similar format as the loot plugin
	--[id (or "none")] = chances for it to be picked,
	--none means nothing will be picked
	["none"] = 61,
	["comp_scrap_metal"] = 3,
	["comp_scrap_cloth"] = 10,
	["comp_mech1"] = 4,
	["comp_duct_tape"] = 2,
	--["comp_wire1"] = 6,
	["metalcan"] = 3,
	["metalcanl"] = 1,
	["shoe"] = 1,
	["bleach"] = 1,
	["drink_beer"] = 4,
	["drink_bh_sodacan"] = 1,
	["drink_dk_sodacan"] = 1,
	["drink_mi_sodacan"] = 1,
	["drink_fi_coffee"] = 1,
	["drink_sodacan"] = 5,
	["food_barchoc"] = 4,
	["food_bagchips"] = 2,
	["food_takeout"] = 2,
	["food_orange"] = 1,
	["food_banana"] = 1,
	["datachik1"] = 3,
	["datachik2"] = 2,
	["eyes_glasses"] = 3,
	["hands_bgloves"] = 4,
	["head_beanie"] = 2,
	["head_gbeanie"] = 2,
	["mask_rbandana"] = 1,
	["mask_bbandana"] = 1,
	["mask_surgicalmask"] = 2,
	["wep_m_pipe"] = 1,
	--["wep_m_f4knuckles"] = 1,
	["wep_m_f4pipe"] = 1,
	--["wep_m_f4switchblade"] = 1,
	["wep_m_f4tireiron"] = 1,
	["wep_m_kknife"] = 1,
	["wep_m_pipe"] = 1,
}