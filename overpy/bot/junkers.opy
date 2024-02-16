#!mainFile "../main.opy"

rule "[bot/junkers.opy]: Junkrat Behavior":
    @Event eachPlayer
    @Hero junkrat
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.JUNKERS))

    eventPlayer.startForcingName("Junker")

    wait(1)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = not eventPlayer.BOT_SECONDARY_FIRE_ENABLED
                eventPlayer.BOT_ABILITY_2_ENABLED = false
                EXECUTE_OFFENSE_ABILITY_1()
                EXECUTE_DEFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/junkers.opy]: Roadhog Behavior":
    @Event eachPlayer
    @Hero roadhog
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.JUNKERS))

    eventPlayer.startForcingName("Junker")

    wait(1)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                EXECUTE_ATTACK_BASED_ON_RANGE()    
                EXECUTE_OFFENSE_ABILITY_1()
                EXECUTE_DEFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/junkers.opy]: Junker Queen Behavior":
    @Event eachPlayer
    @Hero junkerQueen
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.JUNKERS))

    eventPlayer.startForcingName("Junker")

    wait(1)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 5 else false     
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)