#!mainFile "../main.opy"

#!define DISASTER_BLACK_HOLE_CENTER (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.BLACK_HOLE)))

#!define DISASTER_BLACK_HOLE_EFFECT() \
createProjectileEffect(getAllPlayers(), Projectile.ZARYA_GRAVITON, getPlayers(Team.1), DISASTER_BLACK_HOLE_CENTER + (Vector.UP * 3), getClosestPlayer(DISASTER_BLACK_HOLE_CENTER, Team.1), evalOnce(0.25), ProjectileEffectReeval.VISIBILITY_POSITION_DIRECTION_AND_SIZE)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.RING, Color.PURPLE, DISASTER_BLACK_HOLE_CENTER, evalOnce(3), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.RING, Color.VIOLET, DISASTER_BLACK_HOLE_CENTER, evalOnce(10), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createIcon(localPlayer if not localPlayer.isInViewAngle(DISASTER_BLACK_HOLE_CENTER, 90) else null, DISASTER_BLACK_HOLE_CENTER, Icon.SPIRAL, IconReeval.VISIBILITY_AND_POSITION, Color.VIOLET, true)\
allocateEffect()\
\
createInWorldText(localPlayer if localPlayer.isInViewAngle(DISASTER_BLACK_HOLE_CENTER, 90) else null, abilityIconString(Hero.ZARYA, Button.ULTIMATE), DISASTER_BLACK_HOLE_CENTER + (Vector.UP * 2.75), 3, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)\
allocateText()\

rule "[events/black_hole.opy] Disaster Initialization":
    @Condition disasters.BLACK_HOLE[disasterData.ID] in activeDisasters
    @Condition disasterReady

    waitForEntitySpawnFlag(getDisasterId(disasters.BLACK_HOLE))

    if disasterFlags.HARDCORE in activeDisasterFlags:
        activeDisasterEntitySpawning += 1
        for disasterIndex in range(0, dummyBotLimit / 2, 1):
            createDummy(Hero.ZARYA, Team.2, -1, dummyBotSpawn(25), null)
            allocateDummyBotTag(getDisasterId(disasters.BLACK_HOLE))

    DISASTER_BLACK_HOLE_CENTER = random.choice(getSpawnPoints(Team.ALL)).getPosition()

    DISASTER_BLACK_HOLE_EFFECT()

    while disasters.BLACK_HOLE[disasterData.ID] in activeDisasters:
        DISASTER_BLACK_HOLE_CENTER += (directionTowards(DISASTER_BLACK_HOLE_CENTER, sorted(getPlayersInMatch(), lambda player: distance(player.getPosition(), DISASTER_BLACK_HOLE_CENTER)).getPosition()) / 8)
        
        damage(getPlayersInRadius(DISASTER_BLACK_HOLE_CENTER, 3, Team.1, LosCheck.OFF), null, 25)

        wait(0.032)

rule "[events/black_hole.opy] Disaster Impulse":
    @Event eachPlayer
    @Team 1
    @Condition disasters.BLACK_HOLE[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition distance(eventPlayer.getPosition(), DISASTER_BLACK_HOLE_CENTER) < 10

    eventPlayer.startAcceleration(directionTowards(eventPlayer.getPosition(), DISASTER_BLACK_HOLE_CENTER), 20, 100, Relativity.TO_WORLD, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)

    waitUntil(distance(eventPlayer.getPosition(), DISASTER_BLACK_HOLE_CENTER) > 10 or not disasterReady, 9999)

    eventPlayer.stopAcceleration()

    wait(0.016)
    if RULE_CONDITION: goto RULE_START