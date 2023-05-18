#!mainFile "../main.opy"

rule "[events/witch.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.WITCH) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.WITCH))

    createDummy(Hero.RAMATTRA, Team.2, -1, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
    allocateDummyBotTag(getDisasterId(disasters.WITCH))
    applyEntityFlag(allocatedDummyBot, botFlags.NO_DAMAGE_SCALING)