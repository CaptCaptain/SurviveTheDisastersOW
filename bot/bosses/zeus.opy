#!mainFile "../../main.opy"

globalvar DISASTER_ZEUS_ATK_POS = []

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

    for eventPlayer.playerIndex in range(0, 5, 1):
        createEffect(getAllPlayers() if DISASTER_ZEUS_ATK_POS != [] else [], Effect.RING, Color.ORANGE, DISASTER_ZEUS_ATK_POS[evalOnce(eventPlayer.playerIndex)], evalOnce(5), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

        createEffect(getAllPlayers() if DISASTER_ZEUS_ATK_POS != [] else [], Effect.ORB, Color.ORANGE, DISASTER_ZEUS_ATK_POS[evalOnce(eventPlayer.playerIndex)] + Vector.UP, evalOnce(1), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

        createEffect(getAllPlayers() if DISASTER_ZEUS_ATK_POS != [] else [], Effect.CLOUD, Color.GRAY, DISASTER_ZEUS_ATK_POS[evalOnce(eventPlayer.playerIndex)] + evalOnce((Vector.UP * 5)), evalOnce(3), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()

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

rule "[bot/zeus.opy]: Kinetic Grasp Projectiles":
    @Event eachPlayer
    @Hero junkerQueen
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.ZEUS))

    while eventPlayer.isAlive():
        waitUntil(eventPlayer.isUsingAbility1() or not entityExists(eventPlayer.BOT_PLAYER), 9999)

        DISASTER_ZEUS_ATK_POS = [player.getPosition() for player in getPlayers(Team.1)]

        wait(1)
        for eventPlayer.playerIndex in range(0, len(DISASTER_ZEUS_ATK_POS), 1):
            getPlayersInRadius(DISASTER_ZEUS_ATK_POS[eventPlayer.playerIndex], 5, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS).setStatusEffect(null, Status.BURNING, 1)
            getPlayersInRadius(DISASTER_ZEUS_ATK_POS[eventPlayer.playerIndex], 5, Team.1, LosCheck.SURFACES_AND_ENEMY_BARRIERS).startDoT(eventPlayer, 1, 75)

            playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, DISASTER_ZEUS_ATK_POS[eventPlayer.playerIndex], 10)
            playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, DISASTER_ZEUS_ATK_POS[eventPlayer.playerIndex], 10)
            playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Color.ORANGE, DISASTER_ZEUS_ATK_POS[eventPlayer.playerIndex], 50)
            wait(0.016)

        DISASTER_ZEUS_ATK_POS = []

        wait(3)