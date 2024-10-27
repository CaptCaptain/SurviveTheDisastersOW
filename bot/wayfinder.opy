#!mainFile "../main.opy"

rule "[bot/wayfinder.opy]: Behavior":
    @Event eachPlayer
    @Hero venture
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.WAYFINDERS))

    eventPlayer.startForcingName(random.choice(["Wayfinder", "Venture", "Rockeater", "Digger", "Monarch"]))

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                EXECUTE_ATTACK_BASED_ON_RANGE()
                
                if not eventPlayer.isUsingAbility1():
                    PRESS_ABILITY_1()

                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)