#!mainFile "../main.opy"

rule "[events/nuclear_bomb.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.NUCLEAR_BOMB) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.NUCLEAR_BOMB))

    if disasterFlags.HARDCORE in activeDisasterFlags:
        for disasterIndex in range(0, dummyBotLimit, 1):
            createDummy(Hero.DVA, Team.2, -1, dummyBotSpawn(25), null)
            allocateDummyBotTag(getDisasterId(disasters.NUCLEAR_BOMB))
    else:
        createDummy(Hero.DVA, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.NUCLEAR_BOMB))