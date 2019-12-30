ITEM.name = "Basic Medkit"
ITEM.model = "models/sky/items/medkit1.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.healAmount = 40
ITEM.healSeconds = 20
ITEM.healLeg = true
--ITEM.bleedStop = 1
ITEM.price = 15
ITEM.desc = "All-purpose single-use medkit. Allows to handle injuries of different types and degrees of complexity. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds."
ITEM.flag = "0"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_medkit_short.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)