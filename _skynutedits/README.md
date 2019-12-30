# skynutedits
this is a collection of changes/small modifications ive done and just put into a single plugin

a list of contents:
- preventing of jumping when out of stamina
- jumping reduces stamina
- complete hiding of the persist (has completely broken servers of mine in the past when someones accidentally used it, so i dont trust it anymore), drive, and bonemanipulate properties, and prevents using the edit entity property if not an admin
- a thing for setting a model as female (even if the model doesnt have female in the name), and a command to do it, the modified isFemale function in the newchar plugin is needed for this
- a thing to autokill map entities named "music", and other music/sound entities specifically on rp_stalker_redux (the triggers that turn the music back on, and stops the thunder/lightning off in the distance)
- automatically disabling the c menu in tfa (as i used item based attachments, but this is a part of a larger system that i wont release publicly due to the huge setup required for it)
- disabling player sprays (not entirely sure if this is needed but i left it anyway)
- setting npcs to not drop their weapons when they die
- automatically hiding the crosshair unless using the physgun (its null when using it for some reason, the toolgun, or any nut_ weapon)
- a player disconnected log
- a player death log (not rly needed now i think?)
- kinda shitty anticheat thats probably massively outdated that i found in a gamemode that was given to me (but its actually gotten people a few times lmao)
- a new pac event that changes depending on if your weapon is lowered/raised
- a bind prevention hook that prevents you from using binds unless they have some whitelisted commands in them (some of which arent in this), also a thing to prevent you from suit zooming (again via binds at least) unless you have an item called binoculars
- prevented char switching while in a vehicle/sitting or tied (if you switch chars while in a vehicle (sitting is technically a vehicle), youll be at that same spot on the new char)

- an unused quiz system (like clockwork), have not used with ns2 but with multichar plugin modification should work? uses evolve for kicking on fail but can be modified for other admin suites
- an unused weight system (to be used along side the grid system), this is also not tested with ns2, but might work with it? idk, probably with some modifications