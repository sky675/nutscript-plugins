ITEM.name = "Basic Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires basic repair level 1.
It can only be used above 80 percent durability.
It will repair it by 10 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 700
ITEM.flag = "m"

ITEM.minDurability = 80
ITEM.baseRepair = 10
ITEM.partToRepair = "suit" --suit, head
ITEM.traitreq = {trait = "crafting_repair", val = 1}