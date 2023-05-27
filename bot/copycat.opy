#!mainFile "../main.opy"

subroutine applyCopycatState

def applyCopycatState():
    wait(1)
    eventPlayer.startForcingName("Copycat")
    eventPlayer.startModifyingVoicelinePitch(sin(getTotalTimeElapsed() * 50), true)

    if disasterReady:
        createEffect(getAllPlayers(), Effect.ECHO_CLONING, Team.2, eventPlayer, 1, EffectReeval.VISIBILITY_AND_COLOR)
        allocateEffect()
        allocatePlayerEffect(eventPlayer)
        applyCustomHealthFor(eventPlayer, eventPlayer.getMaxHealth() / 2, 0, eventPlayer.getMaxHealth() / 2)

        if eventPlayer.getCurrentHero() in [Hero.MOIRA, Hero.KIRIKO, Hero.LIFEWEAVER]:
            while not eventPlayer.isFiringSecondaryFire() and entityExists(eventPlayer):
                eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
                wait(1)
        else:
            while not eventPlayer.isFiringPrimaryFire() and entityExists(eventPlayer):
                eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
                wait(1)

rule "[bot/echo.opy]: Echo Behavior":
    @Event eachPlayer
    @Hero echo
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.COPYCAT))

    eventPlayer.preloadHero(DISASTER_COPYCAT_DUPLICATE_HERO)

    cleanupDisasterPlayerEffects(eventPlayer)

    wait(0.032)

    eventPlayer.startForcingName("Copycat")
    eventPlayer.setUltCharge(100)
    eventPlayer.stopModifyingVoicelinePitch()
    eventPlayer.setDamageDealt(100)

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
                eventPlayer.BOT_ABILITY_1_ENABLED = true
                eventPlayer.BOT_JUMP_ENABLED = true if eventPlayer.isInAir() else false

                if eventPlayer.BOT_PLAYER.getNormalizedHealth() < 0.5 and not eventPlayer.isUsingAbility2():
                    PRESS_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
            else:
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
        else:
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/copycat.opy] Switch to Duplicated Character":
    @Event eachPlayer
    @Hero echo
    @Condition hasDisasterTag(getDisasterId(disasters.COPYCAT))
    @Condition eventPlayer.getHeroOfDuplication() != null

    RESET_TO_IDLE()

    async(applyCopycatState, AsyncBehavior.RESTART)

    wait(0.016)
    eventPlayer.startForcingHero(DISASTER_COPYCAT_DUPLICATE_HERO)