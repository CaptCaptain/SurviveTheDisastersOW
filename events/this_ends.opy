#!mainFile "../main.opy"

rule "[events/this_ends.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.THIS_ENDS) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.THIS_ENDS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.SOJOURN, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.THIS_ENDS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)