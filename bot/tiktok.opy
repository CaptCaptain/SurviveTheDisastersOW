#!mainFile "../main.opy"

rule "[bot/tiktok.opy]: Behavior":
    @Event eachPlayer
    @Hero moira
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.TIKTOK))

    eventPlayer.startForcingName(random.choice(["DPSMoira", "TiktokMoira", "NotHealer", "DPSOnly"]))

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_OFFENSE_ABILITY_2()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)