--playerInteract.interact this entity if they use it
local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Run Bus Terminal"
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
		self:SetModel("models/nt/props_street/busstop_kiosk.mdl")
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
		netstream.Start(activator, "interactWithEnt", self)
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

		nut.util.drawText("Bus Terminal", x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
		nut.util.drawText("Return to the main area.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
	end
end