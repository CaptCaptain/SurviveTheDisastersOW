#!mainFile "../main.opy"

rule "[bot/frogger.opy]: Behavior":
    @Event eachPlayer
    @Hero lucio
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.FROGGERS))

    eventPlayer.startForcingName(random.choice(["Lucio", "Redshell", "Frogger", "Eskay"]))

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false if eventPlayer.isFiringSecondaryFire() else true
            eventPlayer.BOT_JUMP_ENABLED = false if eventPlayer.isInAir() else true
            EXECUTE_DEFENSE_ABILITY_1()
            EXECUTE_DEFENSE_ABILITY_2()
            EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)