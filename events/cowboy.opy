#!mainFile "../main.opy"

rule "[events/cowboy.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.COWBOY) in activeDisasters
    @Condition disasterReady
    
    waitForEntitySpawnFlag(getDisasterId(disasters.COWBOY))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.MCCREE, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.COWBOY))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)