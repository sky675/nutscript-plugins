AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Office Worker Terminal"
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

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "CurUser")
	self:NetworkVar("Bool", 0, "Oncd")
end

if(SERVER) then

	function ENT:Initialize()
		--replace
		self:SetModel( "models/nt/props_tech/computer_flipdown.mdl" )
		self:SetSkin(math.random(0, self:SkinCount()-1))
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
		if(IsValid(self:GetCurUser())) then
			activator:notify("There is somebody already using this!")
			return
		end
		if(activator:getChar():getVar("curJob", "") != "office") then
			activator:notify("You need the Office Worker job to use this!")
			return
		end
		if(self.cooldown and self.cooldown > CurTime()) then
			activator:notify("It is still gathering more data!")
			return
		end
	
		netstream.Start(activator, "officeStart", self:EntIndex()) --this is from runs but were using that too so
		--?
		self:SetCurUser(activator)
	end

	netstream.Hook("officeEnd", function(client, ind)
		local entity = Entity(ind)
		if(!IsValid(entity)) then return end
		entity:SetCurUser()
	end)
	netstream.Hook("officeCheck", function(ply, ind)
		--PLUGIN:checkInJob(ply:getChar())
		
		local entity = Entity(ind)
		if(!IsValid(entity)) then return end
		--this doesnt feel like enough
		entity.cooldown = CurTime()+60
		entity:SetOncd(true)
		timer.Simple(60, function()
			if(!IsValid(entity)) then return end
			entity:SetOncd(false)
		end)
	end)
	
else --client

	netstream.Hook("officeStart", function(index)
		print("office start index",index)
		OpenOfficeUI()
		OFFICE_ID = index
	end)
	
	ENT.DrawEntityInfo = true
	
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get
	
	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
	
	
		drawText("Office Terminal", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
		y = y+16
		--[[drawText("", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
		y = y+16]]
		if(self:GetOncd()) then
			drawText("The terminal is locked and currently shows the message: 'COLLECTING NEW DATA'", x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
			y = y+16
		end
	end

	offmenu = offmenu or nil
	function SendCompletion()
		netstream.Start("officeCheck", OFFICE_ID)
		nut.util.notify("The sequence has been completed and the terminal temporarily locks.")
		offmenu:Remove()
	end
	local charset = {}

-- qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length, fullrandom)
  --math.randomseed(os.time())

  if length > 0 then
	if(!fullrandom) then
	return string.random(length - 1) .. charset[math.random(1, #charset)]
	else
		local result = "" -- The empty string we start with
	
		for i = 1, length do
	
			result = result .. string.char( math.random( 33, 126 ) )
	
		end
	
		return result
	end
  else
    return ""
  end
end

	local unitStuff = {
		"UNION","GRID","HELIX","STORM","CITY","VICE","ZERO","ADMINISTER",
		"COOPERATE","APEX","APPLY","BLADE","BLOCK","BOOMER","DASH","DEFENDER",
		"DOCUMENT","ECHO","FLASH","FLUSH","HAMMER","HERO","HUNTER","HURRICANE",
		"ICE","ION","JET","JUDGE","JURY","KING","KILO","LINE","LOCK","MACE",
		"NOMAD","NOVA","QUICKSAND","RANGER","RAZOR","SCAR","SLASH","SPEAR",
		"STAR","STRIKER","SWEEPER","SWIFT","SWORD","VICTOR","YELLOW","ZONE"
	}
	local propa = {
		"Remember- alliance rhymes with compliance.",
		"Boomer. Haha.",
		"Hang it there! You're almost through.",
		"The Universal Union serves to manage the discrepencies of the old world.",
		"Downloading data.. Recieving cache data. Sending client info.",
		"Protection.",
		"If you are new to our city, welcome!",
		"Seven hours to some. A great, unifying, historical moment to us.",
		"Workers, safety first!",
		"Workers, stay proud!",
		"Mold the metals! Fan the forge flames! We are building a utopia for all.",
		"City 72 is the heart of the twelve Citadels on Earth.",
		"Please do not interfere with VICE units on duty unless otherwise stated.",
		"Universal Union cities are the safest locations in the solar system.",
	}

	local textGens = {
		function()
			return "CID "..math.random(10000,99999)
		end,
		function()
			return "Quality "..string.random(8)
		end,
		function()
			return string.random(math.random(9,18), true)
		end,
		function()
			local val = {}
			for i = 1, math.random(3,6) do
				val[#val+1] = unitStuff[math.random(#unitStuff)]
			end
			return table.concat(val, " ")
		end,
		function()
			return propa[math.random(#propa)]
		end
	}

	function OpenOfficeUI()
		offmenu = vgui.Create("DFrame")
		local base = offmenu
		base:SetSize(ScrW()/3, ScrH()/2)
		base:SetTitle("Office Terminal #"..(OFFICE_ID or 0))
		base:SetDraggable(true)
		base:MakePopup()
		base:Center()
		base:DockPadding(0, 0, 0, 0)
		base.OnRemove = function()
			netstream.Start("officeEnd", OFFICE_ID)
		end

		local at = 1
		
		local labs = {}

		local entr = base:Add("DTextEntry")
		entr:Dock(BOTTOM)
		entr:DockMargin(20,20,20,10)
		entr.OnEnter = function(self)
			
			if(labs[at] and string.Trim(self:GetValue()) == labs[at]:GetText()) then
				labs[at]:Remove()
				at = at + 1

				if(at == 16) then
					SendCompletion()
				else
					labs[at]:SetTextColor(Color(0,255,0))
				end
			end
			self:SetText("")
			self:RequestFocus()
		end

		local lab = base:Add("DListLayout")
		lab:Dock(TOP)
		lab:DockMargin(10,25,10,10)

		for i = 1, 15 do
			local lo = lab:Add("DLabel")
			labs[i] = lo
			lo:Dock(TOP)
			lo:SetTall(26)
			--lo:SetTextColor(Color(0,0,0))
			lo:SetContentAlignment(5)
			lo:SetFont("nutMediumLightFont")
			if(i == 1) then
				lo:SetTextColor(Color(0,255,0))
			end
			local txt = string.Trim(textGens[math.random(#textGens)]())
			lo:SetText(txt)
			lo:SetTooltip(txt)
		end
	end
end