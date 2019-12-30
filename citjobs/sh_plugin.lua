local PLUGIN = PLUGIN

PLUGIN.name = "Citizen Jobs"
PLUGIN.author = "sky"
PLUGIN.desc = "job system yes"

PLUGIN.jobTypes = {
	--[[
	["job_type"] = { --the class index
		name = "name", --idk might not be needed
		pay = { --pay data, pays amt in time, is banked
			time = 0, --for checkout
			paytick = 0, --int, every x mins pay will be given
			amt = 0
		}
	},
	]]
	["medical"] = { --the class index
		name = "Medical Worker", --idk might not be needed
		pay = { --pay data, pays amt in time, is banked
			time = 1800, --for checkout
			paytick = 30, --int, every x mins pay will be given
			amt = 125
		},
		requireCheck = function(ply)
			if(!nut.traits.hasTrait(ply, "tech_med")) then
				ply:getPlayer():notify("You need medical knowledge for this job!")
				return false
			end

			return true
		end
	},
	["craft"] = { --the class index
		name = "Industrial Worker", --idk might not be needed
		pay = { --pay data, pays amt in time, is banked
			time = 300, --for checkout
			paytick = 5, --int, every x mins pay will be given
			amt = 6 --4 from selling items?
		}
	},
	["office"] = { --the class index
		name = "Office Worker", --idk might not be needed
		pay = { --pay data, pays amt in time, is banked
			time = 600, --for checkout
			paytick = 10, --int, every x mins pay will be given
			amt = 25 --4 from selling items?
		}
	},
	["janitor"] = {
		name = "Janitor",
		pay = {
			pay = 600,
			paytick = 10,
			amt = 0,
		},
		nopay = true,
	}
}
--[[data on char:
current job (var?)
an amt of money, the total banked
the time to get autochecked out (curtime() + pay.time?)
check in count: max of 3 in a row before checked out
temp ban: once auto checked out, must wait time until above to be a job again
unsafe amt: the last 2-3? payouts combined, will get removed from banked amt if autochecked
warned: this should be var, each session they get 1 free checkout period, in case theyre new
]]

function PLUGIN:assignToJob(char, job)
	local ply = char:getPlayer()
	if(!self.jobTypes[job]) then
		ply:notify("this job doesnt exist??? "..job)
		nut.log.addRaw(ply:Name().." tried to get assigned to invalid job "..job)
		return
	end
	if(char:getData("tempJobBan", 0) > os.time()) then
		ply:notify("You are still temporarily banned from taking a job.")
		nut.log.addRaw(ply:Name().." tried to get assigned to a job "..job.." but was still banned")
		return
	end
	if(char:getVar("curJob")) then
		ply:notify("You currently have a job and cannot take another.")
		nut.log.addRaw(ply:Name().." tried to get assigned to job "..job.." but they already have one")
		return
	end
	if(self.jobTypes[job].requireCheck and !self.jobTypes[job].requireCheck(char)) then
		nut.log.addRaw(ply:Name().." tried to join job "..job.." but did not have the requirements for it")
		return --notif inside that
	end
	ply:notify("You are now clocked into the "..self.jobTypes[job].name.." job.")

	nut.log.addRaw(ply:Name().." successfully assigned to job "..job)

	char:setData("jobUnsafe")
	char:setData("tempJobBan")
	char:setData("jobCheckCount")
	char:setVar("curJob", job)
	char:setVar("jobCheck", CurTime()+self.jobTypes[job].pay.time)
end

function PLUGIN:checkInJob(char, terminalcheck)
	local job = char:getVar("curJob")
	char:setVar("jobCheck", CurTime()+self.jobTypes[job].pay.time)
	if(terminalcheck) then
		char:setData("jobCheckCount", char:getData("jobCheckCount", 0)+1)
		if(char:getData("jobCheckCount", 0) < 3) then	
			nut.log.addRaw(char:getName().." terminal checked in their job "..job.." with check count "..char:getData("jobCheckCount", 0))
			char:getPlayer():notify("You have used "..char:getData("jobCheckCount", 0).." of 3 consecutive check ins.")
		elseif(char:getData("jobCheckCount", 0) == 3) then
			nut.log.addRaw(char:getName().." terminal checked in their job "..job.." with check count "..char:getData("jobCheckCount", 0))
			char:getPlayer():notify("You have 1 consecutive check in remaining. Do your actual job or on the next check in you will be kicked from the job and receive a temporary ban (2 hrs) from all jobs.")
		elseif(char:getData("jobCheckCount", 0) == 4) then
			nut.log.addRaw(char:getName().." terminal checked in their job "..job.." with check count "..char:getData("jobCheckCount", 0).." and now have a temp ban")
			char:getPlayer():notify("You have been kicked from the job and will unable to be able to get another for two hours. You have also lost 3 ticks worth of pay from your bank.")
			self:kickFromJob(char)
			char:setData("tempJobBan", os.time()+7200)
			char:setData("jobSafe", math.max(char:getData("jobSafe", 0)-(self.jobTypes[job].amt*3), 0))
		end
	else
		char:setData("jobCheckCount") --reset if they do their job
		nut.log.addRaw(char:getName().." did normal check in at their job "..job)
		char:getPlayer():notify("You have performed your job and the check in timer has been reset.")
	end
end

function PLUGIN:checkoutCheck(char)
	return char:getVar("jobCheck", 0) >= CurTime()
end
function PLUGIN:payCheck(char, checkagainst, nopay)
	if(nopay) then return false end
	return char:getVar("jobTick", 0) >= checkagainst
end

--reset jobtick in this
function PLUGIN:addToBank(char)
	local money = nut.traits.getMod(char:getPlayer(), "jobmoney", self.jobTypes[char:getVar("curJob","")].pay.amt)
	nut.log.addRaw(char:getName().." got added money "..money.." to bank because of job ")

	char:setVar("jobTick")
	money = money + char:getData("jobSafe", 0) --woops
	char:setData("jobSafe", money)
end

function PLUGIN:givePay(char)
	nut.log.addRaw(char:getName().." withdraw banked tokens of "..char:getData("jobSafe", 0))
	char:giveMoney(char:getData("jobSafe", 0))
	char:getPlayer():notify("You have recieved "..nut.currency.get(char:getData("jobSafe", 0)).." from the terminal")
	char:setData("jobSafe")
end

function PLUGIN:kickFromJob(char)
	if(!char:getVar("curJob")) then return end
	if(self:payCheck(char, self.jobTypes[char:getVar("curJob")].pay.paytick)) then
		self:addToBank(char)
	end

	nut.log.addRaw(char:getName().." left job "..char:getData("curJob", ""))
	char:setVar("curJob")
	char:setData("jobUnsafe") --idk wtf this is tbh
	--char:setData("tempJobBan")
	char:setData("jobCheckCount")
	char:setVar("jobCheck")
	char:setVar("jobTick")

end

if(SERVER) then
	hook.Add("OnPlayerInteractItem", "takeitem", function(ply, action, item)
		if(ply:getChar():getVar("curJob", "") == "janitor") then
			if(action == "take" and item.entity and item.entity.temp) then
				local tbl = ply:getChar():getVar("janitems", {})
				tbl[item.id] = true
				ply:getChar():setVar("janitems", tbl)
				PLUGIN:checkInJob(ply:getChar())
			elseif(action == "drop") then
				local tbl = ply:getChar():getVar("janitems", {})
				tbl[item.id] = nil
				ply:getChar():setVar("janitems", tbl)
			end
		end
	end)


	hook.Add("OnCraftFinish", "jobstuff", function(ply, recipe)
		if(ply:getChar():getVar("curJob", "") == "craft" and recipe.jobRequire) then --special thing for this
			PLUGIN:checkInJob(ply:getChar())
			print("success")
		end
	end)

	hook.Add("OnPlayerHeal", "uhbothlmao", function(client, target, amount, seconds)
		if(client != target and client:getChar():getVar("curJob", "") == "medical") then
			PLUGIN:checkInJob(client:getChar())

		end
	end)

	netstream.Hook("jobStart", function(client, job)
		if(client:getChar():getVar("curJob")) then return end --just double checking

		PLUGIN:assignToJob(client:getChar(), job)
	end)
	netstream.Hook("jobCheck", function(client)
		if(client:getChar():getVar("curJob")) then
			PLUGIN:checkInJob(client:getChar(), true)
		end
	end)
	netstream.Hook("jobLeave", function(client)
		local job = client:getChar():getVar("curJob")
		if(job) then
			PLUGIN:kickFromJob(client:getChar())
			client:notify("You have left the job "..PLUGIN.jobTypes[job].name)
			--possibly if they abuse this or something, give a temp ban of the length left of their check period?
			--if they rejoin to get around this, move everything to dates instead
		end
	end)
	netstream.Hook("jobBankCheck", function(client)
		client:notify("Your current balance is "..nut.currency.get(client:getChar():getData("jobSafe", 0)))
	end)
	netstream.Hook("jobBankWithdraw", function(client)
		PLUGIN:givePay(client:getChar())
	end)
	netstream.Hook("jobCheckTime", function(client)
		local secLeft = client:getChar():getVar("jobCheck", 0) - CurTime()
		local ti = string.FormattedTime(secLeft)
		client:notify("You have "..ti.h.." hours, "..ti.m.." minutes, and "..ti.s.." seconds until you are kicked from your current job. Doing your job will reset the timer. You have approximately "..(PLUGIN.jobTypes[client:getChar():getVar("curJob")].pay.paytick - client:getChar():getVar("jobTick", 0)).." minutes left until the next pay tick.")
	end)

	hook.Add("OnCharDisconnect", "chardis", function(ply, char)
		PLUGIN:kickFromJob(char)
	end)

	hook.Add("InitializedPlugins", "jobinit", function()
		--start check here, timer for like 60 i guess?
		timer.Create("jobCheckTimer", 60, 0, function()
			local plys = player.GetAll()
			for k,v in pairs(plys) do
				local char = v:getChar()
				if(!char or char:getFaction() != FACTION_CITIZEN or !char:getVar("curJob") or !PLUGIN.jobTypes[char:getVar("curJob")]) then continue end

				char:setVar("jobTick", char:getVar("jobTick", 0)+1)

				if(PLUGIN:checkoutCheck(char)) then
					local job = PLUGIN.jobTypes[char:getVar("curJob")]
					if(PLUGIN:payCheck(char, job.pay.paytick, job.nopay)) then
						PLUGIN:addToBank(char)
					end
				else
					if(char:getVar("jobWarning")) then
						local job = char:getVar("curJob")
						PLUGIN:kickFromJob(char)
						v:notify("You have been kicked from the job "..PLUGIN.jobTypes[job].name.." for inactivity")
					else
						local job = char:getVar("curJob")
						char:setVar("jobCheck", CurTime()+PLUGIN.jobTypes[job].pay.time)
						char:setVar("jobWarning", true)
						v:notify("You need to do your job, or check in at the job's terminal or you may get kicked from the job and recent previous earnings may be revoked.")
					end
				end
			end
		end)
	end)
end