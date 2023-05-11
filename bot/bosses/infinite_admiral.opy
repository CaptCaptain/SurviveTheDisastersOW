#!mainFile "../../main.opy"

rule "[bot/infinite_admiral.opy]: Sojourn Behavior":
    @Event eachPlayer
    @Hero sojourn
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.RED, true)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.SOJOURN, Button.ULTIMATE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.RED, SpecVisibility.DEFAULT)
    allocateText()
    allocatePlayerText(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, Color.RED, eventPlayer, 1.5, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    eventPlayer.startForcingName("Infinite Admiral")
    eventPlayer.setDamageReceived(50)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setDamageDealt(150)
    eventPlayer.setUltCharge(100)

    applyCustomHealthFor(eventPlayer, getBossHealth() / 10, 0, 0)

    eventPlayer.disableRespawn()

    while eventPlayer.isAlive():
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 5 else false     
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_OFFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                        if eventPlayer.isUsingAbility1():
                            eventPlayer.forceButtonPress(Button.JUMP)
                        break
                break
        
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/infinite_admiral.opy]: Overclock Charge":
    @Event eachPlayer
    @Hero sojourn
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    
    while true:
        eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 5)
        wait(1)

rule "[bot/infinite_admiral.opy]: Sojourn Death Behavior":
    @Event playerDied
    @Hero sojourn
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    startDialogueOnce(1, [[Hero.SOJOURN, random.choice(["This won't be the end...", "(dying sounds)"]), 1]], sky)
    waitUntil(is_dialoguing == false, 9999)

    wait(1)

    cleanupDisasterPlayerEffects(eventPlayer)
    cleanupDisasterPlayerTexts(eventPlayer)

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    destroyDummy(dialogue_bot.getTeam(), dialogue_bot.getSlot())