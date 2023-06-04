#!mainFile "../main.opy"

globalvar DISASTER_SNIPER_POOL

rule "[events/sniper.opy] Disaster Initialization":
    @Condition disasters.SNIPER[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_SNIPER_POOL = [Hero.WIDOWMAKER, Hero.ASHE, Hero.ANA].exclude(random.choice([Hero.WIDOWMAKER, Hero.ASHE, Hero.ANA]))

    waitForEntitySpawnFlag(disasters.SNIPER[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(DISASTER_SNIPER_POOL, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.SNIPER[disasterData.ID])
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)