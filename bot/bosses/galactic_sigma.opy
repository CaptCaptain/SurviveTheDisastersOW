#!mainFile "../../main.opy"

globalvar DISASTER_GALACTIC_SIGMA_ATK_POS = []

rule "[bot/galactic_sigma.opy]: Behavior":
    @Event eachPlayer
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.VIOLET, true)
    allocateEffect()

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.SIGMA, Button.ULTIMATE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.VIOLET, SpecVisibility.DEFAULT)
    allocateText()

    createEffect(getAllPlayers(), Effect.RING, Color.VIOLET, eventPlayer, 3, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    eventPlayer.startForcingName("Galactic Emperor")
    eventPlayer.setDamageDealt(250)
    eventPlayer.setDamageReceived(50)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startScalingSize(1.5, false)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_CROUCH_SPAM = false

    createEffect(getAllPlayers(), Effect.WRECKING_BALL_ADAPTIVE_SHIELD_TARGET, Team.2, updateEveryTick(evalOnce(eventPlayer).getEyePosition()), evalOnce(1), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    applyCustomHealthFor(eventPlayer, getBossHealth() / 2, 0, getBossHealth() / 2)

    while eventPlayer.isAlive():
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        PRESS_PRIMARY_FIRE()
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_OFFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/galactic_sigma.opy]: Kinetic Grasp Projectiles":
    @Event eachPlayer
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    @Condition eventPlayer.isUsingAbility1()

    for eventPlayer.playerIndex in range(0, 5, 1):
        createEffect(getAllPlayers() if DISASTER_GALACTIC_SIGMA_ATK_POS != [] else [], Effect.RING, Color.RED, DISASTER_GALACTIC_SIGMA_ATK_POS[evalOnce(eventPlayer.playerIndex)], evalOnce(5), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

        createEffect(getAllPlayers() if DISASTER_GALACTIC_SIGMA_ATK_POS != [] else [], Effect.LUCIO_SOUND_BARRIER_PROTECTED, Team.2, DISASTER_GALACTIC_SIGMA_ATK_POS[evalOnce(eventPlayer.playerIndex)], evalOnce(1), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

    while eventPlayer.isAlive():
        waitUntil(eventPlayer.isUsingAbility1(), 9999)

        DISASTER_GALACTIC_SIGMA_ATK_POS = [player.getPosition() for player in getPlayers(Team.1)]

        wait(1)
        for eventPlayer.playerIndex in range(0, 100, 1):
            createProjectile(Projectile.RAMATTRA_RAVENOUS_VORTEX_SPHERE, eventPlayer, random.choice(DISASTER_GALACTIC_SIGMA_ATK_POS) + (Vector.UP * 4) + (Vector.LEFT * random.uniform(-5, 5)) + (Vector.FORWARD * random.uniform(-5, 5)), Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.DAMAGE, Team.1, 30, 1, 2, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION_SOUND, 0, 10, 1, 0, 0, 30)
            wait(0.016)
        
        waitUntil(not eventPlayer.isUsingAbility1(), 9999)

        DISASTER_GALACTIC_SIGMA_ATK_POS = []

rule "[bot/galactic_sigma.opy]: Gravitic Flux Charge / Kinetic Grasp Behavior":
    @Event eachPlayer
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    
    while true:
        waitUntil(not eventPlayer.isUsingUltimate(), 9999)
        eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 5)

        if not entityExists(eventPlayer.BOT_PLAYER):
            eventPlayer.forceButtonPress(Button.ABILITY_1)
            eventPlayer.setAbilityCooldown(Button.ABILITY_1, min(eventPlayer.getAbilityCooldown(Button.ABILITY_1), 6))

        wait(1)

rule "[bot/galactic_sigma.opy]: Gravitic Flux":
    @Event playerDealtDamage
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    @Condition eventAbility == Button.ULTIMATE

    if victim.hasStatusEffect(Status.HACKED):
        victim.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
    
    victim.setStatusEffect(eventPlayer, Status.HACKED, 3)