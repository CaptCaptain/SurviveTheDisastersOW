#!mainFile "../../main.opy"

rule "[bot/space_prince.opy]: Space Prince Behavior":
    @Event eachPlayer
    @Hero lucio
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.GREEN, true)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.LUCIO, Button.ABILITY_1)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.GREEN, SpecVisibility.DEFAULT)
    allocateText()
    allocatePlayerText(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, eventPlayer, 1.5, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    eventPlayer.startForcingName("Space Prince")
    eventPlayer.setHealingDealt(1000)
    eventPlayer.setHealingReceived(0)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setUltCharge(100)

    PRESS_ABILITY_1()

    applyCustomHealthFor(eventPlayer, getBossHealth() / 10, 0, 0)

    eventPlayer.disableRespawn()

    while eventPlayer.isAlive():
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer, eventPlayer.BOT_PLAYER) < 8 else false              
                        EXECUTE_DEFENSE_ABILITY_2()
                        if getPlayersOnHero(Hero.SIGMA, Team.2)[0].getNormalizedHealth() < 0.5:
                            EXECUTE_ULTIMATE_ABILITY()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/space_prince.opy]: Beat Charge":
    @Event eachPlayer
    @Hero lucio
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))
    
    while true:
        eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 5)
        wait(1)

rule "[bot/space_prince.opy]: Lucio Death Behavior":
    @Event playerDied
    @Hero lucio
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    wait(1)

    cleanupDisasterPlayerEffects(eventPlayer)
    cleanupDisasterPlayerTexts(eventPlayer)

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    destroyDummy(dialogue_bot.getTeam(), dialogue_bot.getSlot())