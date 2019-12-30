## needs
a fairly simple hunger + thirst plugin

has integration for my traits plugin but will work fine without it.
also included are some example food items.

at the top of the plugin file, there are variables to change the rate at which you lose hunger or thirst, and the rate at which you take damage from either of those values being at 0.

there are also character mods depending on your hunger/thirst level: at high hunger, you slowly regain hp (default is 1 every 2 mins), at high thrist, you can run longer
<hr>
for the high thirst buff, you can either use the stamina plugin in this repo, or this modification needs to be made to the default stamina plugin:
add these lines in the main timer (i did it after the crouching check, right before it actually modifies stamina):
```
--high needs bonus
if(HIGH_THIRST_THRESHOLD and offset > 0 and character:GetThirst() >= HIGH_THIRST_THRESHOLD) then
	offset = offset*1.1 --slight boost
end
```