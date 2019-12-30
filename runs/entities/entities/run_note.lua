local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Note"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Category = "OASIS"
ENT.RenderGroup 		= RENDERGROUP_BOTH
ENT.name = "dynamic note"
ENT.desc = "this is a dynamic note that the run system will change automatically,\nif you want to use this yourself ask sky to set what the name/desc/model should be,\nas this is intended for generated runs im not going to make a way to customize this so ill have to set it manually"
ENT.model = "models/props_lab/clipboard.mdl"

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
		self:SetModel(self.model or "models/props_lab/clipboard.mdl")
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

		nut.util.drawText(self.name, x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)


		local lines = nut.util.wrapText(self.desc, ScrW() * 0.7, "nutSmallFont")

		for i = 1, #lines do
			local info = lines[i]

			local _, ty = nut.util.drawText(self.desc[1], x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
			y = y + ty
		end			

	end
end