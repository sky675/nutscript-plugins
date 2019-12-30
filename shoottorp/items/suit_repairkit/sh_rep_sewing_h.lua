ITEM.name = "Heavy Sewing Kit"
ITEM.desc = [[Drag onto damaged suit to repair it.
This kit only repairs the body.
Requires armor repair.
It can only be used above 40 percent durability.
It will repair it by 40 percent durability.]]
ITEM.model = "models/items/repairpacks/sewing_kit_h.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 2600
ITEM.flag = "m"

ITEM.minDurability = 40
ITEM.baseRepair = 40
ITEM.partToRepair = "suit" --suit, head
ITEM.traitreq = {trait = "crafting_repaira", val = 1}