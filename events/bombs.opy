#!mainFile "../main.opy"

rule "[events/bombs.opy] Disaster Initialization":
    @Condition disasters.BOMBS[disasterData.ID] in activeDisasters
    @Condition disasterReady

    while disasters.BOMBS[disasterData.ID] in activeDisasters:
        createProjectile(Projectile.PHARAH_ROCKET, null, dummyBotSpawnAny(10) + vect(0, 50, 0), vect(0, -1, 0), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 100, 1, 3, DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0, 50, 3, 0, 0, 50)
        wait(0.5)