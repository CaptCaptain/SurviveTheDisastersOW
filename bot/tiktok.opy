#!mainFile "../main.opy"

rule "[bot/tiktok.opy]: Behavior":
    @Event eachPlayer
    @Hero moira
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.TIKTOK))

    eventPlayer.startForcingName(random.choice(["DPSMoira", "TiktokMoira", "NotHealer", "DPSOnly"]))

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
            
        waitThrottle(Wait.IGNORE_CONDITION)