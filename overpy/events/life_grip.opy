#!mainFile "../main.opy"

rule "[events/life_grip.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.LIFE_GRIP) in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.LIFE_GRIP))

    createDummy(Hero.LIFEWEAVER, Team.1, 6, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
    allocateDummyBotTag(getDisasterId(disasters.LIFE_GRIP))
    applyEntityFlag(allocatedDummyBot, botFlags.RESPAWNABLE_NO_LOS)
    allocatedDummyBot.BOT_DISABLE_AI = true
    allocatedDummyBot.setStatusEffect(null, Status.PHASED_OUT, Math.INFINITY)
    allocatedDummyBot.setInvisibility(Invis.ALL)
    allocatedDummyBot.setHealingDealt(0)

    #!define lifeGripper getPlayers(Team.1)[disasterIndex]
    #!define validLifeGripTargets getPlayersInRadius(lifeGripper.getEyePosition(), 30, Team.1, LosCheck.SURFACES).exclude(lifeGripper)

    while disasterReady:
        for disasterIndex in range(0, len(getPlayers(Team.1)), 1):
            if hasDisasterTag(lifeGripper, getDisasterId(disasters.LIFE_GRIP)):
                lifeGripper.teleport(dummyBotSpawn(20))
                lifeGripper.setAbilityCooldown(Button.ABILITY_2, 0)
                lifeGripper.startFacing(directionTowards(evalOnce(lifeGripper).getEyePosition(), evalOnce(random.choice(validLifeGripTargets)).getEyePosition()), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
                wait(0.032)
                lifeGripper.forceButtonPress(Button.ABILITY_2)
                waitUntil(not lifeGripper.isUsingAbility2(), 9999)
                [player for player in getPlayers(Team.1) if player.hasStatusEffect(Status.ROOTED) and player.hasStatusEffect(Status.INVINCIBLE)].setStatusEffect(null, Status.HACKED, 2)
        wait(1)

    destroyAllDummies()