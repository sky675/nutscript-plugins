ITEM.name = "Chinese Takeout"
ITEM.desc = "Cold chinese takeout."
ITEM.price = 3
ITEM.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 2
ITEM.hungerAmt = 22
ITEM.thirstAmt = 3

local function onUse(item)
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
