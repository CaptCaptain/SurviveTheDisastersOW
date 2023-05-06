#!mainFile "../main.opy"

enum disasterWitchPotionType:
    POISON,
    FREEZE

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
    eventPlayer.setMaxHealth(200)
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.disableRespawn()

    createEffect(getAllPlayers(), Effect.ORB, DISASTER_WITCH_POTION_COLOR, DISASTER_WITCH_POTION_POS, evalOnce(1), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.RING, DISASTER_WITCH_POTION_COLOR, DISASTER_WITCH_POTION_POS, evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.RING, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.CLOUD, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.BAD_AURA, DISASTER_WITCH_POTION_COLOR, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.isMoving() else eventPlayer.getPosition(), evalOnce(3), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()

    while eventPlayer.isAlive():
        DISASTER_WITCH_POTION = random.choice([disasterWitchPotionType.POISON, disasterWitchPotionType.FREEZE])
        wait(1)

        DISASTER_WITCH_POTION_POS = dummyBotSpawn(5) + Vector.UP

        switch (DISASTER_WITCH_POTION):
            case disasterWitchPotionType.POISON:
                DISASTER_WITCH_POTION_COLOR = Color.VIOLET

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.VIOLET, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                for DISASTER_WITCH_INDEX in range(0, 50, 1):
                    createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, eventPlayer, DISASTER_WITCH_POTION_POS, Vector.UP + (Vector.LEFT * random.uniform(-1, 1)) + (Vector.FORWARD * random.uniform(-1, 1)), Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 25, 1, 2, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0, 10, 1, 0, 0, 30)
                    wait(0.016)

                break
            case disasterWitchPotionType.FREEZE:
                DISASTER_WITCH_POTION_COLOR = Color.SKY_BLUE

                playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.SKY_BLUE, DISASTER_WITCH_POTION_POS, 2)

                wait(1)

                for DISASTER_WITCH_INDEX in range(0, 50, 1):
                    createProjectile(Projectile.MEI_ICICLE, eventPlayer, DISASTER_WITCH_POTION_POS + (Vector.UP * 4) + (Vector.LEFT * random.uniform(-3, 3)) + (Vector.FORWARD * random.uniform(-3, 3)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.ALL, 25, 1, 2, DynamicEffect.TRACER_RECALL_DISAPPEAR, DynamicEffect.TRACER_RECALL_DISAPPEAR_SOUND, 0, 10, 1, 0, 0, 30)
                    wait(0.016)

                break
    
        wait(1)

rule "[bot/witch.opy]: Behavior":
    @Event eachPlayer
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WITCH))
    
    waitUntil(eventPlayer.getNormalizedHealth() < 1, 9999)
    eventPlayer.BOT_DISABLE_AI = false
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    RESET_TO_IDLE()
    while eventPlayer.isAlive():
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) and eventPlayer.isAlive(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
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

                        break
                break
        waitThrottle(Wait.ABORT_WHEN_FALSE)

rule "[bot/witch.opy]: Behavior":
    @Event playerDealtDamage
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WITCH))
    @Condition eventPlayer.BOT_DISABLE_AI == true

    switch (DISASTER_WITCH_POTION):
        case disasterWitchPotionType.FREEZE:
            victim.setStatusEffect(eventPlayer, Status.FROZEN, 1)
            break