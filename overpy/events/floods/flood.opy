#!mainFile "../../main.opy"

#!define DISASTER_FLOOD_Y_POS (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.FLOOD)))

rule "[events/flood.opy] Disaster Initialization":
    @Condition disasters.FLOOD[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_FLOOD_Y_POS = getGroundLevel()
    FLOOD_TIME = getTotalTimeElapsed()

    createEffect(localPlayer, Effect.SPHERE, Color.BLUE, vect(localPlayer.getPosition().x, DISASTER_FLOOD_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasters.FLOOD[disasterData.ID] in activeDisasters and DISASTER_FLOOD_Y_POS < getHighestLevel():
        createProjectile(Projectile.SYMMETRA_PHOTON_PROJECTOR, null, dummyBotSpawnAny(10) + vect(0, 50, 0), vect(0, -1, 0), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.2, 0, 0, 0, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, 0, 50, 3, 0, 0, 50)
        DISASTER_FLOOD_Y_POS += 0.064
        wait(0.08)

rule "[events/flood.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.FLOOD[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition playerIsBelowWaterLevel(eventPlayer, DISASTER_FLOOD_Y_POS, 0)

    wait(0.032, Wait.ABORT_WHEN_FALSE)

    damage(eventPlayer, null, 50 + getFloodDamageBonus())

    wait(1)

    if RULE_CONDITION: goto RULE_START