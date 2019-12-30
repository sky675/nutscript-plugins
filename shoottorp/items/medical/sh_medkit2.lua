ITEM.name = "Advanced Medkit"
ITEM.model = "models/sky/items/medkit1.mdl"--stalker/item/medical/medkit2.mdl"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.healAmount = 60
ITEM.healSeconds = 35
ITEM.healLeg = true
ITEM.canRevive = false
ITEM.bleedStop = 3
ITEM.price = 33
ITEM.desc = "Includes medicine for faster blood coagulation, as well as painkillers, antibiotics, immunity stimulators, and more. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "1"

local function onUse(item)
	item.player:EmitSound("interface/inv_medkit_short.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)