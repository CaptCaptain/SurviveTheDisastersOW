#!mainFile "../main.opy"

rule "[bot/inti_warrior.opy]: Behavior":
    @Event eachPlayer
    @Hero illari
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.INTI_WARRIORS))

    eventPlayer.startForcingName("Sun Warrior")

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
            eventPlayer.BOT_ABILITY_2_ENABLED = true
            EXECUTE_ULTIMATE_ABILITY()
        elif entityExists(eventPlayer.BOT_PLAYER):
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
            EXECUTE_DEFENSE_ABILITY_1()
            EXECUTE_DEFENSE_ABILITY_2()
            EXECUTE_ULTIMATE_ABILITY()
    
        UPDATE_BOT_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)