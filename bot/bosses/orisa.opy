#!mainFile "../../main.opy"

globalvar DISASTER_ORISA_ATK_POS = []

rule "[bot/orisa.opy]: Behavior":
    @Event eachPlayer
    @Hero orisa
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.ORISA_DEFENDER))

    createBossName(eventPlayer, Icon.EXCLAMATION_MARK, abilityIconString(Hero.ORISA, Button.ULTIMATE), Color.LIME_GREEN)

    eventPlayer.startForcingName("OR15-A")
    eventPlayer.setDamageDealt(250)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startScalingSize(1.5, false)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_CROUCH_SPAM = false

    for eventPlayer.playerIndex in range(0, 5, 1):
        createEffect(getAllPlayers() if DISASTER_ORISA_ATK_POS != [] else [], Effect.RING, Color.RED, DISASTER_ORISA_ATK_POS[evalOnce(eventPlayer.playerIndex)], evalOnce(5), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

        createEffect(getAllPlayers() if DISASTER_ORISA_ATK_POS != [] else [], Effect.BAD_AURA, Color.ROSE, DISASTER_ORISA_ATK_POS[evalOnce(eventPlayer.playerIndex)] + Vector.UP, evalOnce(1), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

    createEffect(getAllPlayers(), Effect.WINSTON_PRIMAL_RAGE, Team.2, eventPlayer, evalOnce(1), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    applyCustomHealthWithMaxHealthFor(eventPlayer, getBossHealth() / 2, getBossHealth() / 4, 0, 750)

    while eventPlayer.isAlive():
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.setAbilityCooldown(Button.ABILITY_1, min(eventPlayer.getAbilityCooldown(Button.ABILITY_1), 0)) 
                eventPlayer.BOT_ABILITY_1_ENABLED = true if not eventPlayer.isUsingAbility1() and eventPlayer.getNormalizedHealth() < 0.5 else false
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if not eventPlayer.isFiringSecondaryFire() and eventPlayer.BOT_PLAYER.getNormalizedHealth() < 0.5 else false
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                EXECUTE_ULTIMATE_DEFLECT()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/zeus.opy]: Javelin Spin Projectiles":
    @Event eachPlayer
    @Hero orisa
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.ORISA_DEFENDER))

    while eventPlayer.isAlive():
        waitUntil(eventPlayer.isUsingAbility2() or not entityExists(eventPlayer.BOT_PLAYER), 9999)

        DISASTER_ORISA_ATK_POS = [player.getPosition() for player in getPlayers(Team.1)]

        wait(1)
        for eventPlayer.playerIndex in range(0, 100, 1):
            createProjectile(Projectile.ORISA_FUSION_DRIVER, eventPlayer, random.choice(DISASTER_ORISA_ATK_POS) + (Vector.UP * 4) + (Vector.LEFT * random.uniform(-5, 5)) + (Vector.FORWARD * random.uniform(-5, 5)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 30, 1, 2, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, 0, 10, 1, 0, 0, 30)
            wait(0.016)

        DISASTER_ORISA_ATK_POS = []

        wait(3)