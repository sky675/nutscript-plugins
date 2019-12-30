AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "depot base"
ENT.Category = "HL2RP"
ENT.Author = "sky"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.name = ""
ENT.desc = ""
--ENT.model = ""
--ENT.mat = "" --optional
ENT.action = ""
ENT.timeUse = 1 --how long to hold it
ENT.cooldownTime = 1
ENT.stock = 1
ENT.fullCd = 1
--[[ENT.loottable = {
--	["none"] = 1,

}]]

local scalingtbl = {
	["low"] = {
		stock = 0.4,
		usetime = 2,
		cdtime = 1.5,
	},
	["med"] = {
		stock = 0.2,
		usetime = 1.5,
		cdtime = 1.25,
	}
}

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Onfullcd")
	self:NetworkVar("Bool", 1, "Oncd")
	self:NetworkVar("Int", 0, "Curstock")

end

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
--local spawnhere = nut.plugin.loot.SpawnAtPos

--local curstock = 0

--generated in initialize
--local loot = {}

function ENT:Initialize()
	self:SetModel( self.model or "models/props_interiors/BathTub01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )

	if(self.mat) then
		self:SetMaterial(self.mat, true)
	end

	self.loot = {}

	for k2, v2 in pairs(self.loottable) do
		
		for i=1, v2 do
			table.insert(self.loot, k2)
		end
	end

	self:SetCurstock(self.stock)


	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	if(self.regentime) then
		local ent = self
		local id = "selfregen"..self:EntIndex()
		timer.Create(id, self.regentime, 0, function()
			if(!IsValid(ent)) then timer.Remove(id) return end --if invalid, byebye
			local stock = self:GetCurstock()
			if(stock <= 0 or stock == self.stock) then return end --if on full cd or full, skip
			
			stock = stock+1 --add 1
			self:SetCurstock(stock) --and set
		end)
	end
end

local cooldown = 0
local fullcd = 0

local callback = function(item, entity)
	print("?????")
	--hard overwrite becuz its being annoying
	--its likely never going to be above 1 anyway
	if(item.base == "base_junk") then
		item:setQuantity(1)
	end
		
	entity.temp = true
end

local wepRefreshReset = 2

function ENT:SpawnItem(ply)
	local skipstock = nut.traits and nut.traits.getMod(ply, "depotuse") or false
	local plycnt = #player.GetAll()
	local timemulti = 1--#player.GetAll() <= 3 and 2 or 1
	local stockuse = 1
	if(plycnt <= 3) then
		timemulti = scalingtbl["low"].cdtime
		stockuse = math.Round(self.stock * scalingtbl["low"].stock)
	elseif(plycnt < 6) then
		timemulti = scalingtbl["med"].cdtime
		stockuse = math.Round(self.stock * scalingtbl["med"].stock)
	end

	local it = self.loot[math.random(#self.loot)]
	if(it:find("wep_")) then
		if(self.wepGiven) then 
			it = "none"
		else
			self.wepGiven = true
			self.wepRef = 0
		end
	end
	if(it == "none") then
		ply:notify("You found nothing.")

		self.cooldown = CurTime()+(self.cooldownTime*timemulti)
		self:SetOncd(true)
		local stock = self:GetCurstock() - (skipstock and 0 or stockuse) --thisllwork
		self:SetCurstock(stock)
		if(stock <= 0) then
			--self:setNetVar("onfullcd", true)
			self:SetOnfullcd(true)
			self.cooldown = CurTime()+(self.fullCd*timemulti)
			timer.Simple((self.fullCd*timemulti), function()
				self:SetOncd(false)
				--self:setNetVar("onfullcd")
				self:SetOnfullcd(false)
				
				if(self.wepGiven) then
					self.wepRef = self.wepRef + 1
					if(self.wepRef >= wepRefreshReset) then
						self.wepGiven = false
					end
				end
			end)
		else
			timer.Simple((self.cooldownTime*timemulti), function()
				self:SetOncd(false)
			end)
		end

		return
	end

	nut.item.spawn(it, 
		self:GetPos()+Vector(0,0,24), callback, 
		Angle(0, math.random(-180, 180), 0), data)

	self.cooldown = CurTime()+(self.cooldownTime*timemulti)
	self:SetOncd(true)
	local stock = self:GetCurstock() - (skipstock and 0 or stockuse)
	self:SetCurstock(stock)
	if(stock <= 0) then
		self:SetOnfullcd(true)
		--self:setNetVar("onfullcd", true)
		self.cooldown = CurTime()+(self.fullCd*timemulti)
		timer.Simple((self.fullCd*timemulti), function()
			self:SetOncd(false)
			self:SetOnfullcd(false)
			--self:setNetVar("onfullcd")

				if(self.wepGiven) then
					self.wepRef = self.wepRef + 1
					if(self.wepRef >= wepRefreshReset) then
						self.wepGiven = false
					end
				end
		end)
	else
		timer.Simple((self.cooldownTime*timemulti), function()
			self:SetOncd(false)
		end)
	end
end

--todo maybe rework this to allow instant use but stocks regain over time? idk
function ENT:Use( activator, caller )
	if(self.cooldown and self.cooldown > CurTime()) then return end
	if(self:GetCurstock() <= 0) then
		self:SetCurstock(self.stock)
	end


	self:SetOncd(false)
	--self:setNetVar("onfullcd")
	self:SetOnfullcd(false)
	
	local plycnt = #player.GetAll()
	local timemulti = 1--#player.GetAll() <= 3 and 2 or 1
	if(plycnt <= 3) then
		timemulti = scalingtbl["low"].usetime
	elseif(plycnt < 6) then
		timemulti = scalingtbl["med"].usetime
	end

	local val = self.timeUse
	val = val * nut.traits.getMod(activator, "actiontime") * timemulti

	activator:setAction(self.action, val)
	activator:doStaredAction(self, function() self.SpawnItem(self, activator) end, val, function()activator:setAction()end)
end

else--client
	
	function ENT:Draw()
		self:DrawModel()
	
		--draw 3d ui mebi idk
	end
	
		ENT.DrawEntityInfo = true
	
		local toScreen = FindMetaTable("Vector").ToScreen
		local colorAlpha = ColorAlpha
		local drawText = nut.util.drawText
		local configGet = nut.config.get
	
		local halfstock = ENT.stock*0.5
		local quarterstock = math.ceil(ENT.stock*0.25)

		function ENT:onDrawEntityInfo(alpha)
			local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
			local x, y = position.x, position.y
			--print("??")
	
			drawText(self.name or self.PrintName, x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
			y = y+16
			drawText((self.desc or "??"), x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
			y = y+16
			
			local curstock = self:GetCurstock()
			if(curstock > 0) then
				if(curstock == 1) then
					drawText("It looks like this has 1 more go.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
					y = y+16
				elseif(self.vlowstock and self.vlowstock > curstock) then
					drawText("It looks like this is almost empty.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
					y = y+16
				elseif(self.lowstock and self.lowstock > curstock) then
					drawText("It looks like this is starting to get empty.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
					y = y+16
				end
			end

			if(self:GetOnfullcd()) then
			--if(self:GetNW2Bool("onfullcd")) then
				drawText("This is currently empty. Check back later.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
				y = y+16
			--elseif(self:getNetVar("oncd")) then
			elseif(self:GetOncd()) then
				drawText("This is not ready yet.", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
				y = y+16
			end
			
		end

end