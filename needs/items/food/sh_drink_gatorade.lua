ITEM.name = "Gatorade"
ITEM.desc = "A bottle of Gatorade."
ITEM.price = 4
ITEM.model = "models/warz/consumables/gatorade.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.85
ITEM.hungerAmt = 0
ITEM.thirstAmt = 35

ITEM.regenStam = {
	--amount, seconds
	60, 40
}

local function onUse(item)
--	item.player:restoreStamina(60)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
