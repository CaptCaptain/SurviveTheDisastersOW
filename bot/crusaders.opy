#!mainFile "../main.opy"

rule "[bot/crusaders.opy]: Behavior":
    @Event eachPlayer
    @Hero reinhardt
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.CRUSADERS))

    eventPlayer.startForcingName(random.choice(["Crusader", "Reinhardt Wilhelm", "Balderich von Adler"]))
    eventPlayer.setDamageDealt(200)

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 5 else false     
                eventPlayer.BOT_ABILITY_1_ENABLED = true if eventPlayer.BOT_PLAYER.hasStatusEffect(Status.KNOCKED_DOWN) else false
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()

                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.NONE)
                
        waitThrottle(Wait.IGNORE_CONDITION)