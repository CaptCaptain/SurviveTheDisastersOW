#!mainFile "../main.opy"

rule "[bot/sombra.opy]: Behavior":
    @Event eachPlayer
    @Hero sombra
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.SOMBRA))

    eventPlayer.startForcingName("Hacker")

    while true:
        botWaitUntilReady()
        eventPlayer.BOT_ABILITY_1_ENABLED = true if not eventPlayer.isUsingAbility1() and eventPlayer.getNormalizedHealth() >= 1 and not eventPlayer.BOT_PLAYER.hasStatusEffect(Status.HACKED) else false

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                if eventPlayer.BOT_PLAYER.hasStatusEffect(Status.HACKED):
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                else:
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false if eventPlayer.getNormalizedHealth() >= 1 else true
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if eventPlayer.getNormalizedHealth() >= 1 else false
                    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
                    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/sombra.opy]: Voice Lines":
    @Event eachPlayer
    @Hero sombra
    @Team 2

    eventPlayer.startModifyingVoicelinePitch((getTotalTimeElapsed() % 1) * 1.5, true)

    while true:
        eventPlayer.communicate(Comms.HELLO)
        wait(10)