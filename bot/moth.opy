#!mainFile "../main.opy"

rule "[bot/moth.opy]: Behavior":
    @Event eachPlayer
    @Hero mercy
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.MOTHS))

    eventPlayer.startForcingName("Moth")

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.setWeapon(2)
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/moth.opy]: Force Valk":
    @Event eachPlayer
    @Hero mercy
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.MOTHS))

    eventPlayer.setUltCharge(100)

    while true:
        eventPlayer.setUltCharge(100)
        wait(0.016)
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        wait(0.425)
        eventPlayer.setStatusEffect(null, Status.FROZEN, 0.001)

        waitUntil(not eventPlayer.isUsingUltimate(), 9999)

        goto RULE_START