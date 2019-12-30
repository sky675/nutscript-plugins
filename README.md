##Plugins for NS2
here are some nutscript plugins meant for the latest nutscript 2/1.1-beta version (as of 12/29/2019, but it should be fine with any later versions provided they dont make any huge changes)

these are provided as is, but should be (relatively) bug free
you can do whatever you want with them
i just ask you to 1. not sell/put them up as your own creations, and 2. keep the author variables as is, or at least not remove anything already in there, thanks

nearly all of these are designed to work off of each other, but you should be able to edit out most of these instances of it referencing another plugin if you arent using that plugin
the only one that actually checks if you have that plugin is the crafting plugin, in which it checks for the traits plugin

MANY of these plugins don't use default hl2/ep2/css models/mats/sounds, some of which are rare/custom (not easily available), so i recommend for you to go through and change models you dont have.

finally, as i said before, these are provided as is, i will NOT offer any kind of support for these, you're on your own but they should work (no promises lmao)

<hr>

there are some more advanced plugins here that require extra/map-based setup and/or base ns modification, these are:
- autoevents
- hacking
- runs
- shoottorp
- traits
- newchar (not technically a plugin but still)
there are also some ***UNTESTED*** plugins here that i thought id include because im about 99% sure theyll work, these are:
- autoevents
- bountyboard
- lives

<hr>

you will find information about each folder plugin inside it's folder, here is information on each of the single file plugins (and a library):

#bleeding
a simple bleeding plugin.
you can toggle whether bleeding is on via the "bleed" config option under server
there is shoottorp and traits integration, but (should) work fine without either (provided you delete said references)
you can reduce bleed by using: 
`hook.Run("ReduceBleed", char, amt)`
with char being the character that should have their bleed reduced
and amt being the amount to multiply the bleeding by (the lower the number, the faster it bleeds)
it has its own bar with the id of "bleed"
see shoottorp for medical item examples for use with this

mechanics:
- higher values make you bleed slower
- if the value reaches 3, the bleed will be removed (if you want to change this value, you can change it via the local minbleed variable at the top of the file)
- the ticking for bleeding slows while the player is typing, unless they have the nut data "typeImm" or the config option for it (bleedtypeimm) is disabled. shoottorp has a command to set typeImm on players (and an additional use for it), but its not necessary

#dynamusic
a (relatively) simple dynamic music plugin.
it has two states: passive and active.
active plays whenever an npc has you as their enemy, youve taken damage, a hook from a file that i havent converted to a plugin yet was ran, or you overrid the value to always be active. after 12 seconds of no actions that cause it to switch to active, it switches back to passive.
passive plays in all other instances.

there are a handful of customizations and settings for this:
- you can toggle it via `nut_dynamusic 1` or the "Toggle Dynamic Music" button in the quick menu (its off by default)
- you can play specific sound/music to people that have it enabled by using the `/playdynamusic` command
- you can override the plugin to only play a specific state by using the `nut_dynaoverride` convar. the following values are accepted: -2 - the default value, normal state. -1 - disables automatic music but will play music played via the `/playdynamusic` command. 0 - forces it into passive state. 1 - forces it into active state.
- you can select what music pack you want to play (and it even implements some dynamic music mods' packs automatically)
- you can create your own music packs (see the halflife2 example in the plugin, place it above/below that in the same table that one is in)
- it will automatically detect and make available any nombat packs you have installed locally (provided they are formatted correctly with a* and c* file names)
- it will also automatically detect and create packs (1 per combat music type detected) for dynamo music packs, however this needs at least 1 ambient and 1 of one combat music type (the one i initially downloaded to test only had combat music, so make sure to be sure you have at least one of both kinds), it also creates a pack that combines all the combat music into one

#lives
an automated, customizable, lives system, check the plugin for more info

#obsitemesp
a very simple item esp for observer.
it lets you see where items are while in observer, it has an option on the quick menu to toggle this.

#sh_newchar
this is NOT a plugin, this was implemented as a library, so it should go in your schema under schema/libs/

this is a bunch of (sometimes janky) utility stuff used to support seperated models on player (ex the actual player model being a head, while the body is bonemerged on, this does this automatically)

there is example implementation in shoottorp, and can be used in items there
there are also config variables in the file that should probably be changed (the models used by default in the file arent on the workshop and for now wont be, however the heads built for it are :) feel free to find them)

also highly recommended to use with this are the f1menu and multichar plugins, as these are modified versions of those plugins that add newchar support for them