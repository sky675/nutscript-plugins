local PLUGIN = PLUGIN

--hook for dropping stuff
hook.Add("OnNPCKilled", "jobdrop", function(npc, atk, inf)
	local class = npc:GetClass()
	
	if(npc:getNetVar("dropitem")) then
		local item = nut.item.instances[npc:getNetVar("dropitem")]
		if(item) then
			item:spawn(npc:GetPos())
		else
			nut.log.addRaw("oh no, npc was supposed to drop an obj item but its nonexistant now")
		end
	end
end)

--random tables and stuff for jobs
local bountyItems = {
	{
		name = "Small Cache",
		desc = "A small plastic green container with 'GEOSTASH' on it. Quick check inside reveals that there's actually nothing in it.",
		model = "models/props_clutter/geo_cache_001.mdl",
	},
	{
		name = "Dossier",
		desc = "A dossier of some kind.",
		model = "models/stalker/item/handhelds/files4.mdl",
	},
	{
		name = "Journal",
		desc = "Some locked journal.",
		model = "models/props_lab/bindergraylabel01a.mdl",
	},
}
local bountyPrices = {700,1000,1000,1000,1250,1250,1500}
local genericItemTbl = {
	--[[
	{
		uniqueID = "",
		counts = {
			{count = 1, rewards = {}}
		},
	},
	]]
}
local genericItemPlurs = {
	--["uniqueID"] = "replacement"
}

--job templates
PLUGIN.jobTemps = {
	--[[
	["type"] = {
		name = "", --formatted, %s
		desc = "", --generic desc? idk
		--unique = true, --uncomment to prevent this from being random gen
		generate = function() --return a table, gets merged with curjob
		end,
		format = function(job) --format table, return table
		end,
		--checked when you try and turn it in, return true/false
		onTurnIn = function(client, job) 
		end,
		giveReward = function(client, job)
		end
	},
	]]
	["genericItem"] = {
		name = "Collect %s %s - %s", --formatted, %s
		desc = "Collect a number of this item and turn them in.", --generic desc? idk
		--unique = true, --uncomment to prevent this from being random gen
		generate = function() --return a table, gets merged with curjob
			local sel = genericItemTbl[math.random(#genericItemTbl)]
			local cnt = sel.counts[#sel.counts]
			return {itemid = sel.uniqueID, itemcount = cnt.count, reward = cnt.rewards[math.random(#cnt.rewards)]}
		end,
		format = function(job) --format table, return table
			return {job.itemcount, job.itemcount != 1 and genericItemPlurs[job.itemid] or nut.item.get(job.itemid).name, nut.currency.get(job.reward)}
		end,
		--checked when you try and turn it in, return true/false
		onTurnIn = function(client, job) 
			local items = client:getChar():getInv():getItems()
			local num, req, uniqueID, done = 0, job.itemcount, job.itemid, false
			local torem = {}

			for k,v in pairs(items) do
				if(v.uniqueID == uniqueID) then
					local quan = v:getQuantity()
					num = num+quan
					if(num >= req) then
						if(num == req) then
							v:remove()
							done = true
							break
						else
							v:setQuantity(quan-num)
							done = true
							break
						end
					else
						torem[k] = v
					end
				end
			end
			if(done) then
				for k,v in pairs(torem) do
					v:remove()
				end
				return true
			else
				return false
			end
		end,
		giveReward = function(client, job)
			client:getChar():giveMoney(job.reward)
			client:notify("Received "..nut.currency.get(job.reward))
		end
	},

	["banditbounty"] = { --this is randomly placed in autoevents, so its unique and has a few unique functions with different args
		name = "Bounty for %s bandit at %s - %s", --formatted, %s
		desc = "Find and kill the target bandit and deliver the special item they drop.", --generic desc? idk
		unique = true, --uncomment to prevent this from being random gen
		generate = function(npc) --return a table, gets merged with curjob
			local id
			local rand = bountyItems[math.random(#bountyItems)]
			nut.item.instance(0, "run_obj", {
				customName = rand.name,
				customDesc = rand.desc,
				customMdl = rand.model
			}, 1, 1, function(item)
				id = item.id
			end)
			npc:setNetVar("dropitem", id)

			return id, bountyPrices[math.random(#bountyPrices)]
		end,
		format = function(npc, area, job) --format table, return table
			return {npc.fem and "female" or "male", area.name, nut.currency.get(job)}
		end,
		--checked when you try and turn it in, return true/false
		onTurnIn = function(client, job) 
			local has = false
			for k,v in pairs(client:getChar():getInv():getItems()) do
				if(v.id == job.itemid) then --psure k is the same too but idk
					has = true
					v:remove()
				end
			end
			return has
		end,
		giveReward = function(client, job)
			client:getChar():giveMoney(job.reward)
			client:notify("Received "..nut.currency.get(job.reward))
		end
	},
	
}