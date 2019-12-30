local PLUGIN = PLUGIN
PLUGIN.itemconfig = { --im sorry i had to // for differences
	--[[	
    ["ex"] = {
		name = "name",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "desc",
		model = "model",
		--skin = 0,
		price = 1,
		width = 1,
		height = 1,
		--flag = "",

		outfitCategory = "",
		--gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		--gs = {type = "top", bg = 0}
		--addons = {"bag", "trenchcoat", "mpvest"} --a table of "addons" that can be equipped with it, will prevent unequipping item while any of these items are equipped

		//pacoutfit/suit
		--pacData = {},
		--pacF = {},
		--pacM = {},

		//outfit/suit
		--newSkin = 0, --setting this prevents data set skins from working (getData("skins"))
		--bodyGroups = {}
		--replacements = ""
		--onGetReplacement = function(item) end

		//suit
		--armor = {}
		--resists = {}
		--upgradePath = "" --id of upgrade if readded
	},
	]]
	
	--citizen female top
    ["torso_fem_refw"] = {
		name = "White Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A yellowed white button down shirt.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 2},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_refg"] = {
		name = "Green Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty green button down shirt.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 3},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_hosw"] = {
		name = "Branded White Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A white work shirt branded with a now defunct company.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 4},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_cwua"] = {
		name = "CWU A Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A button down shirt for A-Class CWU members.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 5},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_oldrefg"] = {
		name = "Dirty Green Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "An old dirty green shirt from a different city.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 6},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_jacket"] = {
		name = "Dark Jacket (White Logo) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dark jacket with a white UU logo on the back.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 7},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_refm"] = {
		name = "Blue Medic Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A blue button down shirt with a medic armband.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 2},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_hosb"] = {
		name = "Branded Blue Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A blue work shirt branded with a now defunct company.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 4},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_cwud"] = {
		name = "CWU D Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A button down shirt for D-Class CWU members.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 5},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_oldrefcamo"] = {
		name = "Dirty Camo Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "An old dirty camo shirt with a faded armband.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 6},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_jackety"] = {
		name = "Dark Jacket (Yellow Logo) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dark jacket with a yellow UU logo on the back.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 7},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
	
	--citizen male top
    ["torso_mal_refg"] = {
		name = "Green Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty green button down shirt.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 2},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_hosb"] = {
		name = "Branded Blue Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A blue work shirt branded with a now defunct company.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 4},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_cwua"] = {
		name = "CWU A Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A button down shirt for A-Class CWU members.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 5},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_oldrefb"] = {
		name = "Dirty Blue Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "An old, dirty, blue shirt from another city.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 6},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_jacket"] = {
		name = "Dark Jacket (White Logo) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dark jacket with a white UU logo on the back.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 7},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_refw"] = {
		name = "White Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A yellowed white button down shirt.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 2},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_refm"] = {
		name = "Blue Medic Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A blue button down shirt with a medic armband.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 3},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_hosw"] = {
		name = "Branded White Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A white work shirt branded with a now defunct company.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "1",
		scrapGive = 4,

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 4},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_cwud"] = {
		name = "CWU D Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A button down shirt for D-Class CWU members.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 5},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_oldrefg"] = {
		name = "Dirty Green Shirt (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty old green shirt from a different city.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 6},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_jacketo"] = {
		name = "Open Outer Jacket (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A light outer jacket with a broken zipper.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, skin = 7},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
	
	--citizen female legs
    ["legs_fem_cwulegs"] = {
		name = "Skinny Jeans with Boots (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of skinny jeans with old boots.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, skin = 0},
	},
    ["legs_fem_cwulegsb"] = {
		name = "Blue Skinny Jeans with Boots (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of skinny jeans with old boots.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, skin = 1},
	},
    ["legs_fem_cit1"] = {
		name = "Dark Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A black colored pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 1},
	},
    ["legs_fem_cit2"] = {
		name = "Dirty Grey Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty greyish pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 2},
	},
    ["legs_fem_cit3"] = {
		name = "Dirty Blue Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty pair of blue pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 3},
	},
    ["legs_fem_hostage"] = {
		name = "Jeans (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of jeans.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 4},
	},
    ["legs_fem_cit4"] = {
		name = "Dark Grey Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A dirty pair of dark grey pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 5},
	},
    ["legs_fem_cit5"] = {
		name = "Worn Faded Blue Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A worn pair of faded blue pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 6},
	},
    ["legs_fem_track"] = {
		name = "Track Pants (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of blue track pants with yellow stripe.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 7},
	},

	--citizen male legs
    ["legs_mal_cit1"] = {
		name = "Dark Pants (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of black colored pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 1},
	},
    ["legs_mal_cit2"] = {
		name = "Bright Blue Pants (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of bright blue pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 2},
	},
    ["legs_mal_hostage"] = {
		name = "Jeans (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of jeans.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 3},
	},
    ["legs_mal_cit3"] = {
		name = "Dirty Grey Pants (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of dirty grey pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 4},
	},
    ["legs_mal_cit4"] = {
		name = "Worn Faded Blue Pants (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A worn pair of faded blue pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 5},
	},
    ["legs_mal_track"] = {
		name = "Track Pants (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A pair of dark blue track pants with a yellow stripe.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 3,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 3,
		permit = "cloth",

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, skin = 6},
	},
	
	--wintercoat
    ["torso_fem_bwintercoat"] = {
		name = "Brown Wintercoat (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A brown wintercoat.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 7,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso;addon",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, skin = 0},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_fem_dwintercoat"] = {
		name = "Dark Wintercoat (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A darker wintercoat.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 7,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso;addon",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["torso_mal_bwintercoat"] = {
		name = "Brown Wintercoat (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A brown wintercoat.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 7,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso;addon", --addon becuz its not compatible with any
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, skin = 0},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["torso_mal_dwintercoat"] = {
		name = "Dark Wintercoat (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A darker wintercoat.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 7,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso;addon",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},

	--rebel female top
    ["torso_fem_rebel11"] = { --model 1 skin 1
		name = "Rebel Top (variant 1-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, model = "models/sky/torsos/female_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebel12"] = { --model 1 skin 2
		name = "Rebel Top (variant 1-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, model = "models/sky/torsos/female_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebel21"] = { --model 2 skin 1
		name = "Rebel Top (variant 2-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, model = "models/sky/torsos/female_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebel22"] = { --model 2 skin 2
		name = "Rebel Top (variant 2-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, model = "models/sky/torsos/female_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},

	--rebel top male
    ["torso_mal_rebel11"] = { --model 1 skin 1
		name = "Rebel Top (variant 1-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, model = "models/sky/torsos/male_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebel12"] = { --model 1 skin 2
		name = "Rebel Top (variant 1-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, model = "models/sky/torsos/male_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebel21"] = { --model 2 skin 1
		name = "Rebel Top (variant 2-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, model = "models/sky/torsos/male_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebel22"] = { --model 2 skin 2
		name = "Rebel Top (variant 2-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 1, model = "models/sky/torsos/male_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
	
	--medic female top
    ["torso_fem_rebelm11"] = { --model 1 skin 1
		name = "Rebel Medic Top (variant 1-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, model = "models/sky/torsos/female_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebelm12"] = { --model 1 skin 2
		name = "Rebel Medic Top (variant 1-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, model = "models/sky/torsos/female_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebelm21"] = { --model 2 skin 1
		name = "Rebel Medic Top (variant 2-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 3, model = "models/sky/torsos/female_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_fem_rebelm22"] = { --model 2 skin 2
		name = "Rebel Medic Top (variant 2-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 3, model = "models/sky/torsos/female_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
		addons = {"molle","ota","trenchcoat"},
		
		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},

	--medic top male
    ["torso_mal_rebelm11"] = { --model 1 skin 1
		name = "Rebel Medic Top (variant 1-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, model = "models/sky/torsos/male_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebelm12"] = { --model 1 skin 2
		name = "Rebel Medic Top (variant 1-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 2, model = "models/sky/torsos/male_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebelm21"] = { --model 2 skin 1
		name = "Rebel Medic Top (variant 2-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 3, model = "models/sky/torsos/male_rebel1.mdl", skin = 1},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},
    ["torso_mal_rebelm22"] = { --model 2 skin 2
		name = "Rebel Medic Top (variant 2-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift set of armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "torso;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 3, model = "models/sky/torsos/male_rebel1.mdl", skin = 2},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		addons = {"molle","ota","trenchcoat"},

		--this is just copied from sec basic for now
		armor = {
			chest = ARMOR_IIIA
		},
		resists = {
			[DMG_BULLET] = 0.18,
			[DMG_SLASH] = 0.15,
			[DMG_CLUB] = 0.15,
			[DMG_BURN] = 0.1,
			[DMG_BLAST] = 0.1,
			spd = 0.94,
		},
	},

	--rebel legs female
    ["legs_fem_rebel11"] = { --model 1 skin 1
		name = "Rebel Legs (variant 1-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, model = "models/sky/legs/female_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_fem_rebel12"] = { --model 1 skin 2
		name = "Rebel Legs (variant 1-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, model = "models/sky/legs/female_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_fem_rebel21"] = { --model 2 skin 1
		name = "Rebel Legs (variant 2-1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, model = "models/sky/legs/female_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_fem_rebel22"] = { --model 2 skin 2
		name = "Rebel Legs (variant 2-2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, model = "models/sky/legs/female_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
	
	--rebel legs male
    ["legs_mal_rebel11"] = { --model 1 skin 1
		name = "Rebel Legs (variant 1-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, model = "models/sky/legs/male_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_mal_rebel12"] = { --model 1 skin 2
		name = "Rebel Legs (variant 1-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 0, model = "models/sky/legs/male_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_mal_rebel21"] = { --model 2 skin 1
		name = "Rebel Legs (variant 2-1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, model = "models/sky/legs/male_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_mal_rebel22"] = { --model 2 skin 2
		name = "Rebel Legs (variant 2-2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 1, model = "models/sky/legs/male_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},

	--medic legs female
    ["legs_fem_rebelm1"] = { --skin 1
		name = "Rebel Medic Legs (variant 1) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 2, model = "models/sky/legs/female_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_fem_rebelm2"] = { --skin 2
		name = "Rebel Medic Legs (variant 2) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 2, model = "models/sky/legs/female_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
	
	--medic legs male
    ["legs_mal_rebelm1"] = { --skin 1
		name = "Rebel Medic Legs (variant 1) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 2, model = "models/sky/legs/male_rebel1.mdl", skin = 1},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},
    ["legs_mal_rebelm2"] = { --skin 2
		name = "Rebel Medic Legs (variant 2) (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A makeshift pair of pants.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 55,	
		width = 1,
		height = 1,
		
		noBusiness = true,

		outfitCategory = "legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "bot", bg = 2, model = "models/sky/legs/male_rebel1.mdl", skin = 2},
	
	
		--this is just copied from sec basic for now
		armor = {
		},
		resists = {
			[DMG_BULLET] = 0.06,
			[DMG_SLASH] = 0.06,
			[DMG_CLUB] = 0.06,
			spd = 0.98,
		},
	},

	--admin seperates
    ["sep_fem_admin"] = {
		name = "Administrator Suit (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A brown clean suit.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 15,
		width = 1,
		height = 1,
		flag = "4",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, model = "models/sky/seperate/female_admin.mdl", skin = 0},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3, ["upper"] = 1}
		end,
		
	},
    ["sep_fem_adminskirt"] = {
		name = "Administrator Suit (Skirt) (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A clean brown suit with a skirt and opaque pantyhose.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 15,
		width = 1,
		height = 1,
		flag = "4",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 1, model = "models/sky/seperate/female_admin.mdl", skin = 0,
		custombg = {[1] = 1}
		},
		
		getBodyGroups = function(item, ply)
			return {["arms"] = 3, ["upper"] = 1}
		end,
		
	},
    ["sep_mal_admin"] = {
		name = "Administrator Suit (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A clean brown suit.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 15,
		width = 1,
		height = 1,
		flag = "4",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, model = "models/sky/seperate/male_admin.mdl", skin = 0},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
		
	},

	--jumpsuits
    ["sep_mal_gjumpsuit"] = {
		name = "Green Jumpsuit (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A green jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		--skin = 0,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 2}
		end,
		upgradePath = "jumpsuit",
	},
    ["sep_fem_gjumpsuit"] = {
		name = "Green Jumpsuit (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A green jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		--skin = 0,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/female_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 1}
		end,
		upgradePath = "jumpsuit",
	},
    ["sep_mal_wjumpsuit"] = {
		name = "White Jumpsuit (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A white jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 2,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 1, model = "models/sky/seperate/male_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 2}
		end,
		upgradePath = "jumpsuit",
	},
    ["sep_fem_wjumpsuit"] = {
		name = "White Jumpsuit (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A white jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 2,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 1, model = "models/sky/seperate/female_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 1}
		end,
		upgradePath = "jumpsuit",
	},
    ["sep_mal_bjumpsuit"] = {
		name = "Black Jumpsuit (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A black jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 1,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 2, model = "models/sky/seperate/male_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 2}
		end,
		upgradePath = "jumpsuit",
	},
    ["sep_fem_bjumpsuit"] = {
		name = "Black Jumpsuit (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A black jumpsuit.",
		model = "models/sky/dropped/jumpsuit.mdl",
		skin = 1,
		price = 6,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 2, model = "models/sky/seperate/female_jumpsuit.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 1}
		end,
		upgradePath = "jumpsuit",
	},

	--scrubs
    ["sep_mal_bscrubs"] = {
		name = "Blue Scrubs (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of blue scrubs.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 7,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_scrubs.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["sep_mal_pscrubs"] = {
		name = "Purple Scrubs (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of purple scrubs.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 7,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 1, model = "models/sky/seperate/male_scrubs.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4}
		end,
	},
    ["sep_fem_bscrubs"] = {
		name = "Blue Scrubs (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of blue scrubs.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 7,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/female_scrubs.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
    ["sep_fem_pscrubs"] = {
		name = "Purple Scrubs (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of purple scrubs.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 7,
		width = 1,
		height = 2,
		flag = "0",

		outfitCategory = "torso;legs",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 1, model = "models/sky/seperate/female_scrubs.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
	
    ["armor_ota"] = {
		name = "OTA Armor",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "for giving ota armor",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 0,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "torso;legs;gloves;armor;mask;eyes;head",
		--gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		--gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_militia.mdl"},
		--[[getBodyGroups = function(item, ply)
			return {["arms"] = 4, ["hands"] = 3}
		end,]]
		armor = {
			chest = ARMOR_IV,
			larm = ARMOR_IV,
			rarm = ARMOR_IV,
			lleg = ARMOR_IV,
			rleg = ARMOR_IV,
			head = ARMOR_IV,
		},
		resists = {
			[DMG_BULLET] = 0.38,
			[DMG_SLASH] = 0.4,
			[DMG_CLUB] = 0.3,
			[DMG_BURN] = 0.3,
			[DMG_BLAST] = 0.3,
			[DMG_FALL] = 0.35,
			[DMG_SHOCK] = 0.3,
			[DMG_NERVEGAS] = 0.35,
			spd = 0.81,
		},
		--upgradePath = "militia",
	},

	--militia
    ["sep_mal_militia"] = {
		name = "Militia Armor (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of makeshift commercial armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "torso;legs;gloves;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_militia.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4, ["hands"] = 3}
		end,
		armor = {
			chest = ARMOR_II,
			larm = ARMOR_IIA,
			rarm = ARMOR_IIA,
			lleg = ARMOR_IIA,
			rleg = ARMOR_IIA,
		},
		resists = {
			[DMG_BULLET] = 0.19,
			[DMG_SLASH] = 0.19,
			[DMG_CLUB] = 0.19,
			[DMG_BURN] = 0.25,
			[DMG_BLAST] = 0.04,
			spd = 0.87,
		},
		upgradePath = "militia",
	},
    ["sep_fem_militia"] = {
		name = "Militia Armor (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of makeshift commerical armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "torso;legs;gloves;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/female_militia.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3, ["hands"] = 3}
		end,
		armor = {
			chest = ARMOR_II,
			larm = ARMOR_IIA,
			rarm = ARMOR_IIA,
			lleg = ARMOR_IIA,
			rleg = ARMOR_IIA,
		},
		resists = {
			[DMG_BULLET] = 0.19,
			[DMG_SLASH] = 0.19,
			[DMG_CLUB] = 0.19,
			[DMG_BURN] = 0.25,
			[DMG_BLAST] = 0.04,
			spd = 0.87,
		},
		upgradePath = "militia",
	},

	
	--prob should be deleted imo
	--kevlar vest
    ["armor_basickevlar"] = {
		name = "Kevlar Vest",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "THIS IS LEFT OVER AND MAY BE DELETED LOL A light kevlar vest worn underneath whatever you wear.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 1550,
		width = 1,
		height = 1,
		flag = "1",
		noBusiness = true,

		outfitCategory = "armor",

		armor = {
			chest = ARMOR_IIA
		},
		resists = {
			[DMG_BULLET] = 0.07,
			[DMG_SLASH] = 0.07,
			[DMG_CLUB] = 0.07,
			spd = 0.97,
		},
	},

	--[[
    ["armor_sunrise"] = {
		name = "Sunrise",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "wip",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_militia.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4, ["hands"] = 3}
		end,
		armor = {
			chest = ARMOR_II,
			larm = ARMOR_IIA,
			rarm = ARMOR_IIA,
			lleg = ARMOR_IIA,
			rleg = ARMOR_IIA,
		},
		resists = {
			[DMG_BULLET] = 0.19,
			[DMG_SLASH] = 0.19,
			[DMG_CLUB] = 0.19,
			[DMG_BURN] = 0.25,
			[DMG_BLAST] = 0.04,
			spd = 0.87,
		},
		upgradePath = "militia",
	},]]

}