ITEM.name = "Helmet Repair Kit"
ITEM.desc = "Drag onto damaged armor to repair it. Only repairs head. Requires basic repair level 2. This repair kit can only be used above 40 percent durability. It will repair approximately 50 percent."
ITEM.model = "models/items/repairpacks/helmet_repair.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1300
ITEM.flag = "m"

ITEM.minDurability = 40
ITEM.baseRepair = 50
ITEM.partToRepair = "head" --suit, head, all
ITEM.traitreq = {trait = "crafting_repair", val = 2}
ITEM.xpinc = 2