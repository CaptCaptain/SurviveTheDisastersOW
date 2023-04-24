#!mainFile "../main.opy"

rule "[bot/kamehameha.opy]: Behavior":
    @Event eachPlayer
    @Hero moira
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.KAME))

    eventPlayer.startForcingName("Kamehameha")
    eventPlayer.setDamageDealt(Math.INFINITY)
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.disableEnvironmentCollision(false)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.startFacing(angleToDirection(getTotalTimeElapsed() * 150, 0), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.setInvisibility(Invis.ALL)
    
    wait(1)

    eventPlayer.teleport(evalOnce(worldVector(vect(0, 5, 0), getClosestPlayer(eventPlayer.getPosition(), Team.1), Transform.ROTATION_AND_TRANSLATION)))

    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR, Team.2, eventPlayer.getEyePosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Team.2, eventPlayer.getEyePosition(), 50)

    eventPlayer.setInvisibility(Invis.NONE)

    wait(0.1)

    eventPlayer.setUltCharge(100)
    eventPlayer.forceButtonPress(Button.ULTIMATE)

    waitUntil(not eventPlayer.isUsingUltimate(), 9999)

    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR, Team.2, eventPlayer.getEyePosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR_SOUND, Team.2, eventPlayer.getEyePosition(), 50)

    eventPlayer.setInvisibility(Invis.ALL)