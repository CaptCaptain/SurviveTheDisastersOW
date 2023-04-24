#!mainFile "../main.opy"

rule "[events/murderers.opy] Disaster Initialization":
    @Condition disasters.MURDERERS[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.MURDERERS[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.JUNKER_QUEEN, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.MURDERERS[disasterData.ID])