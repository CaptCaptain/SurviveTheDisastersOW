#!mainFile "../main.opy"

rule "[bot/talon.opy]: Doomfist Behavior":
    @Event eachPlayer
    @Hero doomfist
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.TALON))

    eventPlayer.HEALTH_NORMAL = getNumberOfLivingPlayers(Team.1) * 500
    eventPlayer.startScalingSize(1.5, false)

    wait(1)
    applyCustomHealth()

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.RED, true)
    allocateEffect()

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.RED, SpecVisibility.DEFAULT)
    allocateText()

    createEffect(getAllPlayers(), Effect.RING, Color.RED, eventPlayer, 3, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    while eventPlayer.isAlive():
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if not eventPlayer.isUsingUltimate() and not eventPlayer.isFiringSecondaryFire() else false
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0 and not eventPlayer.isFiringSecondaryFire() else false
                        eventPlayer.setAmmo(0, 4)
                        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 2 if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 2 else eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE))
                        
                        EXECUTE_OFFENSE_ABILITY_1()
                        if not eventPlayer.isUsingAbility2():
                            EXECUTE_DEFENSE_ABILITY_2()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Team.1, eventPlayer, 50)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.stopFacing()
    cleanupDisasterPlayerEffects(eventPlayer)

    if len(activeDisasters) == 1:
        setMatchTime(min(5, getMatchTime()))

rule "[bot/talon.opy]: Trooper Behavior":
    @Event eachPlayer
    @Hero baptiste
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.TALON))

    eventPlayer.startForcingName("Trooper")
    eventPlayer.HEALTH_NORMAL = 150

    wait(1)
    applyCustomHealth()

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/talon.opy]: Shotgunner Behavior":
    @Event eachPlayer
    @Hero reaper
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.TALON))

    eventPlayer.startForcingName("Shotgunner")
    eventPlayer.HEALTH_NORMAL = 250
    eventPlayer.setMoveSpeed(50)

    wait(1)
    applyCustomHealth()

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)