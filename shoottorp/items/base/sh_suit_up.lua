--modified attach base for suit upgrades
local PLUGIN = PLUGIN
ITEM.name = "upgrade base"
ITEM.desc = "Drag this over a valid upgrade to attach it."
ITEM.model = "models/Items/BoxMRounds.mdl"
ITEM.price = 150
ITEM.flag = "m"
ITEM.category = "Suit Upgrades"


--[[
--req:
ITEM.upgrades = {
    ["burn"] = 5, --list resistances like this, positive if increase negative if decrease
    ["levels"] = { --do levels like this
        ["chest"] = 1 --body part, will always increase it to next level
    }
}
]]

local levels = { --THIS NEEDS TO BE UPDATED BTW TODO
    "none","IIA","II","IIIA","III","IV","V"
}


function ITEM:onCombineTo(target)
	if(target.base != "base_suit" or target:getData("equip") == true) then return end

	local ply = self.player
	local item = self

	if(!ply:getChar():hasFlags("U")) then
		ply:notify("You need a technician for armor upgrades!")
		return false
	end

	if(target:getData("upgrades")) then
		local right = false
		for k,v in pairs(target:getData("upgrades")) do
			if(k == item.uniqueID) then
				ply:notify("This upgrade has already been applied!")
				return false
			end
		end
		for k2,v2 in pairs(PLUGIN.upgradePaths) do
			if(table.HasValue(target.upgradePath or "", k2)) then
				for _, i in pairs(v2) do
					PrintTable(i)
					print("annoying")
					local iddd
					for id,name in pairs(i) do
						print(id.." : "..name.." : "..item.uniqueID)
						if(item.uniqueID == name) then
							print("right")
							right = true
							iddd = id
						end
					end
					if(right) then
						--print("right "..iddd)
						for id,name in pairs(i) do
							if(id != iddd) then continue end
							for k,v in pairs(target:getData("upgrades")) do
								if(k == name) then
									ply:notify("A similar upgrade has already been applied!")
									return false
								end
							end
						end
					end
				end             
			end
		end
		if(!right) then
			ply:notify("You cannot add this upgrade to this suit!")
			return false
		end
	end

	local res = target:GetResists()
	local lvls = target:GetArmor()
	for k,v in pairs(item.upgrades) do
		if(k == "levels") then
			local char = ply:getChar()

			for k2,v2 in pairs(v) do
				if(v2 == 1) then
					lvls[k2] = lvls[k2] or {level = 0}
					lvls[k2].level = lvls[k2].level+1 --levels[table.KeyFromValue(levels, lvls[k2].level)+1]
				end
			end

			continue
		elseif(type(k) == "number") then
			res[k] = math.Clamp(res[k] + v, 0, 0.95) --make 0.95 the max possible value
		elseif(res[k]) then --these are usually something that can be overridden, so override it if the value is higher
			if(res[k] < v) then
				res[k] = v
			end
		else --else it doesnt exist so just set it
			res[k] = v
		end


	end
	target:setData("resists", res)
	target:setData("armor", lvls)

	local ups = target:GetUpgrades()
	ups[item.uniqueID] = item.name
	target:setData("upgrades", ups)

	item:remove()
end

--[[
ITEM.functions.--combine = {
    name = "Combine",
    tip = "Equip to active weapon",
    icon = "icon16/wrench.png",
    onRun = function(item, id)
        local target = nut.item.instances[id]
        local ply = item.player

        if(id and target) then
            if(!ply:getChar():hasFlags("U")) then
                ply:notify("You need a technician for armor upgrades!")
                return false
            end

            if(target:getData("upgrades")) then
				local right = false
                for k,v in pairs(target:getData("upgrades")) do
                    if(k == item.uniqueID) then
                        ply:notify("This upgrade has already been applied!")
                        return false
					end
				end
                for k2,v2 in pairs(PLUGIN.upgradePaths) do
                    if(table.HasValue(target.upgradePath or "", k2)) then
						for _, i in pairs(v2) do
							PrintTable(i)
							print("annoying")
							local iddd
							for id,name in pairs(i) do
								print(id.." : "..name.." : "..item.uniqueID)
								if(item.uniqueID == name) then
									print("right")
									right = true
									iddd = id
                                end
                            end
							if(right) then
								--print("right "..iddd)
								for id,name in pairs(i) do
									if(id != iddd) then continue end
									for k,v in pairs(target:getData("upgrades")) do
                                        if(k == name) then
                                            ply:notify("A similar upgrade has already been applied!")
                                            return false
                                        end
									end
                                end
                            end
                        end             
                    end
                end
				if(!right) then
					ply:notify("You cannot add this upgrade to this suit!")
					return false
				end
            end

            local res = target:GetResists()
            local lvls = target:GetArmor()
            for k,v in pairs(item.upgrades) do
                if(k == "levels") then
                    local char = ply:getChar()

                    for k2,v2 in pairs(v) do
                        if(v2 == 1) then
                            lvls[k2].level = lvls[k2].level+1 --levels[table.KeyFromValue(levels, lvls[k2].level)+1]
                        end
                    end

					continue
				elseif(type(k) == "number") then
					res[k] = math.Clamp(res[k] + v, 0, 0.95) --make 0.95 the max possible value
				elseif(res[k]) then --these are usually something that can be overridden, so override it if the value is higher
					if(res[k] < v) then
						res[k] = v
					end
				else --else it doesnt exist so just set it
					res[k] = v
				end


            end
            target:setData("resists", res)
            target:setData("armor", lvls)

            local ups = target:GetUpgrades()
            ups[item.uniqueID] = item.name
            target:setData("upgrades", ups)

            return true
        end
    end,
    onCanRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            if(!IsValid(item.entity) and target:getData("armor") and target:getData("equip") != true) then
                return true
            else
                return false
            end
        end

        return false
    end
}]]