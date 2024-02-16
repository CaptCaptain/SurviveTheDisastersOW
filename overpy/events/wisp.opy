#!mainFile "../main.opy"

rule "[events/wisp.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.WISP) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.WISP))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.TRACER, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.WISP))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)