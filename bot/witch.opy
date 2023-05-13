#!mainFile "../main.opy"

enum disasterWitchPotionType:
    POISON,
    FREEZE,
    STUNNED,
    BURNING,

globalvar DISASTER_WITCH_POTION = 0
globalvar DISASTER_WITCH_POTION_POS = 0
globalvar DISASTER_WITCH_POTION_COLOR = rgb(0, 0, 0)
globalvar DISASTER_WITCH_INDEX = 0

rule "[bot/witch.opy]: Potion Behavior":
    @Event eachPlayer
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WITCH))

    eventPlayer.startForcingName("Witch")
    eventPlayer.setMaxHealth(500)
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.disableRespawn()

    createEffect(getAllPlayers(), Effect.ORB, DISASTER_WITCH_POTION_COLOR, DISASTER_WITCH_POTION_POS, evalOnce(1), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, DISASTER_WITCH_POTION_COLOR, DISASTER_WITCH_POTION_POS, evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.CLOUD, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.BAD_AURA, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    while eventPlayer.isAlive():
        wait(1)

        DISASTER_WITCH_POTION = random.choice([disasterWitchPotionType.POISON, disasterWitchPotionType.FREEZE, disasterWitchPotionType.STUNNED, disasterWitchPotionType.BURNING])
        DISASTER_WITCH_POTION_POS = random.choice(getPlayersAlive()).getPosition() + Vector.UP

        switch (DISASTER_WITCH_POTION):
            case disasterWitchPotionType.POISON:
                DISASTER_WITCH_POTION_COLOR = Color.VIOLET

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.VIOLET, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                for DISASTER_WITCH_INDEX in range(0, 50, 1):
                    createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, eventPlayer, DISASTER_WITCH_POTION_POS, Vector.UP + (Vector.LEFT * random.uniform(-1, 1)) + (Vector.FORWARD * random.uniform(-1, 1)), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 30, 1, 2, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0, 10, 1, 0, 0, 30)
                    wait(0.016)

                break
            case disasterWitchPotionType.FREEZE:
                DISASTER_WITCH_POTION_COLOR = Color.SKY_BLUE

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.SKY_BLUE, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                for DISASTER_WITCH_INDEX in range(0, 50, 1):
                    createProjectile(Projectile.MEI_ICICLE, eventPlayer, DISASTER_WITCH_POTION_POS + (Vector.UP * 4) + (Vector.LEFT * random.uniform(-3, 3)) + (Vector.FORWARD * random.uniform(-3, 3)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 30, 1, 2, DynamicEffect.TRACER_RECALL_DISAPPEAR, DynamicEffect.TRACER_RECALL_DISAPPEAR_SOUND, 0, 10, 1, 0, 0, 30)
                    wait(0.016)

                break
            case disasterWitchPotionType.STUNNED:
                DISASTER_WITCH_POTION_COLOR = Color.WHITE

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.WHITE, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, Team.2, DISASTER_WITCH_POTION_POS, 1)
                playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Team.2, DISASTER_WITCH_POTION_POS, 100)

                getPlayersInRadius(DISASTER_WITCH_POTION_POS, 5, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS).setStatusEffect(eventPlayer, Status.STUNNED, 1)

                break
            case disasterWitchPotionType.BURNING:
                DISASTER_WITCH_POTION_COLOR = Color.ORANGE

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Team.2, DISASTER_WITCH_POTION_POS, 1)
                playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Team.2, DISASTER_WITCH_POTION_POS, 100)

                getPlayersInRadius(DISASTER_WITCH_POTION_POS, 20, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS).startDoT(null, 1, 50)
                getPlayersInRadius(DISASTER_WITCH_POTION_POS, 20, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS).setStatusEffect(eventPlayer, Status.BURNING, 1)
                break
    
        wait(1)

    cleanupDisasterPlayerEffects(eventPlayer)

rule "[bot/witch.opy]: Behavior":
    @Event eachPlayer
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WITCH))
    
    waitUntil(eventPlayer.getNormalizedHealth() < 0.75, 9999)
    eventPlayer.BOT_DISABLE_AI = false
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    RESET_TO_IDLE()
    while eventPlayer.isAlive():
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                if eventPlayer.getMaxHealthOfType(Health.ARMOR) > 0:
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if eventPlayer.getNormalizedHealth() < 0.5 else false
                    eventPlayer.BOT_ABILITY_1_ENABLED = false
                else:
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                    eventPlayer.BOT_ABILITY_1_ENABLED = true if (eventPlayer.BOT_PLAYER.getNormalizedHealth() < 0.5 or eventPlayer.getNormalizedHealth() < 0.5) and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 else false
                    EXECUTE_ULTIMATE_ABILITY()

                eventPlayer.BOT_ABILITY_2_ENABLED = true if eventPlayer.BOT_PLAYER.isInAir() else false
                
        waitThrottle(Wait.ABORT_WHEN_FALSE)

rule "[bot/witch.opy]: Behavior":
    @Event playerDealtDamage
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WITCH))

    switch (DISASTER_WITCH_POTION):
        case disasterWitchPotionType.FREEZE:
            victim.setStatusEffect(eventPlayer, Status.FROZEN, 1)
            break
        case disasterWitchPotionType.STUNNED:
            victim.setStatusEffect(eventPlayer, Status.STUNNED, 1)
            break

    wait(2)