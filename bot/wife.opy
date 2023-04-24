#!mainFile "../main.opy"

rule "[bot/wife.opy]: Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WIFELEAVER))

    eventPlayer.startForcingName(random.choice(["Rizzweaver", "Lifeweaver", "Wifeleaver", "Peacemaker", ]))

rule "[bot/wife.opy]: Apply Custom Health & Additional Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WIFELEAVER))

    clearCustomHealth()
    eventPlayer.setPrimaryFireEnabled(false)
    #eventPlayer.stopScalingSize()
    eventPlayer.setUltCharge(0)
    eventPlayer.setDamageDealt(400)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1.5)

    wait(0.5)

    eventPlayer.setMaxHealth(25)

    wait(1)

    applyCustomHealthFor(eventPlayer, 50, 0, 50)
    
    # Say Hello / Goodbye
    waitUntil(any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), 9999)

    while eventPlayer.getNormalizedHealth() >= 0.75:
        eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer.getPosition(), Team.1)), Relativity.TO_WORLD)
        eventPlayer.communicate(Comms.HELLO)
        eventPlayer.setStatusEffect(null, Status.ROOTED, 1)

        waitUntil(eventPlayer.getNormalizedHealth() < 0.75, 3)
        wait(0.016)

    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
    eventPlayer.clearStatusEffect(Status.ROOTED)
    #eventPlayer.startScalingSize(1.5, false)
    eventPlayer.setUltCharge(95)

    getPlayersInRadius(eventPlayer.getEyePosition(), 15, Team.2, LosCheck.OFF).setStatusEffect(null, Status.UNKILLABLE, 0.064)
    wait(0.016)
    damage(getPlayersInRadius(eventPlayer.getEyePosition(), 15, Team.2, LosCheck.OFF), null, 30)

    applyCustomHealthFor(eventPlayer, 50, 100, 0)

    createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED, Team.2, eventPlayer, 1, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.ANA_NANO_BOOSTED_SOUND, Team.2, eventPlayer, 100, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    while eventPlayer.isAlive():
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) or eventPlayer.isDead(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.setWeapon(2)
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                        
                        if eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 1:
                            eventPlayer.setAbilityCooldown(Button.ABILITY_1, 1)
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_DEFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                        if eventPlayer.getUltCharge() == 100:
                            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)
    
    waitUntil(eventPlayer.isAlive(), 9999)

    wait(0.016)

    cleanupDisasterPlayerEffects(eventPlayer)

    if RULE_CONDITION: goto RULE_START