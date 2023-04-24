#!mainFile "../main.opy"

rule "[bot/simon.opy]: Behavior":
    @Event eachPlayer
    @Hero reinhardt
    @Team 2
    @Condition eventPlayer.BOT_DISASTER_TAG == disasters.SIMON[disasterData.ID]

    eventPlayer.startForcingName(random.choice(["Simon", "Simon", "Simon", "Simon", "Simon", "Daddy Rein"]))
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.startScalingSize(1.5, false)
    eventPlayer.disablePlayerCollision()
    eventPlayer.communicate(Comms.HELLO)
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer.getEyePosition(), Team.1)), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    getPlayers(Team.1).teleport(eventPlayer.getPosition())

    waitUntil(isGameInProgress() and getMatchTime() < 10, 9999)

    startDialogueOnce(1, [[Hero.REINHARDT, "Looks like my limited free trial of life is over.", 1], [Hero.REINHARDT, "See you next time!", 1]], sky)

    waitUntil(is_dialoguing == false, 9999)
    eventPlayer.communicate(Comms.GOODBYE)
    wait(1)

    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    kill(eventPlayer, null)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Team.1, eventPlayer.getEyePosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Team.1, eventPlayer.getEyePosition(), 50)