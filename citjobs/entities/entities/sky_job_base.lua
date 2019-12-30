AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "job base"
ENT.Category = "HL2RP"
ENT.Author = "sky"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.name = ""
ENT.desc = ""
ENT.job = ""
--ENT.model = ""


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
		self:SetModel( self.model or "models/props_interiors/BathTub01a.mdl" )
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
	
		netstream.Start(activator, "interactWithEnt", self) --this is from runs but were using that too so
		--?
	
	end
	
else --client
	nut.playerInteract.addFunc("jobstart", {
		name = "Clock into this job",
		callback = function(target)
			netstream.Start("jobStart", target.job)
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base") and LocalPlayer():getChar():getVar("curJob", "") == ""
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("jobcheck", {
		name = "Check in at this job",
		callback = function(target)
			netstream.Start("jobCheck")
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base") and LocalPlayer():getChar():getVar("curJob", "") == target.job
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("jobchecktime", {
		name = "Check time remaining until kicked from job",
		callback = function(target)
			netstream.Start("jobCheckTime")
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base") and LocalPlayer():getChar():getVar("curJob", "") == target.job
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("jobleave", {
		name = "Clock out of this job",
		callback = function(target)
			netstream.Start("jobLeave")
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base") and LocalPlayer():getChar():getVar("curJob", "") == target.job
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("jobbankcheck", {
		name = "Check current banked pay",
		callback = function(target)
			netstream.Start("jobBankCheck")
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base")
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("jobbankwithdraw", {
		name = "Withdraw current banked pay",
		callback = function(target)
			netstream.Start("jobBankWithdraw")
		end,
		canSee = function(target)
			return IsValid(target) and (target.Base and target.Base == "sky_job_base") and LocalPlayer():getChar():getData("jobSafe", 0) != 0
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	
	function ENT:Draw()
		self:DrawModel()
	
		--draw 3d ui mebi idk
	end
	
		ENT.DrawEntityInfo = true
	
		local toScreen = FindMetaTable("Vector").ToScreen
		local colorAlpha = ColorAlpha
		local drawText = nut.util.drawText
		local configGet = nut.config.get
	
		function ENT:onDrawEntityInfo(alpha)
			local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
			local x, y = position.x, position.y
	
	
			drawText(self.name or self.PrintName, x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
			y = y+16
			drawText((self.desc or "??"), x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
			y = y+16
			
		end
	
	end