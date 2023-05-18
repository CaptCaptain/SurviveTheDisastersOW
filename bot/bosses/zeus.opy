#!mainFile "../../main.opy"

rule "[bot/zeus.opy]: Behavior":
    @Event eachPlayer
    @Hero junkerQueen
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.ZEUS))

    createBossName(eventPlayer, Icon.BOLT, iconString(Icon.BOLT), Color.ORANGE)

    eventPlayer.startForcingName("Zeus: God of Thunder")
    eventPlayer.setDamageDealt(250)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startScalingSize(1.5, false)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_CROUCH_SPAM = false

    createEffect(getAllPlayers(), Effect.WINSTON_PRIMAL_RAGE, Team.2, eventPlayer, evalOnce(1), EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(1)

    applyCustomHealthWithMaxHealthFor(eventPlayer, getBossHealth() / 2, getBossHealth() / 4, 0, 1000)

    while eventPlayer.isAlive():
        botWaitUntilReady()
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 5 else false    
                eventPlayer.setAbilityCooldown(Button.ABILITY_1, min(eventPlayer.getAbilityCooldown(Button.ABILITY_1), 2)) 
                EXECUTE_DEFENSE_ABILITY_1()
                EXECUTE_OFFENSE_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                
        waitThrottle(Wait.IGNORE_CONDITION)