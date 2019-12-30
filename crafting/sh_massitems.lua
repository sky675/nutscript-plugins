local itemList = {
	--[[
	["uniqueid"] = {
		name = "name",
		desc = RarityText(RARITY_UNCOMMON).."",
		price = 12,--12,
		model = "models/sky/mags/pistol_mag_ext.mdl",
		width = 1,
		height = 1,
		flag = "m",
		count = 1,
		--destroy = {["id"] = 1},
	},
	]]
	--todo: actual models for these? or idk something else obvi
	["job_plate1"] = {
		name = "Crude Plate",
		desc = "",
		price = 12,--12,
		model = "models/props_junk/vent001_chunk4.mdl",
		width = 1,
		height = 1,
		flag = "m",
		count = 1,
		--destroy = {["id"] = 1},
	},
	["job_plate2"] = {
		name = "Unfinished Plate",
		desc = "",
		price = 12,--12,
		model = "models/props_junk/vent001_chunk5.mdl",
		width = 1,
		height = 1,
		flag = "m",
		count = 1,
		--destroy = {["id"] = 1},
	},
	["job_obj"] = {
		name = "Metal Plate",
		desc = "",
		price = 12,--12,
		model = "models/props_junk/vent001_chunk6.mdl",
		width = 1,
		height = 1,
		flag = "m",
		count = 1,
		--destroy = {["id"] = 1},
	},
}

function PLUGIN:InitializedItems()
	for id, data in pairs(itemList) do
		local ITEM = nut.item.register(id, "base_junk", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		
		ITEM.countMax = data.count
		ITEM.maxQuantity = data.count

		ITEM.destroyval = data.destroy

		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
	end		
end