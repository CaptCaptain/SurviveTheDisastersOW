#!mainFile "../main.opy"

rule "[events/climatologist.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.CLIMATOLOGIST) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.CLIMATOLOGIST))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.MEI, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.CLIMATOLOGIST))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.MEI, Team.2).setUltCharge(90)