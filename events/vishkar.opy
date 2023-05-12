#!mainFile "../main.opy"

rule "[events/vishkar.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.VISHKAR) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.VISHKAR))

    for disasterIndex in range(0, dummyBotLimit / 2, 1):
        createDummy(Hero.SYMMETRA, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.VISHKAR))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    for disasterIndex in range(0, dummyBotLimit / 2, 1):
        createDummy(Hero.LIFEWEAVER, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.VISHKAR))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)