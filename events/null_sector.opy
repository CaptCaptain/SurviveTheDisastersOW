#!mainFile "../main.opy"

rule "[events/null_sector.opy] Disaster Initialization":
    @Condition disasters.NULL_SECTOR[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.NULL_SECTOR[disasterData.ID])

    waitUntil(getNumberOfPlayers(Team.2) > 0, 1)
    for disasterIndex in range(0, dummyBotLimit - 1, 1):
        createDummy([Hero.BASTION, Hero.BAPTISTE, Hero.BAPTISTE, Hero.BAPTISTE, Hero.BAPTISTE], Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.NULL_SECTOR[disasterData.ID])