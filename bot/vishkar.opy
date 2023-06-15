#!mainFile "../main.opy"

rule "[bot/vishkar.opy]: Symmetra Behavior":
    @Event eachPlayer
    @Hero symmetra
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.VISHKAR))

    eventPlayer.startForcingName("Satya Vaswani")

    if disasterFlags.HARDCORE in activeDisasterFlags:
        eventPlayer.setUltCharge(99)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                EXECUTE_ATTACK_BASED_ON_RANGE()
                EXECUTE_DEFENSE_ABILITY_1()
                if all([not player.isUsingUltimate() for player in getPlayersOnHero(Hero.SYMMETRA, eventPlayer.getTeam())]):
                    EXECUTE_ULTIMATE_PLACEMENT()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/vishkar.opy]: Lifeweaver Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.VISHKAR))

    eventPlayer.startForcingName("Niran Pruksamanee")

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
            eventPlayer.BOT_ABILITY_2_ENABLED = true
            PRESS_ABILITY_1()
            EXECUTE_ULTIMATE_ABILITY()
        elif entityExists(eventPlayer.BOT_PLAYER):
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
            eventPlayer.BOT_ABILITY_1_ENABLED = false
            eventPlayer.BOT_ABILITY_2_ENABLED = false 
            EXECUTE_ULTIMATE_ABILITY()
    
        UPDATE_BOT_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/vishkar.opy]: Lifeweaver Behavior":
    @Event eachPlayer
    @Hero lifeweaver
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.VISHKAR))

    wait(1)
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false

    if RULE_CONDITION: goto RULE_START
