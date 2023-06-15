#!mainFile "../main.opy"

globalvar DISASTER_JUNKERS_POOL

rule "[events/junkers.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.JUNKERS) in activeDisasters
    @Condition disasterReady

    DISASTER_JUNKERS_POOL = [Hero.JUNKER_QUEEN, Hero.ROADHOG, Hero.JUNKRAT].exclude(random.choice([Hero.JUNKER_QUEEN, Hero.ROADHOG, Hero.JUNKRAT]))
    
    waitForEntitySpawnFlag(getDisasterId(disasters.JUNKERS))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(DISASTER_JUNKERS_POOL, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(getDisasterId(disasters.JUNKERS))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)