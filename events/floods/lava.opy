#!mainFile "../../main.opy"

globalvar DISASTER_LAVA_Y_POS

rule "[events/lava.opy] Disaster Initialization":
    @Condition disasters.LAVA[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_LAVA_Y_POS = getGroundLevel()

    createEffect(localPlayer, Effect.SPHERE, Color.RED, vect(localPlayer.getPosition().x, DISASTER_LAVA_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasters.LAVA[disasterData.ID] in activeDisasters and DISASTER_LAVA_Y_POS < getHighestLevel():
        DISASTER_LAVA_Y_POS += 0.064
        wait(0.08)

rule "[events/lava.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.LAVA[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition playerIsBelowWaterLevel(eventPlayer, DISASTER_LAVA_Y_POS, -1.5)

    wait(0.032, Wait.ABORT_WHEN_FALSE)

    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)

    eventPlayer.startDoT(null, 1, 50)

    wait(1)

    if RULE_CONDITION: goto RULE_START

    eventPlayer.clearStatusEffect(Status.BURNING)