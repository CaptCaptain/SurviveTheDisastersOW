#!mainFile "../main.opy"

rule "[bot/wisp.opy]: Behavior":
    @Event eachPlayer
    @Hero tracer
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WISP))

    eventPlayer.startForcingName("Will-o'-wisp")
    eventPlayer.setMaxHealth((30 / 150) * 100)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)
    eventPlayer.setDamageDealt(100)

    wait(1)

    createEffect(getAllPlayers(), Effect.ECHO_CLONING, Team.2, eventPlayer, 1, EffectReeval.VISIBILITY)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.ORB, Color.ORANGE, updateEveryTick(eventPlayer.getEyePosition() + Vector.UP), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.YELLOW, updateEveryTick(eventPlayer.getEyePosition() + Vector.UP), 0.1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) and eventPlayer.isAlive(), 9999)
        if entityExists(eventPlayer.BOT_PLAYER):
            if eventPlayer.BOT_PLAYER.isAlive():
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                
                eventPlayer.setAbilityCharge(Button.ABILITY_1, 1)

                eventPlayer.forceButtonPress(Button.ABILITY_1)

                if eventPlayer.BOT_PLAYER.isMeleeing() or eventPlayer.BOT_PLAYER.isFiringPrimaryFire() or eventPlayer.BOT_PLAYER.isFiringSecondaryFire():
                    eventPlayer.forceButtonPress(Button.ABILITY_2)
                    
                eventPlayer.forceButtonPress(Button.MELEE)
                eventPlayer.communicate(Comms.HELLO)
                
        waitThrottle(Wait.IGNORE_CONDITION)