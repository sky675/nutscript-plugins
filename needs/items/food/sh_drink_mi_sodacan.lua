ITEM.name = "Mister Intense Soda" --idk"
ITEM.desc = "A can of soda."
ITEM.price = 5
ITEM.model = "models/nt/props_debris/can01.mdl"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.86
ITEM.hungerAmt = 0
ITEM.thirstAmt = 18

ITEM.regenStam = {
	--amount, seconds
	50, 30
}

local function onUse(item)
	--item.player:restoreStamina(50)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
