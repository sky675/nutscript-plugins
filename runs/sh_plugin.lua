local PLUGIN = PLUGIN
PLUGIN.name = "Runs"
PLUGIN.author = "sky"
PLUGIN.desc = "randomly generated shadowruns"

--moved into own file
nut.util.include("sh_config.lua")
nut.util.include("sh_itemtake.lua")

RUN_DIFF_NORMAL = 1
RUN_DIFF_HARD = 2
RUN_DIFF_EXPERT = 3

--syncd time, needed for run expiration
if SERVER then
	local function SendTime(ply)
        umsg.Start("svr_time",ply)
            umsg.Long(os.time())
            umsg.Long(CurTime())
        umsg.End()
    end
    hook.Add("PlayerInitialSpawn","SendTime",SendTime)
end
if CLIENT then
	os._SVRDiff = 0
	local function GetSVRTime(um)
		os._SVRDiff = os.time()-um:ReadLong()+um:ReadLong()-CurTime()
    end
    usermessage.Hook("svr_time",GetSVRTime)
    
	function os.ServerTime()
		return os.time() - os._SVRDiff
	end
	local function TCMD()
		print(os.time(),os.ServerTime(),os.date("%I:%M %p",os.time()),os.date("%I:%M %p",os.ServerTime()))
    end
    concommand.Add("print_servertime",TCMD)
end


nut.command.add("rundisable", {
	syntax = "<number id> <bool status> [bool remove]",
	desc = "Disable runs being generated in the specified area, if you/someone wants to do something special there. Optional remove to remove the run there if it exists (recommended)",
    adminOnly = true,
	onRun = function(client, arguments)
		local runid = tonumber(arguments[1])
		local status = tobool(arguments[2])
		local remove = tobool(arguments[3])

		if(!PLUGIN.areas[runid]) then
			return "A run id of that doesnt exist!"
		end

		PLUGIN:SetAdminArea(runid, status, remove)

        return "Area #"..arguments[1].." "..(status and "disabled" or "reenabled").."!"..(remove and " And if there was a run there, its removed now.")
	end
})
nut.command.add("runforce", {
	syntax = "<number id> [bool remove] [number obj]",
	desc = "Forcefully generate a run with obj (or random if none) at this area id, will not be ran if a run is active and remove isnt true.",
    adminOnly = true,
	onRun = function(client, arguments)
		local runid = tonumber(arguments[1])
		local remove = tobool(arguments[2])
		local obj = tonumber(arguments[3])

		if(!PLUGIN.areas[runid]) then
			return "A run id of that doesnt exist!"
		end

		PLUGIN:GenerateRun(runid, remove, obj)

        return "Generated run at "..runid.." with "..(obj and arguments[3] or "a random objective")..(remove and ", if there was a run there, it was replaced with it." or ".")
	end
})
nut.command.add("runremove", {
	syntax = "<number id>",
	desc = "Remove a run at the specified area.",
    adminOnly = true,
	onRun = function(client, arguments)
		local runid = tonumber(arguments[1])

		if(!PLUGIN.areas[runid]) then
			return "A run id of that doesnt exist!"
		end

		PLUGIN:RemoveRun(runid)

        return "Area #"..arguments[1].."'s run has been removed if there was one."
	end
})

if(SERVER) then
	--agh
	

	--activate a pending active run because someone accepted it
	function PLUGIN:activateRun(runid, diff)
		--set this as active
		self.curRuns[runid].active = true

		--run the onAccept of the objective, 
		--this will spawn the enemies and do all the work needed
		self.areas[self.curRuns[runid].area].objectives[self.curRuns[runid].obj].onAccept(runid, diff)
	end
	netstream.Hook("runActivate", function(client, runid, cmb)
		--just double check
		if(client:getChar():getData("leadactiverun") or client:getChar():getData("activerun")) then
			client:notify("You're already part of a run and can't accept another.")
			return
		end
		--print(runid)
		if(PLUGIN.curRuns[runid].active) then
			client:notify("this run is already active, possibly someone got it first?")
			return
		end

		if(cmb and PLUGIN.curRuns[runid].cobj) then --if cmb, replace with that ver
			PLUGIN.curRuns[runid].obj = PLUGIN.curRuns[runid].cobj
		end

		PLUGIN:activateRun(runid)

		client:notify("You have accepted the run!")

		client:getChar():setData("activerun", PLUGIN.curRuns[runid].uniqueid)
		client:getChar():setData("leadactiverun", PLUGIN.curRuns[runid].uniqueid)
		if(!PLUGIN.curRuns[runid].players) then
			PLUGIN.curRuns[runid].players = {}
		end
		table.insert(PLUGIN.curRuns[runid].players, client)
	end)

	runuid = runuid or 1 --increments with every run

	--function (intended to be run via rcon) to force a specific type of run
	--to be made, basically use the same code as below when checking
	--if the area doesnt have a run or the run is active but theres no players
	--left, remove the current run and generate one with the specified obj id
	--if it does, log it so can see

	--generate initial runs and make a timer for checking if an area doesnt have a run
	--or the run is active but has no players left
	--or its been more than 3 hours since the run was made and its not active
	--and remove the current run (if applicable) and generate a new one
	run_loadedalready = run_loadedalready or false
	function PLUGIN:OnLoaded()
		if(run_loadedalready) then
			return
		else
			run_loadedalready = true
		end
		for k,v in pairs(self.areas) do
			self:GenerateRun(k)
		end
								--1 hr from 30m (1800)
		timer.Create("runchecker", 3600, 0, function()
			for k,v in pairs(self.areas) do
				if(self.adminused[k]) then continue end --these are areas that are disabled because someone wants to use it
				if(!self.curRuns[k]) then
					--run doesnt exist
					print("run not exist")
					self:GenerateRun(k)
					continue
				end
				if(self.curRuns[k].active and !self.curRuns[k].done) then
					local cu = 0
					print("checking for player count "..k)
					if(self.curRuns[k] or self.curRuns[k].players) then
					for k2,v2 in pairs(self.curRuns[k].players) do
						if(v2 == nil or v2 == NULL or !v2:getChar() or (v2:getChar() and v2:getChar():getData("activerun", -1) != self.curRuns[k].uniqueid)) then
							print("player not exists")
						else
							cu = cu + 1
							print("player exists, cu = "..cu)
						end
					end
					end
					if(cu == 0) then
						--current player count is 0
						print("player count is 0 on "..k)
						self:GenerateRun(k, true)
						continue
					end
				elseif((os.time()-self.curRuns[k].starttime) > 10800) then
					--3 hours since generation and its not accepted
					print("time out")
					self:GenerateRun(k, true)
				end
			end
		end)
	end

	function PLUGIN:SetAdminArea(area, stat, remove)
		if(stat == false) then stat = nil end
		self.adminused[area] = stat-- or true
		if(remove) then
			self:RemoveRun(area)
		end
	end

	function PLUGIN:RemoveRun(area) 
		local runb = self.curRuns[area]
		if(runb) then
		if(runb.enemies) then
		for k,v in pairs(runb.enemies) do
			if(IsValid(v)) then v:Remove() end
		end
		end
		if(runb.items) then
		for k,v in pairs(runb.items) do
			if(IsValid(v)) then v:Remove() end
		end
		end
		if(runb.other) then
		for k,v in pairs(runb.other) do
			if(IsValid(v)) then v:Remove() end
		end
		end
		if(runb.objid and nut.item.instances[runb.objid]) then
			if(!IsValid(nut.item.instances[runb.objid]:getEntity())) then
				nut.item.instances[runb.objid]:remove()
			else --idk its being buggy
				nut.item.instances[runb.objid]:getEntity():Remove()
			end
		end
		if(timer.Exists("rem"..area)) then
			timer.Remove("rem"..area)
		end
		if(timer.Exists("killallthink"..area)) then
			timer.Remove("killallthink"..area)
		end
		self.curRuns[area] = nil --remove the run
		end
	end

	--generate a run for this area, it should be empty already,
	--if remove is true, remove the current run, also
	--warn if a run for that area already exists but stop there if remove isnt true
	--obj is optional to force an objective id
	function PLUGIN:GenerateRun(area, remove, obj)
		if(self.curRuns[area] != nil) then
			print("run already exists"..(remove and ", but itll be removed since remove is true" or ""))
			if(!remove) then return end
		end
		if(remove) then
			local runb = self.curRuns[area]
			if(runb) then
			if(runb.enemies) then
			for k,v in pairs(runb.enemies) do
				if(IsValid(v)) then v:Remove() end
			end
			end
			if(runb.items) then
			for k,v in pairs(runb.items) do
				if(IsValid(v)) then v:Remove() end
			end
			end
			if(runb.other) then
			for k,v in pairs(runb.other) do
				if(IsValid(v)) then v:Remove() end
			end
			end
			if(runb.objid and nut.item.instances[runb.objid]) then
				if(!IsValid(nut.item.instances[runb.objid]:getEntity())) then
					nut.item.instances[runb.objid]:remove()
				else --idk its being buggy
					nut.item.instances[runb.objid]:getEntity():Remove()
				end
			end
			if(timer.Exists("rem"..area)) then
				timer.Remove("rem"..area)
			end
			if(timer.Exists("killallthink"..area)) then
				timer.Remove("killallthink"..area)
			end
			self.curRuns[area] = nil --remove the run
			end
		end
		print("generating run "..area)
		self.curRuns[area] = {
			["area"] = area,
			["starttime"] = os.time(),
			["uniqueid"] = runuid,
		}
		runuid = runuid + 1

		local cobj

		--get a random objective out of available objectives
		if(!obj) then
			local rel = {}
			local cmb = {}
			for k,v in pairs(self.areas[area].objectives) do
				if(!v.special and !v.cmb) then
					table.insert(rel, k)
				end
				if(v.cmb) then
					table.insert(cmb, k)
				end
			end
			local o = table.Random(rel)
			local co = table.Random(cmb)
			self.curRuns[area].obj = o
			self.curRuns[area].cobj = co
			obj = o
			cobj = co
		else
			self.curRuns[area].obj = obj
		end


		--get random enemy list
		if(#self.areas[area].enemies != 0) then
			self.curRuns[area].enemylist = self.areas[area].enemies[math.random(#self.areas[area].enemies)]
		end

		--it generates in the area areas
		self.curRuns[area].name = self.areas[area].name().." - "..self.areas[area].objectives[obj].name()
		self.curRuns[area].desc = self.areas[area].objectives[obj].desc()
		
		if(cobj) then
			self.curRuns[area].cname = self.areas[area].name().." - "..self.areas[area].objectives[cobj].name()
			self.curRuns[area].cdesc = self.areas[area].objectives[cobj].desc()
		end
		print("run generated "..area)
	end

	--to teleport to run, check if all players with this as their activerun
	--are nearby the terminal, if theyre not, warn the client and let them confirm
	--else do onTravel and sequentially setpos and seteyeangles on playerspawns in area
	--if playerspawns are table of tables, pick random table and then spawn
	--sequentially	
	netstream.Hook("runToRun", function(client, diff, ind) 
		if(diff == nil) then diff = RUN_DIFF_NORMAL end
		local runid = client:getChar():getData("leadactiverun")
		if(!runid) then client:notify("you need an active run to use this") return end
		local run
		for k,v in pairs(PLUGIN.curRuns) do
			if(v.uniqueid == runid) then
				run = k
			end
		end
		if(!run) then client:notify("you either arent leading a run or your run is invalid?") return end
		if(PLUGIN.curRuns[run].running) then
			return --player interact bug
		end

		PLUGIN.curRuns[run].busindex = ind

		local ent = ind and Entity(ind) or ents.FindByClass("run_mainbus")[1]
		if(!ent) then client:notify("uh the main bus doesnt exist??") return end

		local ene = ents.FindInSphere(ent:GetPos(), 750)
		local plys = {}
		for k,v in pairs(ene) do
			if(v:IsPlayer() and v:getChar() and v:getChar():getData("activerun", -1) == runid) then
				table.insert(plys, v)
			end
		end
		nut.log.addRaw(client:Name().." went on run "..runid.." at "..run.." with obj "..PLUGIN.curRuns[run].obj.." and diff "..diff)

		if(#plys == #PLUGIN.curRuns[run].players) then
			PLUGIN.curRuns[run].running = true
			--teleport - if travel will spawn the players itself let it
			print("manual", PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].manualspawn)
			if(!PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].manualspawn) then
			local spawns = PLUGIN.areas[run].playerspawns
			--now it should support whatever number of players and not get people stuck
			local coolspawns = {}
			for k,v in pairs(spawns) do
				if(#plys <= #v) then
					coolspawns[k] = v
				end
			end
			local actualspawn = coolspawns[math.random(#coolspawns)]
			for k,v in pairs(plys) do
				if(!IsValid(v)) then continue end
				if(actualspawn[k]) then
					--the ang/pos in spawn[k], use seteyeangles and setpos
					v:SetPos(actualspawn[k][1])
					v:SetEyeAngles(actualspawn[k][2])
				else
					--same as above but do the last spawn and warn that theyre probably in someone
					v:SetPos(actualspawn[#actualspawn][1])
					v:SetEyeAngles(actualspawn[#actualspawn][2])
					v:notify("youre probably stuck in someone. sorry! this shouldnt ever happen though.")
				end
			end
			end
			PLUGIN.curRuns[run].diff = diff
			--make sure to run this in goahead too
			PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].onTravel(run, diff)
		else
			--notify that not all players are in area
			netstream.Start(client, "runWarnPpl", diff)
		end
	end)
	--called after the client decided to go ahead with the run even though
	--everyone isnt in the area, strip the activerun from the people not there
	--(and notify them) and do the same thing as above but only for people 
	--in the area, check in sphere just in case it hasnt stripped it yet 
	--from the other ppl
	netstream.Hook("runGoAhead", function(client, diff)
		if(diff == nil) then diff = RUN_DIFF_NORMAL end
		local runid = client:getChar():getData("leadactiverun")
		if(!runid) then client:notify("you need an active run to use this") return end
		local run
		for k,v in pairs(PLUGIN.curRuns) do
			if(v.uniqueid == runid) then
				run = k
			end
		end
		if(!run) then client:notify("you either arent leading a run or your run is invalid?") return end

		local ent = ents.FindByClass("run_mainbus")[1]
		if(!ent) then client:notify("uh the main bus doesnt exist??") return end

		local ene = ents.FindInSphere(ent:GetPos(), 750)
		local plys = {}
		for k,v in pairs(ene) do
			if(v:IsPlayer() and v:getChar() and v:getChar():getData("activerun", -1) == runid) then
				table.insert(plys, v)
			end
		end
		nut.log.addRaw(client:Name().." went ahead on run "..runid.." at "..run.." with obj "..PLUGIN.curRuns[run].obj.." and diff "..diff.." with people missing")

		PLUGIN.curRuns[run].running = true

		if(!PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].manualspawn) then
		local spawns = PLUGIN.areas[run].playerspawns
		for k,v in pairs(plys) do
			if(!IsValid(v)) then continue end
			if(spawns[k]) then
				--the ang/pos in spawn[k], use seteyeangles and setpos
				v:SetPos(spawns[k][1])
				v:SetEyeAngles(spawns[k][2])
			else
				--same as above but do the last spawn and warn that theyre probably in someone
				v:SetPos(spawns[#spawns][1])
				v:SetEyeAngles(spawns[#spawns][2])
				v:notify("youre probably stuck in someone. sorry! these runs are meant for 4 people max.")
			end
		end
		end
		for k,v in pairs(PLUGIN.curRuns[run].players) do
			if(!IsValid(v)) then continue end
			if(table.KeyFromValue(plys, v) == nil) then --theyre not nearby
				if(v:getChar()) then
					v:getChar():setData("activerun", nil)
					--todo change to auto chat pm?
					v:notify("Your party members have left on the run without you.")
				end
			end
		end

		PLUGIN.curRuns[run].diff = diff
		--make sure to run this in goahead too
		PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].onTravel(run, diff)
	
	end)

	--bring them back to the main bus terminal, run onFinish if theyre the leader
	--if it returns true, they failed so strip the run from all players and 
	--remove all entities when all players are clear (check every min)
	--and remove the run from curRuns
	--if it didnt, remove all entites when all players are clear
	--(check every min), onFinish should set the run as done if it needs to
	--if theyre not the winner, remove their activerun
	netstream.Hook("runComeBack", function(client)

		if(client:getChar():getData("leadactiverun")) then
			local runid = client:getChar():getData("leadactiverun")
			local run
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == runid) then
					run = k
				end
			end
			if(!run) then client:notify("this shouldnt happen, your run is invalid, tell sky") return end
			
			local ent = Entity(PLUGIN.curRuns[run].busindex) or ents.FindByClass("run_mainbus")[1]

			local pos = ent:GetPos() + Vector(0, 36, 0) --hoping this will work
			client:SetPos(pos)

			local diff = PLUGIN.curRuns[run].diff 
			local succ = PLUGIN.areas[run].objectives[PLUGIN.curRuns[run].obj].onFinish(run, diff)

			nut.log.addRaw(client:Name()..", run leader of "..runid.." at "..run.." with obj "..PLUGIN.curRuns[run].obj.." returned from the run, succ = "..tostring(succ).." (true means failed)")

			if(succ) then --this actually means it failed
				client:notify("The run has been abandoned.")
				timer.Create("rem"..runid, 30, 0, function()
					local sph = ents.FindInSphere(PLUGIN.areas[run].center, PLUGIN.areas[run].centerrange)
					local plyin = false
					for k,v in pairs(sph) do
						if(v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP) then
							plyin = true
							break
						end
					end

					if(PLUGIN.curRuns[run].uniqueid != runid) then
						timer.Remove("rem"..runid)
						return
					end

					if(!plyin and PLUGIN.curRuns[run].done) then
						local runb = PLUGIN.curRuns[run]
						--loop through enemies, items, and other and remove them
						if(runb.enemies) then
						for k,v in pairs(runb.enemies) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.items) then
						for k,v in pairs(runb.items) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.other) then
						for k,v in pairs(runb.other) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.objid and nut.item.instances[runb.objid]) then
							if(!IsValid(nut.item.instances[runb.objid]:getEntity())) then
								nut.item.instances[runb.objid]:remove()
							else --idk its being buggy
								nut.item.instances[runb.objid]:getEntity():Remove()
							end
						end

						PLUGIN.curRuns[run] = nil --remove the run
						if(timer.Exists("killallthink"..run)) then
							timer.Remove("killallthink"..run)
						end
						timer.Remove("rem"..runid)
					end
				end)

				PLUGIN.curRuns[run].failed = true
				
				--strip active run from clients when they collect the money
				client:getChar():setData("leadactiverun", nil)
				client:getChar():setData("activerun", nil)
				table.RemoveByValue(PLUGIN.curRuns[run].players, client)
				
				--added
				client:getChar():setVar("runitems")
			end
			
		elseif(client:getChar():getData("activerun")) then
			local runid = client:getChar():getData("activerun")
			local run
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == runid) then
					run = k
				end
			end
			if(!run) then client:notify("this shouldnt happen, your run is invalid, tell sky") return end
			
			local ent = Entity(PLUGIN.curRuns[run].busindex) or ents.FindByClass("run_mainbus")[1]

			local pos = ent:GetPos() + Vector(0, 36, 0) --hoping this will work
			client:SetPos(pos)

			client:getChar():setData("activerun", nil)
			--just in case idk how that happened
			client:getChar():setData("leadactiverun", nil)
			--added
			client:getChar():setVar("runitems")
			table.RemoveByValue(PLUGIN.curRuns[run].players, client)
		end
	end)
	
	--check if the run at id is done, if it is give the money (seperate credstick?)
	--and strip run from all players that still have it,
	--if its not, notify player
	netstream.Hook("runCollect", function(client, id)
		
		if(PLUGIN.curRuns[id].uniqueid != client:getChar():getData("leadactiverun", -1)) then
			--their leadactiverun isnt this, they shouldnt be getting here
			client:notify("hey what the fuck do you think youre doing :)")
			nut.log.addRaw(client:Name().." tried to collect "..id.." but theyre not the leader????")
			return
		end

			local run = PLUGIN.curRuns[id]
			if(run.done and !run.collect) then
				--give credstick with price on it,
				local inv = client:getChar():getInv()
				--if they dont have the inv space its their fault
				if(run.price) then
					if(run.price[1] == "") then --just give them straight money
						local price = math.Round(run.price[2])
						
						client:getChar():giveMoney(price)
						if(run.players and #run.players != 1) then
							client:notify("The terminal dispenses "..nut.currency.get(price)..". Please split it with your team members :)")
						else
							client:notify("The terminal dispenses "..nut.currency.get(price)..".")
						end
					else
						local price = math.Round(run.price[2])
						local succ, res = inv:add(run.price[1], 1, {money = price})
						if(!succ) then
							client:notify(res or "failed collection")
							return
						end
						client:notify("Item given with "..price.." money on it. (if this shows it prob shouldnt)")
						--client:notify("The terminal dispenses a credstick with ¥"..price.." nuyen on it.")
					end
				else
					client:notify("The terminal marks the run as completed and shortly after the entry disappears.")
				end
				

				run.collect = true

				--strip run from all players that still have it
				for k,v in pairs(player.GetAll()) do
					if(v:getChar() and (v:getChar():getData("activerun", -1) == run.uniqueid)) then
						v:getChar():setData("activerun", nil)
						--added
						v:getChar():setVar("runitems")
					end
				end
				client:getChar():setData("leadactiverun", nil)
				--uh just in case lol
				client:getChar():setVar("runitems")
				--start remove timer (above)
				local runid = id
				timer.Create("rem"..runid, 30, 0, function()
					local sph = ents.FindInSphere(PLUGIN.areas[runid].center, PLUGIN.areas[runid].centerrange)
					local plyin = false
					for k,v in pairs(sph) do
						if(v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP) then
							plyin = true
							break
						end
					end


					if(!plyin and run.done) then
						local runb = run
						--loop through enemies, items, and other and remove them
						if(runb.enemies) then
						for k,v in pairs(runb.enemies) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.items) then
						for k,v in pairs(runb.items) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.other) then
						for k,v in pairs(runb.other) do
							if(IsValid(v)) then v:Remove() end
						end
						end
						if(runb.objid and nut.item.instances[runb.objid]) then
							if(!IsValid(nut.item.instances[runb.objid]:getEntity())) then
								nut.item.instances[runb.objid]:remove()
							else --idk its being buggy
								nut.item.instances[runb.objid]:getEntity():Remove()
							end
						end


						PLUGIN.curRuns[runid] = nil --remove the run
						timer.Remove("rem"..runid)
					end
				end)
			else
				client:notify("This run hasn't been completed yet!")
			end
	end)

	hook.Add("ShutDown", "removeactiverun", function()
		nut.log.addRaw("server shutting down")
		for k,v in pairs(player.GetAll()) do
			if(v.getChar and v:getChar()) then
				if(v:getChar():getData("activerun")) then
					v:getChar():setData("pos", nil) --make them respawn at spawn if they were in a run
				end
				v:getChar():setData("activerun", nil)
				v:getChar():setData("leadactiverun", nil)
			end
		end
	end)

	--remove their activerun because it shouldnt persist and idk about getvar
	hook.Add("OnCharDisconnect", "removeactiverun", function(ply, char)
		if(char) then
		if(char:getData("activerun")) then
			nut.log.addRaw(ply:Name().." left mid run, removing them from the run and setting their pos to nil")
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == char:getData("activerun")) then
					table.RemoveByValue(v.players, ply)
				end
			end
			char:setData("removepos", true) --make them respawn at spawn if they were in a run
		end
		
		local lastChar = char
		if(lastChar:getData("leadactiverun") != nil) then
			local id
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == lastChar:getData("activerun")) then
					id = k
				end
			end
			
			if(id and PLUGIN.curRuns[id].players) then
				for k,v in pairs(PLUGIN.curRuns[id].players) do
					v:getChar():setData("activerun")
				end
				PLUGIN.curRuns[id].players = {} --reset it
			end
		end


		if(ply:getChar() and ply:getNetVar("neardeath")) then
			char:setData("removepos", true)
		end
		char:setData("activerun", nil)
		char:setData("leadactiverun", nil)
		end
	end)

	hook.Add("CharacterPreSave", "zzzremove", function(char)
		if(char:getData("removepos")) then
			char:setData("pos")
			char:setData("removepos")
		else
			--idk? for some reason it doesnt save
			local client = char:getPlayer()
			if(!IsValid(client)) then return end 
			char:setData("pos", {client:GetPos(), client:EyeAngles(), game.GetMap()})
		end
	end)
	--remove their activerun when they die so they cant come back
	hook.Add("PostPlayerDeath", "removeactiverun", function(ply)
		if(ply:getChar()) then
			if(ply:getChar():getData("activerun")) then
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == ply:getChar():getData("activerun")) then
					table.RemoveByValue(v.players, ply)
				end
			end
			end
			local lastChar = ply:getChar()
			if(lastChar:getData("leadactiverun") != nil) then
				local id
				for k,v in pairs(PLUGIN.curRuns) do
					if(v.uniqueid == lastChar:getData("activerun")) then
						id = k
					end
				end
				
				if(id and PLUGIN.curRuns[id].players) then
					for k,v in pairs(PLUGIN.curRuns[id].players) do
						v:getChar():setData("activerun")
					end
					PLUGIN.curRuns[id].players = {} --reset it
				end
			end
			
			ply:getChar():setData("activerun", nil)
			ply:getChar():setData("leadactiverun", nil)
		end
	end)
	hook.Add("PlayerLoadedChar", "removeactiverun", function(ply, char, lastChar)
		if(lastChar) then
			if(lastChar:getData("activerun") != nil) then
			for k,v in pairs(PLUGIN.curRuns) do
				if(v.uniqueid == lastChar:getData("activerun")) then
					table.RemoveByValue(v.players, ply)
				end
			end
			lastChar:setData("pos", nil) --make them respawn at spawn if they were in a run
			end

			if(lastChar:getData("leadactiverun") != nil) then
				local id
				for k,v in pairs(PLUGIN.curRuns) do
					if(v.uniqueid == lastChar:getData("activerun")) then
						id = k
					end
				end
				
				if(id and PLUGIN.curRuns[id].players) then
					for k,v in pairs(PLUGIN.curRuns[id].players) do
						v:getChar():setData("activerun")
					end
					PLUGIN.curRuns[id].players = {} --reset it
				end
			end

			lastChar:setData("activerun", nil)
			lastChar:setData("leadactiverun", nil)

			if(lastChar) then --uhh save it again lmao
				lastChar:save()
			end
		end
		ply:getChar():setData("activerun", nil)
		ply:getChar():setData("leadactiverun", nil)
	end)

	--send a runRecInv to who theyre inviting, so they can accept
	netstream.Hook("runInv", function(client, target)
		local runid = client:getChar():getData("leadactiverun")
		if(!runid) then client:notify("you need an active run to use this") return end
		--if(target:getChar():isSectcom()) then client:notify("data on this character prevents them from going on jobs") return end
		local run
		for k,v in pairs(PLUGIN.curRuns) do
			if(v.uniqueid == runid) then
				run = k
			end
		end
		if(#PLUGIN.curRuns[run].players == PLUGIN.areas[run].maxply) then
			client:notify("you cant invite any more people")
			return
		end
		if(!IsValid(target) or !target.getChar or !target:getChar()) then client:notify("uh bad target, weird") return end
		if(target:getChar():getData("activerun")) then
			client:notify("they're apart of a run already")
			return
		end
		netstream.Start(target, "runRecInv", client)
	end)

	--both of these called from runRecInv
	--set their activerun to the clients activerun and notify the client
	netstream.Hook("runAccInv", function(client, target)
		local runid = target:getChar():getData("leadactiverun")
		if(!runid) then target:notify("you need an active run to use this") return end
		if(client:getChar():getData("activerun")) then return end
		local run
		for k,v in pairs(PLUGIN.curRuns) do
			if(v.uniqueid == runid) then
				run = k
			end
		end
		if(PLUGIN.curRuns[run].running) then
			client:notify("unfortunately theyve already left :(")
			return
		end
		
		client:getChar():setData("activerun", target:getChar():getData("leadactiverun"))
		table.insert(PLUGIN.curRuns[run].players, client)
		nut.log.addRaw(client:Name().." is now a part of "..target:Name().."'s run party.")
		client:notify("You are now a part of run id #"..client:getChar():getData("activerun")..".")
		target:notify("They accepted the run invite.")

		
	end)
	--notify the client the target declined
	netstream.Hook("runDecInv", function(client, target, menu)
		if(!menu) then
			target:notify("They declined the run invite.")
		else
			target:notify("They are currently in a menu.")
		end
	end)

	netstream.Hook("runGetNewList", function(activator)
		
		local list = {}
		--loop through curruns and add ones that arent active
		--but if they are add them anyway if the players activerun
		--is that run
		--add only necessary stuff, name, desc, active, done, etc
		if(!activator:getChar():getData("leadactiverun") and activator:getChar():getData("activerun")) then
			activator:notify("You cannot use the terminal while you are a part of a run and not the run leader!")
		end
		for k,v in pairs(nut.plugin.list["runs"].curRuns) do
			--this should hide any active runs that arent the clients 			--collect means its been collected
			if((!v.active or v.uniqueid == activator:getChar():getData("leadactiverun", -1)) and !v.collect) then
				
				list[k] = {
					name = v.name, --display the name
					desc = v.desc, --desc as tooltip? or idk how to do it yet
					active = v.active, --if its active, check if its the players 
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

		netstream.Start(activator, "runLoadTerminal", list)
	end)

elseif(CLIENT) then
	netstream.Hook("fakepdapm", function(text)
		--if(!LocalPlayer():HasPDA()) then return end
		if(NUT_CVAR_CHATFILTER:GetString():lower():find("pda")) then return end

		if(GetConVar("nutDisablePdaSound") and GetConVar("nutDisablePdaSound"):GetBool()) then
		else --simple
			surface.PlaySound("pda/pda.wav", 50) 
		end
		chat.AddText(Color(206, 82, 24),"[PDA-PM] ", Color(255, 255, 255), text)
		
	end)
	
	--derma query to warn that there are people in the party not nearby,
	--and if they continue they will be removed from the party
	--if they decline, do nothing, if they continue start runGoAhead
	netstream.Hook("runWarnPpl", function(client, diff)
		Derma_Query("WARNING: There are members of your invited party that are not near the terminal. You may continue but any members not near the terminal will be left behind and not be able to join later.", "Invited members away", 
		"Continue", function()
			netstream.Start("runGoAhead", diff)
		end, "Abort", function()
		end)
	end)

	--derma query to accept the persons invite, client is the inviter
	netstream.Hook("runRecInv", function(client)
		if(IsValid(nut.gui.menu) or 
			IsValid(nut.gui.char) or
			IsValid(nut.gui.stash) or
			IsValid(nut.gui.vendor)) then
			nut.util.notify(client:Name().." tried to send you an invite but you're in a menu")
			netstream.Start("runDecInv", client, true)
			return
		end
		
		surface.PlaySound("gameplay/ghost_ping.wav")
		if(!system.HasFocus()) then
			system.FlashWindow()
		end

		Derma_Query(client:Name().." has sent you an invite to join their run.", "Run Invite",
		"Accept", function()
		netstream.Start("runAccInv", client)
		end,
		"Decline", function()
		netstream.Start("runDecInv", client, false)
		end)
	end)

	netstream.Hook("interactWithEnt", function(ent)
		nut.playerInteract.interact(ent, nut.config.get("playerInteractSpeed", 1))
	end)
	--player can press e on a player to invite to active run
	nut.playerInteract.addFunc("invitetorun", {
		name = "Invite to Active Run",
		callback = function(target)
			netstream.Start("runInv", target)
		end,
		canSee = function(target)
			return IsValid(target) and target:IsPlayer() and !target:getChar():getData("activerun") and LocalPlayer():getChar():getData("leadactiverun")
		end
	})

	--when player presses e on bus terminal, itll interact with it, use this
	--to check if they can start a run (activerun is table if they can, 
	--otherwise its just the id)
	nut.playerInteract.addFunc("startrun", {
		name = "Start Active Run (Normal)",
		callback = function(target)
			netstream.Start("runToRun", RUN_DIFF_NORMAL, target:EntIndex())
		end,
		canSee = function(target)
			return IsValid(target) and target:GetClass() == "run_mainbus" and LocalPlayer():getChar():getData("leadactiverun")
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("startrun1hard", {
		name = "Start Active Run (Hard)",
		callback = function(target)
			netstream.Start("runToRun", RUN_DIFF_HARD, target:EntIndex())
		end,
		canSee = function(target)
			return IsValid(target) and target:GetClass() == "run_mainbus" and LocalPlayer():getChar():getData("leadactiverun")
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	nut.playerInteract.addFunc("startrun2exp", {
		name = "Start Active Run (Expert)",
		callback = function(target)
			netstream.Start("runToRun", RUN_DIFF_EXPERT, target:EntIndex())
		end,
		canSee = function(target)
			return IsValid(target) and target:GetClass() == "run_mainbus" and LocalPlayer():getChar():getData("leadactiverun")
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})
	--for the bus terminals at run sites, warn them 
	--that they wont be able to come back, and additonally
	--warn if they are the run owner that if your mission is not
	--complete or you dont need to drop an objective off, 
	--the run will be canceled
	--allow use without an active run tho and dont warn them if 
	--they dont have one
	nut.playerInteract.addFunc("returnrun", {
		name = "Return from Run",
		callback = function(target)
			if(LocalPlayer():getChar():getData("activerun")) then
				Derma_Query("WARNING: If you leave, you won't be able to come back! If you are the run leader and your objective isn't something you need to come back to complete (ex delivering an item), the run will be abandoned if the objective isn't complete when you leave!", "Leave warning",
				"Travel Back", function()
					netstream.Start("runComeBack")
				end,
				"Abort", function()
				end)
			else
				netstream.Start("runComeBack")
			end
		end,
		canSee = function(target)
			return IsValid(target) and target:GetClass() == "run_runbus"
			--return target:IsPlayer() and !target:getData("activerun")
		end
	})

	--create ui for displaying runList, 
	--if players activerun is a table
	--change the accept button to a turn in button for the values line
	netstream.Hook("runLoadTerminal", function(runList, cmb)
		CreateTerminalUI(runList, cmb)
	end)

	--[[
		--k being the runid
		list[k] = {
			name = v.name, --display the name
			desc = v.desc, --desc as tooltip? or idk how to do it yet
			active = v.active, --if its active, check if its the players 
			--leadactiverun just to make sure, and then 
			--replace the accept button with a turn in button, 
			--the turn in button should start runCollect netstream, 
			--with the run id as the argument
			done = v.done, --only enable the turn in button if done is true
			starttime = v.starttime, --to display how much time is left if
			--the run hasnt been accepted yet until it expires
			uniqueid = v.uniqueid
		}
	]]

	termmenu = termmenu or nil

	function CreateTerminalUI(list, cmb)
		termmenu = vgui.Create("DFrame")
		local base = termmenu
		base:SetSize(ScrW()/2, ScrH()/2)
		base:SetTitle("run browser interface v1.21")
		base:SetDraggable(true)
		base:MakePopup()
		base:SetKeyboardInputEnabled(false)
		base:Center()
		base:DockPadding(0, 0, 0, 0)

		createrunlist(base, list, cmb)
	end

	function createrunlist(self, list, cmb)
		if(self.data) then
			self.data:Remove()
		end

		self.data = self:Add("DListView")
		local data = self.data
		data:Dock(FILL)
		--data:SetWide(self:GetWide())
		data:DockMargin(0, 20, 0, 0)
		--probably will be changed
		data:AddColumn("Name")
		data:AddColumn("Time until expiration")
		data:AddColumn("Button") --this can be a button


		for k,v in pairs(list) do
			--creation: data:AddLine(name, minpay, curtime paybutton) --with paybutton being an actual button
			local button = vgui.Create("DButton")
			local line = data:AddLine(cmb and v.cname or v.name, string.NiceTime(math.Round(math.max(0, ((v.starttime+10800)-os.ServerTime())))), button)
			line:SetTooltip(cmb and v.cdesc or v.desc)
		--	print(((v.starttime+10800)-os.ServerTime()))
		--	print(os.ServerTime())
			line.realtime = math.Round(math.max(0, ((v.starttime+10800)-os.ServerTime())))
			button:Dock(RIGHT)
			button:SetWide(data:ColumnWidth(3))
			button:SetText("Accept Run")
			button.DoClick = function()
				netstream.Start("runActivate", k, cmb)
				timer.Simple(0.01, function() termmenu:Remove() netstream.Start("runGetNewList") end)
			end
			--double checking if they own it
			if(v.uniqueid == LocalPlayer():getChar():getData("leadactiverun", -1)) then
				button:SetText("Collect Pay")
				button.DoClick = function()
					netstream.Start("runCollect", k)
					timer.Simple(0.01, function() termmenu:Remove() netstream.Start("runGetNewList") end)
				end
			end
		end

		timer.Create("termupdate", 1, 0, function()
			if(!IsValid(termmenu) or !termmenu.data) then timer.Remove("termupdate") return end

			for k,v in pairs(termmenu.data:GetLines()) do
				if(v.realtime > 0) then
					v:SetColumnText(2, string.NiceTime(v.realtime-1))
					v.realtime = v.realtime-1
				else
					v:SetColumnText(2, "Expires soon")
				end
			end
		end)
	
	end
end