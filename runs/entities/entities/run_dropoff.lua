--start runLoadDropoff on use
local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Dropoff Box"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Category = "OASIS"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:SpawnFunction(client, trace, className)
		if (!trace.Hit or trace.HitSky) then return end

		local ent = ents.Create(className)
		local pos = trace.HitPos + trace.HitNormal * 50
		ent:SetPos(pos)
		ent:Spawn()
		ent:Activate()

		return ent
	end

	function ENT:Initialize()
		self:SetModel("models/nt/props_street/mailbox2.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
	end

	function ENT:OnRemove()
	end

	function ENT:Use(activator)
		local list = {}
		--loop through curruns and see if they have items and if the player has
		--that item add it to the list
		--then add any other items to the list

			local d = 0
		--remove those items and set the related runs to done
		for k,v in pairs(PLUGIN.curRuns) do
			if(v.objid) then
				local item = nut.item.instances[v.objid]
				if(item and item:getOwner() == activator) then
					v.done = true
					item:remove()
					d = d+1
				end
			end
		end

		local b = 0
		for k,v in pairs(activator:getChar():getInv():getItems()) do
			if(v.uniqueID == "run_obj") then
				v:remove()
				b = b+1
			end
		end

		activator:notify("Turned in objectives for "..d.." run(s)!"..((b != 0) and " Also turned in "..b.." objectives that didn't have any run attached to it! Thanks for cleaning up." or ""))

	end
else
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:onShouldDrawEntityInfo()
		return true
	end

	function ENT:onDrawEntityInfo(alpha)
		local position = self:LocalToWorld(self:OBBCenter()):ToScreen()
		local x, y = position.x, position.y

		nut.util.drawText("Dropoff Box", x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
		nut.util.drawText("Turn in all run objective items you have.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
	end
end