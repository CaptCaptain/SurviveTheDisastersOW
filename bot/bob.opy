#!mainFile "../main.opy"

rule "[bot/bob.opy]: Behavior":
    @Event eachPlayer
    @Hero ashe
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.BOB))

    eventPlayer.setInvisibility(Invis.ENEMIES)
    eventPlayer.setUltCharge(100)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.disablePlayerCollision()
    eventPlayer.setDamageDealt(50)
    eventPlayer.setMaxHealth(25)
    eventPlayer.BOT_DISABLE_AI = true

    wait(1.5)

    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(0.016)
    if eventPlayer.getSlot() == 0:
        return
    eventPlayer.setStatusEffect(null, Status.FROZEN, 0.016)
    eventPlayer.startForcingPosition(vect(0, 9999, 0), false)