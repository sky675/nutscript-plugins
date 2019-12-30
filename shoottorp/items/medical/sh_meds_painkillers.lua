ITEM.name = "Painkillers"
ITEM.model = "models/warz/consumables/painkillers.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.4
ITEM.healAmount = 60
ITEM.healSeconds = 100
ITEM.bleedStop = 1
ITEM.price = 15
ITEM.desc = "A bottle of painkillers. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds."
ITEM.flag = "1"

local function onUse(item)
	item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)