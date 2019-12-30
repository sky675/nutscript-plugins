ITEM.name = ">Breen's Private Reserve Sparkling" --idk"
ITEM.desc = "A red can of imported water."
ITEM.price = 13
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.86
ITEM.hungerAmt = 0
ITEM.thirstAmt = 22

ITEM.regenStam = {
	--amount, seconds
	30, 20
}

local function onUse(item)
--	item.player:restoreStamina(30)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
