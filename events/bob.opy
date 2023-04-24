#!mainFile "../main.opy"

rule "[events/minefield.opy] Disaster Initialization":
    @Condition disasters.BOB[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.BOB[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.ASHE, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.BOB[disasterData.ID])