#!mainFile "../main.opy"

rule "[events/tiktok.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.TIKTOK) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.TIKTOK))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.MOIRA, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.TIKTOK))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)