#!mainFile "../main.opy"

#!define DISASTER_TRAMPOLINE_Y_POS (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.DEATH_TRAMPOLINE)))
playervar DISASTER_TRAMPOLINED

rule "[events/death_trampoline.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.DEATH_TRAMPOLINE) in activeDisasters
    @Condition disasterReady

    DISASTER_TRAMPOLINE_Y_POS = getGroundLevel() + 5

    createEffect(localPlayer, Effect.SPHERE, Color.GRAY, vect(localPlayer.getPosition().x, DISASTER_TRAMPOLINE_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasterReady:
        [player for player in getPlayersInMatch() if player.isOnGround()].enableEnvironmentCollision()

        waitUntil(not disasterReady, 0.25)

        [player for player in getPlayersAlive() if playerIsBelowWaterLevel(player, DISASTER_TRAMPOLINE_Y_POS, -1.5)].startAcceleration(Vector.UP, 500, Math.INFINITY, Relativity.TO_WORLD, AccelReeval.NONE)

        [player for player in getPlayersAlive() if playerIsBelowWaterLevel(player, DISASTER_TRAMPOLINE_Y_POS, -1.5)].DISASTER_TRAMPOLINED = true

        [player for player in getPlayersAlive() if playerIsBelowWaterLevel(player, DISASTER_TRAMPOLINE_Y_POS, -1.5)].disableEnvironmentCollision(false)

        [player for player in getPlayersInMatch() if player.isDead()].stopAcceleration()

        [player for player in getPlayersInMatch() if player.isDead()].enableEnvironmentCollision()

        waitUntil(not disasterReady, 0.25)
        wait(0.016)
    
    getPlayers(Team.1).stopAcceleration()
    getPlayers(Team.1).enableEnvironmentCollision()
    [player for player in getPlayers(Team.1) if player.DISASTER_TRAMPOLINED].respawn()
    getPlayers(Team.1).DISASTER_TRAMPOLINED = false

rule "[events/death_trampoline.opy] Launch Player / Kill Player":
    @Event eachPlayer
    @Team 1
    @Condition getDisasterId(disasters.DEATH_TRAMPOLINE) in activeDisasters
    @Condition disasterReady
    
    waitUntil(eventPlayer.getPosition().y > getHighestLevel() + 100 or not disasterReady, 9999)
    if eventPlayer.getPosition().y > getHighestLevel() + 100:
        kill(eventPlayer, null)

    waitUntil(eventPlayer.isAlive(), 9999)
    eventPlayer.stopAcceleration()
    eventPlayer.enableEnvironmentCollision()