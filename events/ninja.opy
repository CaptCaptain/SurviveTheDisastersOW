#!mainFile "../main.opy"

rule "[events/ninja.opy] Disaster Initialization":
    @Condition disasters.NINJA[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.NINJA[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy([Hero.KIRIKO, Hero.GENJI], Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.NINJA[disasterData.ID])