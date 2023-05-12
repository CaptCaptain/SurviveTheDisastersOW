#!mainFile "../main.opy"

rule "[player/reinhardt.opy]: Cancel Charge on Boss":
    @Event eachPlayer
    @Hero reinhardt
    @Team 1
    @Condition eventPlayer.isUsingAbility1()

    while eventPlayer.isUsingAbility1():
        if raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0, 0, 2), eventPlayer, Transform.ROTATION), getPlayers(Team.2), [player for player in getAllPlayers() if not botFlags.BOSS in player.BOT_DISASTER_FLAGS], false).getPlayerHit():
            damage(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0, 0, 2), eventPlayer, Transform.ROTATION), getPlayers(Team.2), [player for player in getAllPlayers() if not botFlags.BOSS in player.BOT_DISASTER_FLAGS], false).getPlayerHit(), eventPlayer, 225)
            eventPlayer.cancelPrimaryAction()

        wait(0.032)