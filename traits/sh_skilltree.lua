--[[new idea: 
	after a certain level in a skill, 
	on the trait menu a button becomes available
	and you can then click it to get a derma request which lets you
	pick from a skill (pick from one)
]]
local skills = {
	--[[
	["id"] = {
		levels = {  --levels to add a skill point at
			[1] = true, --can be true or number
		},
		picks = { 
			--picks available and the number of picks needed to choose each
			--use . to denote level that should be given
			--should technically be compatible with non-level ids too, as
			--not including it should make it nil
			["id2.1"] = 1,
		},
		picknames = { --friendlier names to display on buttons
			["id2.1"] = "",
		}
	},
	]]
}
--return levels for that num == add a level up pick
function PLUGIN:LevelupCheck(name, num)

end

if(SERVER) then			--orig skill, number of points to remove, new skill
	netstream.Hook("LevelupSkill", function(client, orig, add)
		local pick = client:getChar():getData("traitlevelups")
		if(!pick[orig]) then return end --just in case?
		local rem = skills[orig].picks[add]
		pick[orig] = pick[orig] - rem
		if(pick[orig] <= 0) then
			pick[orig] = nil
		end

		local spl = string.Split(add, ".")
		nut.traits.setTrait(client, spl[1], nil, tonumber(spl[2]))

		client:getChar():setData("traitlevelups", pick)

		client:notify("Skill "..skills[orig].picknames[add].." picked successfully.")
	end)
end

--get picks for name (id), only 4 at once (for now) but 
--prob wont need more than that lol
--[1] = {name = "", id = ""},
function PLUGIN:GetSkillChoiceForSkill(name)

end