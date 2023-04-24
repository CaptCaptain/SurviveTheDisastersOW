#!mainFile "../main.opy"

rule "[events/sombra.opy] Disaster Initialization":
    @Condition disasters.SOMBRA[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.SOMBRA[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.SOMBRA, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.SOMBRA[disasterData.ID])