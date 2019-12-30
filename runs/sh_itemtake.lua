
if(SERVER) then
	hook.Add("OnPlayerInteractItem", "takeitem", function(ply, action, item)
		if(ply:getChar():getData("activerun")) then
			if(action == "take") then
				local tbl = ply:getChar():getVar("runitems", {})
				tbl[item.id] = true
				ply:getChar():setVar("runitems", tbl)
			elseif(action == "drop") then
				local tbl = ply:getChar():getVar("runitems", {})
				tbl[item.id] = nil
				ply:getChar():setVar("runitems", tbl)
			end
		end
	end)

	hook.Add("PostPlayerDeath", "taketheitem", function(ply)
		if(ply:getChar() and ply:getChar():getVar("runitems")) then
			local items = ply:getChar():getVar("runitems")
			for k,v in pairs(items) do
				local item = nut.item.instances[k]
				if(!item) then continue end
				if(item:getOwner() == ply) then
					item:remove()
				end
			end
			ply:getChar():setVar("runitems")
		end
	end)

	--delete them here too
	hook.Add("OnCharDisconnect", "taketheitem", function(ply, char)
		if(char and char:getVar("runitems")) then
			local items = char:getVar("runitems")
			for k,v in pairs(items) do
				local item = nut.item.instances[k]
				if(!item) then continue end
				if(item:getOwner() == ply) then
					item:remove()
				end
			end
			char:setVar("runitems")
		end
	end)
	--and here
	hook.Add("PlayerLoadedChar", "taketheitem", function(ply, char, lastChar)
		if(lastChar and lastChar:getVar("runitems")) then
			local items = lastChar:getVar("runitems")
			for k,v in pairs(items) do
				local item = nut.item.instances[k]
				if(!item) then continue end
				if(item:getOwner() == ply) then
					item:remove()
				end
			end
			lastChar:setVar("runitems")
		end
	end)
end