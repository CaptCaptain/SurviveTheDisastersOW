#!mainFile "../main.opy"

rule "[events/moth.opy] Disaster Initialization":
    @Condition disasters.MOTHS[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.MOTHS[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.MERCY, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.MOTHS[disasterData.ID])
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)