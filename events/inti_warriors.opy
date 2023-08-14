#!mainFile "../main.opy"

rule "[events/inti_warriors.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.INTI_WARRIORS) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.INTI_WARRIORS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.ILLARI, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.INTI_WARRIORS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.ILLARI, Team.2).setUltCharge(90)