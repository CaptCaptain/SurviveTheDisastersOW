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

    eventPlayer.setDamageDealt(150)
    eventPlayer.startForcingName("Sniper")

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        PRESS_PRIMARY_FIRE()
                        EXECUTE_SCOPING()            
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_OFFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/sniper.opy]: Widow Behavior":
    @Event eachPlayer
    @Hero widowmaker
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.SNIPER))

    eventPlayer.setDamageDealt(250)
    eventPlayer.startForcingName("Sniper")

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        EXECUTE_SCOPING()
                        wait()
                        switch eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
                            case true:
                                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                                # Run this subroutine independently so the rest of the code can continue to execute
                                async(delayedSniperScopedAttack, AsyncBehavior.NOOP)
                                break
                            default:
                                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                                break           
                        EXECUTE_DEFENSE_ABILITY_1()
                        EXECUTE_OFFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)