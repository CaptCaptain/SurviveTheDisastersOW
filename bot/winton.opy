#!mainFile "../main.opy"

rule "[bot/winton.opy]: Behavior":
    @Event eachPlayer
    @Hero winston
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WINTON))

    eventPlayer.startForcingName(random.choice(["Winton", "Bogur", "Monke", "Winston", "Monkey"]))
    eventPlayer.setDamageDealt(300)

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.forceButtonPress(Button.ABILITY_1)
                        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.NONE)
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/winton.opy]: Force Primal":
    @Event eachPlayer
    @Hero winston
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WINTON))

    eventPlayer.setUltCharge(100)

    while true:
        eventPlayer.setUltCharge(100)
        wait(0.016)
        eventPlayer.forceButtonPress(Button.ULTIMATE)

        waitUntil(not eventPlayer.isUsingUltimate(), 9999)

        goto RULE_START