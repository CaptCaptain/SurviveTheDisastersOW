#!mainFile "../main.opy"

rule "[bot/nuclear_bomb.opy]: Behavior":
    @Event eachPlayer
    @Hero dva
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NUCLEAR_BOMB))

    eventPlayer.startForcingName("Nuclear Bomb")
    eventPlayer.setDamageDealt(Math.INFINITY)
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.disableEnvironmentCollision(false)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setInvisibility(Invis.ALL)
    
    wait(1)

    eventPlayer.teleport(evalOnce(worldVector(vect(0, 5, 0), getClosestPlayer(eventPlayer.getPosition(), Team.1), Transform.ROTATION_AND_TRANSLATION)))

    playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, Team.2, eventPlayer.getEyePosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Team.2, eventPlayer.getEyePosition(), 50)

    wait(0.1)

    eventPlayer.setUltCharge(100)
    eventPlayer.forceButtonPress(Button.ULTIMATE)

    waitUntil(eventPlayer.isInAlternateForm(), 9999)
    eventPlayer.startForcingPosition(sky, false)