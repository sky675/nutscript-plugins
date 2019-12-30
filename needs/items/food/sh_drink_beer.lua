ITEM.name = "Bottle of Beer"
ITEM.desc = "A foggy green bottle of alcohol."
ITEM.price = 4
ITEM.model = "models/props_junk/garbage_glassbottle003a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.2
ITEM.hungerAmt = 0
ITEM.thirstAmt = 12
ITEM.alcrem = 2

--ITEM.playsound = "npc/barnacle/barnacle_gulp1.wav"

local function onUse(item)
	 
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
