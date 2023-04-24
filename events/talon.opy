#!mainFile "../main.opy"

rule "[events/talon.opy] Disaster Initialization":
    @Condition disasters.TALON[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.TALON[disasterData.ID])

    waitUntil(getNumberOfPlayers(Team.2) > 0, 1)
    for disasterIndex in range(0, dummyBotLimit - 1, 1):
        createDummy([Hero.REAPER, Hero.BAPTISTE, Hero.BAPTISTE, Hero.BAPTISTE, Hero.BAPTISTE], Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.TALON[disasterData.ID])