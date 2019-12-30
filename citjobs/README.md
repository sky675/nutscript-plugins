# citjobs
some interactable jobs, built for hl2rp but can be used with other things i guess

requires the traits plugin, *BUT* can be modified to not need it, shouldnt be that hard :)

the basic job tutorial:
1. sign in to your job using the terminal for it
2. do the action thats specified with the job. if you dont do it in a certain amount of time (different depending on the job), you get kicked out of the job and need to go sign in again. you can also check into the job manually using the terminal, in order to not be kicked out. however if you do this 3 times in a row you'll get kicked out and then banned from taking another job for 2 hours.

there are 4 jobs, one of which went untested and unused (but might work?), and one that requires the crafting plugin.
- medical worker: in order to keep in this job, you need to heal people. as a result, the check in time for this job is 30 minutes.
- industrial worker: **REQUIRES CRAFTING**, the default crafting plugin includes whats necessary for this.
this also should be used with (but does not require) the depots plugin.
in order to do this job, there are 3 workbenches, (the work Workbenches), you need to take a scrap, and go through each of the workbenches in order to eventually make it into a metal plate.
- office worker: this uses the office worker terminal **(it uses a neotokyo model, so might need to change that)** when you use the terminal while having the job, a series of phrases will appear. in order to do the job you need to type these phrases in order into the text box. after this is done, youll need to wait a period of time (60 seconds?) before that terminal can be used again.
- janitor: this is the one that went unused. in order to do this job you need to pick up items around the map (they need to have a temp = true variable on them, loot and depot both already do this, this is also used by the default save items plugin to not save these items on the map), and then turn them into a dropoff point. you dont get a passive pay with this job, you get a reward based off of the items' business prices (all items are turned in at once)