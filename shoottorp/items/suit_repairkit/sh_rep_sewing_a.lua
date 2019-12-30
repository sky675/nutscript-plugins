ITEM.name = "Advanced Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 2.
It can only be used above 60 percent durability.
It will repair it by 20 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1600
ITEM.flag = "m"

ITEM.minDurability = 60
ITEM.baseRepair = 20
ITEM.partToRepair = "suit" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2