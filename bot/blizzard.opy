#!mainFile "../main.opy"

rule "[bot/blizzard.opy]: Behavior":
    @Event eachPlayer
    @Hero mei
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.BLIZZARD))

    eventPlayer.startForcingName("Blizzard")

    eventPlayer.setProjectileGravity(0)
    eventPlayer.setProjectileSpeed(0)
    eventPlayer.setGravity(0)
    eventPlayer.setUltCharge(100)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.BOT_DISABLE_AI = true
    wait(1)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(5)

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())