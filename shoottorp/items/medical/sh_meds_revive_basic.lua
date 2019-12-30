ITEM.name = "Basic Revive"
ITEM.model = "models/sky/items/revive1.mdl"--stalker/item/medical/medkit1.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.healAmount = 0
ITEM.healSeconds = 0
ITEM.canRevive = true
ITEM.reviveOnly = true
ITEM.price = 500
ITEM.desc = "ITEM IS LEFT OVER FROM OASIS, SHOULD BE FUNCTIONAL BUT MAY BE DELETED LATER\nIf the target is applicable for normal reviving, they can be revived with this. Typically this is if they did not take a headshot and the shot that downed them was not very strong."
ITEM.flag = "m"
ITEM.noBusiness = true

local function onUse(item)
	--sound????
	item.player:EmitSound("ambient/machines/catapult_throw.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)