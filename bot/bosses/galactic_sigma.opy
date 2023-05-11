#!mainFile "../../main.opy"

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

    setMatchTime(min(1, getMatchTime()))

rule "[bot/galactic_sigma.opy]: Kinetic Grasp Projectiles":
    @Event eachPlayer
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    @Condition eventPlayer.isUsingAbility1()

    while eventPlayer.isUsingAbility1():
        createHomingProjectile(Projectile.ZARYA_GRAVITON, eventPlayer, null, Vector.FORWARD + (Vector.UP * random.uniform(-1, 1)) + (Vector.LEFT * random.uniform(-1, 1)), Relativity.TO_PLAYER, ModifyHealth.DAMAGE, Team.1, 10, 1, 1, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, 0, 30, 5, 3, getClosestPlayer(eventPlayer.getPosition(), Team.1), 1)
        wait(0.032)

rule "[bot/galactic_sigma.opy]: Gravitic Flux Charge":
    @Event eachPlayer
    @Hero sigma
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    
    while true:
        waitUntil(not eventPlayer.isUsingUltimate(), 9999)
        eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 5)
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