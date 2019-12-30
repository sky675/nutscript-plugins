ITEM.name = "food base"
ITEM.desc = "u shouldnt see this"
ITEM.model = "models/props_junk/garbage_metalcan002a.mdl"
ITEM.price = 1
ITEM.flag = "0"
ITEM.isFood = true
ITEM.category = "Food"
ITEM.permit = "food"
--ITEM.hungerAmt = 0
--ITEM.thirstAmt = 0

local function healPlayer(client, amount, seconds, itemid)

	if (client:Alive()) then
		local id = "nutStam_"..itemid --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!client:IsValid() or !client:Alive()) then
				timer.Destroy(id)	
			end

			client:restoreStamina(1)
		end)
	end
end

ITEM.functions.use = {
	name = "Eat/Drink",
    tip = "Eat or drink this food.",
    icon = "icon16/cup.png",
    onRun = function(item)
        local char = item.player:getChar()

		local soundto = item.playsound
		if(soundto) then
			item.player:EmitSound(soundto)
		end

        if(item.hungerAmt) then
		char:SetHunger(math.Clamp(char:GetHunger()+item.hungerAmt, 0, 100))
		end
        if(item.thirstAmt) then
		char:SetThirst(math.Clamp(char:GetThirst()+item.thirstAmt, 0, 100))
		end
		if(item.regenStam) then
			healPlayer(item.player, item.regenStam[1], item.regenStam[2], item.id)
		end
		if(item.alcrem) then
			if(nut.traits.hasTrait(item.player, "big_alcohol") and !item.dontalch) then
				--remove
				char:setData("alcoh", math.max(0, char:getData("alcoh", 0)-item.alcrem))
			else
				--add
				char:setVar("alcoh", math.max(0, char:getVar("alcoh", 0)+item.alcrem))
				if(item.alcrem > 0) then
				timer.Simple(item.alcrem*180, function()
				char:setVar("alcoh", math.max(0, char:getVar("alcoh", 0)-item.alcrem))
				end)
				end
			end
		end
		--artifact radiation support
		if(char.addRad and item.radGive) then
			char:addRad(item.radGive)
		end
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity))
    end
}