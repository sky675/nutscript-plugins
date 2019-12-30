local PLUGIN = PLUGIN
--table of upgrades to mass create, look at cw2+ other plugins lol
--i still want suits to be their own tho for easyness
--[[
	dmg types per stalker type: psure theres others need to check
	impact - dmg_club
	rupture - dmg_slash dmg_bullet
	burn - dmg_burn
	elec - dmg_shock dmg_sonic(?) dmg_energybeam
	chem - dmg_nervegas dmg_poison dmg_acid
	rad - dmg_radiation 
	psy - ?????
]]


PLUGIN.upgradesList = {
    --[[
    ["ex"] = {
        name = "name",
        desc = "desc",
        price = 1,
        upgrades = {
            ["burn"] = 0.1, --10
            ["levels"] = {
                ["chest"] = 1
            },
            ["nv"] = 1
        }
	},]]
	--[[
	--generated
	["suit_psy_grills"] = {
		name = "A psy-protection band made of paired steel grills",
		desc = "The closed band has been demonstrated to provide partial protection against direct psy-emissions",
		price = 3000,
		upgrades = {["psy"]=0.5}
	},
	["suit_filter"] = {
		name = "Filter for work in contaminated areas",
		desc = "A filter with a reinforced anti-corrosive coating with an additional preventing layer for removal of poisons",
		price = 3000,
		upgrades = {["chem"]=0.1}
	},
	["suit_plexicoat"] = {
		name = "Plexiglass Coating",
		desc = "A plexiglass mask can provide partial protection from radiation",
		price = 3000,
		upgrades = {["rad"]=0.2}
	},
	["suit_nightvision"] = {
		name = "PN21KL Night Vision Device",
		desc = "desc too long to type its a nv device ok use /togglenightvision to toggle it",
		price = 11000,
		upgrades = {["nv"]=1},
		flag = "m"
	},
	["suit_imp_mask"] = {
		name = "Impregnated Breathing Mask",
		desc = "Repsirator for total blocking of poisons.",
		price = 3000,
		upgrades = {["chem"]=0.1,["rad"]=0.1}
	},
	["suit_radchem_sys"] = {
		name = "Radioactive and chemical threat prevention system",
		desc = "A system for switching to closed cycle breathing in the event of critical air contamination with radioactive or chemical particles.",
		price = 4000,
		upgrades = {["chem"]=0.2,["rad"]=0.2}
	},
	["suit_const_face"] = {
		name = "Thunderbird Constantan Face Armor",
		desc = "Protective alloy frame to prevent thermal and electrical damage.",
		price = 4000,
		upgrades = {["elec"]=0.2,["burn"]=0.2}
	},
	["suit_thick_ins"] = {
		name = "Thickening Leather Inserts",
		desc = "Thickened inserts.",
		price = 2000,
		upgrades = {["phys"]=0.05}
	},
	["suit_magn_ins"] = {
		name = "Magnesium Plate Inserts",
		desc = "Magnesium inserts protect the wearer from thermal dangers.",
		price = 3000,
		upgrades = {["burn"]=0.1}
	},
	["suit_imp_fabric"] = {
		name = "Impregnated Bodysuit Fabric",
		desc = "Impregnated fabric should prevent chemical poisoning.",
		price = 3000,
		upgrades = {["chem"]=0.1}
	},
	["suit_rub_fabric"] = {
		name = "Rubberized Bodysuit Fabric",
		desc = "Rubber is a basic way of protecting yourself from brief radiation exposure.",
		price = 3000,
		upgrades = {["rad"]=0.1}
	},
	["suit_canvas_body"] = {
		name = "Canvas Bodysuit",
		desc = "Basic protection against rain and caustic substances coming into contact with the skin.",
		price = 3000,
		upgrades = {["chem"]=0.1,["elec"]=0.1}
	},
	["suit_fire_fabric"] = {
		name = "Fabric Treated with a Fire-Resistance substance",
		desc = "Fabric treated with a fire-resistant substance.",
		price = 3000,
		upgrades = {["burn"]=0.1,}
	},
	["suit_comp_ele"] = {
		name = "Addition of a compenstation element",
		desc = "Armor with an inner layer that spreads impact over a greater area",
		price = 3000,
		upgrades = {["phys"]=0.05,}
	},
	["suit_const_ins"] = {
		name = "Constantan thermal isolation inserts",
		desc = "Constantan is capable of isolating against electricity and has a very high melting point.",
		price = 3000,
		upgrades = {["elec"]=0.2,["burn"]=0.2}
	},
	["suit_exp_body"] = {
		name = "Expanse Anomalous Protection Bodysuit",
		desc = "Freedom's airtight Expanse bodysuit used to locate artifacts in anomalous areas.",
		price = 3000,
		upgrades = {["chem"]=0.1,["elec"]=0.1,["rad"]=0.1},
		flag = "m"
	},
	["suit_eco_body"] = {
		name = "Ecologist polymer bodysuit with bismuth inserts",
		desc = "A bodysuit made using new unspecified polymers previously used by the Kiev research institute in developing the SSP-99 with cavities filled with bismuth.",
		price = 3000,
		upgrades = {["chem"]=0.15,["burn"]=0.15},
		flag = "m"
	},
	["suit_plexi_body"] = {
		name = "Lifesaver plexiglass bodysuit with flexible lead mesh",
		desc = "The lead mesh creates radiation and chemical protection without sacrificing mobility.",
		price = 3000,
		upgrades = {["elec"]=0.15,["rad"]=0.15},
		flag = "m"
	},
	["suit_exo_run"] = {
		name = "Addition of hydraulic boosters into drive devices",
		desc = "Installation of hydraulic boosters is a modification that seperates third generation exoskeletons from the fourth generation. Allows you to sprint in an exoskeleton.",
		price = 30000,
		upgrades = {["run"]=1,["stm"]=-0.45,["spd"]=-0.65}
	},
	["suit_2_chest_up"] = {
		name = "II to IIIA Chest Upgrade",
		desc = "Increases a II chest to IIIA.",
		price = 0,
		upgrades = {["levels"]={["chest"]=1}}
	},
	["suit_kevlar"] = {
		name = "Kevlar vest for unarmored chests",
		desc = "Adds a kevlar vest for unarmored chests giving it IIA armor level. Don't ask why you need a tech for this okay.",
		price = 600,
		upgrades = {["levels"]={["chest"]=1}}
	},
	["suit_3a_chest_up"] = {
		name = "IIIA to III Chest Upgrade",
		desc = "Increases a IIIA chest to III.",
		price = 0,
		upgrades = {["levels"]={["chest"]=1}}
	},
	["suit_3_chest_up"] = {
		name = "III to IV Chest Upgrade",
		desc = "Increases a III chest to IV.",
		price = 0,
		upgrades = {["levels"]={["chest"]=1}}
	},
	["suit_none_head_up"] = {
		name = "None to IIA Head Upgrade",
		desc = "Increases a armorless head bodypart to IIA.",
		price = 0,
		upgrades = {["levels"]={["head"]=1}}
	},
	["suit_3_chest_up"] = {
		name = "III to IV Head Upgrade",
		desc = "Increases a III head to IV.",
		price = 0,
		upgrades = {["levels"]={["head"]=1}}
	},
	["suit_3a_chest_up"] = {
		name = "IIIA to III Chest Upgrade",
		desc = "Increases a IIIA chest to III.",
		price = 0,
		upgrades = {["levels"]={["chest"]=1}}
	},
	["suit_none_limb_up"] = {
		name = "None to IIA Limbs Upgrade",
		desc = "Increases armorless limbs bodyparts to IIA.",
		price = 0,
		upgrades = {["levels"]={["larm"]=1,["rarm"]=1,["lleg"]=1,["rleg"]=1,}}
	},
	["suit_3a_head_up"] = {
		name = "IIIA to III Head Upgrade",
		desc = "Increases a IIIA head to III.",
		price = 0,
		upgrades = {["levels"]={["head"]=1}}
	},
	["suit_2a_head_up"] = {
		name = "IIA to II Head Upgrade",
		desc = "Increases a IIA head to II.",
		price = 0,
		upgrades = {["levels"]={["head"]=1}}
	},	
	["suit_2_head_up"] = {
		name = "II to IIIA Head Upgrade",
		desc = "Increases a II head to IIIA.",
		price = 0,
		upgrades = {["levels"]={["head"]=1}}
	},	
	["suit_2_limb_up"] = {
		name = "II to IIIA Limbs Upgrade",
		desc = "Increases II limbs bodyparts to IIIA.",
		price = 0,
		upgrades = {["levels"]={["larm"]=1,["rarm"]=1,["lleg"]=1,["rleg"]=1,}}
	},]]
}