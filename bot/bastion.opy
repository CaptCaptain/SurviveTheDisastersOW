#!mainFile "../main.opy"

rule "[bot/bastion.opy]: Behavior":
    @Event eachPlayer
    @Hero bastion
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.FLYING_BASTION))

    while true:
        botWaitUntilReady()

        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if not eventPlayer.BOT_SECONDARY_FIRE_ENABLED else false
                eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
                if eventPlayer.isInAlternateForm():
                    if eventPlayer.getNormalizedHealth() < 0.5:
                        PRESS_ABILITY_1()
                else:
                    if eventPlayer.getNormalizedHealth() > 0.5:
                        PRESS_ABILITY_1()
                        
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/bastion.opy]: Flying Behavior":
    @Event eachPlayer
    @Hero bastion
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.FLYING_BASTION))
    @Condition eventPlayer.isInAlternateForm()

    eventPlayer.setGravity(0)
    eventPlayer.setMoveSpeed(150)
    eventPlayer.applyImpulse(vect(0, 1, 0), 2, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)

    waitUntil(not eventPlayer.isInAlternateForm(), 9999)

    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)