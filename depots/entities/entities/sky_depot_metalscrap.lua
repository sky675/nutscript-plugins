AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.Base = "sky_depot_base"
ENT.PrintName = "depot metalscrap"
ENT.Category = "HL2RP"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE


ENT.name = "Scrap Pile"
ENT.desc = "A pile of various metal scraps."
ENT.model = "models/props_debris/concrete_floorpile01a.mdl" --better thing pls
ENT.mat = "models/props_pipes/destroyedpipes01a" --optional to overwrite material
ENT.action = "Searching..."
ENT.timeUse = 3 --how long to hold it
ENT.cooldownTime = 11 --idk
ENT.stock = 10
ENT.lowstock = 5
ENT.vlowstock = 3
ENT.fullCd = 600
ENT.loottable = {
--	["none"] = 1,
	["comp_scrap_metal"] = 1
}