#!mainFile "../main.opy"

rule "[bot/vishkar.opy]: Symmetra Behavior":
    @Event eachPlayer
    @Hero symmetra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.VISHKAR))

    eventPlayer.startForcingName("Satya Vaswani")
    eventPlayer.setUltCharge(99)

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        EXECUTE_ATTACK_BASED_ON_RANGE()
                        EXECUTE_DEFENSE_ABILITY_1()
                        if all([not player.isUsingUltimate() for player in getPlayersOnHero(Hero.SYMMETRA, eventPlayer.getTeam())]):
                            EXECUTE_ULTIMATE_PLACEMENT()
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/vishkar.opy]: Lifeweaver Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.VISHKAR))

    eventPlayer.startForcingName("Niran Pruksamanee")

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            case true:
                async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                eventPlayer.BOT_ABILITY_2_ENABLED = true
                PRESS_ABILITY_1()
                EXECUTE_ULTIMATE_ABILITY()
                break
            default:
                switch entityExists(eventPlayer.BOT_PLAYER):
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
                        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
                        eventPlayer.BOT_ABILITY_1_ENABLED = false
                        eventPlayer.BOT_ABILITY_2_ENABLED = false 
                        EXECUTE_ULTIMATE_ABILITY()
                        break
                break
    
        UPDATE_BOT_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/vishkar.opy]: Lifeweaver Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.VISHKAR))
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)

    wait(1)
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
