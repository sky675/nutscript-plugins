AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Janitor Dropoff"
ENT.Category = "HL2RP"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE


function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 6

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()



	return ent

end

if(SERVER) then
	function ENT:Initialize()
		--replace
		self:SetModel( "models/nt/props_street/ticketkiosk.mdl" )
		--self:SetSkin(math.random(0, self:SkinCount()-1))
		self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
		self:SetUseType( SIMPLE_USE )
	
			local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end


	function ENT:Use( activator, caller )
		local items = activator:getChar():getInv():getItems()

		if(items) then
			local price = 0
			local num = 0
			local key = activator:getChar():getVar("janitems", {})
			for k,v in pairs(items) do
				if(key[v.id]) then
					num = num+1
					price = price+math.Round(v.price*0.5)
					v:remove()
				end
			end

			activator:getChar():giveMoney(price)
			activator:notify("You have turned in "..num.." items and earned "..price.." tokens as a result.")
		end
	end
else

	ENT.DrawEntityInfo = true
	
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get
	
	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
	
	
		drawText("Janitor Dropoff", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
		y = y+16
		drawText("Drop off items picked up while a janitor here.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
		y = y+16
	end

end