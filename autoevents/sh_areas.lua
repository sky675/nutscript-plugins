local PLUGIN = PLUGIN
AREANAVALLOWED = { 
	--tables whos key corresponds with an area, [1] = {[1] = true, [2] = true, etc}
	--these are the navmesh areas theyre allowed to go on
	--done this way so theres just a direct table to access it
	--[[
		[1] = {
		["areas"] = {
			[23] = true
		},
		["pos"] = Vector(1519.5147705078, -1790.5834960938, -143.96875)
	}
	]]

}
PLUGIN.areas = {
	--[[
		[1] = {
			name = "",
			--available = true,
			objs = {
				--[1] = true,
			},
			--default enemy spawns
			enemySpawns = {

			},
			--default item spawns
			itemSpawns = {

			},
			--default props to randomly toss around there
			props = {

			},
			--if an obj needs a special table itll say so
			--like mutant attack requires mutantSpawns, same format as enemySpawns
			
		},
	]]
}