#!mainFile "../main.opy"

rule "[events/pharamercy.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.PHARAMERCY) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.PHARAMERCY))

    for disasterIndex in range(0, dummyBotLimit / 2, 1):
        createDummy(Hero.PHARAH, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.PHARAMERCY))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    for disasterIndex in range(0, dummyBotLimit / 2, 1):
        createDummy(Hero.MERCY, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.PHARAMERCY))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)