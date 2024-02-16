#!mainFile "../../main.opy"

#!define DISASTER_ACID_Y_POS (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.ACID)))

rule "[events/acid.opy] Disaster Initialization":
    @Condition disasters.ACID[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_ACID_Y_POS = getGroundLevel()
    FLOOD_TIME = getTotalTimeElapsed()

    createEffect(localPlayer, Effect.SPHERE, Color.GREEN, vect(localPlayer.getPosition().x, DISASTER_ACID_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    createEffect(localPlayer if playerIsBelowWaterLevel(localPlayer, DISASTER_ACID_Y_POS, -1.5) else null, Effect.LUCIO_SOUND_BARRIER_PROTECTED, Team.1, localPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    createEffect(localPlayer if playerIsBelowWaterLevel(localPlayer, DISASTER_ACID_Y_POS, -1.5) else null, Effect.LUCIO_SOUND_BARRIER_PROTECTED_SOUND, Team.1, localPlayer, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasters.ACID[disasterData.ID] in activeDisasters and DISASTER_ACID_Y_POS < getHighestLevel():
        DISASTER_ACID_Y_POS += 0.064
        wait(0.08)

rule "[events/acid.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.ACID[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition playerIsBelowWaterLevel(eventPlayer, DISASTER_ACID_Y_POS, -1.5)

    wait(0.032, Wait.ABORT_WHEN_FALSE)

    eventPlayer.startDoT(null, 1, 50 + getFloodDamageBonus())

    wait(1)

    if RULE_CONDITION: goto RULE_START