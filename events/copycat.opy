#!mainFile "../main.opy"

globalvar DISASTER_COPYCAT_DUPLICATE_HERO

rule "[events/copycat.opy] Disaster Initialization":
    @Condition disasters.COPYCAT[disasterData.ID] in activeDisasters
    @Condition disasterReady

    if len(getPlayersInMatch()) > 0:
        DISASTER_COPYCAT_DUPLICATE_HERO = random.choice([player.getCurrentHero() for player in getPlayersInMatch()])
    else:
        DISASTER_COPYCAT_DUPLICATE_HERO = random.choice(getAllHeroes())
    
    waitForEntitySpawnFlag(disasters.COPYCAT[disasterData.ID])

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.ECHO, Team.2, -1, dummyBotSpawn(25), null)
        allocateDummyBotTag(disasters.COPYCAT[disasterData.ID])
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)