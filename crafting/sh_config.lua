local PLUGIN = PLUGIN

PLUGIN.recipeList = {
	--[[
	recipe def:
	["uniqueID"] = {
		name = the name,
		desc = the desc,
		category = the category to file it under,
		model = model to display,
		skin = skin of model (not required),
		workbench = table of workbench ids ({["basic"] = true,},)
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			["ingreduniqueid"] = true, --or # of needed,
		},
		result = "result", --can also be table for multiple results
		flag = "", --optional can be left out, flag to check for
		handpick = function(items)
			--return an item id from the list of items and that id will get passed into beforeCraft
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--handpick is the item id gotten from handpick, it will be nil if this wasnt done
			--return a table and it will reappear in oncreate as data
		end,
		adddata = true, --this will set the data returned in beforeCraft on the result item
		onCreate = function(ply, item, data) 
			--to do something when created such as transfer data
		end,
		timed = {
			action = "the action to display during timed action",
			time = 0, --length of the action
		},
		--jobRequire = true, --special thing for crafting job keeping
	},
	]]
	--basic stuff
	["basic_bandage"] = {
		name = "Bandage",
		desc = [[A simple bandage.
Ingredients: 3x Patch of Cloth
Results: 1x Bandage]],
		category = "Medical",
		model = "models/sky/items/bandage.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 3, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "meds_bandage", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["basic_upbandage"] = {
		name = "Upgrade Bandage",
		desc = [[Increase the quality of a bandage by using a jar of antiseptic.
Trait Requirements: General Crafting Level 1
Ingredients: 1x Bandage, 1x Jar of Antiseptic
Results: 1x Antiseptic Bandage]],
		category = "Medical",
		model = "models/sky/items/bandage.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["meds_bandage"] = true, --or # of needed,
			["comp_jar_antiseptic"] = true,
		},
		result = "meds_bandage2", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["basic_medkit"] = {
		name = "Medkit",
		desc = [[Combine various things to make a basic medkit.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Bandage, 1x Jar of Antiseptic, 3x Patch of Cloth
Results: 1x Basic Medkit]],
		category = "Medical",
		model = "models/sky/items/medkit1.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["meds_bandage"] = 2, --or # of needed,
			["comp_jar_antiseptic"] = 1,
			["comp_scrap_cloth"] = 3,
		},
		result = "medkit1", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--job related
	["job_craftpt1"] = { 
		name = "Weld Scrap",
		desc = [[Combine metal scrap into a crude, incomplete metal plate.
Ingredients: 2x Scrap Metal
Results: 1x Crude Plate]],
		category = "Job",
		model = "models/props_debris/metal_panel02a.mdl",
		--skin = skin of model (not required),
		workbench = {["work1"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 2, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "job_plate1", --can also be table for multiple results
		timed = {
			action = "Combining...",
			time = 5, --length of the action
		},
		--flag = "", --optional can be left out, flag to check for
	},
	["job_craftpt2"] = { 
		name = "Complete Metal Plate",
		desc = [[Smooth and trim the incomplete metal plate.
Ingredients: 1x Crude Plate
Results: 1x Unfinalized Plate]],
		category = "Job",
		model = "models/props_debris/metal_panel02a.mdl",
		--skin = skin of model (not required),
		workbench = {["work2"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["job_plate1"] = 1, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "job_plate2", --can also be table for multiple results
		timed = {
			action = "Working...",
			time = 5, --length of the action
		},
		--flag = "", --optional can be left out, flag to check for
	},
	["job_craftobj"] = { 
--doc suggested something like "stuff that isnt useful now but can be made into stuff 
--useful later ex bottom part of circuitboards"
		name = "Finalize Metal Plate",
		desc = [[Add coating and various other things to finish the plate.
Ingredients: 1x Unfinalized Plate
Results: 1x Metal Plate]],
		category = "Job",
		model = "models/props_debris/metal_panel02a.mdl",
		--skin = skin of model (not required),
		workbench = {["compwork"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["job_plate2"] = 1, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "job_obj", --can also be table for multiple results
		timed = {
			action = "Finalizing...",
			time = 3, --length of the action
		},
		jobRequire = true,
		--flag = "", --optional can be left out, flag to check for
	},

	--crafting
	["comp_mech1"] = {
		name = "Craft Light Mechanisms",
		desc = [[Fashions the scrap into some various springs and mechanisms.
Trait Requirements: General Crafting Level 2
Ingredients: 2x Scrap Metal, 1x Wire Spool
Results: 1x Light Mechanisms]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 5,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_wire1"] = 1, --or # of needed,
			["comp_scrap_metal"] = 2,
		},
		result = "comp_mech1", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["comp_mech2"] = {
		name = "Reinforce Mechanisms",
		desc = [[Does some stuff to make the assorted mechanisms sturdier.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Light Mechanisms, 1x Scrap Metal
Results: 1x Reinforced Mechanisms]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 3,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_mech1"] = 2, --or # of needed,
			["comp_scrap_metal"] = true,
		},
		result = "comp_mech2", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["comp_padcloth"] = {
		name = "Padded Cloth",
		desc = [[Does some stuff to make a more thick cloth.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Scrap of Cloth
Results: 1x Padded Cloth]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 2, --or # of needed,
		},
		result = "comp_pad_cloth", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--special yes
	["maki_special"] = {
		name = "Craft Hack Tool",
		desc = [[Creates a specialized hack tool.
Trait Requirements: None
Ingredients: 6x Scrap Metal, 5x Wire Spool, 6x Basic Tech, 1x Data Reader, 1x Data Recorder, 1x GPS
Results: 1x Maki's Hack Tool]],
		category = "Special",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		--[[traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},]]
		steamid = "STEAM_0:0:23875518", --me :)
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 6,
			["comp_wire1"] = 5, --or # of needed,
			["comp_tech1"] = 6,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			["datachik1"] = 1,
			["datachik2"] = 1,
			["datachik3"] = 1,
		},
		result = "hacktool_maki", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["maki_remote"] = {
		name = "Craft Hack Remote",
		desc = [[Creates an experimental hack remote.
Trait Requirements: None
Ingredients: 3x Scrap Metal, 3x Wire Spool, 4x Basic Tech, 1x GPS
Results: 1x Hack Remote]],
		category = "Special",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		--[[traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},]]
		steamid = "STEAM_0:0:23875518", --me :)
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3,
			["comp_wire1"] = 3, --or # of needed,
			["comp_tech1"] = 4,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			--["datachik1"] = 1,
			--["datachik2"] = 1,
			["datachik3"] = 1,
		},
		result = "hack_remote", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	["craft_flashlight"] = {
		name = "Craft Flashlight (Tape)",
		desc = [[Create a flashlight out of various bits. Lightbulb? Don't worry about it.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 3x Scrap Metal, 1x Light Mechanisms, 2x Small Tech, 1x Duct Tape, 1x Wire Spool
Results: 1x Flashlight]],
		category = "Items",
		model = "models/props_junk/cardboard_box004a.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_duct_tape"] = 1,
			["comp_wire1"] = 1,
		},
		result = "flashlight", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["craft_flashlight2"] = {
		name = "Craft Flashlight (Wire)",
		desc = [[Create a flashlight out of various bits. Lightbulb? Don't worry about it.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 3x Scrap Metal, 1x Light Mechanisms, 2x Small Tech, 4x Wire Spool
Results: 1x Flashlight]],
		category = "Items",
		model = "models/props_junk/cardboard_box004a.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_wire1"] = 4,
		},
		result = "flashlight", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["craft_radio"] = {
		name = "Craft Radio",
		desc = [[Create a makeshift radio out of various bits.
Trait Requirements: Basic Tech Crafting Level 2
Ingredients: 4x Scrap Metal, 1x Light Mechanisms, 3x Small Tech, 2x Wire Spool
Results: 1x Radio]],
		category = "Items",
		model = "models/stalker/item/handhelds/radio.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 4, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 3,
			["comp_wire_spool"] = 2,
		},
		result = "radio", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["craft_flashlightatt"] = {
		name = "Flashlight -> Flashlight Attachment",
		desc = [[Turn a flashlight into a kind that you can mount on a gun.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 1x Flashlight, 1x Scrap Metal, 1x Duct Tape, 1x Wire Spool
Results: 1x Flashlight Attachment]],
		category = "Items",
		model = "models/Items/BoxMRounds.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["flashlight"] = 1,
			["comp_scrap_metal"] = 1, --or # of needed,
			["comp_duct_tape"] = 1,
			["comp_wire1"] = 1,
		},
		result = "ins2_ub_light", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--craft weps
	["wep_switchblade"] = {
		name = "Switchblade",
		desc = [[Assemble some scrap and assorted parts into a makeshift switchblade.
Trait Requirements: General Crafting Level 2
Ingredients: 2x Scrap Metal, 1x Light Mechanisms
Results: 1x Switchblade]],
		category = "Weapons",
		model = "models/mosi/fallout4/props/weapons/melee/switchblade.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"]=true},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 2, --or # of needed,
			["comp_mech1"] = 1,
		},
		result = "wep_m_f4switchblade", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--weapon conversions
	["wepconv_glocka"] = {
		name = "G17 -> G17 Auto Conversion",
		desc = [[Converts a Glock 17 to be automatic only.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 2
ingredients: 1x Glock 17, 2x Reinforced Mechanisms,
results: 1x Glock 17 Auto]],
		category = "Custom Conversions",
		model = "models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_glock"] = true, --or # of needed,
			["comp_mech2"] = 2,
			--["jar_antiseptic"] = true,
		},
		result = "wep_glocka", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_glock") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},
	["wepconv_glock"] = {
		name = "G17 Auto -> G17 Conversion",
		desc = [[Converts a Glock 17 Auto back to the normal version.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 2
Ingredients: 1x Glock 17,
Result: 1x Glock 17 Auto]],
		category = "Custom Reverts",
		model = "models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_glocka") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},
	["wepconv_izhsawn"] = {
		name = "IZH-43 Sawn-off",
		desc = [[Converts a IZH-43 to be the sawn-off version. Not reversible.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 1
ingredients: 1x Izh-43,
results: 1x Izh-43 (Sawn-off)]],
		category = "Custom Conversions",
		model = "models/weapons/tfa_ins2/w_sawedoff.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_izh"] = true, --or # of needed,
			--["comp_mech2"] = 2,
			--["jar_antiseptic"] = true,
		},
		result = "wep_izhsawn", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_izh") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},

	--passive weapon upgrades
	["passiveadd_dura"] = {
		name = "Durability Increase",
		desc = [[probably will be renamed eventually
decreases durability taken on firing,
but increases spread, recoil and decreases movespeed
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Custom Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech2"] = 1,
			["comp_scrap_metal"] = 2,
			["comp_duct_tape"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_mweapons" and v:getData("equip") != true) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[10] = "sky_pass_dura" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["passiveadd_hvbrl"] = {
		name = "Heavy Barrel",
		desc = [[reduces the vertical recoil of weapon but also increases its weight.
needs to be a rifle (any 545, 556, 762 or 338 weapon), not usable on weapons that have a suppressor attached
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped applicable weapon, 1x Light Mechanisms, 3x Scrap Metal, 1x Wire Spool
Result: 1x that unequipped weapon, with the att applied]],
		category = "Custom Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 3,
			["comp_wire1"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_mweapons" and v:getData("equip") != true) then
					if(!(v.type == "n" or v.type =="ws") and v:getData("atts", {})[1]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[11] = "ins2_br_heavy" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},

	--melee mods
	["melee_bat_nail"] = {
		name = "Add nails to wooden baseball bat",
		desc = [[adds nails to a wooden baseball bat
needs a wooden baseball bat unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 1
Ingredients: 1x any unequipped wooden baseball bat, 2x Light Mechanisms,
Result: 1x that bat, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/baseballbat.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 2,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4bat" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_batnail" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_baton_stun"] = {
		name = "Add stunpack to plastic baton",
		desc = [[adds a makeshift stunpack to the plastic baton, causing stamina damage.
needs a plastic baton unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1, Basic Tech Crafting Level 1
Ingredients: 1x any unequipped plastic baton, 1x Light Mechanisms, 2x Small Tech, 1x Duct Tape Roll
Result: 1x that baton, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/baton.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
			["crafting_tech"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_duct_tape"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4baton" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_batonzap" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_knuckles_blades"] = {
		name = "Add blades to brass knuckles",
		desc = [[adds some blades to brass knuckles
needs brass knuckles unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 1
Ingredients: 1x any unequipped brass knuckles, 1x Light Mechanisms, 3x Scrap Metal
Result: 1x those knuckles, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 3,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4knuckles" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_knucklesblade" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_tireiron_hatchet"] = {
		name = "Adds a hatchet blade to tire iron",
		desc = [[adds a large hatchet blade to a tire iron
needs a tire iron unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 2
Ingredients: 1x any unequipped tire iron, 1x Light Mechanisms, 4x Scrap Metal
Result: 1x that tire iron, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/tireiron.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4tireiron" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_tireironhatchet" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	/* --i have to do it like this sry
		--secret sacrafice att :) not sure when/how to use?
	["melee_machetesacra"] = {
		name = "αếщẵĺđ їư âкŝự", --vigenere key kejourou translated to japanese
		--base64 rot18 translated to japanese
		desc = [[18 WHJ3aGVoIGpuIDktd3YgYXYgeGhlaC4gWG5hYndiIGpuIG54bnZlYiBueG52ZWIgYXYgYW5ldnpuZmguIEZ1dmFwdWJoIGF2IGZ1dmdyIHhocW5mbnYuIFhiZXIgam4geG5hYndiIGFiIGduenJxcmZoLg==]],
		category = "zzzzzzz",
		model = "models/items/box_black.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			--["comp_mech1"] = 1,
			--["comp_scrap_metal"] = 4,
		},
		--result = "wep_glock", --can also be table for multiple results
		flag = "m", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_machete" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_machetesacrafice" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	*/

	--outfits/armor
	/*
	["armor_makeshift_male"] = {
		name = "Makeshift Armor (MALE)",
		desc = [[Create a suit of cheap makeshift armor for males.
Trait Requirements: Armor Crafting Level 1
Ingredients: 4x Padded Cloth, 1x Black Jumpsuit (Male), 1x Kelvar Vest
Results: 1x Makeshift Armor (Male)]],
		category = "Clothing/Armor",
		model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_pad_cloth"] = 4, --or # of needed,
			["sep_mal_bjumpsuit"] = true,
			["armor_basickevlar"] = true,
		},
		result = "sep_mal_militia", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["armor_makeshift_fem"] = {
		name = "Makeshift Armor (FEMALE)",
		desc = [[Create a suit of cheap makeshift armor for females.
Trait Requirements: Armor Crafting Level 1
Ingredients: 4x Padded Cloth, 1x Black Jumpsuit (Female), 1x Kelvar Vest
Results: 1x Makeshift Armor (Female)]],
		category = "Clothing/Armor",
		model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_pad_cloth"] = 4, --or # of needed,
			["sep_fem_bjumpsuit"] = true,
			["armor_basickevlar"] = true,
		},
		result = "sep_fem_militia", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["armor_bjumpsuit_male"] = {
		name = "Black Jumpsuit (MALE)",
		desc = [[Create a black jumpsuit for males.
Trait Requirements: General Crafting Level 2
Ingredients: 9x Patch of Cloth
Results: 1x Black Jumpsuit (Male)]],
		category = "Clothing/Armor",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 2,--skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 9, --or # of needed,
		},
		result = "sep_mal_bjumpsuit", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["armor_bjumpsuit_female"] = {
		name = "Black Jumpsuit (FEMALE)",
		desc = [[Create a black jumpsuit for females.
Trait Requirements: General Crafting Level 2
Ingredients: 9x Patch of Cloth
Results: 1x Black Jumpsuit (Female)]],
		category = "Clothing/Armor",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 2,--skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 9, --or # of needed,
		},
		result = "sep_fem_bjumpsuit", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	*/



	/* --trying on item
	["cloth_scrap"] = {
		name = "Scrap Item",
		desc = [[Takes the first unequipped citizen clothing item it finds, regardless of gender, and replaces it with an amount of cloth scraps depending on the item. (4 for tops, 3 for bottoms)
For best results, have only the item you want to scrap in your inventory unequipped
Ingredients: Any unequipped clothing item
Results: Variable Cloth Scrap]],
		category = "Scrapping",
		model = "models/items/repairpacks/textile_patch_b.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
		--	["comp_scrap_cloth"] = 9, --or # of needed,
		},
		--result = "sep_fem_bjumpsuit", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(!item:getData("equip") and item.scrapGive and item.base == "base_suit") then
					return k
				end
			end
		end,
		addbasedonpick = function(pick)
			local item = nut.item.instances[pick]
			if(!item) then return end

			local amttogive = item.scrapGive or 4
			local itemgive = item.itemGive or "comp_scrap_cloth"

			item:remove() --get rid of it
			return itemgive, amttogive
		end,
	},
	*/
	
	/*
	["armor_sunriseswap"] = {
		name = "Swap Sunrise",
		desc = [[Swaps the first non-upgrade version sunrise it finds, regardless of gender, with either a masked version if its unmasked, or the unmasked version if its masked.
Data such as armor durability will transfer.
For best results, have only the sunrise you want to swap in your inventory
Ingredients: Any unequipped non-upgrade version sunrise
Results: That same sunrise, but now masked/unmasked]],
		category = "Clothing Swapping",
		model = "models/sky/dropped/sunrise.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
		--	["comp_scrap_cloth"] = 9, --or # of needed,
		},
		--result = "sep_fem_bjumpsuit", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(string.find(v.uniqueID, "sunrise") and !string.find(v.uniqueID, "_up") and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then return end --??
			local item = nut.item.instances[handpick]
			local data = item:getData(true) --this apparently gets all data
					
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		addbasedonpick = function(pick)
			local item = nut.item.instances[pick]
			if(!item) then return end

			if(string.find(item.uniqueID, "_mask")) then
				local id = item.uniqueID
				item:remove() --get rid of it
				return string.gsub(id, "_mask", "")
			else
				local id = item.uniqueID.."_mask"
				item:remove()
				return id
			end
		end,
		adddata = true,
	},
	*/
}