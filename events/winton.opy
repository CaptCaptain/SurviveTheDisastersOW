#!mainFile "../main.opy"

rule "[events/winton.opy] Disaster Initialization":
    @Condition disasters.WINTON[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.WINTON[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.WINSTON, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.WINTON[disasterData.ID])
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)