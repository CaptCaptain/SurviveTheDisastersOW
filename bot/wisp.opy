#!mainFile "../main.opy"

rule "[bot/wisp.opy]: Behavior":
    @Event eachPlayer
    @Hero tracer
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.WISP))

    eventPlayer.startForcingName("Will-o'-wisp")
    eventPlayer.setDamageReceived(Math.INFINITY)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)

    wait(1)

    createEffect(getAllPlayers(), Effect.ECHO_CLONING, Team.2, eventPlayer, 1, EffectReeval.VISIBILITY)
    allocateEffect()

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) and eventPlayer.isAlive(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.setAbilityCharge(Button.ABILITY_1, 3)
                        if distance(eventPlayer.BOT_PLAYER.getPosition(), eventPlayer.getPosition()) > 7.5:
                            eventPlayer.forceButtonPress(Button.ABILITY_1)
                            eventPlayer.teleport(nearestWalkablePosition(eventPlayer.getPosition()))
                        else:
                            eventPlayer.forceButtonPress(Button.ABILITY_1)
                            eventPlayer.teleport(eventPlayer.BOT_PLAYER.getPosition())
                        if eventPlayer.BOT_PLAYER.isMeleeing() or eventPlayer.BOT_PLAYER.isFiringPrimaryFire() or eventPlayer.BOT_PLAYER.isFiringSecondaryFire():
                            eventPlayer.forceButtonPress(Button.ABILITY_2)
                        eventPlayer.forceButtonPress(Button.MELEE)
                        eventPlayer.communicate(Comms.HELLO)
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)