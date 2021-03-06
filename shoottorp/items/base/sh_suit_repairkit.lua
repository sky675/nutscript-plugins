ITEM.name = "Repair Kit"
ITEM.desc = "repair weapon yes ok"
ITEM.model = "models/warz/attachments/optic_acog.mdl"
ITEM.category = "Repair Kits"

--needed
--[[
ITEM.minDurability = 0
ITEM.baseRepair = 1
ITEM.partToRepair = "chest" --suit, head
ITEM.repairType = {"light","medium","heavy"} --table of types (movetypes) allowed
--optional

ITEM.traitreq = {trait = "id", val = true/num}
]]

function ITEM:getDesc()
    return self.desc
end

function ITEM:onCombineTo(target)
	if(target.base != "base_suit" or target:getData("equip") == true) then return end

	
	local ply = self.player
	local item = self

	if(item.traitreq) then
		local t = nut.traits.hasTrait(ply, item.traitreq.trait)
		if(type(item.traitreq.val) == "number") then
			if(t < item.traitreq.val) then
				ply:notify("You do not meet the trait requirements for this item!")
				return
			end
		else
			if(t != item.traitreq.val) then
				ply:notify("You do not meet the trait requirements for this item!")
				return
			end
		end
	end


	local lvls = target:getData("durability")
	ply:notify("on combine to "..lvls)
	if(lvls) then
		if(lvls < (item.minDurability/100)) then
			ply:notify("The armor is too damaged for this!")
			return
		end
		
		ply:notify("adding")

		target:setData("durability", math.Clamp(lvls + (item.baseRepair/100), 0, 1))
		
		--[[
		if(item.partToRepair == "suit") then
			local hasbad = false
			for k,v in pairs(lvls) do
				if(k == "head") then continue end
				if((v.durability or 1) < (item.minDurability/100)) then
					ply:notify("The "..k.." part is too damaged to use this!")
					return false
				end
				if(item.maxDurability and ((v.durability or 1) < (item.maxDurability/100))) then
					hasbad = true
				end
			end
			if(item.maxDurability and !hasbad) then
				ply:notify("You don't have a part low enough to use this!")
				return false
			end

			for k,v in pairs(lvls) do
				if(k == "head") then continue end
				v.durability = math.Clamp((v.durability or 1) + (item.baseRepair/100), 0, 1)
			end
		elseif(item.partToRepair == "head") then
			if(lvls["head"]) then
				if((lvls["head"].durability or 1) < (item.minDurability/100)) then
					ply:notify("The head part is too damaged to use this!")
					return false
				end
				
				lvls["head"].durability = math.Clamp((lvls["head"].durability or 1) + (item.baseRepair/100), 0, 1)
			end
		elseif(item.partToRepair == "all") then
				for k,v in pairs(lvls) do
					if((v.durability or 1) < (item.minDurability/100)) then
						ply:notify("The "..k.." part is too damaged to use this!")
						return false
					end
					
				end

				for k,v in pairs(lvls) do
					v.durability = math.Clamp((v.durability or 1) + (item.baseRepair/100), 0, 1)
				end
		end]]
		

		if(nut.traits and item.traitreq) then
			nut.traits.addXp(item.player, item.traitreq.trait, item.xpinc or 1)
		end

		--target:setData("armor", lvls)

		item:remove()
	end
end

--[[
ITEM.functions.--combine = {
    name = "Combine",
    tip = "Repair weapon",
    icon = "icon16/wrench.png",
	sound = "interface/inv_repair_sewing_kit_fast.ogg",
    onRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            -- and target:getData("durability", 100) >= (item.minDurability or 0)
            local lvls = target:GetArmor()
            if(lvls) then
				if(item.partToRepair == "suit") then
					local hasbad = false
                    for k,v in pairs(lvls) do
                        if(k == "head") then continue end
                        if((v.durability or 1) < (item.minDurability/100)) then
                            item.player:notify("The "..k.." part is too damaged to use this!")
                            return false
						end
						if(item.maxDurability and ((v.durability or 1) < (item.maxDurability/100))) then
							hasbad = true
						end
					end
					if(item.maxDurability and !hasbad) then
						item.player:notify("You don't have a part low enough to use this!")
						return false
					end

                    for k,v in pairs(lvls) do
                        if(k == "head") then continue end
                        v.durability = math.Clamp((v.durability or 1) + (item.baseRepair/100), 0, 1)
                    end
                elseif(item.partToRepair == "head") then
                    if(lvls["head"]) then
                        if((lvls["head"].durability or 1) < (item.minDurability/100)) then
                            item.player:notify("The head part is too damaged to use this!")
                            return false
						end
						
                        lvls["head"].durability = math.Clamp((lvls["head"].durability or 1) + (item.baseRepair/100), 0, 1)
					end
				elseif(item.partToRepair == "all") then
						for k,v in pairs(lvls) do
							if((v.durability or 1) < (item.minDurability/100)) then
								item.player:notify("The "..k.." part is too damaged to use this!")
								return false
							end
							
						end
	
						for k,v in pairs(lvls) do
							v.durability = math.Clamp((v.durability or 1) + (item.baseRepair/100), 0, 1)
						end
				end
				

				if(nut.traits and item.traitreq) then
					nut.traits.addXp(item.player, item.traitreq.trait, item.xpinc or 1)
				end

                target:setData("armor", lvls)
            end

            return true
        end
    end,
    onCanRun = function(item, id)
        --if(!item.player:getChar():hasFlags("U")) then return false end
		local target = nut.item.instances[id]
		local ply = item.player or LocalPlayer()

        if(id and target) then
            if(!IsValid(item.entity) and target.base == "base_suit" and target:getData("equip") != true) then
				if(item.traitreq) then
					local t = nut.traits.hasTrait(ply, item.traitreq.trait)
					if(type(item.traitreq.val) == "number") then
						if(t < item.traitreq.val) then
							return false
						end
					else
						if(t != item.traitreq.val) then
							return false
						end
					end
				end

                return true
            end
        end

        return false
    end
}]]