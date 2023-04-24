#!mainFile "../main.opy"

rule "[events/acid_rain.opy] Disaster Initialization":
    @Condition disasters.ACID_RAIN[disasterData.ID] in activeDisasters
    @Condition disasterReady

    while disasters.ACID_RAIN[disasterData.ID] in activeDisasters:
        createProjectile(Projectile.GENJI_SHURIKEN, null, dummyBotSpawnAny(10) + vect(0, 50, 0), vect(0, -1, 0), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 10, 1, 3, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0, 50, 3, 0, 0, 50)
        wait(0.064)