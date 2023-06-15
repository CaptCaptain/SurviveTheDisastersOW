#!mainFile "../main.opy"

rule "[bot/climatologist.opy]: Behavior":
    @Event eachPlayer
    @Hero mei
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.CLIMATOLOGIST))

    eventPlayer.startForcingName(random.choice(["Mei", "Dr. Zhou", "周美灵", "Mei-Ling Zhou", "Devil", "Climatologist"]))

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                if eventPlayer.BOT_PLAYER.hasStatusEffect(Status.FROZEN):
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                    PRESS_SECONDARY_FIRE()
                else:
                    EXECUTE_ATTACK_BASED_ON_RANGE()
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)