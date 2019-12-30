local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Wave Machine"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Category = "OASIS"
ENT.RenderGroup 		= RENDERGROUP_BOTH

game.AddParticles("particles/fire_01.pcf")
PrecacheParticleSystem("smoke_gib_01")

if (SERVER) then
	function ENT:SpawnFunction(client, trace, className)
		if (!trace.Hit or trace.HitSky) then return end

		local ent = ents.Create(className)
		local pos = trace.HitPos + trace.HitNormal * 50
		ent:SetPos(pos)
		ent:Spawn()
		ent:Activate()

		if(client.notify) then
			client:notify("hey this is something thats used in runs, it will not work spawning it via q menu")
		end

		return ent
	end

	function ENT:Initialize()
		self:SetModel("models/nt/props_tech/server_box2.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
		self.hp = 75
	end

	function ENT:OnRemove()
	end

	function ENT:OnTakeDamage(dmg)
		self.hp = self.hp-dmg:GetDamage()
		if(self.hp <= 0 and !self.destroyed) then
			print("blam")
			--do thingy idk
			self.destroyed = true
			local cd = EffectData()
			cd:SetOrigin(self:GetPos()+Vector(0, -12, 4))
			cd:SetAngles(self:GetAngles())
			cd:SetMagnitude(math.random(2,3))

			--self:StopSound("servermachinesquiet")

			util.Effect("ElectricSpark", cd)
			ParticleEffect("smoke_gib_01", self:GetPos()+Vector(0, 0, 12), self:GetAngles():Up():Angle(), self)
			self:setNetVar("destroyed", true)
			local run = PLUGIN.curRuns[self.runid]
			local players = run.players
			netstream.Start(players, "fakepdapm", "from AUTOREPLY: The machine has been destroyed.")
			if(IsValid(self.Bullseye)) then
				self.Bullseye:Remove()
			end
			if(self.sound) then
			self.sound:Stop()
			end
		end
	end

	local function shuffle(tbl)
		local size = #tbl
		for i = size, 1, -1 do
		  local rand = math.random(size)
		  tbl[i], tbl[rand] = tbl[rand], tbl[i]
		end
		return tbl
	end
	
	function ENT:Use(activator)
		if(self.active) then return end
		if(!self.runid) then return end
		if(self.destroyed) then return end --if theyve somehow destroyed it already

		local run = PLUGIN.curRuns[self.runid]
		local def = PLUGIN.areas[self.runid]
		print("starting waves")
		timer.Simple(math.random(1,3), function()
			local players = run.players
			netstream.Start(players, "fakepdapm", "from AUTOREPLY: The machine has been activated. Any enemies still alive in the area have been alerted and reinforcements will arrive in approximately 30 seconds.")
		end)
		self.active = true
		self:setNetVar("active", true)
		
		--spawning the bullseye for the npcs to shoot at
		local bullseye = ents.Create("ob_vj_bullseye")
		bullseye.SolidMovementType = "Dynamic"
		bullseye.Activated = true
		bullseye.UserStatusColors = false
		bullseye:SetModel("models/hunter/plates/plate.mdl")
		bullseye:SetPos( self:GetPos() + Vector(0,0,20) )
		bullseye:SetAngles( self:GetAngles() )
		bullseye:SetParent( self )
		bullseye:SetSolid( SOLID_NONE )
		bullseye:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )

		bullseye:SetOwner( self )
		bullseye:Spawn()
		bullseye:Activate()
		--bullseye:SetHealth( 9999999 )
		bullseye:SetRenderMode(RENDERMODE_TRANSALPHA)
		bullseye:SetColor(Color(255,255,255,0))
		--because StopSound is broken
		self.sound = CreateSound(self, "servermachinesquiet")
		if(self.sound) then
		self.sound:Play()
		end

		self.Bullseye = bullseye

		if(run.enemies) then
			--send all active enemies to this place
			for k,v in pairs(run.enemies) do
				if(IsValid(v)) then -- and !IsValid(v:GetEnemy())) then
					v:StopMoving()
					v:SetTarget(self.Bullseye)
					if v.IsVJBaseSNPC == true && (v.IsVJBaseSNPC_Creature == true or v.IsVJBaseSNPC_Human == true) then
						v:VJ_TASK_GOTO_TARGET("TASK_RUN_PATH")--[[,function(x) 
							if IsValid(v:GetEnemy()) && v:Visible(v:GetEnemy()) then
								x:EngTask("TASK_FACE_ENEMY", 0) 
								x.CanShootWhenMoving = true 
								x.ConstantlyFaceEnemy = true
							end
						end)]]
					else
						v:SetSchedule(SCHED_FORCED_GO_RUN)
					end
				end
			end
		end
		
	self.LastPos = self:GetPos( )

	local ent = ents.GetAll()
	--table.Add(ents) --??

	for _,v in pairs(ent) do

		if v:GetClass() != self and v:IsNPC() and v:GetClass() != "npc_bullseye" and v:GetClass() != "ob_vj_bullseye" and v:GetClass() != "npc_grenade_frag" then
			v:AddEntityRelationship( bullseye, D_HT, 99 )
		end

	end

		local waves = 0
		local id = "waves"..self.runid
		timer.Create(id, 30, 3, function()
			if(!run) then timer.Remove(id) return end
			local players = run.players
			if(!players or #players == 0) then timer.Remove(id) return end

			if(!IsValid(self)) then timer.Remove(id) return end
			if(self.destroyed) then 
				timer.Remove(id)
				return
			end
			if(waves != 0) then
				netstream.Start(players, "fakepdapm", "from AUTOREPLY: More reinforcements on site.")

			end
			waves = waves + 1
			if(waves == 3) then
				timer.Simple(math.random(3,9), function()
				netstream.Start(players, "fakepdapm", "from AUTOREPLY: The machine has finished. Mission complete.")
				self.finished = true
				self:setNetVar("finished", true)
				self.Bullseye:Remove()
				if(self.sound) then
				self.sound:Stop()
				end
				end)
				--self:StopSound("servermachinesquiet")
			end


			--reinforcements based

			local enm = 0 --cur item number
			--min/max items based on player count
			local enmcount = {
				[1] = {2,3}, --1 player, 1 min 3 max
				[2] = {3,5},
				[3] = {4,6},
				[4] = {5,8},
			}
			if(self.runid == 2) then
				enmcount = {
					[1] = {3,4}, --1 player, 1 min 3 max
					[2] = {3,5},
					[3] = {4,7},
					[4] = {5,8},
					[5] = {6,9},
					[6] = {7,10},
				}
			end
			--randomize the item spawns
			local toremee = table.Copy(def.playerspawns)
			if(self.runid == 2) then
				toremee[3] = nil
			end
			local tmpspawns = shuffle(toremee)

			local enmlist = run.enemylist
			local breakk = false
			for k,v in pairs(tmpspawns) do

				--spawn random from enmlist
				if(type(v[1]) == "table") then
					for k2, v2 in pairs(v) do
						if(enm == enmcount[#players][2]) then
							breakk = true --to quit the entire thing
							break --quit spawning if at max
						end
						--if item count equals or is higher than min
						if(enm >= enmcount[#players][1]) then 
							--random number if itll continue spawning
							--opposite of items
							if(math.Rand(0,1) >= (enm/enmcount[#players][2])) then
								break
							end
						end
				
			
						--spawn at pos
						enm = enm+1
						local np = ents.Create(enmlist[math.random(#enmlist)])
						if(np) then
							np:SetPos(v2[1])
							np:SetAngles(Angle(0, v2[2].y, 0))
							local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK )
							np:SetKeyValue( "spawnflags", SpawnFlags )
							np:Spawn()
							np:Activate() --just in case
							if(np.ComeonSound) then if(np.ComeonSound) then np:ComeonSound() end end
							if(list.Get("NPC")[np:GetClass()]) then
								local lis = list.Get("NPC")[np:GetClass()].Weapons
								if(lis) then
									np:Give(lis[math.random(#lis)])
								end
							end
							local diff = run.diff or 0
							local scale = 1
							if(diff == RUN_DIFF_NORMAL) then
							elseif(diff == RUN_DIFF_HARD) then
								scale = 1.5
							elseif(diff == RUN_DIFF_EXPERT) then
								scale = 2.5
							end
							timer.Simple(0, function() --just to be safe
							np:SetHealth(np:Health()*scale)
							end)
							if(!run.enemies) then
								run.enemies = {}
							end
							table.insert(run.enemies, np)

							local unlucky = self
							if(!IsValid(unlucky)) then
								nut.log.addRaw("tried to add reinforcements for "..run.uniqueid.." but theres no players???")
								continue
							end

							--make them move onto the map by going to a random players position, 
							--theres a complete chance that they wont meet anyone during that time but whatever
							np:StopMoving()
							np:SetTarget(unlucky.Bullseye)
							if np.IsVJBaseSNPC == true && (np.IsVJBaseSNPC_Creature == true or np.IsVJBaseSNPC_Human == true) then
								np:VJ_TASK_GOTO_TARGET("TASK_RUN_PATH")--[[,function(x) 
									if IsValid(np:GetEnemy()) && np:Visible(v:GetEnemy()) then
										x:EngTask("TASK_FACE_ENEMY", 0) 
										x.CanShootWhenMoving = true 
										x.ConstantlyFaceEnemy = true
									end
								end)]]
							else
								np:SetSchedule(SCHED_FORCED_GO_RUN)
							end
						end
					end
				end
				if(breakk) then break end
			end
		end)
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

		nut.util.drawText("Machine", x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
		if(self:getNetVar("destroyed")) then
			nut.util.drawText("Destroyed.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
		elseif(self:getNetVar("finished")) then
			nut.util.drawText("Finished.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
		elseif(self:getNetVar("active")) then
			nut.util.drawText("Working...", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
		else
			nut.util.drawText("Use to start. Nearby enemies will be alerted and reinforcements will come.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
		end
	end
end