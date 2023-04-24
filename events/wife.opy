#!mainFile "../main.opy"

rule "[events/wife.opy] Disaster Initialization":
    @Condition disasters.WIFELEAVER[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.WIFELEAVER[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.LIFEWEAVER, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.WIFELEAVER[disasterData.ID])