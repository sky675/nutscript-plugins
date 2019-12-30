--start runLoadTerminal on use
local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Run Terminal (VR)"
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
		self:SetModel("models/nt/props_tech/computer_flipdown.mdl")
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
		--[[if(activator:getChar():isSectcom()) then
			activator:notify("As a SectCom character, you cannot participate in runs!")
			return
		end]]
		local list = {}
		--loop through curruns and add ones that arent active
		--but if they are add them anyway if the players activerun
		--is that run
		--add only necessary stuff, name, desc, active, done, etc
		if(!activator:getChar():getData("leadactiverun") and activator:getChar():getData("activerun")) then
			activator:notify("You cannot use the terminal while you are a part of a run and not the run leader!")
			return
		end
		for k,v in pairs(nut.plugin.list["runs"].curRuns) do
			--this should hide any active runs that arent the clients 			--collect means its been collected
			if((!v.active or v.uniqueid == activator:getChar():getData("leadactiverun", -1)) and !v.collect) then
				
				list[k] = {
					name = v.name, --display the name
					desc = v.desc, --desc as tooltip? or idk how to do it yet
					active = v.active, --if its active, check if its the players 
					cname = v.cname,
					cdesc = v.cdesc,
					--leadactiverun just to make sure, and then 
					--replace the accept button with a turn in button, 
					--the turn in button should start runCollect netstream, 
					--with the run id as the argument
					done = v.done, --only enable the turn in button if done is true
					starttime = v.starttime, --to display how much time is left if
					--the run hasnt been accepted yet until it expires
					uniqueid = v.uniqueid
				}
			end	
		end

		netstream.Start(activator, "runLoadTerminal", list, true)
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

		nut.util.drawText("VR Run Terminal", x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
		nut.util.drawText("Accept runs and turn in completed ones.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
	end
end