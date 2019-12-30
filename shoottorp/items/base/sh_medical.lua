
ITEM.name = "Medical Stuff"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A Medical Stuff"
ITEM.healAmount = 50
ITEM.healSeconds = 10
ITEM.category = "Medical"

local function healPlayer(client, target, amount, seconds, itemid)
	if(amount == 0) then return end
	local amt, sec = hook.Run("OnPlayerHeal", client, target, amount, seconds)
	local amount = amt or amount --im not sure if doing an or ^ would work
	local seconds = sec or seconds

	if (client:Alive() and target:Alive()) then
		local id = "nutHeal_"..itemid --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!target:IsValid() or !target:Alive()) then
				timer.Destroy(id)
				return	
			end

			if(target:Health() >= 100) then return end
			nut.traits.addXp(client, "tech_med", (client != target) and 2 or 1)
			

			target:SetHealth(math.Clamp(target:Health() + 1, 0, target:GetMaxHealth()))
			if(target:Health() > 25) then
				net.Start("toggleHeartbeat")
				net.WriteBool(false)
				net.Send(target)
			end
		end)
	end
end
--[[
local function onUse(item)
	item.player:EmitSound("items/medshot4.wav", 80, 110)
	item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)
]]
// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.use = { -- sorry, for name order.
	name = "Use",
	tip = "useTip",
	icon = "icon16/add.png",
	onRun = function(item)
		local client = item.player
		if (item.player:Alive()) then
			if(item.skillval and nut.traits.hasTrait(item.player, "tech_med") < item.skillval) then
				item.player:notify("You don't meet trait requirements for this item!")
				return false
			end
			local val = 1
			
			val = val * nut.traits.getMod(client, "actiontime")

			client:setAction("Using...", val, function(client)
			if(client:Alive() and !client:getNetVar("neardeath") and item:getOwner() == client) then
			healPlayer(client, client, item.healAmount, item.healSeconds, item:getID())
			if(item.bleedStop and item.bleedStop != 1) then
				hook.Run("ReduceBleed", client:getChar(), item.bleedStop)
			end
			if(item.healLeg) then
				timer.Create("healLeg_"..client:SteamID(), item.legSec or 30, 1, function()
					if(client:getChar():getData("leghit")) then
						client:getChar():setData("leghit", nil, nil, player.GetAll())
						client:notify("You appear to be able to run again.")
					end
				end)
			end
			item:remove()
			end
			end)
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and !item.reviveOnly
	end
}

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.usef = { -- sorry, for name order.
	name = "Give",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
		local faketarget = trace.Entity
		local target = faketarget
		
		if(item.skillval and nut.traits.hasTrait(item.player, "tech_med") < item.skillval) then
			item.player:notify("You don't meet trait requirements for this item!")
			return false
		end
		local val = 2
		
		val = val * nut.traits.getMod(client, "actiontime")

		client:setAction("Using...", val, function(client)
			if(faketarget:getNetVar("player")) then
				target = faketarget:getNetVar("player")
			end
			client:doStaredAction(target, function()
				if(!client:Alive() or client:getNetVar("neardeath") or item:getOwner() != client) then return end
				if(faketarget:getNetVar("player")) then
					local ply = faketarget:getNetVar("player")
					if(ply:IsValid()) then
					--if(item.canRevive) then --dont think ill ever do this again but just in case
						if(item.canRevive and ply:getNetVar("canrevive")) then
							client:setAction("Reviving", 10, function()
								ply:setRagdolled(false)
								ply:setNetVar("neardeath", nil)
								ply:setNetVar("startdown", nil)
								ply:setNetVar("canrevive", nil)
								ply:setNetVar("canscirevive", nil)
								ply:setNetVar("canplatrevive", nil)
								ply:SetNoTarget(false) --so npcs stop attacking
								ply:SetHealth(15)
								ply:setAction()
								nut.traits.addXp(client, "tech_med", 25)
							end)

							item:remove()
							return
						elseif(item.sciRevive and ply:getNetVar("canscirevive")) then
							client:setAction("Reviving", 10, function()
								ply:setRagdolled(false)
								ply:setNetVar("neardeath", nil)
								ply:setNetVar("startdown", nil)
								ply:setNetVar("canrevive", nil)
								ply:setNetVar("canscirevive", nil)
								ply:setNetVar("canplatrevive", nil)
								ply:SetNoTarget(false) --so npcs stop attacking
								ply:SetHealth(45)
								ply:setAction()
								nut.traits.addXp(client, "tech_med", 25)
							end)

							item:remove()
							return
						elseif(item.platRevive and ply:getNetVar("canplatrevive")) then
							client:setAction("Reviving", 10, function()
								ply:setRagdolled(false)
								ply:setNetVar("neardeath", nil)
								ply:setNetVar("startdown", nil)
								ply:setNetVar("canrevive", nil)
								ply:setNetVar("canscirevive", nil)
								ply:setNetVar("canplatrevive", nil)
								ply:SetNoTarget(false) --so npcs stop attacking
								ply:SetHealth(75)
								ply:setAction()
								nut.traits.addXp(client, "tech_med", 25)
							end)
							item:remove()
							return 
						else
							client:notify("You cannot revive this person.")
						end
				--end
					end
				end

				if (target and target:IsValid() and target:IsPlayer() and target:Alive() and !target:getNetVar("neardeath") and !item.reviveOnly) then
			
					healPlayer(client, target, item.healAmount, item.healSeconds, item:getID())
					if(item.bleedStop and item.bleedStop != 1) then --1 is the same so ignore
						hook.Run("ReduceBleed", client:getChar(), item.bleedStop)
					end
					if(item.healLeg) then
						timer.Create("healLeg_"..target:SteamID(), item.legSec or 30, 1, function()
							if(target:getChar():getData("leghit")) then
								target:getChar():setData("leghit", nil, nil, player.GetAll())
								target:notify("You appear to be able to run again.")
							end
						end)
					end
					item:remove()
					return
				end
			end, val, function()
				client:setAction()
			end)
		end)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}