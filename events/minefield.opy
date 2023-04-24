#!mainFile "../main.opy"

rule "[events/minefield.opy] Disaster Initialization":
    @Condition disasters.MINEFIELD[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.MINEFIELD[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.HAMMOND, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.MINEFIELD[disasterData.ID])