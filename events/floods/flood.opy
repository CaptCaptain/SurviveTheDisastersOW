#!mainFile "../../main.opy"

globalvar DISASTER_FLOOD_Y_POS

rule "[events/flood.opy] Disaster Initialization":
    @Condition disasters.FLOOD[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_FLOOD_Y_POS = getGroundLevel()

    createEffect(localPlayer, Effect.SPHERE, Color.BLUE, vect(localPlayer.getPosition().x, DISASTER_FLOOD_Y_POS - 198, localPlayer.getPosition().z), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while disasters.FLOOD[disasterData.ID] in activeDisasters:
        createProjectile(Projectile.SYMMETRA_PHOTON_PROJECTOR, null, dummyBotSpawnAny(10) + vect(0, 50, 0), vect(0, -1, 0), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 0, 0, 0, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, 0, 50, 3, 0, 0, 50)
        DISASTER_FLOOD_Y_POS += 0.032
        wait(0.128)

rule "[events/flood.opy] Disaster Damage":
    @Event eachPlayer
    @Team 1
    @Condition disasters.FLOOD[disasterData.ID] in activeDisasters
    @Condition disasterReady
    @Condition playerIsBelowWaterLevel(eventPlayer, DISASTER_FLOOD_Y_POS, 0)

    damage(eventPlayer, null, 50)

    wait(1)

    if RULE_CONDITION: goto RULE_START