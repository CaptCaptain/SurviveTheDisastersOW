#!mainFile "../main.opy"

rule "[events/life_grip.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.LIFE_GRIP) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.LIFE_GRIP))

    for disasterIndex in range(0, dummyBotLimit, 1):
        createDummy(Hero.LIFEWEAVER, Team.1, disasterIndex + 6, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
        allocateDummyBotTag(getDisasterId(disasters.LIFE_GRIP))
        applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)
        allocatedDummyBot.BOT_DISABLE_AI = true
        allocatedDummyBot.setStatusEffect(null, Status.PHASED_OUT, Math.INFINITY)
        allocatedDummyBot.setInvisibility(Invis.ALL)

    #!define lifeGripper getPlayers(Team.1)[disasterIndex]
    #!define validLifeGripTargets getPlayersInRadius(lifeGripper.getEyePosition(), 30, Team.1, LosCheck.SURFACES).exclude([player for player in getPlayers(Team.1) if not hasDisasterTag(player, disasters.LIFE_GRIP)])

    while disasterReady:
        for disasterIndex in range(0, len(getPlayers(Team.1)), 1):
            if hasDisasterTag(lifeGripper, getDisasterId(disasters.LIFE_GRIP)):
                lifeGripper.setAbilityCooldown(Button.ABILITY_2, 0)
                lifeGripper.startFacing(directionTowards(evalOnce(lifeGripper).getEyePosition(), evalOnce(random.choice(validLifeGripTargets)).getEyePosition()), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
                lifeGripper.forceButtonPress(Button.ABILITY_2)
        wait(0.5)

    destroyAllDummies()