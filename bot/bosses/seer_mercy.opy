#!mainFile "../../main.opy"

rule "[bot/seer_mercy.opy]: Mercy Behavior":
    @Event eachPlayer
    @Hero mercy
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.RED, true)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.MERCY, Button.PRIMARY_FIRE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.RED, SpecVisibility.DEFAULT)
    allocateText()
    allocatePlayerText(eventPlayer)

    createEffect(getAllPlayers(), Effect.RING, Color.RED, eventPlayer, 1.5, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    eventPlayer.startForcingName("Infinite Seer")
    eventPlayer.setHealingDealt(1000)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setHealingReceived(0)

    applyCustomHealthFor(eventPlayer, getBossHealth() / 5, 0, 0)

    eventPlayer.disableRespawn()

    while eventPlayer.isAlive():
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            eventPlayer.setWeapon(1)
            async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getNormalizedHealth() == 1 else false
            eventPlayer.BOT_ABILITY_1_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getPosition()) > 2 else false
            eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
            PRESS_ABILITY_2()
            EXECUTE_ULTIMATE_ABILITY()
        elif entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.setWeapon(2)
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                EXECUTE_ULTIMATE_ABILITY()
        
        UPDATE_MERCY_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/seer_mercy.opy]: Mercy Death Behavior":
    @Event playerDied
    @Hero mercy
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.GALACTIC_SIGMA))

    startDialogueOnce(1, [[Hero.MERCY, random.choice(["I have failed, your excellency...", "(dying sounds)"]), 1]], sky)
    waitUntil(is_dialoguing == false, 9999)

    wait(1)

    cleanupDisasterPlayerEffects(eventPlayer)
    cleanupDisasterPlayerTexts(eventPlayer)

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())
    destroyDummy(dialogue_bot.getTeam(), dialogue_bot.getSlot())