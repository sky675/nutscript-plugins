#hacking
this is a plugin that allows players to do "hacks" on specified types of entities, uses traits plugin. i dont think anything else is required but i may be wrong

requires special config for hacking entities on the map,
check the different tables in the plugin to see how to do this

explanation of hacking:
using a function on the tool, or /hackmenu, a ui opens
on the left is a list of all the hackable entities nearby, and the right is related to the hack youve chosen
the stuff on the left is fairly self explanatory
once you select an entity on the left, a top bar gets added on the right, here you can choose what type of hack to do on this entity (sometimes there is only one, and some are gated behind skill level)
the other dropdown on the left is your programs, if you have any installed (they are items that you can install by dragging onto your hacktool, i only made 2, they arent always actives tho)
next two different panels get made below this are the actual hacking minigames
the left you use to start the minigame and after its started, get more time, its a simon says kind of game, wait for the combination to finish flashing, and then enter in the combination into the numpad (by clicking, actual numpad wont work)
with the right the combination at the top flashes its numbers periodically, and you need to pick the correct combination of the options below it (the minigame is based off the hacking minigame seen in shadowrun: hong kong, i intended for multiple types of left/right minigames that would be picked randomly independent of each other, but never did it)
picking the wrong combination reduces the time left (i dont remember by what amount), and if you run out of time the hack fails, for most hacks you can just do it again but some may have fail effects or only one chance (see customhackbase ents)
picking the right combination, of course, completes the hack and does the specified effect