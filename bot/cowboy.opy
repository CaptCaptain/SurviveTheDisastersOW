#!mainFile "../main.opy"

rule "[bot/crusaders.opy]: Behavior":
    @Event eachPlayer
    @Hero mccree
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.COWBOY))

    eventPlayer.startForcingName(random.choice(["Huckleberry", "Cassidy", "Cole Casserole", "13:37", "2:00", "4:20"]))

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) < 12 and eventPlayer.isInViewAngle(eventPlayer.BOT_PLAYER, 45):
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                else:
                    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                
        waitThrottle(Wait.IGNORE_CONDITION)