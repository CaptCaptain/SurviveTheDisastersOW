#!mainFile "../main.opy"

rule "[events/wayfinders.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.WAYFINDERS) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.WAYFINDERS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.VENTURE, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.WAYFINDERS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.VENTURE, Team.2).setUltCharge(90)