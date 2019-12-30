ITEM.name = "Chocolate Bar"
ITEM.desc = "A bar of chocolate."
ITEM.price = 3
ITEM.model = "models/warz/consumables/bar_chocolate.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.2
ITEM.hungerAmt = 5
ITEM.thirstAmt = 0

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
