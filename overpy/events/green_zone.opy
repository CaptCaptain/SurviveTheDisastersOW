#!mainFile "../main.opy"

#!define DISASTER_GREEN_ZONE_CENTER (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.GREEN_ZONE)))
#!define DISASTER_GREEN_ZONE_RADIUS (getDisasterVariable(disasterVariables_2, getDisasterId(disasters.GREEN_ZONE)))
#!define DISASTER_GREEN_ZONE_TIME (getDisasterVariable(disasterVariables_3, getDisasterId(disasters.GREEN_ZONE)))

#!define DISASTER_GREEN_ZONE_EFFECT() \
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN, DISASTER_GREEN_ZONE_CENTER + (Vector.UP * 25), DISASTER_GREEN_ZONE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN, DISASTER_GREEN_ZONE_CENTER, DISASTER_GREEN_ZONE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN, DISASTER_GREEN_ZONE_CENTER + (Vector.DOWN * 25), DISASTER_GREEN_ZONE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, DISASTER_GREEN_ZONE_CENTER, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\

rule "[events/green_zone.opy] Disaster Initialization":
    @Condition disasters.GREEN_ZONE[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_GREEN_ZONE_CENTER = random.choice(getSpawnPoints(Team.ALL)).getPosition()
    DISASTER_GREEN_ZONE_RADIUS = 100
    DISASTER_GREEN_ZONE_TIME = getTotalTimeElapsed()

    DISASTER_GREEN_ZONE_EFFECT()

    while disasters.GREEN_ZONE[disasterData.ID] in activeDisasters:
        DISASTER_GREEN_ZONE_RADIUS -= 0.25
        DISASTER_GREEN_ZONE_RADIUS = max(10, DISASTER_GREEN_ZONE_RADIUS)
        wait(0.032)

rule "[events/green_zone.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.GREEN_ZONE[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition distance(eventPlayer.getPosition(), DISASTER_GREEN_ZONE_CENTER) > DISASTER_GREEN_ZONE_RADIUS

    wait(1, Wait.ABORT_WHEN_FALSE)
    
    damage(eventPlayer, null, 20 + ((getTotalTimeElapsed() - DISASTER_GREEN_ZONE_TIME)) * 2)

    if RULE_CONDITION: goto RULE_START