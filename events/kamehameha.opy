#!mainFile "../main.opy"

rule "[events/kamehameha.opy] Disaster Initialization":
    @Condition disasters.KAME[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(disasters.KAME[disasterData.ID])

    if disasterFlags.HARDCORE in activeDisasterFlags:
        for disasterIndex in range(0, dummyBotLimit, 1):
            createDummy(Hero.MOIRA, Team.2, -1, dummyBotSpawn(25), null)
            allocateDummyBotTag(getDisasterId(disasters.KAME))
            wait(1)
    else:
        createDummy(Hero.MOIRA, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.KAME))