## pda
this is a stalker-based pda plugin
- it includes various kinds of chat commands and an interactable pda (its main use is to set your pda handle but it can be modified to add other menus)
- this is the image i used for the pda background: https://vignette.wikia.nocookie.net/stalker/images/d/dd/Ui_pda_eng.png 
in the code this is assumed to be at materials/sky/ui_pda_eng.png, however feel free to put it somewhere else, just make sure to change it (line 34 in derma/cl_pda.lua)
- also pdafaction needs to be config'd to your schema's factions if you want to use it (commenting out the pdafac chattype in plugin and the pdafaction command in commands will remove it)

list of pda channels:
- pdalocal: the global chat of the pda, everyone who has one can see this
- pdapm: allows you to pm other pda handles
- pdatrade: an optional channel, meant for advertising and such
- pdabroad/pdanotif: a global broadcast channel, only characters with the Z (sysadmin i called it) flag can use this
- pdaparty: a leftover from the runs plugin, allows you to chat with only your party remembers while in a run
- pdafaction: a special channel that allows you to only talk with members of your faction, the factionChans table above it denotes the displayed name of the faction depending on the faction index (FACTION_DUTY was 1 for me so its DUTY, etc). by default it also prevents usage by loners (meant for stalker, obvi this wont do anything if a FACTION_LONER doesnt exist)