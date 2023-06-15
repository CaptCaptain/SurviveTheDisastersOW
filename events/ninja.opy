#!mainFile "../main.opy"

#!define DISASTER_NINJA_POOL (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.NINJA)))

rule "[events/ninja.opy] Disaster Initialization":
    @Condition disasters.NINJA[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_NINJA_POOL = [Hero.KIRIKO, Hero.GENJI, Hero.HANZO].exclude(random.choice([Hero.KIRIKO, Hero.GENJI]))

    waitForEntitySpawnFlag(disasters.NINJA[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(DISASTER_NINJA_POOL, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.NINJA[disasterData.ID])
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)

    wait(1)
    if disasterFlags.HARDCORE in activeDisasterFlags:
        getPlayersOnHero(Hero.GENJI, Team.2).setUltCharge(95)