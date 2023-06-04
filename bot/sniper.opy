#!mainFile "../main.opy"

subroutine delayedSniperScopedAttack

def delayedSniperScopedAttack():
    wait(0.9)
    PRESS_PRIMARY_FIRE()


rule "[bot/sniper.opy]: Ashe Behavior":
    @Event eachPlayer
    @Hero ashe
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.SNIPER))

    eventPlayer.startForcingName("Sniper")

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                PRESS_PRIMARY_FIRE()
                EXECUTE_SCOPING()            
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/sniper.opy]: Ana Behavior":
    @Event eachPlayer
    @Hero ana
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.SNIPER))

    eventPlayer.startForcingName("Sniper")

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_ABILITY_2_ENABLED = true
            EXECUTE_ULTIMATE_ABILITY()
        elif entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                EXECUTE_SCOPING()         
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                if getCurrentGamemode() == Gamemode.FFA: EXECUTE_ULTIMATE_ABILITY()
        UPDATE_BOT_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/sniper.opy]: Widow Behavior":
    @Event eachPlayer
    @Hero widowmaker
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.SNIPER))

    eventPlayer.startForcingName("Sniper")

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                EXECUTE_SCOPING()
                wait()
                if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                    # Run this subroutine independently so the rest of the code can continue to execute
                    async(delayedSniperScopedAttack, AsyncBehavior.NOOP)
                else:
                    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true        
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)