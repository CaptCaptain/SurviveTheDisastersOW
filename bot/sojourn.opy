#!mainFile "../main.opy"

rule "[bot/sojourn.opy]: Behavior":
    @Event eachPlayer
    @Hero sojourn
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.THIS_ENDS))

    eventPlayer.startForcingName(random.choice(["Sojourn", "This Ends Now", "That Starts Then"]))

    wait(1)

    eventPlayer.setUltCharge(100)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            PRESS_SECONDARY_FIRE()
            EXECUTE_DEFENSE_ABILITY_1()
            EXECUTE_OFFENSE_ABILITY_2()
            EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)