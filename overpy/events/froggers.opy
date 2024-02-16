#!mainFile "../main.opy"

rule "[events/froggers.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.FROGGERS) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.FROGGERS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.LUCIO, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.FROGGERS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.LUCIO, Team.2).setUltCharge(90)