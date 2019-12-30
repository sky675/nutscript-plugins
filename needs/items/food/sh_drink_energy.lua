ITEM.name = "Energy Drink" --MOORE energy"
ITEM.desc = "A can of MOORE Energy."
ITEM.price = 6
ITEM.model = "models/warz/consumables/energy_drink.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.2
ITEM.hungerAmt = 0
ITEM.thirstAmt = 25


ITEM.regenStam = {
	--amount, seconds
	80, 30
}

local function onUse(item)
	--item.player:restoreStamina(80)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
