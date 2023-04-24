#!mainFile "../main.opy"

rule "[events/sniper.opy] Disaster Initialization":
    @Condition disasters.SNIPER[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.SNIPER[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy([Hero.WIDOWMAKER, Hero.ASHE], Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.SNIPER[disasterData.ID])