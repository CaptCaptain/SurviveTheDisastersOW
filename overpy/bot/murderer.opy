#!mainFile "../main.opy"

rule "[bot/murderer.opy]: Behavior":
    @Event eachPlayer
    @Hero junkerQueen
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.MURDERERS))

    eventPlayer.startForcingName("Murderer")
    eventPlayer.setDamageDealt(200)

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
                eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
                eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
                eventPlayer.forceButtonPress(Button.ABILITY_2)
                EXECUTE_DEFENSE_ABILITY_1()
                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.NONE)
                
        waitThrottle(Wait.IGNORE_CONDITION)