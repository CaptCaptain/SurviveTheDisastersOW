#!mainFile "../../main.opy"

rule "[bot/royal_captain.opy]: Sojourn Behavior":
    @Event eachPlayer
    @Hero brigitte
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.ORANGE, true)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.BRIGITTE, Button.ULTIMATE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.ORANGE, SpecVisibility.DEFAULT)
    allocateText()
    allocatePlayerText(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, eventPlayer, 1.5, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    eventPlayer.startForcingName("Royal Captain")
    eventPlayer.setDamageReceived(50)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setHealingReceived(0)
    eventPlayer.setDamageDealt(250)
    eventPlayer.setHealingDealt(500)
    eventPlayer.setUltCharge(100)

    applyCustomHealthFor(eventPlayer, getBossHealth() / 10, 0, 0)

    eventPlayer.disableRespawn()

    while eventPlayer.isAlive():
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            case true:
                async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
                PRESS_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                break
            default:
                switch entityExists(eventPlayer.BOT_PLAYER):
                    case true:
                        switch eventPlayer.BOT_PLAYER.isAlive():
                            case true:
                                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true if (eventPlayer.getAbilityCooldown(Button.PRIMARY_FIRE) == 0 and distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) < 6) or not eventPlayer.BOT_SECONDARY_FIRE_ENABLED else false
                                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 6 else false
                                EXECUTE_OFFENSE_ABILITY_1()
                                EXECUTE_ULTIMATE_ABILITY()
                                break
                        break
                break
        switch eventPlayer.getAbilityCharge(Button.ABILITY_2) > 0:
            case true:
                UPDATE_BOT_TEAMMATE()
                break
            default:
                eventPlayer.BOT_OVERRIDE_FACING_PLAYER = false
                break
            
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/royal_captain.opy]: Brigitte Death Behavior":
    @Event playerDied
    @Hero brigitte
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    startDialogueOnce(1, [[Hero.BRIGITTE, random.choice(["I have failed my duty...", "(dying sounds)"]), 1]], sky)
    waitUntil(is_dialoguing == false, 9999)

    wait(1)

    cleanupDisasterPlayerEffects(eventPlayer)
    cleanupDisasterPlayerTexts(eventPlayer)

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    destroyDummy(dialogue_bot.getTeam(), dialogue_bot.getSlot())