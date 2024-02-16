#!mainFile "../main.opy"

#!define DISASTER_GET_DOWN_Y_POS (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.GET_DOWN)))
#!define DISASTER_GET_DOWN_RZ_POS (getDisasterVariable(disasterVariables_2, getDisasterId(disasters.GET_DOWN)))

#!define DISASTER_GET_DOWN_WORLD_VECTOR worldVector(vect(0, 0, DISASTER_GET_DOWN_RZ_POS), localPlayer, Transform.ROTATION_AND_TRANSLATION)

#!define CREATE_DISASTER_GET_DOWN_EFFECT()\
createEffect(localPlayer, Effect.SPHERE, Color.RED, vect(DISASTER_GET_DOWN_WORLD_VECTOR.x, DISASTER_GET_DOWN_Y_POS + 198, DISASTER_GET_DOWN_WORLD_VECTOR.z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(localPlayer, Effect.LIGHT_SHAFT, Color.RED, vect(DISASTER_GET_DOWN_WORLD_VECTOR.x, DISASTER_GET_DOWN_Y_POS, DISASTER_GET_DOWN_WORLD_VECTOR.z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\

rule "[events/get_down.opy] Disaster Initialization":
    @Condition disasters.GET_DOWN[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_GET_DOWN_RZ_POS = 500
    DISASTER_GET_DOWN_Y_POS = (nearestWalkablePosition(random.choice(getSpawnPoints(Team.ALL)).getPosition() + (Vector.DOWN * 100)) + (Vector.UP * 5)).y

    CREATE_DISASTER_GET_DOWN_EFFECT()
    CREATE_DISASTER_GET_DOWN_EFFECT()

    onScreenText(localPlayer if DISASTER_GET_DOWN_Y_POS < localPlayer.getEyePosition().y else null, "{0}                {0}".format(iconString(Icon.WARNING)), 0, 0.12, 3, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.NEVER)
    allocateText()

    while disasters.GET_DOWN[disasterData.ID] in activeDisasters:
        DISASTER_GET_DOWN_RZ_POS -= 4
        wait(0.032)

rule "[events/flood.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.GET_DOWN[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition DISASTER_GET_DOWN_RZ_POS < 200 and DISASTER_GET_DOWN_RZ_POS > -200
    @Condition DISASTER_GET_DOWN_Y_POS < eventPlayer.getEyePosition().y

    wait(0.125, Wait.ABORT_WHEN_FALSE)

    damage(eventPlayer, null, Math.INFINITY)

    if RULE_CONDITION: goto RULE_START