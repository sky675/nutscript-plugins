ITEM.name = "Suntory Boss Canned Coffee" --idk"
ITEM.desc = "A cold can of ready to drink coffee."
ITEM.price = 4
ITEM.model = "models/nt/props_debris/can02.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.86
ITEM.hungerAmt = 0
ITEM.thirstAmt = 15

ITEM.regenStam = {
	--amount, seconds
	60, 60
}

local function onUse(item)
--	item.player:restoreStamina(60)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
