#!mainFile "../main.opy"

rule "[events/crusaders.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.CRUSADERS) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.CRUSADERS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.REINHARDT, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.CRUSADERS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.REINHARDT, Team.2).setUltCharge(90)