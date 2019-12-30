## runs
this is a gigantic plugin (mainly because of the config) that creates off-map randomly generated runs. this however requires these areas to be made with the map (when i used this, i made custom versions of the maps we used that added in these areas). this also requires the loot plugin, and a lot of functions rely on vj base functionality (but may work without it? idk)

i personally do not recommend using this because of the effort needed to set it up and the need for a custom map, and recommend using autoevents instead (its a simpler version of this that generates things inside the map that dont need to be accepted, it couples with the bountyboard plugin to make objectives like the run objectives, in theory at least, it was never actually tested lol), but i included this anyway as someone might get something from this idk

<hr>

heres an as-simple-as-i-possibly-can overview of how this works:
- all the runs are accepted from run_runterminal (there is an alternate version called run_terminalcmb, it uses an alternate version of a run (in the schema this was used in, it was like a vr training kinda thing for combine, users would get money for completing runs, however unlike normal runs, no loot will spawn (besides dropped loot from dead enemies using the loot plugin)))
- after you accept it, you can hold e on other players to invite them to your run. it scales the more players you have so more players == more enemies and more loot
- next, you go to the run_mainbus entity and hold e on it. you can select a difficulty (the higher the difficulty the better the loot spawns, but enemies have higher hp, the highest difficulty has a chance to use a special loot table, where super rare loot can spawn sometimes)
- inside the actual run, what you need to do depends on the objective of the run. there are 4 main objectives: kill all, kill target, collect item, and an unused defend machine objective (should still work but went untested in the last schema this was used in)
  - kill all: kill all enemies on the map to win
  - kill target: when you accept the run, youll get via a pda message (you should get one regardless if you have the pda plugin or not, it doesnt check for a pda anymore, however this functionality can be readded, look for fakepdapm in sh_plugin and uncomment the first line in that function)
  - collect item: a special item will spawn within the area, the objective is to take the item, leave, and turn it into a run_dropoff entity
  - defend machine: a special machine will spawn somewhere within the run, find the machine (a server from neotokyo), activate it, and defend it from waves of reinforcements until it completes. if it gets destroyed (by you or attacking npcs), 
- after the objective is completed, youll get another pm saying so, then you can leave and go back to the run terminal to turn it in. 
- by default you get no reward, unless youre using the cmb terminal, which youll get a money reward from