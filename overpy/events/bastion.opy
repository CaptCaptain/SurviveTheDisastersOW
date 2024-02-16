#!mainFile "../main.opy"

rule "[events/bastion.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.FLYING_BASTION) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.FLYING_BASTION))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.BASTION, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.FLYING_BASTION))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.BASTION, Team.2).setUltCharge(90)