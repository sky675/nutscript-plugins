## traits
a plugin for a traits/skills system

- sort of inspired by chancer's traits plugin in respite (i did this from scratch tho not based on that one)
- has huge capability for effects on custom things and some of the plugins in this directory already have integration for it (shoottorp, bleeding, crafting, to name some)

works via a custom char var so if you use mysql, dont worry about this causing char data from going over the char limit.

dont mind the weird 2 char vars "traits" and "trait" it was a weird and only way to make this work, especially since i converted it to a char var while a server was live.

this also includes a language system built in! it has normal, yell, whisper and radio commands for each language and its fairly easy to add new ones!
check sh_languages.lua for details

there are two ways of normally acquiring new traits/skills outside of char creation:
1. skillbooks, these on use give the specific trait(s), if the character meets the requirements and has no specified conflicting traits
2. skilltree, not really a skilltree, but when you level up specified skills, you gain skillpoints specific for that skill, which you then can use in a dialog to gain a new skill. this was never completely implemented and ***UNTESTED*** so use at your own risk

some notes:
- there are some hardcoded things in the creation code: the default trilingual trait has its functionality hardcoded into there, easiest way to do it
- some of the traits are for specific things that i wont include as they require specific things that are a part of other things i dont want to release, namely the weapon related ones
- for the nonenglish trait, an extra step is required to make this work:
the way i did it for me is i edited the default onChatAdd in the sh_chatbox lib in ns itself, i added this above the chat.AddText line
```
local client = speaker
if(nut.traits and nut.traits.hasTrait(client, "big_nonenglish")) then
	if(chatType == "ic") then
		chat.AddText(color, string.format("%s says in English something you cannot understand.", name))
		return
	end
	if(chatType == "y") then
		chat.AddText(color, string.format("%s yells in English something you cannot understand.", name))
		return
	end
	if(chatType == "w") then
		chat.AddText(color, string.format("%s whispers in English something you cannot understand.", name))
		return
	end
	if(chatType == "radio") then
		chat.AddText(color, string.format("%s says in radio something in English you cannot understand.", name))
		return
	end
	if(chatType == "radiow") then
		chat.AddText(color, string.format("%s whispers in radio something in English you cannot understand.", name))
		return
	end
end
```
im definitely sure theres a better way to do this, but this is what i did at the time and i havent bothered working out a better way to do it.
if you dont want to use this you can just comment out the trait in sh_config.lua.
if you are new and/or are inexperienced with lua and you really want to use it, i would HIGHLY recommend just commenting it out unless you're ok with manually updating the file anytime the main ns repo modifies this file (which honestly i dont see happening, but you never know) or recopying these lines into it each time