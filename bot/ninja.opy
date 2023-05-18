#!mainFile "../main.opy"

rule "[bot/ninja.opy]: Genji Behavior":
    @Event eachPlayer
    @Hero genji
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NINJA))

    eventPlayer.startForcingName("Ninja")

    wait(1)

    applyCustomHealthFor(eventPlayer, 150, 0, 0)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                EXECUTE_ATTACK_BASED_ON_RANGE()    
                if eventPlayer.isInAlternateForm():
                    PRESS_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_1()         
                EXECUTE_DEFENSE_ABILITY_2()
                eventPlayer.DEFLECT_BUTTON = Button.ABILITY_2
                EXECUTE_ULTIMATE_DEFLECT()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/ninja.opy]: Kiriko Behavior":
    @Event eachPlayer
    @Hero kiriko
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NINJA))

    eventPlayer.startForcingName(random.choice(["Ninja", "Ninja", "Ninja", "Believe It", "Dattebayo"]))

    wait(1)

    applyCustomHealthFor(eventPlayer, 150, 0, 0)

    while true:
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
            eventPlayer.BOT_ABILITY_1_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getPosition()) > 2 else false
            PRESS_ABILITY_2()
            EXECUTE_ULTIMATE_ABILITY()
        elif entityExists(eventPlayer.BOT_PLAYER):
            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
            eventPlayer.BOT_ABILITY_1_ENABLED = false
            eventPlayer.BOT_ABILITY_2_ENABLED = false 
            EXECUTE_ULTIMATE_ABILITY()
    
        UPDATE_BOT_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/ninja.opy]: Cancel Genji Ult Voiceline":
    @Event eachPlayer
    @Hero genji
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NINJA))
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setStatusEffect(null, Status.FROZEN, 0.016)