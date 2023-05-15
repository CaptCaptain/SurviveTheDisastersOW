#!mainFile "../main.opy"

globalvar DISASTER_TRAMPOLINE_Y_POS

rule "[events/death_trampoline.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.DEATH_TRAMPOLINE) in activeDisasters
    @Condition disasterReady

    DISASTER_TRAMPOLINE_Y_POS = getGroundLevel() + 5

    createEffect(localPlayer, Effect.SPHERE, Color.GRAY, vect(localPlayer.getPosition().x, DISASTER_TRAMPOLINE_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasterReady:
        [player for player in getPlayersInMatch() if player.isOnGround()].enableEnvironmentCollision()
        wait(0.25)
        [player for player in getPlayersInMatch() if playerIsBelowWaterLevel(player, DISASTER_TRAMPOLINE_Y_POS, -1.5)].startAcceleration(Vector.UP, 500, Math.INFINITY, Relativity.TO_WORLD, AccelReeval.NONE)
        [player for player in getPlayersInMatch() if playerIsBelowWaterLevel(player, DISASTER_TRAMPOLINE_Y_POS, -1.5)].disableEnvironmentCollision(false)
        wait(0.25)
    
    getPlayers(Team.1).enableEnvironmentCollision()
    getPlayers(Team.1).stopAcceleration()

rule "[events/death_trampoline.opy] Launch Player / Kill Player":
    @Event eachPlayer
    @Team 1
    @Condition getDisasterId(disasters.DEATH_TRAMPOLINE) in activeDisasters
    @Condition disasterReady
    @Condition eventPlayer.getPosition().y > getHighestLevel() + 100

    kill(eventPlayer, null)