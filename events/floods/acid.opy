#!mainFile "../../main.opy"

globalvar DISASTER_ACID_Y_POS

rule "[events/acid.opy] Disaster Initialization":
    @Condition disasters.ACID[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_ACID_Y_POS = getGroundLevel()

    createEffect(localPlayer, Effect.SPHERE, Color.GREEN, vect(localPlayer.getPosition().x, DISASTER_ACID_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    createEffect(localPlayer if playerIsBelowWaterLevel(localPlayer, DISASTER_ACID_Y_POS, -1.5) else null, Effect.LUCIO_SOUND_BARRIER_PROTECTED, Team.1, localPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    createEffect(localPlayer if playerIsBelowWaterLevel(localPlayer, DISASTER_ACID_Y_POS, -1.5) else null, Effect.LUCIO_SOUND_BARRIER_PROTECTED_SOUND, Team.1, localPlayer, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasters.ACID[disasterData.ID] in activeDisasters:
        DISASTER_ACID_Y_POS += 0.032
        wait(0.128)

rule "[events/acid.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.ACID[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition playerIsBelowWaterLevel(eventPlayer, DISASTER_ACID_Y_POS, -1.5)

    eventPlayer.startDoT(null, 1, 50)

    wait(1)

    if RULE_CONDITION: goto RULE_START