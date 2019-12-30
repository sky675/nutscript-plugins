# autoevents
this is an ***UNTESTED*** new version of the run plugin, that changes it to be "events" inside the map, that just spawn on their own and dont require accepting.
this is designed to be used with bountyboard, as some bounty board jobs are created when autoevents are created
i never got around to actually setting up areas for this, however there are some example event types there, and setting up areas is about the same as setting up areas for runs, but instead of defining the objectives in the area, theyre seperate and you just specify what types are valid for each area
the example event types include:
- mutant attack: areas with this as a valid obj and having players in them have a chance of spawning a "mutant attack" event, where specified npcs travel into the area (typically attacking the people inside the area)
- bandit camp: areas with this as a valid obj and not having players in them have the chance of spawning a "bandit camp" event, where some npcs are automatically spawned in this area along with loot, there is also a random chance for a special bountyboard job to be created in relation to one of the enemies that spawn (see the bountyboard plugin for more info)
there are configs for disabling spawning and a max number of active events
there is also an admin command for disabling a certain area from spawning things at there (like if someone wants to use that area for their own event, but they dont want to worry about the system spawning an event there (as they dont consider players in noclip as players))
