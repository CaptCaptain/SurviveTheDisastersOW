#!mainFile "../main.opy"

rule "[events/kamehameha.opy] Disaster Initialization":
    @Condition disasters.KAME[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.KAME[disasterData.ID])

    createDummy(Hero.MOIRA, Team.2, -1, dummyBotSpawn(25), null)
    allocateDummyBotTag(disasters.KAME[disasterData.ID])